using SistemaIA.Negocio.Servicios;
using System;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SistemaIA.UI.Webforms.Pages
{
    public partial class Chats : System.Web.UI.Page
    {
        private readonly ServicioChat _servicioChat = new ServicioChat();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (int.TryParse(Request.QueryString["idAgente"], out int idAgente))
                    CargarChats(idAgente);
                else
                    Response.Redirect("~/Default.aspx", true);
            }
        }

        private void CargarChats(int idAgente)
        {
            var chats = _servicioChat.ObtenerChatsPorAgente(idAgente);

            if (chats == null || chats.Count == 0)
            {
                pnlEmpty.Visible = true;
                return;
            }

            pnlEmpty.Visible = false;
            var html = new StringBuilder();

            foreach (var c in chats)
            {
                html.Append($@"
                    <div class='agente-card'>
                        <div class='agente-info'>
                            <h6>{c.NombreChat}</h6>
                            <p class='text-muted mb-1'>Creado el {c.FechaCreacion}</p>
                        </div>
                        <div class='agente-tags'>
                            <span class='badge'>Chat</span>
                           <a href='ChatDetalle.aspx?idChat={c.IdChat}&idAgente={idAgente}&nombreChat={HttpUtility.UrlEncode(c.NombreChat)}&fechaCreacion={HttpUtility.UrlEncode(c.FechaCreacion)}' 
                               class='btn btn-sm btn-outline-primary'>
                                <i class='bi bi-eye me-1'></i>Ver
                            </a>
                        </div>
                    </div>");
            }

            contenedorChats.InnerHtml = html.ToString();
        }

    }
}