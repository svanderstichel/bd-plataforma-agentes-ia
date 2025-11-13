using SistemaIA.Dominio.Entidades;
using SistemaIA.Negocio.DTOs;

namespace SistemaIA.Negocio.Mappers
{
    public static class ToolMapper
    {
        public static ToolDto Mapear(Tool entidad)
        {
            if (entidad == null) return null;

            return new ToolDto
            {
                IdTool = entidad.IdTool,
                Nombre = entidad.Nombre,
                Tipo = entidad.Tipo.ToString()
            };
        }
    }
}
