using SistemaIA.Comun.DTOs;
using SistemaIA.Datos.Sql.Repositorios;
using System;
using System.Collections.Generic;

namespace SistemaIA.Negocio.Servicios
{
    public class ServicioReporte
    {
        private readonly RepositorioReporte _repo = new RepositorioReporte();

        public List<ReporteActividadAgenteDto> ObtenerReporte(
            int idUsuarioDueno,
            DateTime? fechaDesde,
            DateTime? fechaHasta)
        {
            return _repo.ObtenerReporteActividad(idUsuarioDueno, fechaDesde, fechaHasta);
        }
    }
}
