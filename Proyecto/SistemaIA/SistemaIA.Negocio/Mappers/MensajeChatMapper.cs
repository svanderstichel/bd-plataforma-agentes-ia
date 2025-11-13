using SistemaIA.Dominio.Entidades;
using SistemaIA.Negocio.DTOs;
using System.Globalization;

namespace SistemaIA.Negocio.Mappers
{
    public static class MensajeChatMapper
    {
        public static MensajeChatDto Mapear(MensajeChat entidad)
        {
            return new MensajeChatDto
            {
                Rol = entidad.Rol,
                Contenido = entidad.Contenido,
                Timestamp = entidad.Timestamp.ToString("g", new CultureInfo("es-AR"))
            };
        }
    }
}
