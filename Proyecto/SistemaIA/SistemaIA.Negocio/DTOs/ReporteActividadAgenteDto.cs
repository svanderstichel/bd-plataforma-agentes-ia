
namespace SistemaIA.Negocio.DTOs
{
    public class ReporteActividadAgenteDto
    {
        public int IdAgente { get; set; }
        public string NombreAgente { get; set; }
        public string NombreUsuarioDueno { get; set; }
        public int TotalChats { get; set; }
        public string PrimeraActividad { get; set; }
        public string UltimaActividad { get; set; }
        public int TotalUsuariosCompartidos { get; set; }
    }
}
