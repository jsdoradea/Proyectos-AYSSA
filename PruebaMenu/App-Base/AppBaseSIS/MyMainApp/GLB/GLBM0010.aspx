<%@ Page Title="" Language="C#" MasterPageFile="~/MyMaintenanceForm.master" AutoEventWireup="true" CodeBehind="GLBM0010.aspx.cs" Inherits="ClsFormas.GLBM0010" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<asp:Content ID="Content4" runat="server" contentplaceholderid="BarraEstatus">
                                <dx:ASPxTextBox ID="lblStatus" runat="server" ClientInstanceName="lblStatus" Font-Bold="True" Font-Italic="True" Width="170px">
                                    <Border BorderStyle="None" />
                                </dx:ASPxTextBox>
                            </asp:Content>

<asp:Content ID="Content5" runat="server" contentplaceholderid="titulo">
                                <dx:ASPxLabel ID="lblTitulo" runat="server" style="font-weight: 700; font-style: italic; font-size: 18px" Text="ASPxLabel" Theme="Office2010Blue">
                                </dx:ASPxLabel>
                            </asp:Content>



<asp:Content ID="Content6" runat="server" contentplaceholderid="pnelMant">
    
    <script type="text/javascript">
            function grid_SelectionChanged(s, e) {
                s.GetSelectedFieldValues('CD_UNIDAD;DS_UNIDAD', OnGridSelectionComplete);
            }
            function OnGridSelectionComplete(values) {
                if (values.length > 0) {
                    tabOpciones.SetActiveTab(tabOpciones.GetTabByName('pgeDetalle'));
                    CD_UNIDAD.SetText(values[0][0]);
                    DS_UNIDAD.SetText(values[0][1]);
                    
                    CD_UNIDAD.GetInputElement().readOnly = true;
                    CD_UNIDAD.GetInputElement().setAttribute('style', 'background:#FFFF99;');
                    CD_UNIDAD.SetIsValid(true);
                    DS_UNIDAD.SetIsValid(true);
                }
            }
    </script>

                        <dx:ASPxPanel ID="pnlPrincipal" runat="server" Width="100%">
                            <PanelCollection>
<dx:PanelContent runat="server">
    <dx:ASPxPageControl ID="tabOpciones" runat="server" ActiveTabIndex="0" Width="100%" ClientInstanceName="tabOpciones" Theme="Office2010Blue">
        <TabPages>
            <dx:TabPage Name="pgeDatos" Text="Datos">
                <ContentCollection>
                    <dx:ContentControl runat="server">
                        <table style="width:100%;">
                            <tr>
                                <td colspan="2">
                                    <dx:ASPxGridView ID="grdDetalleData" runat="server" AutoGenerateColumns="False" ClientInstanceName="grdDetalleData" EnableTheming="True" Theme="Office2010Blue" Width="100%" OnDataBinding="grdDetalleData_DataBinding1">
                                        <ClientSideEvents CustomizationWindowCloseUp="grid_CustomizationWindowCloseUp" SelectionChanged="grid_SelectionChanged" />
                                        <Columns>
                                            <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowInCustomizationForm="True" ShowSelectCheckbox="True" VisibleIndex="0">
                                            </dx:GridViewCommandColumn>
                                            <dx:GridViewDataTextColumn Caption="Código Unidad" FieldName="CD_UNIDAD" ShowInCustomizationForm="True" VisibleIndex="1">
                                                <Settings AllowHeaderFilter="True" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Nombre Unidad" FieldName="DS_UNIDAD" ShowInCustomizationForm="True" VisibleIndex="2">
                                                <Settings AllowHeaderFilter="True" />
                                            </dx:GridViewDataTextColumn>
                                        </Columns>
                                        <SettingsBehavior AllowSelectSingleRowOnly="True" EnableCustomizationWindow="True" />
                                        <SettingsPager NumericButtonCount="8" PageSize="8">
                                            <Summary AllPagesText="Páginas: {0} - {1} ({2} items)" EmptyText="No hay datos para paginar" Text="Página {0} de {1} ({2} items)" />
                                            <PageSizeItemSettings AllItemText="Todos" Caption="Mostrar Items:" Visible="True">
                                            </PageSizeItemSettings>
                                        </SettingsPager>
                                        <Settings ShowFilterRow="True" ShowFooter="True" ShowGroupPanel="True" />
                                        <SettingsText EmptyDataRow="No hay datos para mostrar" GroupPanel="Arrastre un encabezado de columna para agrupar por esa columna" GroupContinuedOnNextPage="(Continúa en pag. sig.)" HeaderFilterShowAll="(Todos)" HeaderFilterShowBlanks="(En Blanco)" HeaderFilterShowNonBlanks="(No en Blanco)" />
                                        <SettingsCommandButton>
                                            <ClearFilterButton ButtonType="Link" Text="Limpiar">
                                            </ClearFilterButton>
                                        </SettingsCommandButton>
                                        <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                                    </dx:ASPxGridView>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <dx:ASPxGridViewExporter ID="gridExport" runat="server" GridViewID="grdDetalleData">
                                    </dx:ASPxGridViewExporter>
                                </td>
                                <td style="text-align: right">
                                    <dx:ASPxButton ID="btnCols" runat="server" Text="Mod. Cols" Theme="Office2010Blue" AutoPostBack="False" UseSubmitBehavior="False">
                                        <ClientSideEvents Click="btnCols_Click" />
                                    </dx:ASPxButton>
                                </td>
                            </tr>
                        </table>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage Name="pgeDetalle" Text="Detalle">
                <ContentCollection>
                    <dx:ContentControl runat="server">
                        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" HeaderText="" Theme="Office2010Blue" Width="100%">
                            <PanelCollection>
                                <dx:PanelContent runat="server">
                                    <table style="width:100%;">
                                        <tr>
                                            <td class="celdaIzquierda-ancho">&nbsp;</td>
                                            <td class="celdaDetalleD-ancho">
                                                <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Código Unidad:">
                                                </dx:ASPxLabel>
                                            </td>
                                            <td class="celdaDetalleI-ancho">
                                                <dx:ASPxTextBox ID="CD_UNIDAD" runat="server" ClientInstanceName="CD_UNIDAD" Width="170px" ReadOnly="True">
                                                    <ReadOnlyStyle BackColor="#FFFF99">
                                                    </ReadOnlyStyle>
                                                </dx:ASPxTextBox>
                                            </td>
                                            <td class="celdaMedio-ancho">&nbsp;</td>
                                            <td class="celdaDetalleD-ancho">&nbsp;</td>
                                            <td class="celdaDetalleI-ancho" colspan="2">&nbsp;</td>
                                            <td class="celdaDerecha-ancho">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td class="celdaIzquierda-ancho">&nbsp;</td>
                                            <td class="celdaDetalleD-ancho">
                                                <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="Nombre Unidad:">
                                                </dx:ASPxLabel>
                                            </td>
                                            <td class="celdaDetalleI-ancho" colspan="3">
                                                <dx:ASPxTextBox ID="DS_UNIDAD" runat="server" ClientInstanceName="DS_UNIDAD" Width="400px">
                                                    <ClientSideEvents TextChanged="function(s, e) {
s.SetText(s.GetText().toUpperCase());
}" />
                                                    <ValidationSettings>
                                                        <RequiredField IsRequired="True" />
                                                    </ValidationSettings>
                                                </dx:ASPxTextBox>
                                            </td>
                                            <td class="celdaDetalleI-ancho" colspan="2">&nbsp;</td>
                                            <td class="celdaDerecha-ancho">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td class="celdaIzquierda-ancho">&nbsp;</td>
                                            <td class="celdaDetalleD-ancho">&nbsp;</td>
                                            <td class="celdaDetalleI-ancho">&nbsp;</td>
                                            <td class="celdaMedio-ancho">&nbsp;</td>
                                            <td class="celdaDetalleD-ancho">&nbsp;</td>
                                            <td class="celdaDetalleI-ancho" colspan="2">&nbsp;</td>
                                            <td class="celdaDerecha-ancho">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td class="celdaIzquierda-ancho">&nbsp;</td>
                                            <td class="celdaDetalleD-ancho">&nbsp;</td>
                                            <td class="celdaDetalleI-ancho">&nbsp;</td>
                                            <td class="celdaMedio-ancho">&nbsp;</td>
                                            <td class="celdaDetalleD-ancho">&nbsp;</td>
                                            <td class="celdaDetalleC-ancho">
                                                <dx:ASPxTextBox ID="lblCtrl" runat="server" ClientInstanceName="lblCtrl" Width="1px" BackColor="#EAF1FA" ForeColor="#EAF1FA" ReadOnly="True">
                                                    <Border BorderStyle="None" />
                                                </dx:ASPxTextBox>
                                            </td>
                                            <td class="celdaDetalleC-ancho">
                                                <dx:ASPxButton ID="cmdRegresar" runat="server" AutoPostBack="False" ClientInstanceName="cmdRegresar" Text="Regresar" UseSubmitBehavior="False">
                                                    <ClientSideEvents Click="function(s, e) {
	tabOpciones.SetActiveTab(tabOpciones.GetTabByName('pgeDatos'));
	lblStatus.SetText(&quot;&quot;);
}" />
                                                </dx:ASPxButton>
                                            </td>
                                            <td class="celdaDerecha-ancho">&nbsp;</td>
                                        </tr>
                                    </table>
                                </dx:PanelContent>
                            </PanelCollection>
                        </dx:ASPxRoundPanel>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
        </TabPages>
    </dx:ASPxPageControl>
                                </dx:PanelContent>
</PanelCollection>
                        </dx:ASPxPanel>
                        </asp:Content>




<asp:Content ID="Content7" runat="server" contentplaceholderid="menuMant">
                        <dx:ASPxMenu ID="mnuPrincipal" runat="server" AutoPostBack="True" OnItemClick="mnuPrincipal_ItemClick" ShowAsToolbar="True" ShowPopOutImages="True" Theme="Office2010Blue" AllowSelectItem="True">
                            <ClientSideEvents ItemClick="function(s, e) {
	if (e.item.name == 'icEliminar')
{
		if (confirm('¿Realmente desea eliminar el Registro seleccionado?'))
		{
			lblCtrl.SetText('S');
		}
		else
		{
			lblCtrl.SetText('N');
}
}
}" />
                            <Items>
                                <dx:MenuItem Name="icRefresh">
                                    <Image AlternateText="Refrescar" IconID="actions_refresh_16x16" ToolTip="Refrescar">
                                    </Image>
                                </dx:MenuItem>
                                <dx:MenuItem Name="icLimpiar">
                                    <Image AlternateText="Limpiar" IconID="actions_new_16x16" ToolTip="Limpiar">
                                    </Image>
                                </dx:MenuItem>
                                <dx:MenuItem Name="icAdicionar">
                                    <Image AlternateText="Adicionar" IconID="actions_add_16x16" ToolTip="Adicionar">
                                    </Image>
                                </dx:MenuItem>
                                <dx:MenuItem Name="icModificar">
                                    <Image AlternateText="Modificar" IconID="save_save_16x16" ToolTip="Modificar">
                                    </Image>
                                </dx:MenuItem>
                                <dx:MenuItem Name="icEliminar">
                                    <Image AlternateText="Eliminar" IconID="edit_delete_16x16" ToolTip="Eliminar">
                                    </Image>
                                </dx:MenuItem>
                                <dx:MenuItem Name="icImprimir">
                                    <Image AlternateText="Imprimir" IconID="print_print_16x16" ToolTip="Imprimir">
                                    </Image>
                                </dx:MenuItem>
                                <dx:MenuItem Name="icExportar" DropDownMode="True">
                                    <Items>
                                        <dx:MenuItem Name="icExportarXls" Text="Excel">
                                            <Image AlternateText="Excel" IconID="export_exporttoxlsx_16x16" ToolTip="Exporta a Excel">
                                            </Image>
                                        </dx:MenuItem>
                                        <dx:MenuItem Name="icExportarDoc" Text="Documento">
                                            <Image AlternateText="Doc" IconID="export_exporttodocx_16x16" ToolTip="Documento">
                                            </Image>
                                        </dx:MenuItem>
                                        <dx:MenuItem Name="icExportarPDF" Text="PDF">
                                            <Image AlternateText="PDF" IconID="export_exporttopdf_16x16" ToolTip="PDF">
                                            </Image>
                                        </dx:MenuItem>
                                    </Items>
                                    <Image AlternateText="Exportar" IconID="export_export_16x16" ToolTip="Exportar">
                                    </Image>
                                </dx:MenuItem>
                            </Items>
                        </dx:ASPxMenu>
                            </asp:Content>





