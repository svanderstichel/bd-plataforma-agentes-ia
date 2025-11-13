using MongoDB.Bson;
using MongoDB.Driver;
using SistemaIA.Dominio.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;

namespace SistemaIA.Datos.Mongo.Repositorios
{
    public class RepositorioChat
    {
        public List<Chat> ObtenerChatsPorAgente(int idAgente)
        {
            var lista = new List<Chat>();

            var baseDatos = ConexionMongo.ObtenerBase();
            var coleccion = baseDatos.GetCollection<BsonDocument>("chats");

            var filtro = Builders<BsonDocument>.Filter.Eq("idAgente", idAgente);

            var documentos = coleccion.Find(filtro)
                                      .Sort(Builders<BsonDocument>.Sort.Descending("fechaCreacion"))
                                      .ToList();

            foreach (var doc in documentos)
            {
                var chat = new Chat();

                chat.IdAgente = idAgente;

                if (doc.Contains("idChatSQL"))
                    chat.IdChat = doc["idChatSQL"].ToInt32();

                if (doc.Contains("idUsuario"))
                    chat.IdUsuario = doc["idUsuario"].ToInt32();

                if (doc.Contains("nombreChat"))
                    chat.NombreChat = doc["nombreChat"].AsString;
                else
                    chat.NombreChat = "(Sin nombre)";

                if (doc.Contains("fechaCreacion"))
                    chat.FechaCreacion = doc["fechaCreacion"].ToUniversalTime();

                chat.Mensajes = new List<MensajeChat>();

                lista.Add(chat);
            }

            return lista;
        }


        public List<MensajeChat> ObtenerMensajesPorChat(int idChatSQL)
        {
            var lista = new List<MensajeChat>();

            var baseDatos = ConexionMongo.ObtenerBase();
            var coleccion = baseDatos.GetCollection<BsonDocument>("chats");

            var filtro = Builders<BsonDocument>.Filter.Eq("idChatSQL", idChatSQL);
            var documento = coleccion.Find(filtro).FirstOrDefault();

            if (documento == null || !documento.Contains("mensajes"))
                return lista;

            var array = documento["mensajes"].AsBsonArray;

            foreach (var item in array)
            {
                var doc = item.AsBsonDocument;

                var mensaje = new MensajeChat
                {
                    Rol = doc.Contains("role") ? doc["role"].AsString : "",
                    Contenido = doc.Contains("content") ? doc["content"].AsString : "",
                    Timestamp = doc.Contains("timestamp") ? doc["timestamp"].ToUniversalTime() : DateTime.MinValue,
                    Metadata = new Dictionary<string, object>()
                };

                if (doc.Contains("metadata") && doc["metadata"].IsBsonDocument)
                {
                    var metaDoc = doc["metadata"].AsBsonDocument;

                    foreach (var meta in metaDoc.Elements)
                    {
                        mensaje.Metadata[meta.Name] = meta.Value.ToString();
                    }
                }

                lista.Add(mensaje);
            }

            return lista;
        }


    }
}
