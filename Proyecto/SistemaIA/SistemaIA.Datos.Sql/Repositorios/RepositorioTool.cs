using SistemaIA.Datos.Sql.Infraestructura;
using SistemaIA.Dominio.Entidades;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SistemaIA.Datos.Sql.Repositorios
{
    public class RepositorioTool
    {

        public List<Tool> ListarTools()
        {
            var lista = new List<Tool>();

            using (var conexion = ConexionSQL.ObtenerConexion())
            using (var comando = new SqlCommand(@"
                        SELECT IdTool, Nombre
                            FROM Tool
                        WHERE Nombre <> 'Python'", conexion))
            {
                conexion.Open();
                using (var lector = comando.ExecuteReader())
                {
                    while (lector.Read())
                    {
                        var t = new Tool();
                        t.IdTool = lector.GetInt32(0);
                        t.Nombre = lector.GetString(1);
                        lista.Add(t);
                    }
                }
            }

            return lista;
        }


    }
}
