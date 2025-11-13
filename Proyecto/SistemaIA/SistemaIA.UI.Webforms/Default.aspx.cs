using SistemaIA.Negocio.DTOs;
using SistemaIA.Negocio.Servicios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SistemaIA.UI.Webforms
{
    public partial class _Default : Page
    {
        private readonly ServicioAgente _servicioAgente = new ServicioAgente();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int idUsuarioActual = 1;
                CargarAgentes(idUsuarioActual);
            }
        }

        private void CargarAgentes(int idUsuario)
        {
            List<AgenteDto> agentes = _servicioAgente.ObtenerAgentesDeUsuario(idUsuario);

            if (agentes == null || agentes.Count == 0)
            {
                pnlEmpty.Visible = true;
                return;
            }

            pnlEmpty.Visible = false;

            StringBuilder html = new StringBuilder();

            foreach (var a in agentes)
            {
                string icono = a.Tipo == "A" ? "bi bi-cpu" : "bi bi-robot";
                string badgeTipo = a.Tipo == "A" ? "Development" : "Assistant";
                string badgeRol = a.Rol == "Propietario" ? "Owner" : "Shared";

                string tooltip = !string.IsNullOrEmpty(a.CompartidoPor)
                    ? $"<i class='bi bi-link text-muted ms-2' data-bs-toggle='tooltip' title='Compartido con: {a.CompartidoPor}'></i>"
                    : "";

                html.Append($@"
                        <div class='agente-card'>
                            <div class='agente-info'>
                                <h6><i class='{icono} text-primary me-2'></i>{a.Nombre}</h6>
                                <p>{a.Descripcion}</p>
                            </div>

                            <div class='agente-meta'>
                                <span class='badge'>{badgeTipo}</span>
                                <span class='badge'>{badgeRol}</span>

                                <a href='Pages/ChatListado.aspx?idAgente={a.IdAgente}' 
                                   class='btn btn-outline-secondary btn-sm'>
                                    Ver Chats
                                </a>

                                <a href='Pages/AgenteEditar.aspx?idAgente={a.IdAgente}' 
                                   class='btn btn-outline-primary btn-sm ms-1'>
                                    <i class='bi bi-pencil-square me-1'></i>Editar
                                </a>
                            </div>
                        </div>");
            }

            contenedorAgentes.InnerHtml = html.ToString();
        }
    }
}