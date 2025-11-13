<%@ Page Title="Crear Agente" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AgenteCrear.aspx.cs" Inherits="SistemaIA.UI.Webforms.Pages.AgenteCrear" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container-fluid px-3 px-md-4 py-3">

        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="fw-bold text-dark mb-0">
                <i class="bi bi-robot text-primary me-2"></i>Crear nuevo agente
            </h3>
            <a href='<%= ResolveUrl("~/Default.aspx") %>' class="btn btn-outline-secondary btn-sm fw-semibold">
                <i class="bi bi-arrow-left me-1"></i>Volver
            </a>
        </div>

        <div class="card border-0 shadow-sm rounded-3 p-4 bg-white">

            <div class="row g-3">

                <div class="col-12 col-md-6">
                    <label class="form-label fw-semibold">Nombre</label>
                    <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control"></asp:TextBox>
                </div>

                <div class="col-12 col-md-6">
                    <label class="form-label fw-semibold">Tipo</label>
                    <asp:DropDownList ID="ddlTipo" runat="server" CssClass="form-select"
                        AutoPostBack="true" OnSelectedIndexChanged="ddlTipo_SelectedIndexChanged">
                        <asp:ListItem Value="S" Text="Simple"></asp:ListItem>
                        <asp:ListItem Value="A" Text="Avanzado"></asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="col-12">
                    <label class="form-label fw-semibold">Descripción</label>
                    <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-control"
                        TextMode="MultiLine" Rows="2"></asp:TextBox>
                </div>

                <div class="col-12">
                    <label class="form-label fw-semibold">Instrucción</label>
                    <asp:TextBox ID="txtInstruccion" runat="server" CssClass="form-control"
                        TextMode="MultiLine" Rows="4"></asp:TextBox>
                </div>

                <asp:Panel ID="pnlArchivos" runat="server" Visible="false" CssClass="col-12 mt-3">
                    <label class="form-label fw-semibold">Archivos disponibles</label>
                    <asp:CheckBoxList ID="chkArchivos" runat="server" CssClass="list-group"></asp:CheckBoxList>
                </asp:Panel>

                <asp:Panel ID="pnlTools" runat="server" CssClass="col-12 mt-3">
                    <label class="form-label fw-semibold">Tools adicionales</label>
                    <asp:CheckBoxList ID="chkTools" runat="server" CssClass="list-group"></asp:CheckBoxList>
                </asp:Panel>

                <div class="col-12 mt-4">
                    <asp:Button ID="btnCrear" runat="server" Text="Crear agente"
                        CssClass="btn btn-primary fw-semibold"
                        OnClick="btnCrear_Click" />
                </div>

            </div>
        </div>

    </div>



    <%-- modal resultado --%>
    <div class="modal fade" id="modalResultado" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 id="modalResultadoTitulo" class="modal-title">Resultado</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p id="modalResultadoDesc"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" id="btnModalCerrar" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>


    <script>

        document.addEventListener("DOMContentLoaded", () => {

            // modal resultado
            window.abrirModalResultado = function (titulo, descripcion) {
                try {
                    document.getElementById('modalResultadoTitulo').textContent = titulo || "Resultado";
                    document.getElementById('modalResultadoDesc').textContent = descripcion || "";
                    new bootstrap.Modal(document.getElementById('modalResultado')).show();
                } catch (err) {
                    console.error("Error al abrir modal de resultado:", err);
                }
            };
        });
    </script>


</asp:Content>
