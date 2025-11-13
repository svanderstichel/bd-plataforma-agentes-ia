<%@ Page Title="Agentes" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SistemaIA.UI.Webforms._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container-fluid px-3 px-md-4 py-3">

        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="fw-bold text-dark mb-0">
                <i class="bi bi-people text-primary me-2"></i>Mis Agentes
            </h3>
            <asp:Label ID="lblUsuario" runat="server" CssClass="text-muted small"></asp:Label>
            <a href='<%= ResolveUrl("/Pages/AgenteCrear.aspx") %>' class="btn btn-outline-secondary btn-sm fw-semibold">
                <i class="bi bi-robot me-1"></i>Crear Agente
            </a>
        </div>


        <div class="card border-0 shadow-sm rounded-3 p-3 bg-white">
            <div id="contenedorAgentes" runat="server" class="d-flex flex-column gap-3"></div>


            <asp:Panel ID="pnlEmpty" runat="server" Visible="false" CssClass="p-5 text-center border border-2 border-dashed rounded-3 bg-white mt-3">
                <i class="bi bi-emoji-neutral text-secondary fs-4 d-block mb-2"></i>
                <p class="fw-semibold text-secondary mb-1">No se encontraron agentes.</p>
                <p class="text-muted small mb-3">Cree un nuevo agente para automatizar sus tareas y mejorar su flujo de trabajo.</p>
                <asp:Button ID="btnNuevo" runat="server" Text="Crear nuevo agente" CssClass="btn btn-primary fw-semibold" />
            </asp:Panel>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
            tooltipTriggerList.map(function (el) { return new bootstrap.Tooltip(el); });
        });
    </script>

</asp:Content>
