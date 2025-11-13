using SistemaIA.Negocio.DTOs;
using SistemaIA.Negocio.Servicios;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SistemaIA.UI.Webforms.Pages
{
    public partial class ChatDetalle : System.Web.UI.Page
    {
        private readonly ServicioChat _servicioChat = new ServicioChat();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                CargarChat();
        }

        private void CargarChat()
        {
            int idChat;
            if (!int.TryParse(Request.QueryString["idChat"], out idChat))
            {
                Response.Redirect("~/Default.aspx", true);
                return;
            }

            List<MensajeChatDto> mensajes = _servicioChat.ObtenerMensajesPorChat(idChat);

            lblNombreChat.Text = Request.QueryString["nombreChat"] ?? "Chat";
            lblFechaChat.Text = "Creado el: " + (Request.QueryString["fechaCreacion"] ?? "");

            foreach (MensajeChatDto msg in mensajes)
            {
                string html = "";

                switch (msg.Rol)
                {
                    case "user":
                        html = GenerarMensajeUsuario(msg.Contenido);
                        break;

                    case "assistant":
                        html = GenerarMensajeAsistente(msg.Contenido);
                        break;

                    case "system":
                        html = GenerarMensajeSistema(msg.Contenido);
                        break;

                    case "tool":
                        html = GenerarMensajeTool(msg.Contenido);
                        break;

                    default:
                        html = "";
                        break;
                }

                contenedorMensajes.InnerHtml += html;
            }
        }

        private string GenerarMensajeUsuario(string contenido)
        {
            return @"
                <div class='chat-row user'>
                    <div class='chat-message chat-user'>" + contenido + @"</div>
                </div>";
        }

        private string GenerarMensajeAsistente(string contenido)
        {
            return @"
                <div class='chat-row assistant'>
                    <div class='chat-message chat-assistant'>" + contenido + @"</div>
                </div>";
        }

        private string GenerarMensajeSistema(string contenido)
        {
            return @"
                <div class='chat-system'>" + contenido + @"</div>";
        }

        private string GenerarMensajeTool(string contenido)
        {
            return @"
                <div class='chat-tool'>
                    <i class='bi bi-gear me-1'></i>" + contenido + @"
                </div>";
        }

    }
}