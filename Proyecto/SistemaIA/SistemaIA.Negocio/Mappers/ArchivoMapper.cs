using SistemaIA.Dominio.Entidades;
using SistemaIA.Negocio.DTOs;
using System.Globalization;

namespace SistemaIA.Negocio.Mappers
{
    public static class ArchivoMapper
    {
        public static ArchivoDto Mapear(Archivo entidad)
        {
            if (entidad == null) return null;

            return new ArchivoDto
            {
                IdArchivo = entidad.IdArchivo,
                Nombre = entidad.Nombre,
                Tipo = entidad.TipoArchivo?.Nombre ?? "",
                FechaSubida = entidad.FechaSubida.ToString("g", new CultureInfo("es-AR")),
                Peso = (entidad.Peso / 1024) + " KB"
            };
        }
    }
}
