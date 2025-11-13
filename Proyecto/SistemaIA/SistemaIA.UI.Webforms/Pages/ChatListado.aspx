<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ChatListado.aspx.cs" Inherits="SistemaIA.UI.Webforms.Pages.Chats" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid px-3 px-md-4 py-3">

        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="fw-bold text-dark mb-0">
                <i class="bi bi-chat-dots text-primary me-2"></i>Historial de Chats
            </h3>

            <a href=<%= ResolveUrl("/Default") %> class="btn btn-outline-secondary btn-sm fw-semibold">
                <i class="bi bi-arrow-left me-1"></i>Volver
            </a>
        </div>

        <div class="card border-0 shadow-sm rounded-3 p-3 bg-white">
            <div id="contenedorChats" runat="server" class="d-flex flex-column gap-3"></div>

            <asp:Panel ID="pnlEmpty" runat="server" Visible="false"
                CssClass="p-5 text-center border border-2 border-dashed rounded-3 bg-white mt-3">
                <i class="bi bi-emoji-neutral text-secondary fs-4 d-block mb-2"></i>
                <p class="fw-semibold text-secondary mb-1">No hay chats disponibles para este agente.</p>
                <p class="text-muted small mb-3">Inicie una conversación para comenzar el registro de interacción.</p>
            </asp:Panel>
        </div>

    </div>
</asp:Content>
