<%@ Page Title="" Language="C#" MasterPageFile="~/MyMaintenanceForm.master" AutoEventWireup="true" CodeBehind="CARM0001.aspx.cs" Inherits="ClsFormas.CARM0001" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" runat="server" contentplaceholderid="pnelMant">
        <script type="text/javascript">
            function grid_SelectionChanged(s, e) {
                s.GetSelectedFieldValues('CD_ENTIDAD;DS_NOM_ENTIDAD;DS_DES_ENTIDAD_COR;DS_DES_ENTIDAD_LAR;CD_ESTADO', OnGridSelectionComplete);
            }
            function OnGridSelectionComplete(values) {
                if (values.length > 0) {
                    tabOpciones.SetActiveTab(tabOpciones.GetTabByName('pgeDetalle'));
                    CD_ENTIDAD.SetText(values[0][0]);
                    DS_NOM_ENTIDAD.SetText(values[0][1]);
                    DS_DES_ENTIDAD_COR.SetText(values[0][2]);
                    DS_DES_ENTIDAD_LAR.SetText(values[0][3]);
                    CD_ESTADO.SetValue(values[0][4]);

                    CD_ENTIDAD.GetInputElement().readOnly = true;
                    CD_ENTIDAD.GetInputElement().setAttribute('style', 'background:#FFFF99;');
                    DS_NOM_ENTIDAD.SetIsValid(true);
                    CD_ESTADO.SetIsValid(true);

                    grdDetalleEntidad.PerformCallback();
                    //DS_UNIDAD.SetIsValid(true);
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
                                    <dx:ASPxGridView ID="grdDetalleData" runat="server" AutoGenerateColumns="False" ClientInstanceName="grdDetalleData" EnableTheming="True" Theme="Office2010Blue" Width="100%" OnDataBinding="grdDetalleData_DataBinding" OnSelectionChanged="grdDetalleData_SelectionChanged">
                                        <ClientSideEvents CustomizationWindowCloseUp="grid_CustomizationWindowCloseUp" SelectionChanged="grid_SelectionChanged" />
                                        <Columns>
                                            <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowInCustomizationForm="True" ShowSelectCheckbox="True" VisibleIndex="0">
                                            </dx:GridViewCommandColumn>
                                            <dx:GridViewDataTextColumn Caption="Código" FieldName="CD_ENTIDAD" Name="CD_ENTIDAD" ShowInCustomizationForm="True" VisibleIndex="1">
                                                <Settings AllowHeaderFilter="True" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Nombre Entidad" FieldName="DS_NOM_ENTIDAD" Name="DS_NOM_ENTIDAD" ShowInCustomizationForm="True" VisibleIndex="2">
                                                <Settings AllowHeaderFilter="True" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Desc. Corta" FieldName="DS_DES_ENTIDAD_COR" Name="DS_DES_ENTIDAD_COR" ShowInCustomizationForm="True" VisibleIndex="3">
                                                <Settings AllowHeaderFilter="True" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Desc. Larga" FieldName="DS_DES_ENTIDAD_LAR" Name="DS_DES_ENTIDAD_LAR" ShowInCustomizationForm="True" VisibleIndex="4">
                                                <Settings AllowHeaderFilter="True" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="CD_ESTADO" Name="CD_ESTADO" ShowInCustomizationForm="False" Visible="False" VisibleIndex="5">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Estado" FieldName="DS_ESTADO" Name="DS_ESTADO" ShowInCustomizationForm="True" VisibleIndex="6">
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
                                            <td class="celdaIzquierda-ancho" style="height: 25px">&nbsp;</td>
                                            <td class="celdaDetalleDMaestro-ancho" style="height: 25px">
                                                &nbsp;</td>
                                            <td class="celdaDetalleIMaestro-ancho" style="height: 25px">
                                                &nbsp;</td>
                                            <td class="celdaMedio-ancho" style="height: 25px">&nbsp;</td>
                                            <td class="celdaDetalleDDetalle-ancho" colspan="3" rowspan="6">
                                                <dx:ASPxGridView ID="grdDetalleEntidad" runat="server" AutoGenerateColumns="False" ClientInstanceName="grdDetalleEntidad" OnDataBinding="grdDetalleEntidad_DataBinding" Theme="Office2010Blue">
                                                    <Columns>
                                                        <dx:GridViewCommandColumn SelectAllCheckboxMode="Page" ShowClearFilterButton="True" ShowInCustomizationForm="True" ShowSelectCheckbox="True" VisibleIndex="0">
                                                        </dx:GridViewCommandColumn>
                                                        <dx:GridViewDataTextColumn FieldName="CD_CAMPOS_ENTI" Name="CD_CAMPOS_ENTI" ShowInCustomizationForm="True" Visible="False" VisibleIndex="1">
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn FieldName="CD_ENTIDAD" Name="CD_ENTIDAD" ShowInCustomizationForm="True" Visible="False" VisibleIndex="2">
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="Campo" FieldName="DS_NOMBRE_CAMPO" Name="DS_NOMBRE_CAMPO" ShowInCustomizationForm="True" VisibleIndex="3">
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn FieldName="DS_ETIQ_CAMPO" Name="DS_ETIQ_CAMPO" ShowInCustomizationForm="True" Visible="False" VisibleIndex="4">
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn FieldName="DS_DES_CAMPO" Name="DS_DES_CAMPO" ShowInCustomizationForm="True" Visible="False" VisibleIndex="5">
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn FieldName="CD_TIPO_DATO" Name="CD_TIPO_DATO" ShowInCustomizationForm="True" Visible="False" VisibleIndex="6">
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="Tipo de Dato" FieldName="DS_TIPO_DATO" Name="DS_TIPO_DATO" ShowInCustomizationForm="True" VisibleIndex="7">
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn FieldName="NM_LONG_CAMPO" Name="NM_LONG_CAMPO" ShowInCustomizationForm="True" Visible="False" VisibleIndex="8">
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn FieldName="NM_DECI_CAMPO" Name="NM_DECI_CAMPO" ShowInCustomizationForm="True" Visible="False" VisibleIndex="9">
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn FieldName="CD_FOR_KEY" Name="CD_FOR_KEY" ShowInCustomizationForm="True" Visible="False" VisibleIndex="11">
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn FieldName="CD_ENTIDAD_FOR" Name="CD_ENTIDAD_FOR" ShowInCustomizationForm="True" Visible="False" VisibleIndex="12">
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataCheckColumn Caption="Llave" FieldName="CD_PRI_KEY" Name="CD_PRI_KEY" ShowInCustomizationForm="True" VisibleIndex="10">
                                                            <PropertiesCheckEdit DisplayTextChecked="Sí" DisplayTextUnchecked="No" ValueChecked="S" ValueType="System.String" ValueUnchecked="N">
                                                            </PropertiesCheckEdit>
                                                        </dx:GridViewDataCheckColumn>
                                                        <dx:GridViewDataCheckColumn Caption="Identidad" FieldName="CD_CAMPO_IDENTITY" Name="CD_CAMPO_IDENTITY" ShowInCustomizationForm="True" VisibleIndex="13">
                                                            <PropertiesCheckEdit DisplayTextChecked="Sí" DisplayTextUnchecked="No" ValueChecked="S" ValueType="System.String" ValueUnchecked="N">
                                                            </PropertiesCheckEdit>
                                                        </dx:GridViewDataCheckColumn>
                                                        <dx:GridViewDataCheckColumn Caption="Perm. Nulos" FieldName="CD_CAMPO_PERM_NULL" Name="CD_CAMPO_PERM_NULL" ShowInCustomizationForm="True" VisibleIndex="14">
                                                            <PropertiesCheckEdit DisplayTextChecked="Sí" DisplayTextUnchecked="No" ValueChecked="S" ValueType="System.String" ValueUnchecked="N">
                                                            </PropertiesCheckEdit>
                                                        </dx:GridViewDataCheckColumn>
                                                    </Columns>
                                                    <SettingsBehavior AllowSelectSingleRowOnly="True" />
                                                    <SettingsPager NumericButtonCount="4" PageSize="4">
                                                    </SettingsPager>
                                                    <Settings ShowFilterRow="True" />
                                                    <SettingsText EmptyDataRow="Presione Ver Detalle para obtener datos" FilterBarClear="Limpiar" />
                                                    <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                                                </dx:ASPxGridView>
                                            </td>
                                            <td class="celdaDerecha-ancho" style="height: 25px">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td class="celdaIzquierda-ancho" style="height: 25px">&nbsp;</td>
                                            <td class="celdaDetalleDMaestro-ancho" style="height: 25px">&nbsp;</td>
                                            <td class="celdaDetalleIMaestro-ancho" style="height: 25px">&nbsp;</td>
                                            <td class="celdaMedio-ancho" style="height: 25px">&nbsp;</td>
                                            <td class="celdaDerecha-ancho" style="height: 25px">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td class="celdaIzquierda-ancho" style="height: 25px"></td>
                                            <td class="celdaDetalleDMaestro-ancho" style="height: 25px">
                                                <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Código:">
                                                </dx:ASPxLabel>
                                            </td>
                                            <td class="celdaDetalleIMaestro-ancho" style="height: 25px">
                                                <dx:ASPxTextBox ID="CD_ENTIDAD" runat="server" ClientInstanceName="CD_ENTIDAD" NullText="Código de la Entidad" Width="170px">
                                                    <ReadOnlyStyle BackColor="#FFFFCC">
                                                    </ReadOnlyStyle>
                                                </dx:ASPxTextBox>
                                            </td>
                                            <td class="celdaMedio-ancho" style="height: 25px"></td>
                                            <td class="celdaDerecha-ancho" style="height: 25px"></td>
                                        </tr>
                                        <tr>
                                            <td class="celdaIzquierda-ancho">&nbsp;</td>
                                            <td class="celdaDetalleDMaestro-ancho">
                                                <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="Nombre:">
                                                </dx:ASPxLabel>
                                            </td>
                                            <td class="celdaDetalleIMaestro-ancho">
                                                <dx:ASPxTextBox ID="DS_NOM_ENTIDAD" runat="server" ClientInstanceName="DS_NOM_ENTIDAD" NullText="Nombre de la Entidad" Width="200px">
                                                    <ValidationSettings>
                                                        <RequiredField IsRequired="True" />
                                                    </ValidationSettings>
                                                </dx:ASPxTextBox>
                                            </td>
                                            <td class="celdaMedio-ancho">&nbsp;</td>
                                            <td class="celdaDerecha-ancho">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td class="celdaIzquierda-ancho">&nbsp;</td>
                                            <td class="celdaDetalleDMaestro-ancho" rowspan="3">
                                                <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="Desc. Corta:">
                                                </dx:ASPxLabel>
                                            </td>
                                            <td class="celdaDetalleIMaestro-ancho" rowspan="3">
                                                <dx:ASPxMemo ID="DS_DES_ENTIDAD_COR" runat="server" ClientInstanceName="DS_DES_ENTIDAD_COR" MaxLength="100" NullText="Descripción Corta (100 caracs. max)" Rows="3" Width="200px">
                                                </dx:ASPxMemo>
                                            </td>
                                            <td class="celdaMedio-ancho">&nbsp;</td>
                                            <td class="celdaDerecha-ancho">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td class="celdaIzquierda-ancho">&nbsp;</td>
                                            <td class="celdaMedio-ancho">&nbsp;</td>
                                            <td class="celdaDerecha-ancho">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td class="celdaIzquierda-ancho">&nbsp;</td>
                                            <td class="celdaMedio-ancho">&nbsp;</td>
                                            <td class="celdaDetalleDDetalle-ancho">&nbsp;</td>
                                            <td class="celdaDetalleIDetalle-ancho" colspan="2">&nbsp;</td>
                                            <td class="celdaDerecha-ancho">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td class="celdaIzquierda-ancho">&nbsp;</td>
                                            <td class="celdaDetalleDMaestro-ancho" rowspan="4">
                                                <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="Desc. Larga:">
                                                </dx:ASPxLabel>
                                            </td>
                                            <td class="celdaDetalleIMaestro-ancho" rowspan="4">
                                                <dx:ASPxMemo ID="DS_DES_ENTIDAD_LAR" runat="server" ClientInstanceName="DS_DES_ENTIDAD_LAR" MaxLength="500" NullText="Descripción Larga (500 caracs. max.)" Rows="5" Width="200px">
                                                </dx:ASPxMemo>
                                            </td>
                                            <td class="celdaMedio-ancho">&nbsp;</td>
                                            <td class="celdaDetalleDDetalle-ancho">&nbsp;</td>
                                            <td class="celdaDetalleIDetalle-ancho" colspan="2">&nbsp;</td>
                                            <td class="celdaDerecha-ancho">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td class="celdaIzquierda-ancho">&nbsp;</td>
                                            <td class="celdaMedio-ancho">&nbsp;</td>
                                            <td class="celdaDetalleDDetalle-ancho">&nbsp;</td>
                                            <td class="celdaDetalleIDetalle-ancho" colspan="2">&nbsp;</td>
                                            <td class="celdaDerecha-ancho">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td class="celdaIzquierda-ancho">&nbsp;</td>
                                            <td class="celdaMedio-ancho">&nbsp;</td>
                                            <td class="celdaDetalleDDetalle-ancho">&nbsp;</td>
                                            <td class="celdaDetalleIDetalle-ancho" colspan="2">&nbsp;</td>
                                            <td class="celdaDerecha-ancho">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td class="celdaIzquierda-ancho">&nbsp;</td>
                                            <td class="celdaMedio-ancho">&nbsp;</td>
                                            <td class="celdaDetalleDDetalle-ancho">&nbsp;</td>
                                            <td class="celdaDetalleIDetalle-ancho" colspan="2">&nbsp;</td>
                                            <td class="celdaDerecha-ancho">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td class="celdaIzquierda-ancho">&nbsp;</td>
                                            <td class="celdaDetalleDMaestro-ancho">
                                                <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="Estado:">
                                                </dx:ASPxLabel>
                                            </td>
                                            <td class="celdaDetalleIMaestro-ancho">
                                                <dx:ASPxComboBox ID="CD_ESTADO" runat="server" ClientInstanceName="CD_ESTADO" NullText="Estado de la Entidad">
                                                    <Items>
                                                        <dx:ListEditItem Text="Activa" Value="A" />
                                                        <dx:ListEditItem Text="Inactiva" Value="I" />
                                                    </Items>
                                                    <ValidationSettings>
                                                        <RequiredField IsRequired="True" />
                                                    </ValidationSettings>
                                                </dx:ASPxComboBox>
                                            </td>
                                            <td class="celdaMedio-ancho">&nbsp;</td>
                                            <td class="celdaDetalleDDetalle-ancho">&nbsp;</td>
                                            <td class="celdaDetalleIDetalle-ancho" colspan="2">&nbsp;</td>
                                            <td class="celdaDerecha-ancho">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td class="celdaIzquierda-ancho">&nbsp;</td>
                                            <td class="celdaDetalleDMaestro-ancho">&nbsp;</td>
                                            <td class="celdaDetalleIMaestro-ancho">
                                                <dx:ASPxTextBox ID="lblControl" runat="server" BackColor="#EAF1FA" ClientInstanceName="lblControl" ForeColor="#EAF1FA" ReadOnly="True" Width="1px">
                                                    <Border BorderStyle="None" />
                                                </dx:ASPxTextBox>
                                                <dx:ASPxButton ID="cmdVerDetalle" runat="server" OnClick="ASPxButton1_Click" Text="Ver Detalle">
                                                </dx:ASPxButton>
                                            </td>
                                            <td class="celdaMedio-ancho">&nbsp;</td>
                                            <td class="celdaDetalleDDetalle-ancho">&nbsp;</td>
                                            <td class="celdaDetalleIDetalle-ancho" colspan="2">&nbsp;</td>
                                            <td class="celdaDerecha-ancho">&nbsp;</td>
                                        </tr>
                                        <tr class="celdaDetalleC-ancho">
                                            <td class="celdaIzquierda-ancho">&nbsp;</td>
                                            <td class="celdaDetalleDMaestro-ancho">&nbsp;</td>
                                            <td class="celdaDetalleIMaestro-ancho">&nbsp;</td>
                                            <td class="celdaMedio-ancho">&nbsp;</td>
                                            <td class="celdaDetalleDDetalle-ancho">&nbsp;</td>
                                            <td class="celdaDetalleC-ancho">&nbsp;</td>
                                            <td class="celdaDetalleC-ancho">
                                                <dx:ASPxButton ID="cmdRegresar" runat="server" AutoPostBack="False" ClientInstanceName="cmdRegresar" Text="Regresar" UseSubmitBehavior="False" >
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
<asp:Content ID="Content2" runat="server" contentplaceholderid="titulo">
                                <dx:ASPxLabel ID="lblTitulo" runat="server" style="font-weight: 700; font-style: italic; font-size: 18px" Text="ASPxLabel" Theme="Office2010Blue">
                                </dx:ASPxLabel>
                            </asp:Content>
<asp:Content ID="Content3" runat="server" contentplaceholderid="BarraEstatus">
                                <dx:ASPxTextBox ID="lblStatus" runat="server" ClientInstanceName="lblStatus" Font-Bold="True" Font-Italic="True" Width="170px">
                                    <Border BorderStyle="None" />
                                </dx:ASPxTextBox>
                            </asp:Content>

<asp:Content ID="Content4" runat="server" contentplaceholderid="menuMant">
                        <dx:ASPxMenu ID="mnuPrincipal" runat="server" AutoPostBack="True" OnItemClick="mnuPrincipal_ItemClick" ShowAsToolbar="True" ShowPopOutImages="True" Theme="Office2010Blue" AllowSelectItem="True">
                            <ClientSideEvents ItemClick="function(s, e) {
	if (e.item.name == 'icEliminar')
{
		if (confirm('¿Realmente desea eliminar el Registro Seleccionado?'))
		{
			lblControl.SetText('S');
		}
		else
		{
			lblControl.SetText('N');
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


