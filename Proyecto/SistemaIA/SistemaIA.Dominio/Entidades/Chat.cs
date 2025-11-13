using System;
using System.Collections.Generic;

namespace SistemaIA.Dominio.Entidades
{
    public class Chat
    {
        public int IdChat { get; set; }
        public int IdAgente { get; set; }
        public int IdUsuario { get; set; }
        public string NombreChat { get; set; }
        public DateTime FechaCreacion { get; set; }

        public List<MensajeChat> Mensajes { get; set; }

        public Chat()
        {
            Mensajes = new List<MensajeChat>();
        }

        public MensajeChat UltimoMensaje()
        {
            if (Mensajes == null || Mensajes.Count == 0)
                return null;

            return Mensajes[Mensajes.Count - 1];
        }

        public int CantidadMensajes
        {
            get { return Mensajes.Count; }
        }
    }
}
