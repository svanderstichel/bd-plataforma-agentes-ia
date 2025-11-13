using SistemaIA.Datos.Mongo.Repositorios;
using SistemaIA.Negocio.DTOs;
using SistemaIA.Negocio.Mappers;
using System.Collections.Generic;

namespace SistemaIA.Negocio.Servicios
{
    public class ServicioChat
    {
        private readonly RepositorioChat _repositorioChat;

        public ServicioChat()
        {
            _repositorioChat = new RepositorioChat();
        }

        public List<ChatDto> ObtenerChatsPorAgente(int idAgente)
        {
            var entidades = _repositorioChat.ObtenerChatsPorAgente(idAgente);

            var listaDto = new List<ChatDto>();

            foreach (var chat in entidades)
            {
                listaDto.Add(ChatMapper.Mapear(chat));
            }

            return listaDto;
        }

        public List<MensajeChatDto> ObtenerMensajesPorChat(int idChat)
        {
            var entidades = _repositorioChat.ObtenerMensajesPorChat(idChat);

            var listaDto = new List<MensajeChatDto>();
            foreach (var m in entidades)
                listaDto.Add(MensajeChatMapper.Mapear(m));

            return listaDto;
        }

    }
}
