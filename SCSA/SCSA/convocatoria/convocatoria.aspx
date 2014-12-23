<%@ Page Title="Convocatoria" Language="C#" MasterPageFile="~/portal/Main.master" AutoEventWireup="true" CodeFile="convocatoria.aspx.cs" Inherits="convocatoria_convocatoria" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridLookup" TagPrefix="dx" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxClasses" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>



<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">

    <div id="titulo" style="vertical-align: top; background-color: #003da5; width: 100%">
        <h2 style="font-family: Verdana, Geneva, Tahoma, sans-serif; font-size: medium; color: #FFFFFF">Convocatoria a sesión de pleno</h2>
    </div>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <dx:ASPxPageControl ID="TabConvocatoria" runat="server" ActiveTabIndex="1" Width="100%" Theme="Glass">
        <TabPages>
            <dx:TabPage Name="datos" Text="Datos">
                <ContentCollection>
                    <dx:ContentControl runat="server">
                        <table>
                            <tr>
                                <td>
                                    <label>Periodo:</label></td>
                                <td>
                                    <dx:ASPxComboBox ID="ASPxComboBox1" runat="server" SelectedIndex="0">
                                        <Items>
                                            <dx:ListEditItem Text="NOV-2014" Value="112014" Selected="true" />
                                            <dx:ListEditItem Text="OCT-2014" Value="102014" />
                                        </Items>
                                    </dx:ASPxComboBox>
                                </td>
                                <td>
                                    <dx:ASPxButton ID="ASPxButton3" runat="server" Text="Nueva convocatoria" OnClick="ASPxButton3_Click"></dx:ASPxButton>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">&nbsp;</td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="DevEx">
                                        <Columns>
                                            <dx:GridViewCommandColumn ShowEditButton="True" ShowInCustomizationForm="True" VisibleIndex="0">
                                            </dx:GridViewCommandColumn>
                                            <dx:GridViewDataTextColumn FieldName="CD_EJERCICIO" ShowInCustomizationForm="True" VisibleIndex="1" Caption="Ejercicio">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="DS_REFERENCIA" ShowInCustomizationForm="True" VisibleIndex="2" Caption="Referencia">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataDateColumn FieldName="FE_FECHA_PROP_INI" ShowInCustomizationForm="True" VisibleIndex="3" Caption="Fecha propuesta de inicio">
                                            </dx:GridViewDataDateColumn>
                                            <dx:GridViewDataDateColumn FieldName="FECH_CREA" ShowInCustomizationForm="True" VisibleIndex="4" Caption="Fecha de registro">
                                            </dx:GridViewDataDateColumn>
                                        </Columns>
                                    </dx:ASPxGridView>
                                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SCSA %>" SelectCommand="select CD_EJERCICIO, DS_REFERENCIA, FE_FECHA_PROP_INI, HO_HORA_PROP_INI, FECH_CREA from dbo.AGD_ENCA_CONVOCATORIA"></asp:SqlDataSource>
                                </td>
                            </tr>
                        </table>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage Name="detalles" Text="Detalles">
                <ContentCollection>
                    <dx:ContentControl runat="server">
                        <div id="detalles">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <label>Referencia:</label></td>
                                    <td>
                                        <asp:TextBox ID="TextBox1" runat="server" BackColor="#FF9900"></asp:TextBox></td>
                                    <td style="text-align: right">
                                        <label>Fecha de registro:</label></td>
                                    <td style="text-align: right">
                                        <input type="date" id="f_reg" /></td>
                                </tr>
                            </table>
                            <div id="tabs">
                                <dx:ASPxPageControl ID="TabSesion" runat="server" Width="100%" Theme="DevEx" ActiveTabIndex="2">

                                    <TabPages>
                                        <dx:TabPage Text="Convocatoria Sesión">
                                            <ContentCollection>
                                                <dx:ContentControl runat="server">
                                                    <table style="width: 100%">
                                                        <tr>
                                                            <td>
                                                                <label>Referencia:</label></td>
                                                            <td>
                                                                <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox></td>
                                                            <td>
                                                                <label>Fecha de sesión:</label></td>
                                                            <td>
                                                                <input type="date" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <label>Tipo de sesión:</label></td>
                                                            <td>
                                                                <asp:DropDownList ID="DDLTipoSesion" runat="server">
                                                                    <asp:ListItem Value="O">ORDINARIA</asp:ListItem>
                                                                    <asp:ListItem Value="E">EXTRAORDINARIA</asp:ListItem>
                                                                </asp:DropDownList></td>
                                                            <td>
                                                                <label>Hora de sesión:</label></td>
                                                            <td>
                                                                <input type="time" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <label>Estado:</label></td>
                                                            <td>
                                                                <asp:DropDownList ID="DDLEstadoSesion" runat="server">
                                                                    <asp:ListItem Value="E">Digitada</asp:ListItem>
                                                                    <asp:ListItem Value="E">Enviada</asp:ListItem>
                                                                    <asp:ListItem Value="A">Iniciada</asp:ListItem>
                                                                    <asp:ListItem Value="P">Pausada</asp:ListItem>
                                                                    <asp:ListItem Value="R">Reprogramada</asp:ListItem>
                                                                    <asp:ListItem Value="C">Cerrada</asp:ListItem>
                                                                </asp:DropDownList></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <label>Miembros del pleno a convocar:</label></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                            <td>
                                                                <asp:CheckBox ID="CheckBox1" runat="server" Text="Todo el pleno" AutoPostBack="True" OnCheckedChanged="CheckBox1_CheckedChanged" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align: center;">
                                                                <asp:ListBox ID="ListMiembros" runat="server">
                                                                    <asp:ListItem Value="1">Miembro 1 (propietario)</asp:ListItem>
                                                                    <asp:ListItem Value="2">Miembro 5 (propietario)</asp:ListItem>
                                                                    <asp:ListItem Value="3">Miembro 6 (suplente)</asp:ListItem>
                                                                    <asp:ListItem Value="4">Miembro 7 (suplente)</asp:ListItem>
                                                                </asp:ListBox>
                                                            </td>
                                                            <td colspan="2" style="text-align: center;">
                                                                <asp:Button ID="btnTodosIzq" runat="server" Text="<<" OnClick="btnTodosIzq_Click" /><br />
                                                                <asp:Button ID="btnUnoIzq" runat="server" Text=" < " OnClick="btnUnoIzq_Click" /><br />
                                                                <asp:Button ID="btnUnoDer" runat="server" Text=" > " OnClick="btnUnoDer_Click" /><br />
                                                                <asp:Button ID="btnTodosDer" runat="server" Text=">>" OnClick="btnTodosDer_Click" />
                                                            </td>
                                                            <td>
                                                                <asp:ListBox ID="ListSelect" runat="server">
                                                                    <asp:ListItem Value="0">--Seleccione miembros a convocar--</asp:ListItem>
                                                                </asp:ListBox>
                                                            </td>
                                                        </tr>

                                                    </table>
                                                </dx:ContentControl>
                                            </ContentCollection>
                                        </dx:TabPage>

                                        <dx:TabPage Text="Puntos a tratar">
                                            <ContentCollection>
                                                <dx:ContentControl runat="server">
                                                    <strong>Puntos solicitados a tratar:</strong><br /><dx:ASPxGridView ID="ASPxGridView3" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource4" EnableTheming="True" Theme="DevEx" Width="100%">
                                                        <Columns>
                                                            <dx:GridViewDataTextColumn Caption="Punto de Agenda" FieldName="DS_PUNTO_AGENDA" ShowInCustomizationForm="True" VisibleIndex="0">
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataDateColumn Caption="Fecha de Solicitud" FieldName="FE_FECH_SOLIC" ShowInCustomizationForm="True" VisibleIndex="1">
                                                            </dx:GridViewDataDateColumn>
                                                            <dx:GridViewDataTextColumn Caption="Solicitante" FieldName="solicitante" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="2">
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataCheckColumn Caption="Punto" FieldName="TIPO_PUNTO" ShowInCustomizationForm="True" VisibleIndex="3">
                                                            </dx:GridViewDataCheckColumn>
                                                            <dx:GridViewDataCheckColumn Caption="Varios" FieldName="VARIOS" ShowInCustomizationForm="True" VisibleIndex="4">
                                                            </dx:GridViewDataCheckColumn>
                                                        </Columns>
                                                        <Settings ShowFilterRow="True" ShowGroupPanel="True" />
                                                    </dx:ASPxGridView>
                                                    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:SCSA %>" SelectCommand="select a.DS_PUNTO_AGENDA, a.FE_FECH_SOLIC, b.DS_NOMBRE_SOLICITANTE + ' ' + b.DS_APELLIDO_SOLICITANTE as solicitante, a.TIPO_PUNTO, a.VARIOS from dbo.AGD_PUNTOS_AGENDA a
INNER JOIN dbo.GLB_SOLICITANTES b ON b.CD_SOLICITANTE = a.CD_SOLICITANTE"></asp:SqlDataSource>

                                                </dx:ContentControl>
                                            </ContentCollection>
                                        </dx:TabPage>
                                        <dx:TabPage Text="Agenda Sugerida">
                                            <ContentCollection>
                                                <dx:ContentControl runat="server">
                                                    <table style="width: 100%;">
                                                        <tr>
                                                            <td style="width: 50%; vertical-align: top;">
                                                                <div class="toggler">
                                                                    <div id="effect" class="ui-widget-content ui-corner-all">
                                                                        <h3 class="ui-widget-header ui-corner-all">Agenda a Notificar</h3>
                                                                        <asp:ListBox ID="ListAgenda" runat="server">
                                                                            <asp:ListItem Value="1">Inventario – Solicitud Consumibles para Impresoras</asp:ListItem>
                                                                            <asp:ListItem Value="2">Juan Pérez – Solicitud Licencia por 5 días a causa de Viaje</asp:ListItem>
                                                                            <asp:ListItem Selected="True" Value="3">Varios</asp:ListItem>
                                                                        </asp:ListBox>
                                                                    </div>
                                                                </div>
                                                                <br />
                                                                <table class="tabla">
                                                                    <thead>
                                                                        <tr>
                                                                            <th style="text-align: left;">Subpunto</th>
                                                                            <th style="text-align: left;">Descripción</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <tr>
                                                                            <td style="text-align: left;">Mención Honorifica</td>
                                                                            <td style="text-align: left;">Reconocimiento a Luisa Gomez</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="text-align: left;">Celebración Nacional</td>
                                                                            <td style="text-align: left;">Pronunciación sobre Feriado Nacional</td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </td>
                                                            <td style="width: 50%; vertical-align: top;" align="center" valign="middle">
                                                                <%--<asp:SqlDataSource ID="SqlDataSource2" runat="server" SelectCommand="select agenda"></asp:SqlDataSource>

                                                                <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Height="325px" Width="100%">
                                                                    <LocalReport ReportEmbeddedResource="ReptAgenda.rdlc" ReportPath="convocatoria/ReptAgenda.rdlc">
                                                                        <DataSources>
                                                                            <rsweb:ReportDataSource DataSourceId="SqlDataSource2" Name="" />
                                                                        </DataSources>
                                                                    </LocalReport>
                                                                </rsweb:ReportViewer>--%>
                                                                <br />
                                                                <dx:ASPxButton ID="ASPxButton4" runat="server" AutoPostBack="False" OnClick="ASPxButton4_Click" Text="Generar agenda preliminar">
                                                                </dx:ASPxButton>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </dx:ContentControl>
                                            </ContentCollection>
                                        </dx:TabPage>
                                        <dx:TabPage Text="Notificar">
                                            <ContentCollection>
                                                <dx:ContentControl runat="server">
                                                    <table>
                                                        <tr>
                                                            <td class="dxeCaptionHACSys">
                                                                <label>Miembros convocados </label>
                                                            </td>
                                                            <td class="dxeCaptionHACSys">
                                                                <label>Puntos sugeridos </label>
                                                            </td>
                                                            <td></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="dxeCaptionHACSys">
                                                                <asp:ListBox ID="ListBox1" runat="server">
                                                                    <asp:ListItem>Miembro 1</asp:ListItem>
                                                                    <asp:ListItem>Miembro 2</asp:ListItem>
                                                                    <asp:ListItem>Miembro 3</asp:ListItem>
                                                                </asp:ListBox></td>
                                                            <td class="dxeCaptionHACSys">
                                                                <asp:ListBox ID="ListBox2" runat="server">
                                                                    <asp:ListItem>UACI</asp:ListItem>
                                                                    <asp:ListItem>Permisos</asp:ListItem>
                                                                </asp:ListBox></td>
                                                            <td>
                                                                <asp:Button ID="Button7" runat="server" OnClick="Button7_Click" Text="Generar Convocatoria" />
                                                            </td>
                                                        </tr>
                                                    </table>

                                                </dx:ContentControl>
                                            </ContentCollection>
                                        </dx:TabPage>
                                        <dx:TabPage Text="Reprogramaciones">
                                            <ContentCollection>
                                                <dx:ContentControl runat="server">
                                                    <table>
                                                        <tr>
                                                            <td colspan="4"><strong>Posponer convocatoria actual:</strong></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Fecha y hora de sesión</td>
                                                            <td>
                                                                <input type="date" id="c1" /></td>
                                                            <td>
                                                                <input type="time" id="h1" /></td>
                                                            <td>
                                                                <asp:Button ID="Button4" runat="server" Text="Posponer convocatoria" Width="200px" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Tipo Sesión:</td>
                                                            <td>
                                                                <asp:DropDownList ID="DropDownList1" runat="server">
                                                                    <asp:ListItem>Ordinaria</asp:ListItem>
                                                                    <asp:ListItem>Extraordinaria</asp:ListItem>
                                                                </asp:DropDownList></td>
                                                            <td>&nbsp;</td>
                                                            <td>
                                                                <asp:Button ID="Button5" runat="server" Text="Notificar nuevamente" Width="200px" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Fecha y hora de reprogramación</td>
                                                            <td>
                                                                <input type="date" id="Date2" /></td>
                                                            <td>
                                                                <input type="time" id="Time2" /></td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>Motivo o razón:</td>
                                                            <td colspan="3">
                                                                <dx:ASPxMemo ID="ASPxMemoMotivo" runat="server" Width="100%" Rows="3"></dx:ASPxMemo>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="4">
                                                                <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource3" EnableTheming="True" Theme="DevEx">
                                                                    <Columns>
                                                                        <dx:GridViewDataTextColumn Caption="N° Convocatoria" FieldName="Convocatoria" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="0">
                                                                        </dx:GridViewDataTextColumn>
                                                                        <dx:GridViewDataDateColumn Caption="Fecha para reprogramación" FieldName="FE_FECH_PROP" ShowInCustomizationForm="True" VisibleIndex="1">
                                                                        </dx:GridViewDataDateColumn>
                                                                        <dx:GridViewDataTextColumn Caption="Hora de reprogramación" FieldName="HO_HORA_PROP" ShowInCustomizationForm="True" VisibleIndex="2">
                                                                        </dx:GridViewDataTextColumn>
                                                                        <dx:GridViewDataTextColumn Caption="Motivo" FieldName="DS_MOTIVO_REPRO" ShowInCustomizationForm="True" VisibleIndex="3">
                                                                        </dx:GridViewDataTextColumn>
                                                                    </Columns>
                                                                </dx:ASPxGridView>
                                                                <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:SCSA %>" SelectCommand="select ROW_NUMBER() OVER(ORDER BY CD_DETA_CONV_REPRO DESC) AS Convocatoria, FE_FECH_PROP, HO_HORA_PROP, DS_MOTIVO_REPRO from dbo.AGD_DETA_CONVOCATORIA_REPROG"></asp:SqlDataSource>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </dx:ContentControl>
                                            </ContentCollection>
                                        </dx:TabPage>
                                        <dx:TabPage Text="Solicitudes">
                                            <ContentCollection>
                                                <dx:ContentControl ID="ContentControl1" runat="server">
                                                    <div style="margin: 0 auto;">
                                                        <table style="width: 100%">
                                                            <tr>
                                                                <td style="width: 20%">
                                                                    <label>Estado:</label></td>
                                                                <td style="width: 80%">
                                                                    <asp:DropDownList ID="DDLEstadoSolicitud" runat="server">
                                                                        <asp:ListItem Value="0">DIGITADO</asp:ListItem>
                                                                    </asp:DropDownList></td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2">
                                                                    <div style="width: 100%; border-style: solid; border-width: 1px;">
                                                                        <table style="width: 100%">
                                                                            <tr>
                                                                                <td style="width: 20%">
                                                                                    <label>Fecha de Solicitud:</label></td>
                                                                                <td style="width: 80%">
                                                                                    <input type="date" /></td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="width: 20%">
                                                                                    <label>Nombre de solicitud:</label></td>
                                                                                <td style="width: 80%">
                                                                                    <asp:TextBox ID="TextBox3" runat="server" Width="90%" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="width: 20%">
                                                                                    <label>Justificación:</label></td>
                                                                                <td style="width: 80%">
                                                                                    <asp:TextBox ID="TextBox4" runat="server" Width="90%" TextMode="MultiLine" Rows="3"></asp:TextBox></td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="width: 20%">
                                                                                    <label>Orígen de Solicitud:</label></td>
                                                                                <td style="width: 80%">
                                                                                    <asp:DropDownList ID="DDLOrigen" runat="server"></asp:DropDownList></td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="width: 20%">
                                                                                    <label>Solicitante:</label></td>
                                                                                <td style="width: 80%">
                                                                                    <asp:DropDownList ID="DDLSolicitantes" runat="server" Width="500px">
                                                                                    </asp:DropDownList>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </dx:ContentControl>
                                            </ContentCollection>
                                        </dx:TabPage>
                                    </TabPages>

                                </dx:ASPxPageControl>
                            </div>
                            <table style="width: 100%">
                                <tr>
                                    <td style="text-align: right">
                                        <asp:Button ID="Button2" runat="server" Text="Guardar" OnClick="Button2_Click" />&nbsp;&nbsp;
                                <asp:Button ID="Button1" runat="server" Text="Cancelar" OnClick="Button1_Click" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
        </TabPages>
    </dx:ASPxPageControl>
</asp:Content>

