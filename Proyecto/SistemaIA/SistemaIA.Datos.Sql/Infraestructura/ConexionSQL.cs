using System.Data.SqlClient;

namespace SistemaIA.Datos.Sql.Infraestructura
{
    public class ConexionSQL
    {
        private static readonly string cadenaConexion = "server=.\\SQLEXPRESS; database=SistemaIA; integrated security=true";

        public static SqlConnection ObtenerConexion()
        {
            return new SqlConnection(cadenaConexion);
        }
    }
}
