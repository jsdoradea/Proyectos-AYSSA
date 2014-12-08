<%@ Page Title="Acuerdos" Language="C#" MasterPageFile="~/portal/Main.master" AutoEventWireup="true" CodeFile="acuerdos.aspx.cs" Inherits="acuerdos_acuerdos" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxClasses" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div id="titulo" style="vertical-align: top; background-color: #003da5; width: 100%">
        <h2 style="font-family: Verdana, Geneva, Tahoma, sans-serif; font-size: medium; color: #FFFFFF">Relación y notificación de acuerdos tomados</h2>
    </div>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <table style="width:100%;">
        <tr>
            <td>Sesión:</td>
            <td><dx:ASPxTextBox ID="ASPxTextBox1" runat="server" Width="170px" Text="35-2014"></dx:ASPxTextBox></td>
            <td>Acta:</td>
            <td><dx:ASPxTextBox ID="ASPxTextBox2" runat="server" Width="170px" Text="6-2014"></dx:ASPxTextBox></td>
            <td>Fecha de registro:</td>
            <td><dx:ASPxTextBox ID="ASPxTextBox3" runat="server" Width="170px" Text="15/10/2014"></dx:ASPxTextBox></td>
        </tr>
    </table>
    <dx:ASPxPageControl ID="tabAcuerdos" runat="server" ActiveTabIndex="1" Theme="Glass" Width="100%">
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
                                    <dx:ASPxButton ID="ASPxButton3" runat="server" Text="Nuevo acuerdo" OnClick="ASPxButton3_Click"></dx:ASPxButton>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">&nbsp;</td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="DevEx" Width="100%">
                                        <Columns>
                                            <dx:GridViewDataTextColumn Caption="Correlativo" FieldName="NM_CORR_ACUERDO" ShowInCustomizationForm="True" VisibleIndex="0">
                                                <CellStyle HorizontalAlign="Left">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Acuerdo" FieldName="DS_ACUERDO_COMP" ShowInCustomizationForm="True" VisibleIndex="1">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataDateColumn Caption="Fecha" FieldName="FECH_CREA" ShowInCustomizationForm="True" VisibleIndex="2">
                                            </dx:GridViewDataDateColumn>
                                        </Columns>
                                    </dx:ASPxGridView>
                                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SCSA %>" SelectCommand="SELECT NM_CORR_ACUERDO, DS_ACUERDO_COMP, FECH_CREA
  FROM [SCSA].[dbo].[ACU_ENCA_ACUERDOS]"></asp:SqlDataSource>
                                </td>
                            </tr>
                        </table>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage Name="detalles" Text="Detalles">
                <ContentCollection>
                    <dx:ContentControl runat="server">
                        <dx:ASPxPageControl ID="ASPxPageControl1" Width="100%" runat="server" ActiveTabIndex="1">
                            <TabPages>
                                <dx:TabPage Text="Acuerdos">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <div id="datos1" style="border: thin solid #000000; width: 100%">
                                                <table style="width: 100%">
                                                    <tr>
                                                        <td>
                                                            <label>Acuerdo (texto descriptivo):</label></td>
                                                        <td colspan="3">
                                                            <dx:ASPxMemo ID="ASPxMemo1" runat="server" Height="71px" Width="100%" Rows="2"></dx:ASPxMemo>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <label>Acuerdo (texto legal):</label>
                                                        </td>
                                                        <td colspan="3">
                                                            <dx:ASPxMemo ID="ASPxMemo2" runat="server" Height="71px" Width="100%" Rows="2"></dx:ASPxMemo>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <label>Tipo de acuerdo:</label>
                                                        </td>
                                                        <td colspan="3">
                                                            <asp:DropDownList ID="DDLTipo" runat="server">
                                                                <asp:ListItem Value="0">Acuerdo por Licencias de Personal</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <label>Notifiquese a:</label></td>
                                                        <td>
                                                            <asp:DropDownList ID="DDLNotificacion" runat="server">
                                                                <asp:ListItem Value="0">María Cruz - Comunicaciones</asp:ListItem>
                                                            </asp:DropDownList></td>
                                                        <td>
                                                            <label>En calidad de:</label></td>
                                                        <td>
                                                            <asp:RadioButtonList ID="Radio" runat="server" Font-Size="X-Small" Width="230px">
                                                                <asp:ListItem Selected="True" Value="I">Interesado</asp:ListItem>
                                                                <asp:ListItem Value="R">Responsable</asp:ListItem>
                                                            </asp:RadioButtonList></td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:TabPage>
                                <dx:TabPage Text="Envio de notificaciones">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">
                                            <table style="width:100%;">
                                                <tr>
                                                    <td><strong>Interesados a Notificar:</strong></td>
                                                    <td><strong>Responsables a Notificar:</strong></td>
                                                    <td><strong>Informe:</strong></td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:ListBox ID="ListBox1" runat="server">
                                                            <asp:ListItem Value="1">María Cruz - Planificación</asp:ListItem>
                                                            <asp:ListItem Value="2">Julio Ramirez - Administración</asp:ListItem>
                                                        </asp:ListBox></td>
                                                    <td>
                                                        <asp:ListBox ID="ListBox2" runat="server">
                                                            <asp:ListItem Value="1">Zuleyma Guardado – Adquisiciones</asp:ListItem>
                                                            <asp:ListItem Value="2">Salvador Quintanilla - Informática</asp:ListItem>
                                                            <asp:ListItem Value="3">Luis Dueñas - Secretaría General</asp:ListItem>
                                                        </asp:ListBox></td>
                                                    <td>&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Enviar notificaciones"></dx:ASPxButton>
                                                    </td>
                                                    <td>
                                                        <dx:ASPxButton ID="ASPxButton2" runat="server" Text="Generar notificaciones"></dx:ASPxButton>
                                                    </td>
                                                    <td>&nbsp;</td>
                                                </tr>
                                            </table>
                                        </dx:ContentControl>
                                    </ContentCollection>
                                </dx:TabPage>
                            </TabPages>
                        </dx:ASPxPageControl>
                        <table style="width: 100%">
                            <tr>
                                <td style="text-align: right">
                                    <asp:Button ID="Button2" runat="server" Text="Guardar" OnClick="Button2_Click" />&nbsp;&nbsp;
                                <asp:Button ID="Button1" runat="server" Text="Cancelar" OnClick="Button1_Click" />
                                </td>
                            </tr>
                        </table>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
        </TabPages>
    </dx:ASPxPageControl>
</asp:Content>

