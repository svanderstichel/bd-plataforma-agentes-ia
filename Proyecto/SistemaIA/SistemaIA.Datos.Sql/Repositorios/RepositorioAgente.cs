using SistemaIA.Datos.Sql.Infraestructura;
using SistemaIA.Dominio.Entidades;
using SistemaIA.Dominio.ValueObjects;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace SistemaIA.Datos.Sql
{
    public class RepositorioAgente
    {
        public List<Agente> ListarAgentesPorUsuario(int idUsuario)
        {
            var lista = new List<Agente>();

            using (var conexion = ConexionSQL.ObtenerConexion())
            using (var comando = new SqlCommand(@"
                SELECT 
                    IdAgente,
                    NombreAgente,
                    Descripcion,
                    Tipo,
                    FechaCreacion,
                    UsuarioDueno,
                    UsuarioCompartido,
                    Permiso,
                    FechaComparticion,
                    Rol
                FROM vw_Agentes_Visibles
                WHERE IdUsuarioDueno = @IdUsuarioActual
                   OR IdUsuarioCompartido = @IdUsuarioActual
                ORDER BY FechaCreacion ASC, NombreAgente ASC;", conexion))
            {
                comando.Parameters.Add("@IdUsuarioActual", SqlDbType.Int).Value = idUsuario;
                conexion.Open();

                using (var lector = comando.ExecuteReader())
                {
                    while (lector.Read())
                    {
                        var agente = new Agente();

                        agente.IdAgente = lector.GetInt32(lector.GetOrdinal("IdAgente"));
                        agente.Nombre = lector.GetString(lector.GetOrdinal("NombreAgente"));
                        agente.Descripcion = lector.GetString(lector.GetOrdinal("Descripcion"));


                        var tipoChar = lector.GetString(lector.GetOrdinal("Tipo"))[0];
                        agente.Tipo = (TipoAgente)tipoChar;

                        agente.FechaCreacion = lector.GetDateTime(lector.GetOrdinal("FechaCreacion"));


                        agente.UsuarioDueno = lector.GetString(lector.GetOrdinal("UsuarioDueno"));

                        agente.CompartidoPor =
                            lector.IsDBNull(lector.GetOrdinal("UsuarioCompartido"))
                            ? null
                            : lector.GetString(lector.GetOrdinal("UsuarioCompartido"));

                        agente.Permiso =
                            lector.IsDBNull(lector.GetOrdinal("Permiso"))
                            ? null
                            : lector.GetString(lector.GetOrdinal("Permiso"));

                        agente.DiaComparticion =
                            lector.IsDBNull(lector.GetOrdinal("FechaComparticion"))
                            ? (DateTime?)null
                            : lector.GetDateTime(lector.GetOrdinal("FechaComparticion"));

                        agente.Rol = lector.GetString(lector.GetOrdinal("Rol"));

                        lista.Add(agente);
                    }
                }
            }

            return lista;
        }



        public int CrearAgente(int idUsuario, string nombre, string descripcion, string instruccion, string tipo,
                        SqlConnection conexion, SqlTransaction transaccion)
        {
            using (var comando = new SqlCommand("sp_Crear_Agente", conexion, transaccion))
            {
                comando.CommandType = CommandType.StoredProcedure;

                comando.Parameters.Add("@IdUsuarioDueno", SqlDbType.Int).Value = idUsuario;
                comando.Parameters.Add("@Nombre", SqlDbType.NVarChar, 100).Value = nombre;
                comando.Parameters.Add("@Descripcion", SqlDbType.NVarChar, 250).Value = descripcion;
                comando.Parameters.Add("@Instruccion", SqlDbType.NVarChar).Value = instruccion;
                comando.Parameters.Add("@Tipo", SqlDbType.Char, 1).Value = tipo;

                return Convert.ToInt32(comando.ExecuteScalar());
            }
        }

        public Agente ObtenerPorId(int idAgente)
        {
            using (var conexion = ConexionSQL.ObtenerConexion())
            using (var comando = new SqlCommand(@"
                    SELECT 
                        IdAgente,
                        IdUsuarioDueno,
                        Nombre,
                        Descripcion,
                        Instruccion,
                        Tipo,
                        Activo
                    FROM Agente
                    WHERE IdAgente = @IdAgente;", conexion))
            {
                comando.Parameters.Add("@IdAgente", SqlDbType.Int).Value = idAgente;

                conexion.Open();
                using (var lector = comando.ExecuteReader())
                {
                    if (!lector.Read()) return null;

                    return new Agente
                    {
                        IdAgente = idAgente,
                        IdUsuarioDueno = lector.GetInt32(lector.GetOrdinal("IdUsuarioDueno")),
                        Nombre = lector.GetString(lector.GetOrdinal("Nombre")),
                        Descripcion = lector.GetString(lector.GetOrdinal("Descripcion")),
                        Instruccion = lector.GetString(lector.GetOrdinal("Instruccion")),
                        Tipo = (TipoAgente)lector.GetString(lector.GetOrdinal("Tipo"))[0]
                    };
                }
            }
        }

        public void ActualizarAgente(Agente entidad, SqlConnection conexion, SqlTransaction transaccion)
        {
            using (var comando = new SqlCommand(@"
                    UPDATE Agente SET
                        Nombre = @Nombre,
                        Descripcion = @Descripcion,
                        Instruccion = @Instruccion,
                        Tipo = @Tipo,
                        FechaUltimaModificacion = GETDATE()
                    WHERE IdAgente = @IdAgente",
                            conexion, transaccion))
            {
                comando.Parameters.Add("@IdAgente", SqlDbType.Int).Value = entidad.IdAgente;
                comando.Parameters.Add("@Nombre", SqlDbType.NVarChar, 100).Value = entidad.Nombre;
                comando.Parameters.Add("@Descripcion", SqlDbType.NVarChar, 250).Value = entidad.Descripcion;
                comando.Parameters.Add("@Instruccion", SqlDbType.NVarChar).Value = entidad.Instruccion;
                comando.Parameters.Add("@Tipo", SqlDbType.Char, 1).Value = entidad.Tipo.ToString();

                comando.ExecuteNonQuery();
            }
        }



    }
}
