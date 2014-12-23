<%@ Page Title="" Language="C#" MasterPageFile="~/portal/Main.master" AutoEventWireup="true" CodeBehind="convocatoria.aspx.cs" Inherits="SICSA.correspondencia.convocatoria" %>

<%@ Register Assembly="DevExpress.XtraReports.v14.2.Web, Version=14.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraReports.Web" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="Content2" ContentPlaceHolderID="Header1" runat="server">
    <script type="text/javascript">
        function OnRowClick(e) {
            //Unselect all rows
            ASPxGridDatosConvocatoria._selectAllRowsOnPage(false);
            //Select the row
            ASPxGridDatosConvocatoria.SelectRow(e.visibleIndex, true);
        }
    </script>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div id="titulo">
        <h2>Convocatoria a sesión de pleno</h2>
    </div>
    <asp:SqlDataSource ID="SqlDataPeriodo" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="SELECT [CD_CIERRE], [DS_PERIODO], [CD_EJERICIO] FROM [GLB_CIERRE_PERIODO] ORDER  BY [CD_EJERICIO] DESC, CD_PERIODO DESC"></asp:SqlDataSource>
    <dx:ASPxPageControl ID="PageConvocatoria" runat="server" ActiveTabIndex="1" Width="100%">
        <TabPages>
            <dx:TabPage Name="Datos" Text="Datos">
                <ContentCollection>
                    <dx:ContentControl runat="server">
                        <table style="width: 100%">
                            <tr>
                                <td style="width: 10%;">
                                    <label>Periodo:</label></td>
                                <td>
                                    <dx:ASPxComboBox ID="ASPxComboBoxPeriodo" runat="server" ValueType="System.Int32" DataSourceID="SqlDataPeriodo" ValueField="CD_CIERRE" AutoPostBack="True">
                                        <Columns>
                                            <dx:ListBoxColumn Caption="CD_CIERRE" FieldName="CD_CIERRE" Name="CD_CIERRE" Visible="False" />
                                            <dx:ListBoxColumn Caption="PERIODO" FieldName="DS_PERIODO" Name="PERIODO" />
                                            <dx:ListBoxColumn Caption="EJERCICIO" FieldName="CD_EJERICIO" Name="EJERCICIO" />
                                        </Columns>
                                    </dx:ASPxComboBox>
                                    <asp:SqlDataSource ID="SqlDataGridDatos" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" DeleteCommand="DELETE FROM dbo.AGD_ENCA_CONVOCATORIA WHERE CD_ENCA_CONVOCATORIA = @CD_ENCA_CONVOCATORIA "
                                        SelectCommand="convocatoria" SelectCommandType="StoredProcedure">
                                        <DeleteParameters>
                                            <asp:Parameter Name="CD_ENCA_CONVOCATORIA" />
                                        </DeleteParameters>
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="ASPxComboBoxPeriodo" Name="PERIODO" PropertyName="Value" Type="Int32" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </td>
                                <td style="text-align: right;">
                                    <dx:ASPxButton ID="btnNuevo" runat="server" Text="Nueva convocatoria" OnClick="btnNuevo_Click"></dx:ASPxButton>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <dx:ASPxGridView ID="ASPxGridConvocatoria" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataGridDatos" KeyFieldName="CD_ENCA_CONVOCATORIA" ClientInstanceName="ASPxGridDatosConvocatoria" Width="100%">
                                        <Columns>
                                            <dx:GridViewDataTextColumn FieldName="CD_ENCA_CONVOCATORIA" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="0">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataCheckColumn Name="Select" ShowInCustomizationForm="False" VisibleIndex="1" Caption=" ">
                                                <PropertiesCheckEdit DisplayFormatString="{0}" ValueChecked="1" ValueType="System.Int32" ValueUnchecked="0">
                                                </PropertiesCheckEdit>
                                                <DataItemTemplate>
                                                    <dx:ASPxButton ID="btnSeleccionar" runat="server" CommandArgument='<%# Eval("CD_ENCA_CONVOCATORIA") %>' OnClick="btnSeleccionar_Click" Text="Seleccionar" />
                                                </DataItemTemplate>
                                            </dx:GridViewDataCheckColumn>

                                            <dx:GridViewDataTextColumn Caption="Convocatoria" FieldName="DS_REFERENCIA" ShowInCustomizationForm="True" VisibleIndex="2">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Tipo" FieldName="TIPO_SESION" ShowInCustomizationForm="True" VisibleIndex="3">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataDateColumn Caption="Fecha Convocatoria" FieldName="FE_FECHA_PROP_INI" ShowInCustomizationForm="True" VisibleIndex="4">
                                            </dx:GridViewDataDateColumn>
                                            <dx:GridViewDataTextColumn Caption="Estado" FieldName="ESTADO_SESION" ShowInCustomizationForm="True" VisibleIndex="5">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewCommandColumn ButtonType="Button" Caption=" " ShowClearFilterButton="True" ShowDeleteButton="True" ShowInCustomizationForm="True" VisibleIndex="6">
                                            </dx:GridViewCommandColumn>
                                        </Columns>
                                        <ClientSideEvents RowClick="function(s, e) { OnRowClick(e); }"></ClientSideEvents>
                                        <SettingsBehavior ConfirmDelete="True" />
                                        <SettingsPager PageSize="7">
                                        </SettingsPager>
                                        <Settings ShowFilterRow="True" ShowGroupPanel="True" />
                                        <SettingsDataSecurity AllowEdit="False" AllowInsert="False" />
                                    </dx:ASPxGridView>
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
                                <td style="width: 150px;">
                                    <label>Referencia:</label>
                                </td>
                                <td>
                                    <dx:ASPxLabel ID="lblRef" runat="server">
                                    </dx:ASPxLabel>
                                </td>
                                <td style="text-align: right;">
                                    <label>Fecha de registro:</label></td>
                                <td style="text-align: right; width: 150px;">
                                    <asp:TextBox ID="TextBoxFecha_Registro" runat="server" TextMode="Date"></asp:TextBox>
                                </td>
                            </tr>
                            </table>
                        <div id="Sesion" style="width:100%">
                            <dx:ASPxPageControl ID="ASPxPageSesion" runat="server" ActiveTabIndex="2" Width="50%" >
                                <TabPages>
                                    <dx:TabPage Name="Crear" Text="Crear Sesión">
                                        <ContentCollection>
                                            <dx:ContentControl ID="ContentControl1" runat="server">
                                                <table style="width:100%;">
                                                        <tr>
                                                            <td>
                                                                <label>Referencia:</label></td>
                                                            <td>
                                                                <asp:TextBox ID="txtRef" runat="server"></asp:TextBox></td>
                                                            <td>
                                                                <label>Fecha de sesión:</label></td>
                                                            <td>
                                                                <asp:TextBox ID="txtFecha" runat="server" TextMode="Date"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <label>Tipo de sesión:</label></td>
                                                            <td>
                                                                <dx:ASPxComboBox ID="ASPxComboBoxTipoSesion" runat="server" ValueType="System.String"></dx:ASPxComboBox>
                                                            </td>
                                                            <td>
                                                                <label>Hora de sesión:</label></td>
                                                            <td>
                                                                <asp:TextBox ID="txtHora" runat="server" TextMode="Time"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <label>Estado:</label></td>
                                                            <td>
                                                                <dx:ASPxComboBox ID="ASPxComboBoxEstadoSesion" runat="server" ValueType="System.String"></dx:ASPxComboBox>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
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
                                                            <td><asp:Button ID="btnAceptar" runat="server" OnClick="btnAceptar_Click" Text="Guardar" />&nbsp;&nbsp;
                                                                <asp:Button ID="btnCancelar" runat="server" OnClick="btnCancelar_Click" Text="Cancelar" />
                                                            </td>
                                                        </tr>
                                                        

                                                    </table>
                                            </dx:ContentControl>
                                        </ContentCollection>
                                    </dx:TabPage>
                                    <dx:TabPage Name="Puntos" Text="Puntos de acta">
                                        <ContentCollection>
                                            <dx:ContentControl ID="ContentControl2" runat="server">
                                            </dx:ContentControl>
                                        </ContentCollection>
                                    </dx:TabPage>
                                    <dx:TabPage Name="Agenda" Text="Agenda Sugerida">
                                        <ContentCollection>
                                            <dx:ContentControl ID="ContentControl3" runat="server">
                                                <dx:ASPxDocumentViewer ID="ASPxDocumentViewer1" runat="server" ReportTypeName="SICSA.reportes.XtraReportagenda">
<StylesViewer>
<Paddings Padding="10px"></Paddings>
</StylesViewer>

<StylesReportViewer>
<Paddings Padding="10px"></Paddings>
</StylesReportViewer>
                                                </dx:ASPxDocumentViewer>
                                            </dx:ContentControl>
                                        </ContentCollection>
                                    </dx:TabPage>
                                    <dx:TabPage Name="Convocar" Text="Convocar">
                                        <ContentCollection>
                                            <dx:ContentControl ID="ContentControl4" runat="server">
                                            </dx:ContentControl>
                                        </ContentCollection>
                                    </dx:TabPage>
                                    <dx:TabPage Name="Reprogramacion" Text="Reprogramación de Sesión">
                                        <ContentCollection>
                                            <dx:ContentControl ID="ContentControl5" runat="server">
                                            </dx:ContentControl>
                                        </ContentCollection>
                                    </dx:TabPage>
                                    <dx:TabPage Name="Solicitudes" Text="Puntos de acta adicionales">
                                        <ContentCollection>
                                            <dx:ContentControl ID="ContentControl6" runat="server">
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
</asp:Content>
