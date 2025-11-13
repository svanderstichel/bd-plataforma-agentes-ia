using SistemaIA.Negocio.Servicios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SistemaIA.UI.Webforms.Pages
{
    public partial class Reportes : System.Web.UI.Page
    {
        private readonly ServicioReporte _servicio = new ServicioReporte();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                CargarReporte(null, null);
        }

        private void CargarReporte(DateTime? desde, DateTime? hasta)
        {
            int idUsuario = 1;

            var datos = _servicio.ObtenerReporte(idUsuario, desde, hasta);
            gvReporte.DataSource = datos;
            gvReporte.DataBind();
        }

        protected void btnFiltrar_Click(object sender, EventArgs e)
        {
            DateTime? desde = null;
            DateTime? hasta = null;

            DateTime temp;
            if (DateTime.TryParse(txtDesde.Text, out temp))
                desde = temp;

            if (DateTime.TryParse(txtHasta.Text, out temp))
                hasta = temp;

            CargarReporte(desde, hasta);
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            txtDesde.Text = "";
            txtHasta.Text = "";
            CargarReporte(null, null);
        }

    }
}