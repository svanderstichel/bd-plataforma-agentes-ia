using System;

namespace SistemaIA.Dominio.Entidades
{
    public class Archivo
    {
        public int IdArchivo { get; set; }
        public int IdUsuarioDueno { get; set; }
        public int IdTipoArchivo { get; set; }
        public string Nombre { get; set; }
        public DateTime FechaSubida { get; set; }
        public int Peso { get; set; }
        public string Ruta { get; set; }

        public TipoArchivo TipoArchivo { get; set; }

        public string FormatoTamaño()
        {
            if (Peso < 1024) return Peso + " B";
            if (Peso < 1048576) return (Peso / 1024.0).ToString("F2") + " KB";
            return (Peso / 1048576.0).ToString("F2") + " MB";
        }

    }
}
