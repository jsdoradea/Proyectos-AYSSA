<%@ Page Title="Correspondencia" Language="C#" MasterPageFile="~/portal/Main.master" AutoEventWireup="true" CodeFile="registro.aspx.cs" Inherits="correspondencia_registro" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxClasses" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<asp:Content ContentPlaceHolderID="Header1" runat="server">
    <script type="text/javascript">
        function OnRowClick(e) {
            //Unselect all rows
            GridCorrespondencia._selectAllRowsOnPage(false);
            //Select the row
            GridCorrespondencia.SelectRow(e.visibleIndex, true);
        }
    </script>
</asp:Content>

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
                                    <dx:ASPxComboBox ID="DDLPeriodo" runat="server"  EnableTheming="True" Theme="Glass" ValueField="CD_CIERRE" AutoPostBack="True" OnSelectedIndexChanged="DDLPeriodo_SelectedIndexChanged" DataSourceID="SQLDS_Periodo">
                                        <Columns>
                                            <dx:ListBoxColumn FieldName="CD_CIERRE" Visible="False" />
                                            <dx:ListBoxColumn Caption="PERIODO" FieldName="DS_PERIODO" Name="PERIODO" />
                                            <dx:ListBoxColumn Caption="EJERCICIO" FieldName="CD_EJERICIO" Name="EJERCICIO" />
                                        </Columns>
                                    </dx:ASPxComboBox>
                                    <asp:SqlDataSource ID="SQLDS_Periodo" runat="server" ConnectionString="<%$ ConnectionStrings:SCSA %>" SelectCommand="SELECT [CD_CIERRE], [DS_PERIODO], [CD_EJERICIO] FROM [GLB_CIERRE_PERIODO] ORDER  BY [CD_EJERICIO] DESC, CD_PERIODO DESC"></asp:SqlDataSource>
                                </td>
                                <td><dx:ASPxButton ID="ASPxButton3" runat="server" Text="Nueva solicitud" OnClick="ASPxButton3_Click"></dx:ASPxButton>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">&nbsp;</td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <dx:ASPxGridView ID="GridCorrespondencia" ClientInstanceName="GridCorrespondencia" runat="server" AutoGenerateColumns="False" EnableTheming="True" Theme="DevEx" DataSourceID="SqlDataSource1" KeyFieldName="CD_AGENDA" >
                                        <Columns>
                                            <dx:GridViewDataTextColumn FieldName="CD_AGENDA" ShowInCustomizationForm="True" VisibleIndex="1" Visible="False">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataCheckColumn Name="Select" ShowInCustomizationForm="False" VisibleIndex="3">
                                                <PropertiesCheckEdit DisplayFormatString="{0}">
                                                </PropertiesCheckEdit>
                                                <DataItemTemplate>
                                                    <asp:Button ID="Button5" runat="server" CommandArgument='<%# Eval("CD_AGENDA") %>' OnClick="Button5_Click" Text="Seleccionar" />
                                                </DataItemTemplate>
                                            </dx:GridViewDataCheckColumn>
                                            <dx:GridViewDataTextColumn FieldName="TIPO_C" ShowInCustomizationForm="True" VisibleIndex="4" Caption="Tipo">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataDateColumn FieldName="FECHA_RECEPCION" ShowInCustomizationForm="True" VisibleIndex="5" Caption="Fecha de recepción">
                                            </dx:GridViewDataDateColumn>
                                            <dx:GridViewDataTextColumn Caption="Concepto" FieldName="CONCEPTO" ShowInCustomizationForm="True" VisibleIndex="6">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Orígen" FieldName="ORIGEN" ShowInCustomizationForm="True" VisibleIndex="7">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Unidad / Institución" FieldName="UNIDAD" ShowInCustomizationForm="True" VisibleIndex="8">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Persona" FieldName="SOLICITANTE" ShowInCustomizationForm="True" VisibleIndex="9">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataDateColumn Caption="Fecha de registro" FieldName="FECHA_REGISTRO" ShowInCustomizationForm="True" VisibleIndex="10">
                                            </dx:GridViewDataDateColumn>
                                        </Columns>
                                        <ClientSideEvents RowClick="function(s, e) { OnRowClick(e); }"></ClientSideEvents>
                                        <SettingsBehavior AllowSelectSingleRowOnly="True" ConfirmDelete="True" />
                                        <Settings ShowFilterRow="True" ShowGroupPanel="True" />
                                    </dx:ASPxGridView>
                                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SCSA %>" SelectCommand="SELECT * FROM [TMP_CORRESPONDENCIA] ORDER BY [FECHA_RECEPCION] DESC"></asp:SqlDataSource>
                                </td>
                            </tr>
                        </table>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage Name="detalles" Text="Detalles" Enabled="False">
                <ContentCollection>
                    <dx:ContentControl runat="server">
                        <div id="detalles">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <label>Estado:</label></td>
                                    <td>
                                        <asp:DropDownList ID="DDLEstado" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="text-align: right; position:relative;">
                                        <label>Fecha de registro:</label>
                                        <asp:TextBox ID="txtFE_REG" runat="server" Enabled="False"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <div id="form_reg" style="border-style: solid; border-width: 1px;">
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td>
                                                        <label>Fecha de Solicitud:</label></td>
                                                    <td style="position:relative;">
                                                        <asp:TextBox ID="txtFE_SOL" runat="server" Enabled="False"></asp:TextBox><asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Content/Images/Calendar.png" Width="20px" OnClick="ImageButton1_Click" />
                                                        <div id="div_calendario" style="position:absolute; left:0px; top:0px;" visible="false" runat="server">
                                                            <dx:ASPxCalendar ID="CalSolicitud" runat="server" Visible="False"  AutoPostBack="True" OnSelectionChanged="CalSolicitud_SelectionChanged"></dx:ASPxCalendar>
                                                        </div>
                                                    </td>
                                                    <td><label>Tipo de Correspondencia:</label></td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <label>Origen de Solicitud:</label></td>
                                                    <td>
                                                        <asp:DropDownList ID="DDLOrigen" runat="server" AutoPostBack="true" OnSelectedIndexChanged="DDLOrigen_SelectedIndexChanged"></asp:DropDownList>
                                                    </td>
                                                    <td rowspan="2">
                                                        <dx:ASPxRadioButtonList ID="RdTipo" runat="server">
                                                            <Items>
                                                                <dx:ListEditItem Text="Soporte de acta" Value="2" Selected="true" />
                                                                <dx:ListEditItem Text="Correspondencia Normal" Value="1" />
                                                            </Items>
                                                        </dx:ASPxRadioButtonList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <label>Solicitante:</label></td>
                                                    <td>
                                                        <dx:ASPxComboBox ID="ComboSolicitantes" runat="server" ValueField="CODIGO"  ValueType="System.String" Width="90%" DataSourceID="SQLDS_Solicitantes">
                                                             <Columns>
                                                                <dx:ListBoxColumn FieldName="CODIGO" Visible="False" />
                                                                <dx:ListBoxColumn Caption="Nombre" FieldName="PERSONA" Name="PERSONA" />
                                                                <dx:ListBoxColumn Caption="Unidad" FieldName="ORIGEN" Name="ORIGEN" />
                                                            </Columns>
                                                        </dx:ASPxComboBox>
                                                        <asp:SqlDataSource ID="SQLDS_Solicitantes" runat="server" ConnectionString="<%$ ConnectionStrings:SCSA %>" SelectCommand="IF @origen=1
BEGIN
SELECT a.CD_EMPLEADO as CODIGO, a.DS_NOMBRE_EMPLEADO + ' ' + a.DS_APELLIDO_EMPLEADO AS PERSONA, b.DS_UNIDAD AS ORIGEN FROM dbo.GLB_EMPLEADOS a 	INNER JOIN dbo.GLB_UNIDADES_TEG b ON b.CD_UNIDAD=a.CD_UNIDAD WHERE a.CD_ESTADO = 1 ORDER BY b.DS_UNIDAD, a.DS_NOMBRE_EMPLEADO, a.DS_APELLIDO_EMPLEADO
END
ELSE
BEGIN
SELECT a.CD_SOLICITANTE as CODIGO, a.DS_NOMBRE_SOLICITANTE + ' ' + a.DS_APELLIDO_SOLICITANTE AS PERSONA, b.DS_INSTITUCION AS ORIGEN FROM dbo.GLB_SOLICITANTES a 	INNER JOIN dbo.GLB_INSTITUCION b ON b.CD_INSTITUCION = a.CD_INSTITUCION ORDER BY b.DS_INSTITUCION, a.DS_NOMBRE_SOLICITANTE, a.DS_APELLIDO_SOLICITANTE
END">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="DDLOrigen" DefaultValue="1" Name="origen" PropertyName="SelectedValue" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <label>Nombre de solicitud:</label></td>
                                                    <td colspan="2">
                                                        <asp:TextBox ID="txtPunto" runat="server" Width="90%" Rows="3" TextMode="MultiLine"></asp:TextBox></td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <label>Justificación:</label></td>
                                                    <td colspan="2">
                                                        <asp:TextBox ID="txtJust" runat="server" TextMode="MultiLine" Rows="4" Width="90%"></asp:TextBox></td>
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
                                        <asp:Label ID="lblCodAgenda" runat="server" Visible="False"></asp:Label>
                                        <asp:Label ID="lblAccion" runat="server" Visible="False"></asp:Label>
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

