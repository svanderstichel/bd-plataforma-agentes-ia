<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Reportes.aspx.cs" Inherits="SistemaIA.UI.Webforms.Pages.Reportes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container-fluid px-3 px-md-4 py-3">

        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="fw-bold text-dark mb-0">
                <i class="bi bi-bar-chart text-primary me-2"></i>
                Reporte de Actividad de Agentes
            </h3>

        </div>

        <div class="card border-0 shadow-sm rounded-3 p-4">
            <div class="row g-3">
                <div class="col-md-4">
                    <label class="form-label fw-semibold">Desde</label>
                    <asp:TextBox ID="txtDesde" runat="server" TextMode="Date" CssClass="form-control form-control-sm"></asp:TextBox>
                </div>

                <div class="col-md-4">
                    <label class="form-label fw-semibold">Hasta</label>
                    <asp:TextBox ID="txtHasta" runat="server" TextMode="Date" CssClass="form-control form-control-sm"></asp:TextBox>
                </div>

                <div class="col-md-4 d-flex align-items-end">
                    <asp:Button ID="btnFiltrar" runat="server" CssClass="btn btn-primary btn-sm fw-semibold me-2"
                        Text="Filtrar" OnClick="btnFiltrar_Click" />
                    <asp:Button ID="btnLimpiar" runat="server" CssClass="btn btn-secondary btn-sm fw-semibold"
                        Text="Limpiar" OnClick="btnLimpiar_Click" />
                </div>
            </div>
        </div>

        <div class="card border-0 shadow-sm rounded-3 mt-4 p-3">
            <asp:GridView ID="gvReporte" runat="server" AutoGenerateColumns="false"
                CssClass="table gridview mb-0" HeaderStyle-CssClass="gv-header"
                EmptyDataText="No se encontraron resultados.">

                <Columns>
                    <asp:BoundField DataField="NombreAgente" HeaderText="Agente" />
                    <asp:BoundField DataField="TotalChats" HeaderText="Total Chats" />
                    <asp:BoundField DataField="PrimeraActividad" HeaderText="Primera Actividad" />
                    <asp:BoundField DataField="UltimaActividad" HeaderText="Última Actividad" />
                    <asp:BoundField DataField="TotalUsuariosCompartidos" HeaderText="Usuarios Compartidos" />
                </Columns>

            </asp:GridView>
        </div>

    </div>

</asp:Content>
