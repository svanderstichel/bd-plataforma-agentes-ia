using SistemaIA.Datos.Sql.Infraestructura;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace SistemaIA.Datos.Sql.Repositorios
{
    public class RepositorioAgenteArchivo
    {
        public void AsignarArchivo(int idAgente, int idArchivo, SqlConnection conexion, SqlTransaction transaccion)
        {
            using (var comando = new SqlCommand("sp_Registrar_Archivo_En_Agente", conexion, transaccion))
            {
                comando.CommandType = CommandType.StoredProcedure;

                comando.Parameters.Add("@IdAgente", SqlDbType.Int).Value = idAgente;
                comando.Parameters.Add("@IdArchivo", SqlDbType.Int).Value = idArchivo;

                comando.ExecuteNonQuery();
            }
        }


        public List<int> ObtenerArchivosDeAgente(int idAgente)
        {
            var lista = new List<int>();

            using (var conexion = ConexionSQL.ObtenerConexion())
            using (var comando = new SqlCommand(@"
                    SELECT IdArchivo 
                        FROM AgenteArchivo
                    WHERE IdAgente = @IdAgente", conexion))
            {
                comando.Parameters.Add("@IdAgente", SqlDbType.Int).Value = idAgente;
                conexion.Open();

                using (var lector = comando.ExecuteReader())
                {
                    while (lector.Read())
                        lista.Add(lector.GetInt32(0));
                }
            }

            return lista;
        }

        public void EliminarArchivos(int idAgente, SqlConnection conexion, SqlTransaction transaccion)
        {
            using (var comando = new SqlCommand(
                "DELETE FROM AgenteArchivo WHERE IdAgente = @IdAgente",
                conexion, transaccion))
            {
                comando.Parameters.Add("@IdAgente", SqlDbType.Int).Value = idAgente;
                comando.ExecuteNonQuery();
            }
        }

    }
}
