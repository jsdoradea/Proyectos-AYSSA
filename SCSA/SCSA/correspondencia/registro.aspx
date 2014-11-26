<%@ Page Title="Correspondencia" Language="C#" MasterPageFile="~/portal/Main.master" AutoEventWireup="true" CodeFile="registro.aspx.cs" Inherits="correspondencia_registro" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxClasses" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div id="titulo" style="vertical-align: top; background-color: #003da5; width: 100%">
        <h2 style="font-family: Verdana, Geneva, Tahoma, sans-serif; font-size: medium; color: #FFFFFF">Registro de correspondencia normal y puntos de sesión</h2>
    </div>


    <dx:ASPxPageControl ID="TabCorrespondencia" runat="server" ActiveTabIndex="0" Width="100%" Theme="Glass">
        <TabPages>
            <dx:TabPage Name="datos" Text="Datos">
                <ContentCollection>
                    <dx:ContentControl runat="server">
                        <table>
                            <tr>
                                <td>
                                    <label>Periodo:</label></td>
                                <td>
                                    <dx:ASPxComboBox ID="ASPxComboBox1" runat="server">
                                        <Items>
                                            <dx:ListEditItem Text="OCT-2014" Value="102014" />
                                            <dx:ListEditItem Text="NOV-2014" Value="112014" Selected="true" />
                                        </Items>
                                    </dx:ASPxComboBox>
                                </td>
                                <td><dx:ASPxButton ID="ASPxButton3" runat="server" Text="Nueva solicitud" OnClick="ASPxButton3_Click"></dx:ASPxButton></td>
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
                                            <dx:GridViewDataTextColumn FieldName="DS_PUNTO_AGENDA" ShowInCustomizationForm="True" VisibleIndex="1" Caption="Punto de Agenda">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="Solicitate" ShowInCustomizationForm="True" VisibleIndex="2" ReadOnly="True" Caption="Solicitante">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataDateColumn FieldName="FECH_CREA" ShowInCustomizationForm="True" VisibleIndex="3" Caption="Fecha de registro">
                                            </dx:GridViewDataDateColumn>
                                        </Columns>
                                    </dx:ASPxGridView>
                                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SCSA %>" SelectCommand="select a.DS_PUNTO_AGENDA, b.DS_NOMBRE_SOLICITANTE+' '+b.DS_APELLIDO_SOLICITANTE as Solicitate,  a.FECH_CREA from dbo.AGD_PUNTOS_AGENDA a
INNER JOIN dbo.GLB_SOLICITANTES b ON b.CD_SOLICITANTE=a.CD_SOLICITANTE"></asp:SqlDataSource>
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
                                        <label>Estado:</label></td>
                                    <td>
                                        <dx:ASPxDropDownEdit ID="ASPxDropDownEdit1" runat="server" Theme="Glass" Text="DIGITADO">
                                        </dx:ASPxDropDownEdit>
                                    </td>
                                    <td style="text-align: right">
                                        <label>Fecha de registro:</label></td>
                                    <td style="text-align: right">&nbsp;<input type="date" id="cal1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <div id="form_reg" style="border-style: solid; border-width: 1px;">
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td style="width: 20%">
                                                        <label>Fecha de Solicitud:</label></td>
                                                    <td style="width: 80%">
                                                        <input type="date" id="Date2" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 20%">
                                                        <label>Nombre de solicitud:</label></td>
                                                    <td style="width: 80%">
                                                        <asp:TextBox ID="TextBox1" runat="server" Width="90%" Rows="3" TextMode="MultiLine"></asp:TextBox></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 20%">
                                                        <label>Justificación:</label></td>
                                                    <td style="width: 80%">
                                                        <asp:TextBox ID="TextBox2" runat="server" TextMode="MultiLine" Rows="4" Width="90%"></asp:TextBox></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 20%">
                                                        <label>Origen de Solicitud:</label></td>
                                                    <td style="width: 80%">
                                                        <table style="width: 100%;">
                                                            <tr>
                                                                <td>
                                                                    <asp:DropDownList ID="DDLOrigen" runat="server"></asp:DropDownList>
                                                                </td>
                                                                <td>
                                                                    <dx:ASPxRadioButtonList ID="RdTipo" runat="server">
                                                                        <Items>
                                                                            <dx:ListEditItem Text="Soporte de acta" Value="0" selected="true" />
                                                                            <dx:ListEditItem Text="Correspondencia Normal" Value="1" />
                                                                        </Items>
                                                                    </dx:ASPxRadioButtonList>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 20%">
                                                        <label>Solicitante:</label></td>
                                                    <td style="width: 80%">
                                                        <asp:DropDownList ID="DDLSolicitantes" runat="server" Height="16px" Width="531px">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                            </table>
                                            <br />
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td style="text-align: right">
                                        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Guardar" />
                                        &nbsp;&nbsp;<asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Cancelar" />
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

