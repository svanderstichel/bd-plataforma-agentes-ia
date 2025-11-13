using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SistemaIA.Negocio.DTOs
{
    public class AgenteCrearDto
    {
        public int IdUsuario { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public string Instruccion { get; set; }
        public string Tipo { get; set; } // S o A

        public List<int> ArchivosSeleccionados { get; set; }
        public List<int> ToolsSeleccionadas { get; set; }
    }

}
