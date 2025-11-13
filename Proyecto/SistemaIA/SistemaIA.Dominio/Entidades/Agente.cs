using SistemaIA.Dominio.ValueObjects;
using System;
using System.Collections.Generic;

namespace SistemaIA.Dominio.Entidades
{
    public class Agente
    {
        public int IdAgente { get; set; }
        public int IdUsuarioDueno { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public string Instruccion { get; set; }
        public TipoAgente Tipo { get; set; }    // 'S' o 'A'
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaUltimaModificacion { get; set; }
        public bool Activo { get; set; }


        public string UsuarioDueno { get; set; }
        public string CompartidoPor { get; set; }
        public string Rol { get; set; }
        public string Permiso { get; set; }
        public DateTime? DiaComparticion { get; set; }

        public List<Archivo> Archivos { get; set; }
        public List<Tool> Tools { get; set; }
        public List<Chat> Chats { get; set; }

        public Agente()
        {
            Archivos = new List<Archivo>();
            Tools = new List<Tool>();
            Chats = new List<Chat>();
        }

        public bool EsAvanzado()
        {
            return Tipo == TipoAgente.Avanzado;
        }

        public bool EsSimple()
        {
            return Tipo == TipoAgente.Simple;
        }

        public bool EsPropietario()
        {
            return Rol != null &&
                   Rol.Equals("Propietario", StringComparison.OrdinalIgnoreCase);
        }
    }
}
