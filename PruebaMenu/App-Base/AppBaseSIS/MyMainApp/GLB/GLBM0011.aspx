<%@ Page Title="" Language="C#" MasterPageFile="~/MyMaintenanceForm.master" AutoEventWireup="true" CodeBehind="GLBM0011.aspx.cs" Inherits="ClsFormas.GLBM0011" %>
<%@ Register assembly="DevExpress.Web.v14.2, Version=14.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" runat="server" contentplaceholderid="titulo">
                                <dx:ASPxLabel ID="lblTitulo" runat="server" style="font-weight: 700; font-style: italic; font-size: 18px" Text="ASPxLabel" Theme="Office2010Blue">
                                </dx:ASPxLabel>
                            </asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="pnelMant">
    <script type="text/javascript">
            function grid_SelectionChanged(s, e) {
                s.GetSelectedFieldValues('CD_EMPLEADO;CD_TITULO;DS_NOMBRE_EMPLEADO;DS_APELLIDO_EMPLEADO;CD_UNIDAD;DS_CORREO;CD_CARGO_INST;CD_ESTADO', OnGridSelectionComplete);
            }
            function OnGridSelectionComplete(values) {
                if (values.length > 0) {
                    tabOpciones.SetActiveTab(tabOpciones.GetTabByName('pgeDetalle'));
                    CD_EMPLEADO.SetText(values[0][0]);
                    CD_TITULO.SetValue(values[0][1]);
                    DS_NOMBRE_EMPLEADO.SetText(values[0][2]);
                    DS_APELLIDO_EMPLEADO.SetText(values[0][3]);
                    CD_UNIDAD.SetValue(values[0][4]);
                    DS_CORREO.SetText(values[0][5]);
                    CD_CARGO.SetValue(values[0][6]);
                    CD_ESTADO.SetValue(values[0][7]);
                    

                    CD_EMPLEADO.GetInputElement().readOnly = true;
                    CD_EMPLEADO.GetInputElement().setAttribute('style', 'background:#FFFF99;');
                    // CD_UNIDAD.SetIsValid(true);
                    // DS_UNIDAD.SetIsValid(true);
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
                                            <dx:GridViewDataTextColumn Caption="Código Empleado" FieldName="CD_EMPLEADO" ShowInCustomizationForm="True" VisibleIndex="1">
                                                <Settings AllowHeaderFilter="True" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Nombre" FieldName="DS_NOMBRE_EMPLEADO" ShowInCustomizationForm="True" VisibleIndex="3">
                                                <Settings AllowHeaderFilter="True" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Apellido" FieldName="DS_APELLIDO_EMPLEADO" ShowInCustomizationForm="True" VisibleIndex="4">
                                                <Settings AllowHeaderFilter="True" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Estado" FieldName="DS_ESTADO" ShowInCustomizationForm="True" VisibleIndex="8">
                                                <Settings AllowHeaderFilter="True" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Unidad" FieldName="DS_UNIDAD" ShowInCustomizationForm="True" VisibleIndex="5">
                                                <Settings AllowHeaderFilter="True" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Correo Electrónico" FieldName="DS_CORREO" ShowInCustomizationForm="True" VisibleIndex="7">
                                                <Settings AllowHeaderFilter="True" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Cargo" FieldName="DS_CARGO_INST" ShowInCustomizationForm="True" VisibleIndex="6">
                                                <Settings AllowHeaderFilter="True" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Título" FieldName="DS_TITULO" ShowInCustomizationForm="True" VisibleIndex="2">
                                                <Settings AllowHeaderFilter="True" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="CD_UNIDAD" ShowInCustomizationForm="False" Visible="False" VisibleIndex="9">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="CD_TITULO" ShowInCustomizationForm="False" Visible="False" VisibleIndex="10">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="CD_CARGO_INST" ShowInCustomizationForm="False" Visible="False" VisibleIndex="11">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="CD_ESTADO" ShowInCustomizationForm="False" Visible="False" VisibleIndex="12">
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
                                                <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Código Empleado:">
                                                </dx:ASPxLabel>
                                            </td>
                                            <td class="celdaDetalleI-ancho">
                                                <dx:ASPxTextBox ID="CD_EMPLEADO" runat="server" ClientInstanceName="CD_EMPLEADO" Width="170px" NullText="Código de Empleado">
                                                </dx:ASPxTextBox>
                                            </td>
                                            <td class="celdaMedio-ancho">&nbsp;</td>
                                            <td class="celdaDetalleD-ancho">
                                                <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="Título:">
                                                </dx:ASPxLabel>
                                            </td>
                                            <td class="celdaDetalleI-ancho" colspan="2">
                                                <dx:ASPxGridLookup ID="CD_TITULO" runat="server" AutoGenerateColumns="False" ClientInstanceName="CD_TITULO" EnableTheming="True" NullText="Título de Empleado" OnDataBinding="CD_TITULO_DataBinding" TextFormatString="{1}" Theme="Office2010Blue" Width="100px">
                                                    <GridViewProperties>
                                                        <SettingsBehavior AllowFocusedRow="True" AllowSelectSingleRowOnly="True" />
                                                        <Settings ShowFilterRow="True" />
                                                    </GridViewProperties>
                                                    <Columns>
                                                        <dx:GridViewDataTextColumn FieldName="CD_TITULO" ShowInCustomizationForm="False" Visible="False" VisibleIndex="0">
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="Nombre Título" FieldName="DS_TITULO" ShowInCustomizationForm="True" VisibleIndex="1">
                                                            <Settings AllowHeaderFilter="True" />
                                                        </dx:GridViewDataTextColumn>
                                                    </Columns>
                                                </dx:ASPxGridLookup>
                                            </td>
                                            <td class="celdaDerecha-ancho">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td class="celdaIzquierda-ancho">&nbsp;</td>
                                            <td class="celdaDetalleD-ancho">
                                                <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="Nombre:">
                                                </dx:ASPxLabel>
                                            </td>
                                            <td class="celdaDetalleI-ancho">
                                                <dx:ASPxTextBox ID="DS_NOMBRE_EMPLEADO" runat="server" ClientInstanceName="DS_NOMBRE_EMPLEADO" NullText="Nombre de Empleado" Width="170px">
                                                </dx:ASPxTextBox>
                                            </td>
                                            <td class="celdaMedio-ancho">&nbsp;</td>
                                            <td class="celdaDetalleD-ancho">
                                                <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="Apellido:">
                                                </dx:ASPxLabel>
                                            </td>
                                            <td class="celdaDetalleI-ancho" colspan="2">
                                                <dx:ASPxTextBox ID="DS_APELLIDO_EMPLEADO" runat="server" NullText="Apellido de Empleado" Width="170px" ClientInstanceName="DS_APELLIDO_EMPLEADO">
                                                </dx:ASPxTextBox>
                                            </td>
                                            <td class="celdaDerecha-ancho">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td class="celdaIzquierda-ancho">&nbsp;</td>
                                            <td class="celdaDetalleD-ancho">
                                                <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="Unidad:">
                                                </dx:ASPxLabel>
                                            </td>
                                            <td class="celdaDetalleI-ancho">
                                                <dx:ASPxGridLookup ID="CD_UNIDAD" runat="server" ClientInstanceName="CD_UNIDAD" NullText="Unidad en que Labora Empleado" OnDataBinding="CD_UNIDAD_DataBinding" Theme="Office2010Blue" AutoGenerateColumns="False" TextFormatString="{0}" Width="275px">
                                                    <GridViewProperties>
                                                        <SettingsBehavior AllowFocusedRow="True" AllowSelectSingleRowOnly="True" />
                                                        <Settings ShowFilterRow="True" />
                                                    </GridViewProperties>
                                                    <Columns>
                                                        <dx:GridViewDataTextColumn Caption="Unidad" FieldName="DS_UNIDAD" ShowInCustomizationForm="True" VisibleIndex="1">
                                                            <Settings AllowHeaderFilter="True" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn FieldName="CD_UNIDAD" ShowInCustomizationForm="False" Visible="False" VisibleIndex="0">
                                                        </dx:GridViewDataTextColumn>
                                                    </Columns>
                                                </dx:ASPxGridLookup>
                                            </td>
                                            <td class="celdaMedio-ancho">&nbsp;</td>
                                            <td class="celdaDetalleD-ancho">
                                                <dx:ASPxLabel ID="ASPxLabel6" runat="server" Text="Cargo:">
                                                </dx:ASPxLabel>
                                            </td>
                                            <td class="celdaDetalleI-ancho" colspan="2">
                                                <dx:ASPxGridLookup ID="CD_CARGO" runat="server" ClientInstanceName="CD_CARGO" NullText="Cargo del Empleado" Theme="Office2010Blue" AutoGenerateColumns="False" OnDataBinding="CD_CARGO_DataBinding" TextFormatString="{1}" Width="275px">
                                                    <GridViewProperties>
                                                        <SettingsBehavior AllowFocusedRow="True" AllowSelectSingleRowOnly="True" />
                                                        <Settings ShowFilterRow="True" />
                                                    </GridViewProperties>
                                                    <Columns>
                                                        <dx:GridViewDataTextColumn FieldName="CD_CARGO_INST" ShowInCustomizationForm="False" Visible="False" VisibleIndex="0">
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="Cargo" FieldName="DS_CARGO_INST" ShowInCustomizationForm="True" VisibleIndex="1">
                                                            <Settings AllowHeaderFilter="True" />
                                                        </dx:GridViewDataTextColumn>
                                                    </Columns>
                                                </dx:ASPxGridLookup>
                                            </td>
                                            <td class="celdaDerecha-ancho">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td class="celdaIzquierda-ancho">&nbsp;</td>
                                            <td class="celdaDetalleD-ancho">
                                                <dx:ASPxLabel ID="ASPxLabel7" runat="server" Text="Correo:">
                                                </dx:ASPxLabel>
                                            </td>
                                            <td class="celdaDetalleI-ancho">
                                                <dx:ASPxTextBox ID="DS_CORREO" runat="server" ClientInstanceName="DS_CORREO" NullText="Correo Electrónico" Width="170px">
                                                </dx:ASPxTextBox>
                                            </td>
                                            <td class="celdaMedio-ancho">&nbsp;</td>
                                            <td class="celdaDetalleD-ancho">
                                                <dx:ASPxLabel ID="ASPxLabel8" runat="server" Text="Estado:">
                                                </dx:ASPxLabel>
                                            </td>
                                            <td class="celdaDetalleI-ancho" colspan="2">
                                                <dx:ASPxComboBox ID="CD_ESTADO" runat="server" ClientInstanceName="CD_ESTADO" NullText="Estado Actual" EnableTheming="True" Theme="Office2010Silver" ValueType="System.Boolean">
                                                    <Items>
                                                        <dx:ListEditItem Text="Activo" Value="True" />
                                                        <dx:ListEditItem Text="De Baja" Value="False" />
                                                    </Items>
                                                </dx:ASPxComboBox>
                                            </td>
                                            <td class="celdaDerecha-ancho">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td class="celdaIzquierda-ancho">&nbsp;</td>
                                            <td class="celdaDetalleD-ancho">&nbsp;</td>
                                            <td class="celdaDetalleI-ancho">&nbsp;</td>
                                            <td class="celdaMedio-ancho">&nbsp;</td>
                                            <td class="celdaDetalleD-ancho">&nbsp;</td>
                                            <td class="celdaDetalleI-ancho" colspan="2">&nbsp;</td>
                                            <td class="celdaDerecha-ancho">
                                                &nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td class="celdaIzquierda-ancho">&nbsp;</td>
                                            <td class="celdaDetalleD-ancho">&nbsp;</td>
                                            <td class="celdaDetalleI-ancho">&nbsp;</td>
                                            <td class="celdaMedio-ancho">&nbsp;</td>
                                            <td class="celdaDetalleD-ancho">&nbsp;</td>
                                            <td class="celdaDetalleC-ancho">
                                                &nbsp;</td>
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


<asp:Content ID="Content3" runat="server" contentplaceholderid="menuMant">
                        <dx:ASPxMenu ID="mnuPrincipal" runat="server" AutoPostBack="True" OnItemClick="mnuPrincipal_ItemClick" ShowAsToolbar="True" ShowPopOutImages="True" Theme="Office2010Blue" AllowSelectItem="True">
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



