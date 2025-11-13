using SGTO.UI.Webforms.Utils;
using SistemaIA.Negocio.DTOs;
using SistemaIA.Negocio.Servicios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SistemaIA.UI.Webforms.Pages
{
    public partial class AgenteCrear : System.Web.UI.Page
    {

        private readonly ServicioAgente _servicioAgente = new ServicioAgente();
        private const int ID_USUARIO = 1;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarArchivos();
                CargarTools();
            }
        }

        private void CargarArchivos()
        {
            var archivos = _servicioAgente.ObtenerArchivosUsuario(ID_USUARIO);

            chkArchivos.Items.Clear();
            foreach (var a in archivos)
            {
                chkArchivos.Items.Add(new ListItem(a.Nombre, a.IdArchivo.ToString()));
            }
        }

        private void CargarTools()
        {
            var tools = _servicioAgente.ObtenerTools();

            chkTools.Items.Clear();
            foreach (var t in tools)
            {
                chkTools.Items.Add(new ListItem(t.Nombre, t.IdTool.ToString()));
            }
        }

        protected void ddlTipo_SelectedIndexChanged(object sender, EventArgs e)
        {
            pnlArchivos.Visible = ddlTipo.SelectedValue == "A";
        }

        protected void btnCrear_Click(object sender, EventArgs e)
        {
            var dto = new AgenteCrearDto();
            dto.IdUsuario = ID_USUARIO;
            dto.Nombre = txtNombre.Text.Trim();
            dto.Descripcion = txtDescripcion.Text.Trim();
            dto.Instruccion = txtInstruccion.Text.Trim();
            dto.Tipo = ddlTipo.SelectedValue;

            dto.ArchivosSeleccionados = new List<int>();
            dto.ToolsSeleccionadas = new List<int>();

            if (dto.Tipo == "A")
            {
                foreach (ListItem item in chkArchivos.Items)
                    if (item.Selected)
                        dto.ArchivosSeleccionados.Add(Convert.ToInt32(item.Value));
            }

            foreach (ListItem item in chkTools.Items)
                if (item.Selected)
                    dto.ToolsSeleccionadas.Add(Convert.ToInt32(item.Value));

            try
            {

                _servicioAgente.CrearAgente(dto);
                MensajeUiHelper.SetearYMostrar(
                   this.Page,
                   "Agente creado",
                   "El agente se ha creado correctamente.",
                   "Resultado",
                   VirtualPathUtility.ToAbsolute("~/Default.aspx"),
                   "abrirModalResultado"
               );
            }
            catch (Exception ex)
            {
                MensajeUiHelper.SetearYMostrar(this.Page,
                    "Error al ejecutar la acción",
                    ex.Message,
                    "Resultado",
                    null,
                    "abrirModalResultado");
            }

        }

    }
}