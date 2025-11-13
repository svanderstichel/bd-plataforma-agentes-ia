using MongoDB.Driver;

namespace SistemaIA.Datos.Mongo
{
    public class ConexionMongo
    {
        private static readonly string cadenaConexion = "mongodb://localhost:27017";
        private static readonly string nombreBase = "SistemaIA_Mongo";

        public static IMongoDatabase ObtenerBase()
        {
            var cliente = new MongoClient(cadenaConexion);
            return cliente.GetDatabase(nombreBase);
        }
    }
}
