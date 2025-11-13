using SistemaIA.Dominio.Entidades;
using SistemaIA.Dominio.ValueObjects;
using SistemaIA.Negocio.DTOs;

namespace SistemaIA.Negocio.Mappers
{
    public static class AgenteMapper
    {
        public static AgenteDto Mapear(Agente entidad)
        {
            if (entidad == null)
                return null;

            return new AgenteDto
            {
                IdAgente = entidad.IdAgente,
                Nombre = entidad.Nombre,
                Descripcion = entidad.Descripcion,
                Tipo = ((char)entidad.Tipo).ToString(), // A, S
                Rol = entidad.Rol,
                CompartidoPor = entidad.CompartidoPor
            };
        }


        public static Agente MapearEditar(AgenteEditarDto dto)
        {
            return new Agente
            {
                IdAgente = dto.IdAgente,
                Nombre = dto.Nombre,
                Descripcion = dto.Descripcion,
                Instruccion = dto.Instruccion,
                Tipo = (TipoAgente)dto.Tipo[0],
                Activo = true,
                IdUsuarioDueno = dto.IdUsuario
            };
        }


        public static AgenteEditarDto MapearADto(Agente entidad)
        {
            return new AgenteEditarDto
            {
                IdAgente = entidad.IdAgente,
                IdUsuario = entidad.IdUsuarioDueno,
                Nombre = entidad.Nombre,
                Descripcion = entidad.Descripcion,
                Instruccion = entidad.Instruccion,
                Tipo = entidad.Tipo.ToString()[0].ToString()
            };
        }

    }
}
