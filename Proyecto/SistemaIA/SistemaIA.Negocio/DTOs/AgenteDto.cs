namespace SistemaIA.Negocio.DTOs
{
    public class AgenteDto
    {
        public int IdAgente { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }

        public string Tipo { get; set; }

        public string Rol { get; set; }
        public string CompartidoPor { get; set; }
    }
}
