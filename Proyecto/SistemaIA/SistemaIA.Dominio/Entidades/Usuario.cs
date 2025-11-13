using System;

namespace SistemaIA.Dominio.Entidades
{
    public class Usuario
    {
        public int IdUsuario { get; set; }
        public string Nombre { get; set; }
        public string Email { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaUltimaConexion { get; set; }
        public bool Activo { get; set; }

        public bool EstaActivo() => Activo;
        public void Desactivar() => Activo = false;
    }
}
