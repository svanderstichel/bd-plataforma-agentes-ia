using System.Collections.Generic;

namespace SistemaIA.Negocio.DTOs
{
    public class AgenteEditarDto
    {
        public int IdAgente { get; set; }
        public int IdUsuario { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public string Instruccion { get; set; }
        public string Tipo { get; set; }  // "S" o "A"

        public List<int> ArchivosSeleccionados { get; set; } = new List<int>();
        public List<int> ToolsSeleccionadas { get; set; } = new List<int>();
    }
}
