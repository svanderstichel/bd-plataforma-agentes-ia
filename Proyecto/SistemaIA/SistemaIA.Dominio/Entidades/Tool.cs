using SistemaIA.Dominio.ValueObjects;

namespace SistemaIA.Dominio.Entidades
{
    public class Tool
    {
        public int IdTool { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public TipoTool Tipo { get; set; }

        public bool EsEspecializada()
        {
            return Tipo == TipoTool.Especializada;
        }

        public bool EsPredeterminada()
        {
            return Tipo == TipoTool.Predeterminada;
        }
    }
}
