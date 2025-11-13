using SGTO.UI.Webforms.Utils;
using SistemaIA.Negocio.DTOs;
using SistemaIA.Negocio.Servicios;
using System;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Web;
using System.Web.UI.WebControls;

namespace SistemaIA.UI.Webforms.Pages
{
    public partial class AgenteEditar : System.Web.UI.Page
    {
        private readonly ServicioAgente _servicio = new ServicioAgente();
        private const int ID_USUARIO = 1;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                CargarDatosIniciales();
        }

        private void CargarDatosIniciales()
        {
            int idAgente;
            if (!int.TryParse(Request.QueryString["idAgente"], out idAgente))
            {
                pnlError.Visible = true;
                pnlError.Controls.Add(new Literal { Text = "ID de agente inválido." });
                return;
            }

            hdnIdAgente.Value = idAgente.ToString();

            var agente = _servicio.ObtenerAgentePorId(idAgente);
            if (agente == null)
            {
                pnlError.Visible = true;
                pnlError.Controls.Add(new Literal { Text = "El agente no existe." });
                return;
            }

            txtNombre.Text = agente.Nombre;
            txtDescripcion.Text = agente.Descripcion;
            txtInstruccion.Text = agente.Instruccion;
            ddlTipo.SelectedValue = agente.Tipo;

            CargarArchivos();
            CargarTools();

            var archivosActuales = _servicio.ObtenerArchivosDeAgente(idAgente);

            foreach (ListItem item in chkArchivos.Items)
                item.Selected = archivosActuales.Contains(int.Parse(item.Value));

            pnlArchivos.Visible = ddlTipo.SelectedValue == "A";

            var toolsActuales = _servicio.ObtenerToolsDeAgente(idAgente);

            foreach (ListItem item in chkTools.Items)
                item.Selected = toolsActuales.Contains(int.Parse(item.Value));
        }

        private void CargarArchivos()
        {
            var archivos = _servicio.ObtenerArchivosUsuario(ID_USUARIO);

            chkArchivos.Items.Clear();

            foreach (var archivo in archivos)
            {
                chkArchivos.Items.Add(
                    new ListItem($"{archivo.Nombre} ({archivo.Tipo})", archivo.IdArchivo.ToString())
                );
            }
        }

        private void CargarTools()
        {
            var tools = _servicio.ObtenerTools();

            chkTools.Items.Clear();

            foreach (var t in tools)
            {
                if (t.Nombre == "Python")
                    continue;

                chkTools.Items.Add(
                    new ListItem(t.Nombre, t.IdTool.ToString())
                );
            }
        }

        protected void ddlTipo_SelectedIndexChanged(object sender, EventArgs e)
        {
            pnlArchivos.Visible = ddlTipo.SelectedValue == "A";
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                int idAgente = int.Parse(hdnIdAgente.Value);

                var dto = new AgenteEditarDto
                {
                    IdAgente = idAgente,
                    IdUsuario = ID_USUARIO,
                    Nombre = txtNombre.Text.Trim(),
                    Descripcion = txtDescripcion.Text.Trim(),
                    Instruccion = txtInstruccion.Text.Trim(),
                    Tipo = ddlTipo.SelectedValue,
                };

                foreach (ListItem item in chkArchivos.Items)
                    if (item.Selected)
                        dto.ArchivosSeleccionados.Add(int.Parse(item.Value));

                foreach (ListItem item in chkTools.Items)
                    if (item.Selected)
                        dto.ToolsSeleccionadas.Add(int.Parse(item.Value));

                _servicio.EditarAgente(dto);

                MensajeUiHelper.SetearYMostrar(
                    this.Page,
                    "Agente actualizado",
                    "El agente se ha actualizado correctamente.",
                    "Resultado",
                    VirtualPathUtility.ToAbsolute("~/Default.aspx"),
                    "abrirModalResultado"
                );
            }
            catch (SqlException ex)
            {
                Debug.WriteLine(ex.Message);
                pnlError.Visible = true;
                pnlError.Controls.Add(new Literal { Text = ex.Message });
                return;

            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
                MensajeUiHelper.SetearYMostrar(
                    this.Page,
                    "Error al ejecutar la acción",
                    ex.Message,
                    "Resultado",
                    null,
                    "abrirModalResultado");
            }
        }

    }
}