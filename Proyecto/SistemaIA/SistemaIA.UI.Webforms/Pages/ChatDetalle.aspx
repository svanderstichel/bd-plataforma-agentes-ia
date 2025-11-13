<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ChatDetalle.aspx.cs" Inherits="SistemaIA.UI.Webforms.Pages.ChatDetalle" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container-fluid px-3 px-md-4 py-3">

        <div class="d-flex justify-content-between align-items-center mb-4">

            <div>
                <h3 class="fw-bold text-dark mb-0">
                    <i class="bi bi-chat-square-text text-primary me-2"></i>
                    <asp:Label ID="lblNombreChat" runat="server" Text="Chat"></asp:Label>
                </h3>
                <asp:Label ID="lblFechaChat" runat="server" CssClass="text-muted small"></asp:Label>
            </div>

            <a href='<%= ResolveUrl("~/Pages/ChatListado.aspx?idAgente=" + Request.QueryString["idAgente"]) %>'
                class="btn btn-outline-secondary btn-sm fw-semibold">
                <i class="bi bi-arrow-left me-1"></i>Volver
            </a>
        </div>


        <div class="card border-0 shadow-sm rounded-3 bg-white chat-wrapper">


            <div id="contenedorMensajes" runat="server" class="chat-messages p-4"></div>

            <div class="chat-input p-3 border-top">
                <input type="text" class="form-control form-control-sm bg-light"
                    disabled placeholder="El envío está deshabilitado en modo historial." />
            </div>

        </div>

    </div>

</asp:Content>
