<%@ Page Title="Quorum" Language="C#" MasterPageFile="~/portal/Main.master" AutoEventWireup="true" CodeFile="quorum.aspx.cs" Inherits="quorum_quorum" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxClasses" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div id="titulo" style="vertical-align: top; background-color: #003da5; width: 100%">
        <h2 style="font-family: Verdana, Geneva, Tahoma, sans-serif; font-size: medium; color: #FFFFFF">Desarrollo de sesión de pleno</h2>
    </div>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <dx:ASPxPageControl ID="tabQuorum" runat="server" ActiveTabIndex="1" Width="100%" Theme="Glass">
        <TabPages>
            <dx:TabPage Name="Datos" Text="Datos">
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
                                    <dx:ASPxButton ID="ASPxButton3" runat="server" Text="Nuevo quorum" OnClick="ASPxButton3_Click"></dx:ASPxButton>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">&nbsp;</td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <dx:ASPxGridView ID="ASPxGridView1" runat="server" Theme="DevEx" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" Width="100%">
                                        <Columns>
                                            <dx:GridViewCommandColumn Caption="Editar" ShowEditButton="True" ShowInCustomizationForm="True" VisibleIndex="0">
                                            </dx:GridViewCommandColumn>
                                            <dx:GridViewDataTextColumn Caption="Referencia" FieldName="DS_REFERENCIA" ShowInCustomizationForm="True" VisibleIndex="1">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Tipo de Sesión" FieldName="TIPO" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="2">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Estado" FieldName="ESTADO" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="3">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataDateColumn Caption="Fecha programada" FieldName="FE_FECHA_PROP_INI" ShowInCustomizationForm="True" VisibleIndex="4">
                                            </dx:GridViewDataDateColumn>
                                            <dx:GridViewDataTextColumn Caption="Hora programada" FieldName="HO_HORA_PROP_INI" ShowInCustomizationForm="True" VisibleIndex="5">
                                            </dx:GridViewDataTextColumn>
                                        </Columns>
                                    </dx:ASPxGridView>
                                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SCSA %>" SelectCommand="SELECT DS_REFERENCIA, case when CD_TIPO_SESION ='O' THEN 'ORDINARIA' ELSE 'EXTRAORDINARIA' END AS TIPO, 
	case when CD_ESTADO ='D' THEN 'DIGITADO' ELSE 'EN PROCESO' END AS ESTADO, FE_FECHA_PROP_INI, HO_HORA_PROP_INI
  FROM AGD_ENCA_CONVOCATORIA"></asp:SqlDataSource>
                                </td>
                            </tr>
                        </table>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage Name="Detalles" Text="Detalles">
                <ContentCollection>
                    <dx:ContentControl runat="server">
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
                                <dx:ASPxPageControl ID="TabSesion" runat="server" Width="100%" Theme="DevEx" ActiveTabIndex="0">

                                    <TabPages>
                                        <dx:TabPage Text="Quorum" Name="quorum">
                                            <ContentCollection>
                                                <dx:ContentControl ID="ContentControl1" runat="server">
                                                    <table style="width: 100%">
                                                        <tr>
                                                            <td style="height: 22px"></td>
                                                            <td style="height: 22px"></td>
                                                            <td style="text-align: center; height: 22px;">
                                                                <strong>
                                                                    <label>Quorum necesario</label></strong>
                                                            </td>

                                                        </tr>
                                                        <tr>
                                                            <td style="text-align:center;">
                                                                <strong>Miembros No convocados</strong>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                            <td style="text-align:center;">
                                                                <strong>Miembros del pleno presentes</strong>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align:center;">
                                                                <asp:ListBox ID="ListBox1" runat="server">
                                                                    <asp:ListItem>Miembro 1 (propietario)</asp:ListItem>
                                                                    <asp:ListItem>Miembro 5 (propietario)</asp:ListItem>
                                                                    <asp:ListItem>Miembro 6 (suplente)</asp:ListItem>
                                                                </asp:ListBox></td>
                                                            <td style="text-align:center;">
                                                                <asp:Button ID="Button1" runat="server" Text="&gt;" />
                                                                <br />
                                                                <br />
                                                                <asp:Button ID="Button2" runat="server" Text="&lt;" />
                                                            </td>
                                                            <td style="text-align:center;">
                                                                <div>
                                                                    <asp:CheckBoxList ID="CheckBoxList1" runat="server">
                                                                        <asp:ListItem>Miembro 2</asp:ListItem>
                                                                        <asp:ListItem>Miembro 3</asp:ListItem>
                                                                        <asp:ListItem Selected="True">Mimebro 4</asp:ListItem>
                                                                        <asp:ListItem Selected="True">Miembro 8 (recien convocado)</asp:ListItem>
                                                                        <asp:ListItem Selected="True">Miembro 9 (recien convocado)</asp:ListItem>
                                                                    </asp:CheckBoxList>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </dx:ContentControl>
                                            </ContentCollection>
                                        </dx:TabPage>
                                        <dx:TabPage Text="Agenda definitiva">
                                            <ContentCollection>
                                                <dx:ContentControl runat="server">
                                                    <table style="width:100%">
                                                        <tr>
                                                            <td colspan="2">

                                                                <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" Theme="DevEx" Width="100%">
                                                                    <Columns>
                                                                        <dx:GridViewDataTextColumn FieldName="Correlativo" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="0">
                                                                        </dx:GridViewDataTextColumn>
                                                                        <dx:GridViewDataTextColumn FieldName="DS_PUNTO_AGENDA" ShowInCustomizationForm="True" VisibleIndex="1">
                                                                        </dx:GridViewDataTextColumn>
                                                                        <dx:GridViewDataTextColumn FieldName="solicitante" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="2">
                                                                        </dx:GridViewDataTextColumn>
                                                                        <dx:GridViewDataDateColumn FieldName="FE_FECH_SOLIC" ShowInCustomizationForm="True" VisibleIndex="3">
                                                                        </dx:GridViewDataDateColumn>
                                                                    </Columns>
                                                                </dx:ASPxGridView>
                                                                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:SCSA %>" SelectCommand="SELECT ROW_NUMBER() OVER(ORDER BY a.CD_PUNTO_AGENDA DESC) AS Correlativo,
	a.DS_PUNTO_AGENDA,
	b.DS_NOMBRE_SOLICITANTE +' '+b.DS_APELLIDO_SOLICITANTE AS solicitante,
	a.FE_FECH_SOLIC
 FROM dbo.AGD_PUNTOS_AGENDA a
 INNER JOIN dbo.GLB_SOLICITANTES b ON b.CD_SOLICITANTE = a.CD_SOLICITANTE"></asp:SqlDataSource>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align:center;">
                                                                <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Adición de punto de agenda"></dx:ASPxButton>
                                                            </td>
                                                            <td style="text-align:center;">
                                                                <dx:ASPxButton ID="ASPxButton2" runat="server" Text="Establecer agenda definitiva"></dx:ASPxButton>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                <div style="width:100%">
                                                                    <table style="width:100%">
                                                                        <tr>
                                                                            <td><label>Nombre:</label></td>
                                                                            <td>
                                                                                <dx:ASPxTextBox ID="ASPxTextBox1" runat="server" Width="400px"></dx:ASPxTextBox>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><label>Detalle:</label></td>
                                                                            <td>
                                                                                <dx:ASPxMemo ID="ASPxMemo1" runat="server" Width="400px" Rows="2"></dx:ASPxMemo>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><label>Origen de solicitud:</label></td>
                                                                            <td>
                                                                                <asp:DropDownList ID="DDLOrigen" runat="server"></asp:DropDownList></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><label>Solicitante:</label></td>
                                                                            <td>
                                                                                <asp:DropDownList ID="DDLSolicitante" runat="server"></asp:DropDownList></td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>

                                                </dx:ContentControl>
                                            </ContentCollection>
                                        </dx:TabPage>
                                        <dx:TabPage Text="Minuta de desarrollo">
                                            <ContentCollection>
                                                <dx:ContentControl runat="server">
                                                    <table style="width:100%">
                                                        <tr>
                                                            <td>
                                                                <dx:ASPxGridView ID="ASPxGridView3" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource3" Width="100%">
                                                                    <Columns>
                                                                        <dx:GridViewDataTextColumn FieldName="Correlativo" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="0">
                                                                        </dx:GridViewDataTextColumn>
                                                                        <dx:GridViewDataTextColumn FieldName="DS_PUNTO_AGENDA" ShowInCustomizationForm="True" VisibleIndex="1">
                                                                        </dx:GridViewDataTextColumn>
                                                                    </Columns>
                                                                </dx:ASPxGridView>
                                                                <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:SCSA %>" SelectCommand="SELECT ROW_NUMBER() OVER(ORDER BY CD_PUNTO_AGENDA DESC) AS Correlativo, DS_PUNTO_AGENDA
  FROM AGD_PUNTOS_AGENDA"></asp:SqlDataSource>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <dx:ASPxPageControl ID="tabAcuerdos" runat="server" ActiveTabIndex="0" Width="100%">
                                                                    <TabPages>
                                                                        <dx:TabPage Text="Aspectos relevantes">
                                                                            <ContentCollection>
                                                                                <dx:ContentControl runat="server">
                                                                                    <dx:ASPxMemo ID="ASPxMemo2" runat="server" Height="71px" Width="100%">
                                                                                    </dx:ASPxMemo>
                                                                                </dx:ContentControl>
                                                                            </ContentCollection>
                                                                        </dx:TabPage>
                                                                        <dx:TabPage Text="Documentación">
                                                                            <ContentCollection>
                                                                                <dx:ContentControl runat="server">
                                                                                    <dx:ASPxMemo ID="ASPxMemo3" runat="server" Height="71px" Width="100%">
                                                                                    </dx:ASPxMemo>
                                                                                </dx:ContentControl>
                                                                            </ContentCollection>
                                                                        </dx:TabPage>
                                                                        <dx:TabPage Text="Acuerdos">
                                                                            <ContentCollection>
                                                                                <dx:ContentControl runat="server">
                                                                                    <dx:ASPxMemo ID="ASPxMemo4" runat="server" Height="71px" Width="100%">
                                                                                    </dx:ASPxMemo>
                                                                                </dx:ContentControl>
                                                                            </ContentCollection>
                                                                        </dx:TabPage>
                                                                    </TabPages>
                                                                </dx:ASPxPageControl>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </dx:ContentControl>
                                            </ContentCollection>
                                        </dx:TabPage>
                                        <dx:TabPage Text="Cierre de sesión">
                                            <ContentCollection>
                                                <dx:ContentControl runat="server">
                                                    <br />
                                                    <div id="cierre" style="width:100%; margin:0 auto; text-align:center;">
                                                        <dx:ASPxButton ID="ASPxButton4" runat="server" Text="Registrar cierre de sesión"></dx:ASPxButton>
                                                        <br /><br />
                                                        <dx:ASPxButton ID="ASPxButton5" runat="server" Text="Generar documentación"></dx:ASPxButton>
                                                    </div>
                                                </dx:ContentControl>
                                            </ContentCollection>
                                        </dx:TabPage>
                                    </TabPages>
                                 </dx:ASPxPageControl>
                            </div>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
        </TabPages>
   
    </dx:ASPxPageControl>
    
    <table style="width: 100%">
        <tr>
            <td style="text-align: right">
                <asp:Button ID="Button3" runat="server" Text="Guardar" OnClick="Button2_Click" />&nbsp;&nbsp;
                                <asp:Button ID="Button4" runat="server" Text="Cancelar" OnClick="Button1_Click" />
            </td>
        </tr>
    </table>
</asp:Content>

