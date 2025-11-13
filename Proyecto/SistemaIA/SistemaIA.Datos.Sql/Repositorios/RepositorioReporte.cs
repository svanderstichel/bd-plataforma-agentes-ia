using SistemaIA.Datos.Sql.Infraestructura;
using SistemaIA.Comun.DTOs;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;

namespace SistemaIA.Datos.Sql.Repositorios
{
    public class RepositorioReporte
    {
        public List<ReporteActividadAgenteDto> ObtenerReporteActividad(
            int idUsuarioDueno,
            DateTime? fechaDesde,
            DateTime? fechaHasta)
        {
            var lista = new List<ReporteActividadAgenteDto>();

            using (var conexion = ConexionSQL.ObtenerConexion())
            using (var comando = new SqlCommand("sp_Reporte_Actividad_Agentes", conexion))
            {
                comando.CommandType = CommandType.StoredProcedure;

                comando.Parameters.Add("@IdUsuarioDueno", SqlDbType.Int).Value = idUsuarioDueno;

                comando.Parameters.Add("@FechaDesde", SqlDbType.DateTime);
                if (fechaDesde.HasValue)
                    comando.Parameters["@FechaDesde"].Value = fechaDesde.Value;
                else
                    comando.Parameters["@FechaDesde"].Value = DBNull.Value;

                comando.Parameters.Add("@FechaHasta", SqlDbType.DateTime);
                if (fechaHasta.HasValue)
                    comando.Parameters["@FechaHasta"].Value = fechaHasta.Value;
                else
                    comando.Parameters["@FechaHasta"].Value = DBNull.Value;

                conexion.Open();

                using (var lector = comando.ExecuteReader())
                {
                    while (lector.Read())
                    {
                        var dto = new ReporteActividadAgenteDto();
                        dto.IdAgente = lector.GetInt32(lector.GetOrdinal("IdAgente"));
                        dto.NombreAgente = lector.GetString(lector.GetOrdinal("NombreAgente"));
                        dto.NombreUsuarioDueno = lector.GetString(lector.GetOrdinal("NombreUsuarioDueno"));
                        dto.TotalChats = lector.GetInt32(lector.GetOrdinal("TotalChats"));

                        dto.PrimeraActividad =
                            lector.IsDBNull(lector.GetOrdinal("PrimeraActividad"))
                            ? "-"
                            : lector.GetDateTime(lector.GetOrdinal("PrimeraActividad"))
                                    .ToString("g", new CultureInfo("es-AR"));

                        dto.UltimaActividad =
                            lector.IsDBNull(lector.GetOrdinal("UltimaActividad"))
                            ? "-"
                            : lector.GetDateTime(lector.GetOrdinal("UltimaActividad"))
                                    .ToString("g", new CultureInfo("es-AR"));

                        dto.TotalUsuariosCompartidos = lector.GetInt32(
                            lector.GetOrdinal("TotalUsuariosCompartidos"));

                        lista.Add(dto);
                    }
                }
            }

            return lista;
        }
    }
}
