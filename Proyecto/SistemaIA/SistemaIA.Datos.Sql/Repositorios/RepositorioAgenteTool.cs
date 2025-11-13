using SistemaIA.Datos.Sql.Infraestructura;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;


namespace SistemaIA.Datos.Sql.Repositorios
{
    public class RepositorioAgenteTool
    {
        public void AsignarTool(int idAgente, int idTool, SqlConnection conexion, SqlTransaction transaccion)
        {
            using (var comando = new SqlCommand("sp_Asignar_Tool_A_Agente", conexion, transaccion))
            {
                comando.CommandType = CommandType.StoredProcedure;

                comando.Parameters.Add("@IdAgente", SqlDbType.Int).Value = idAgente;
                comando.Parameters.Add("@IdTool", SqlDbType.Int).Value = idTool;

                comando.ExecuteNonQuery();
            }
        }


        public List<int> ObtenerToolsDeAgente(int idAgente)
        {
            var lista = new List<int>();

            using (var conexion = ConexionSQL.ObtenerConexion())
            using (var comando = new SqlCommand(@"
                    SELECT IdTool 
                        FROM AgenteTool
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

        public void EliminarTools(int idAgente, SqlConnection conexion, SqlTransaction transaccion)
        {
            using (var comando = new SqlCommand(
                "DELETE FROM AgenteTool WHERE IdAgente = @IdAgente",
                conexion, transaccion))
            {
                comando.Parameters.Add("@IdAgente", SqlDbType.Int).Value = idAgente;
                comando.ExecuteNonQuery();
            }
        }


    }
}
