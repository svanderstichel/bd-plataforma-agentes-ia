using System;
using System.Collections.Generic;

namespace SistemaIA.Dominio.Entidades
{
    public class MensajeChat
    {
        public string Rol { get; set; }      // user, assistant, tool, system
        public string Contenido { get; set; }
        public DateTime Timestamp { get; set; }

        public Dictionary<string, object> Metadata { get; set; }

        public MensajeChat()
        {
            Metadata = new Dictionary<string, object>();
        }

        public bool EsDeUsuario() { return Rol == "user"; }
        public bool EsDeAsistente() { return Rol == "assistant"; }
        public bool EsDeTool() { return Rol == "tool"; }
        public bool EsDelSistema() { return Rol == "system"; }
    }
}
