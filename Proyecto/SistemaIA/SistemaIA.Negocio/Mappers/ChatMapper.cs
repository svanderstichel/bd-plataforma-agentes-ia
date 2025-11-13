using SistemaIA.Dominio.Entidades;
using SistemaIA.Negocio.DTOs;

namespace SistemaIA.Negocio.Mappers
{
    public static class ChatMapper
    {
        public static ChatDto Mapear(Chat entidad)
        {
            if (entidad == null)
                return null;

            return new ChatDto
            {
                IdChat = entidad.IdChat,
                NombreChat = entidad.NombreChat ?? "(Sin nombre)",
                FechaCreacion = entidad.FechaCreacion.ToString("dd/MM/yyyy HH:mm"),
            };
        }
    }
}
