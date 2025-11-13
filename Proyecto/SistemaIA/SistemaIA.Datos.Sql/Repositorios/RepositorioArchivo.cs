using SistemaIA.Datos.Sql.Infraestructura;
using SistemaIA.Dominio.Entidades;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;


namespace SistemaIA.Datos.Sql.Repositorios
{
    public class RepositorioArchivo
    {

        public List<Archivo> ListarPorUsuario(int idUsuario)
        {
            var lista = new List<Archivo>();

            using (var conexion = ConexionSQL.ObtenerConexion())
            using (var comando = new SqlCommand(@"
                        SELECT IdArchivo, Nombre
                            FROM Archivo
                        WHERE IdUsuarioDueno = @IdUsuario;", conexion))
            {
                comando.Parameters.Add("@IdUsuario", SqlDbType.Int).Value = idUsuario;

                conexion.Open();
                using (var lector = comando.ExecuteReader())
                {
                    while (lector.Read())
                    {
                        var arc = new Archivo();
                        arc.IdArchivo = lector.GetInt32(0);
                        arc.Nombre = lector.GetString(1);

                        lista.Add(arc);
                    }
                }
            }

            return lista;
        }





    }
}
