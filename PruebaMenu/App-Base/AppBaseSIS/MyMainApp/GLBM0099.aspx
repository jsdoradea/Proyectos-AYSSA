<%@ Page Title="" Language="C#" MasterPageFile="~/MyMaintenanceForm.master" AutoEventWireup="true" CodeBehind="GLBM0099.aspx.cs" Inherits="ClsFormas.GLBM0099" enableSessionState="true" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<asp:Content ID="Content1" runat="server" contentplaceholderid="pnelMant">
    <script type="text/javascript">
        function grid_SelectionChanged(s, e) {
            s.GetSelectedFieldValues('CD_CODI_OPCI_SIST;DS_CODI_OPCI_SIST;DS_NOMBRE_FORMA;DS_RUTA_FORMA', OnGridSelectionComplete);
        }
        function OnGridSelectionComplete(values) {
            if (values.length > 0) {
                tabOpciones.SetActiveTab(tabOpciones.GetTabByName('pgeDetalle'));
                CD_CODI_OPCI_SIST.SetText(values[0][0]);
                DS_CODI_OPCI_SIST.SetText(values[0][1]);
                DS_NOMBRE_FORMA.SetText(values[0][2]);
                DS_RUTA_FORMA.SetText(values[0][3]);

                CD_CODI_OPCI_SIST.GetInputElement().readOnly = true;
                CD_CODI_OPCI_SIST.GetInputElement().setAttribute('style', 'background:#FFFF99;');
                CD_CODI_OPCI_SIST.SetIsValid(true);
                DS_NOMBRE_FORMA.SetIsValid(true);
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
                                    <dx:ASPxGridView ID="grdDetalleData" runat="server" AutoGenerateColumns="False" ClientInstanceName="grdDetalleData" EnableTheming="True" Theme="Office2010Blue" Width="100%" OnDataBinding="grdDetalleData_DataBinding">
                                        <ClientSideEvents CustomizationWindowCloseUp="grid_CustomizationWindowCloseUp" SelectionChanged="grid_SelectionChanged" />
                                        <Columns>
                                            <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowInCustomizationForm="True" ShowSelectCheckbox="True" VisibleIndex="0">
                                            </dx:GridViewCommandColumn>
                                            <dx:GridViewDataTextColumn Caption="Código Opción" FieldName="CD_CODI_OPCI_SIST" ShowInCustomizationForm="True" VisibleIndex="1">
                                                <Settings AllowHeaderFilter="True" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Descripción Opción" FieldName="DS_CODI_OPCI_SIST" ShowInCustomizationForm="True" VisibleIndex="3">
                                                <Settings AllowHeaderFilter="True" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Nombre de Forma" FieldName="DS_NOMBRE_FORMA" ShowInCustomizationForm="True" VisibleIndex="2">
                                                <Settings AllowHeaderFilter="True" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Ruta Forma" FieldName="DS_RUTA_FORMA" ShowInCustomizationForm="True" VisibleIndex="4">
                                                <Settings AllowHeaderFilter="True" />
                                            </dx:GridViewDataTextColumn>
                                        </Columns>
                                        <SettingsBehavior AllowSelectSingleRowOnly="True" EnableCustomizationWindow="True" />
                                        <SettingsPager>
                                            <Summary AllPagesText="Páginas: {0} - {1} ({2} items)" EmptyText="No hay datos para paginar" Text="Página {0} de {1} ({2} items)" />
                                            <PageSizeItemSettings AllItemText="Todos" Caption="Mostrar Items:" Visible="True">
                                            </PageSizeItemSettings>
                                        </SettingsPager>
                                        <Settings ShowFilterRow="True" ShowFooter="True" ShowGroupPanel="True" />
                                        <SettingsText EmptyDataRow="No hay datos para mostrar" GroupPanel="Arrastre un encabezado de columna para agrupar por esa columna" HeaderFilterShowAll="(Todos)" HeaderFilterShowBlanks="(En Blanco)" HeaderFilterShowNonBlanks="(No en Blanco)" GroupContinuedOnNextPage="(Continúa en pag. sig.)" />
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
                                <dx:PanelContent ID="PanelContent1" runat="server">
                                    <table style="width:100%;">
                                        <tr>
                                            <td class="celdaIzquierda-ancho">&nbsp;</td>
                                            <td class="celdaDetalleD-ancho">
                                                <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Código Opción:">
                                                </dx:ASPxLabel>
                                            </td>
                                            <td class="celdaDetalleI-ancho">
                                                <dx:ASPxTextBox ID="CD_CODI_OPCI_SIST" runat="server" MaxLength="10" Width="170px" ClientInstanceName="CD_CODI_OPCI_SIST" NullText="Código de la opción" ReadOnly="True">
                                                    <ClientSideEvents TextChanged="function(s, e) {
                s.SetText(s.GetText().toUpperCase());
            }" />
                                                    <ValidationSettings>
                                                        <RequiredField IsRequired="True" />
                                                    </ValidationSettings>
                                                    <ReadOnlyStyle BackColor="#FFFF99">
                                                    </ReadOnlyStyle>
                                                </dx:ASPxTextBox>
                                            </td>
                                            <td class="celdaMedio-ancho">&nbsp;</td>
                                            <td class="celdaDetalleD-ancho">&nbsp;</td>
                                            <td class="celdaDetalleI-ancho" colspan="2">
                                                &nbsp;</td>
                                            <td class="celdaIzquierda-ancho">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td class="celdaIzquierda-ancho">&nbsp;</td>
                                            <td class="celdaDetalleD-ancho">
                                                <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="Nombre Forma:">
                                                </dx:ASPxLabel>
                                            </td>
                                            <td class="celdaDetalleI-ancho">
                                                <dx:ASPxTextBox ID="DS_NOMBRE_FORMA" runat="server" MaxLength="100" Width="170px" ClientInstanceName="DS_NOMBRE_FORMA" NullText="Nombre de la Forma">
                                                    <ValidationSettings>
                                                        <RequiredField IsRequired="True" />
                                                    </ValidationSettings>
                                                </dx:ASPxTextBox>
                                            </td>
                                            <td class="celdaMedio-ancho">&nbsp;</td>
                                            <td class="celdaDetalleD-ancho">
                                                <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="Descripción:">
                                                </dx:ASPxLabel>
                                            </td>
                                            <td class="celdaDetalleI-ancho" colspan="2">
                                                <dx:ASPxTextBox ID="DS_CODI_OPCI_SIST" runat="server" MaxLength="100" Width="200px" ClientInstanceName="DS_CODI_OPCI_SIST" NullText="Descripción de la Opción">
                                                </dx:ASPxTextBox>
                                            </td>
                                            <td class="celdaIzquierda-ancho">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td class="celdaIzquierda-ancho">&nbsp;</td>
                                            <td class="celdaDetalleD-ancho">
                                                <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="Ruta - Link:">
                                                </dx:ASPxLabel>
                                            </td>
                                            <td class="celdaDetalleI-ancho">                        
                                                <dx:ASPxTextBox ID="DS_RUTA_FORMA" runat="server" ClientInstanceName="DS_RUTA_FORMA" Width="200px" NullText="Ruta Link de Pantalla">
                                                </dx:ASPxTextBox>
                                            </td>
                                            <td class="celdaMedio-ancho">&nbsp;</td>
                                            <td class="celdaDetalleD-ancho">&nbsp;</td>
                                            <td class="celdaDetalleC-ancho">&nbsp;</td>
                                            <td class="celdaDetalleC-ancho">
                                                &nbsp;</td>
                                            <td class="celdaIzquierda-ancho">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td class="celdaIzquierda-ancho">&nbsp;</td>
                                            <td class="celdaDetalleD-ancho">&nbsp;</td>
                                            <td class="celdaDetalleI-ancho">&nbsp;</td>
                                            <td class="celdaMedio-ancho">&nbsp;</td>
                                            <td class="celdaDetalleD-ancho">
                                                <dx:ASPxTextBox ID="lblCtrl" runat="server" ClientInstanceName="lblCtrl" ForeColor="White" Width="0px">
                                                    <Border BorderStyle="None" />
                                                </dx:ASPxTextBox>
                                            </td>
                                            <td class="celdaDetalleC-ancho">&nbsp;</td>
                                            <td class="celdaDetalleC-ancho">
                                                <dx:ASPxButton ID="cmdRegresar" runat="server" AutoPostBack="False" ClientInstanceName="cmdRegresar" Text="Regresar" UseSubmitBehavior="False" OnClick="cmdRegresar_Click">
                                                    <ClientSideEvents Click="function(s, e) {
	            tabOpciones.SetActiveTab(tabOpciones.GetTabByName('pgeDatos'));
	            lblStatus.SetText(&quot;&quot;);
            }" />
                                                </dx:ASPxButton>
                                            </td>
                                            <td class="celdaIzquierda-ancho">&nbsp;</td>
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



<asp:Content ID="Content2" runat="server" contentplaceholderid="titulo">
                                <dx:ASPxLabel ID="lblTitulo" runat="server" style="font-weight: 700; font-style: italic; font-size: 18px" Text="ASPxLabel" Theme="Office2010Blue">
                                </dx:ASPxLabel>
                            </asp:Content>




<asp:Content ID="Content3" runat="server" contentplaceholderid="menuMant">
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





<asp:Content ID="Content4" runat="server" contentplaceholderid="BarraEstatus">
                                <dx:ASPxTextBox ID="lblStatus" runat="server" ClientInstanceName="lblStatus" Font-Bold="True" Font-Italic="True" Width="170px">
                                    <Border BorderStyle="None" />
                                </dx:ASPxTextBox>
                            </asp:Content>







