<%@ Page Title="Control de Actividades" Language="C#" MasterPageFile="~/portal/Main.master" AutoEventWireup="true" CodeBehind="control_actividades.aspx.cs" Inherits="SICSA.modulos.control_actividades" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Header1" runat="server">
    <script type="text/javascript">
        function OnRowClick(e) {
            //Unselect all rows
            ASPxGridProrrogas._selectAllRowsOnPage(false);
            //Select the row
            ASPxGridProrrogas.SelectRow(e.visibleIndex, true);
        }
        function OnRowClick2(e) {
            //Unselect all rows
            ASPxGridActComp._selectAllRowsOnPage(false);
            //Select the row
            ASPxGridActComp.SelectRow(e.visibleIndex, true);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="titulo">
        <h2>Control de actividades</h2>
    </div>
    <dx:ASPxPageControl ID="ASPxPageControlActividades" runat="server" ActiveTabIndex="0" Width="100%">
        <TabPages>
            <dx:TabPage Text="Actividades completadas">
                <ContentCollection>
                    <dx:ContentControl runat="server">
                        <asp:SqlDataSource ID="SqlDataActividadesComp" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="SELECT a.CD_DETA_PLAN_EJECUCION_ACTIVIDAD, a.CD_TAREA, f.DS_ACTA, f.DS_REFERENCIA, d.DS_ACUERDO_COMP, d.NM_CORR_ACUERDO, b.DS_TAREA,  c.url_imagen, b.FE_FECHA_INI, b.FECHA_FIN, a.DS_COMENTARIO_ACT_PLAN,a.DS_ARCHIVO_ACT_PLAN, a.DS_RUTA_ARCHIV_ACT_PLAN, a.FECH_CREA, g.DS_NOMBRE_EMPLEADO + ' ' + g.DS_APELLIDO_EMPLEADO AS RESPONSABLE
FROM EJE_DETA_PLAN_EJECUCION_ACTIVIDADES a
	INNER JOIN dbo.ACU_TAREAS_ACUERDOS b ON b.CD_TAREA = a.CD_TAREA
	INNER JOIN dbo.GLB_SEMAFORO c ON c.id_semaforo = b.ESTADO_TAREA
	INNER JOIN dbo.ACU_ENCA_ACUERDOS d ON d.CD_ENCA_ACUERDOS = b.CD_ENCA_ACUERDOS
	INNER JOIN dbo.CONV_PUNTOS_AGENDA e ON e.CD_CONVOCATORIA = d.CD_DETA_CONV
	INNER JOIN dbo.AGD_ENCA_CONVOCATORIA f ON f.CD_ENCA_CONVOCATORIA = e.CD_ENCA_CONVOCATORIA
	INNER JOIN dbo.GLB_EMPLEADOS g ON g.CD_EMPLEADO = b.CD_RESPONSABLE
WHERE a.ESTADO_TAREA = 2 and (a.AUTORIZADO =0 OR a.AUTORIZADO is null)"></asp:SqlDataSource>
                        <dx:ASPxGridView ID="ASPxGridActComp" ClientInstanceName="ASPxGridActComp" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataActividadesComp" KeyFieldName="CD_DETA_PLAN_EJECUCION_ACTIVIDAD" Width="100%">
                            <Columns>
                                <dx:GridViewDataTextColumn FieldName="CD_DETA_PLAN_EJECUCION_ACTIVIDAD" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="0">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="CD_TAREA" ShowInCustomizationForm="True" Visible="False" VisibleIndex="1">
                                    <EditFormSettings Visible="False" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataCheckColumn Name="Select" ShowInCustomizationForm="False" VisibleIndex="2" Caption=" ">
                                    <PropertiesCheckEdit DisplayFormatString="{0}" ValueChecked="1" ValueType="System.Int32" ValueUnchecked="0">
                                    </PropertiesCheckEdit>
                                    <DataItemTemplate>
                                        <dx:ASPxButton ID="btnSeleccionar" runat="server" CommandArgument='<%# Eval("CD_DETA_PLAN_EJECUCION_ACTIVIDAD") %>' OnClick="btnSeleccionar_Click" Text="" Image-Url="~/Content/Images/edit.png" ToolTip="Editar" />
                                    </DataItemTemplate>
                                </dx:GridViewDataCheckColumn>
                                <dx:GridViewDataTextColumn Caption="Acta" FieldName="DS_ACTA" ShowInCustomizationForm="True" VisibleIndex="3">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="Sesión" FieldName="DS_REFERENCIA" ShowInCustomizationForm="True" VisibleIndex="4">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="Acuerdo" FieldName="DS_ACUERDO_COMP" ShowInCustomizationForm="True" VisibleIndex="5" Width="250px">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="N° Acuerdo" FieldName="NM_CORR_ACUERDO" ShowInCustomizationForm="True" VisibleIndex="6">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="Tarea" FieldName="DS_TAREA" ShowInCustomizationForm="True" VisibleIndex="7">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataDateColumn Caption="Fecha Inicio" FieldName="FE_FECHA_INI" ShowInCustomizationForm="True" VisibleIndex="9">
                                </dx:GridViewDataDateColumn>
                                <dx:GridViewDataDateColumn Caption="Fecha Fin" FieldName="FECHA_FIN" ShowInCustomizationForm="True" VisibleIndex="10">
                                </dx:GridViewDataDateColumn>
                                <dx:GridViewDataTextColumn Caption="Comentario" FieldName="DS_COMENTARIO_ACT_PLAN" ShowInCustomizationForm="True" VisibleIndex="12">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataDateColumn Caption="Fecha completado" FieldName="FECH_CREA" ShowInCustomizationForm="True" VisibleIndex="14">
                                </dx:GridViewDataDateColumn>
                                <dx:GridViewDataImageColumn Caption="Estado" FieldName="url_imagen" ShowInCustomizationForm="True" VisibleIndex="11">
                                    <PropertiesImage ImageAlign="Middle" ImageHeight="30px" ImageWidth="30px">
                                    </PropertiesImage>
                                </dx:GridViewDataImageColumn>
                                <dx:GridViewDataHyperLinkColumn Caption="Archivo" FieldName="DS_RUTA_ARCHIV_ACT_PLAN" ShowInCustomizationForm="True" VisibleIndex="13">
                                    <PropertiesHyperLinkEdit Target="_blank" TextField="DS_ARCHIVO_ACT_PLAN">
                                    </PropertiesHyperLinkEdit>
                                    <CellStyle ForeColor="#FF0066">
                                    </CellStyle>
                                </dx:GridViewDataHyperLinkColumn>
                                <dx:GridViewDataTextColumn Caption="Responsable" FieldName="RESPONSABLE" ShowInCustomizationForm="True" VisibleIndex="8" Width="250px">
                                </dx:GridViewDataTextColumn>
                            </Columns>
                            <ClientSideEvents RowClick="function(s, e) { OnRowClick2(e); }">
                            </ClientSideEvents>
                            <SettingsPager PageSize="4">
                            </SettingsPager>
                            <Settings ShowFilterRow="True" ShowGroupPanel="True" />
                            <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                            <Styles>
                                <Header Wrap="True">
                                </Header>
                            </Styles>
                        </dx:ASPxGridView>
                        <br />
                        <table style="width:100%">
                            <tr>
                                <td style="width: 200px;">&nbsp;</td>
                                <td>
                                    <dx:ASPxRadioButtonList ID="ASPxRadioButtonList1" runat="server" Enabled="False" RepeatDirection="Horizontal" SelectedIndex="0" ValueType="System.Int32">
                                        <Items>
                                            <dx:ListEditItem Selected="True" Text="Aceptada" Value="1" />
                                            <dx:ListEditItem Text="Rechazada" Value="3" />
                                        </Items>
                                    </dx:ASPxRadioButtonList>
                                </td>
                            </tr>
                            <tr>
                                <td>Comentarios:</td>
                                <td>
                                    <dx:ASPxMemo ID="ASPxMemo1" runat="server" Enabled="False" Rows="3" Width="90%">
                                    </dx:ASPxMemo>
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td>
                                    <dx:ASPxButton ID="ASPxButtonGuardarAprob" runat="server" Enabled="False" OnClick="ASPxButtonGuardarAprob_Click" Text="Guardar">
                                    </dx:ASPxButton>
                                    &nbsp;&nbsp;&nbsp;
                                    <dx:ASPxButton ID="ASPxButtonCancelarApro" runat="server" Enabled="False" OnClick="ASPxButtonCancelarApro_Click" Text="Cancelar">
                                    </dx:ASPxButton>
                                    &nbsp;<dx:ASPxLabel ID="ASPxLabelCD_EJE_ACT" runat="server" Visible="False">
                                    </dx:ASPxLabel>
                                </td>
                            </tr>
                        </table>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage Text="Prórrogas solicitadas">
                <ContentCollection>
                    <dx:ContentControl runat="server">
                        <asp:SqlDataSource ID="SqlDataProrrogas" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="SELECT a.CD_PRORROGA, e.DS_ACTA, e.DS_REFERENCIA, c.DS_ACUERDO_COMP,  b.DS_TAREA, a.NM_CORR_PROR_ACTIVIDAD, a.DS_JUSTIF_PROR, a.NM_DIAS_PROR_SOLIC, a.NM_DIAS_PROR_AUT, b.FE_FECHA_INI, b.FECHA_FIN, b.DIAS_EJECUCION, f.nombre + ' ' + f.apellido as solicitante, g.url_imagen
FROM dbo.EJE_PLAN_EJECUCION_PRORROGAS_ACT a
	INNER JOIN dbo.ACU_TAREAS_ACUERDOS b ON b.CD_TAREA = a.CD_TAREA
	INNER JOIN dbo.ACU_ENCA_ACUERDOS c ON c.CD_ENCA_ACUERDOS = b.CD_ENCA_ACUERDOS
	INNER JOIN dbo.CONV_PUNTOS_AGENDA d ON d.CD_CONVOCATORIA = c.CD_DETA_CONV
	INNER JOIN dbo.AGD_ENCA_CONVOCATORIA e ON e.CD_ENCA_CONVOCATORIA = d.CD_ENCA_CONVOCATORIA
	INNER JOIN dbo.CONF_USUARIO f ON f.CD_EMPLEADO = b.CD_RESPONSABLE
	INNER JOIN dbo.GLB_SEMAFORO g ON g.id_semaforo = b.ESTADO_TAREA
"></asp:SqlDataSource>
                        <dx:ASPxGridView ID="ASPxGridProrrogas" ClientInstanceName="ASPxGridProrrogas" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataProrrogas" KeyFieldName="CD_PRORROGA">
                            <Columns>
                                <dx:GridViewDataTextColumn FieldName="CD_PRORROGA" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="0">
                                    <EditFormSettings Visible="False" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataCheckColumn Name="Select" ShowInCustomizationForm="False" VisibleIndex="1" Caption=" ">
                                    <PropertiesCheckEdit DisplayFormatString="{0}" ValueChecked="1" ValueType="System.Int32" ValueUnchecked="0">
                                    </PropertiesCheckEdit>
                                    <DataItemTemplate>
                                        <dx:ASPxButton ID="btnAutProrroga" runat="server" CommandArgument='<%# Eval("CD_PRORROGA") %>' OnClick="btnAutProrroga_Click" Text="" Image-Url="~/Content/Images/edit.png" ToolTip="Editar" />
                                    </DataItemTemplate>
                                </dx:GridViewDataCheckColumn>
                                <dx:GridViewDataTextColumn Caption="ACTA" FieldName="DS_ACTA" ShowInCustomizationForm="True" VisibleIndex="2">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="SESION" FieldName="DS_REFERENCIA" ShowInCustomizationForm="True" VisibleIndex="3">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="Acuerdo" FieldName="DS_ACUERDO_COMP" ShowInCustomizationForm="True" VisibleIndex="4">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="Tarea" FieldName="DS_TAREA" ShowInCustomizationForm="True" VisibleIndex="5">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="N° Prorroga" FieldName="NM_CORR_PROR_ACTIVIDAD" ShowInCustomizationForm="True" VisibleIndex="11">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="Justificación" FieldName="DS_JUSTIF_PROR" ShowInCustomizationForm="True" VisibleIndex="12">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="Días de prorroga solicitados" FieldName="NM_DIAS_PROR_SOLIC" ShowInCustomizationForm="True" VisibleIndex="13">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="Días autorizados" FieldName="NM_DIAS_PROR_AUT" ShowInCustomizationForm="True" VisibleIndex="14">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataDateColumn Caption="Fecha Inicio" FieldName="FE_FECHA_INI" ShowInCustomizationForm="True" VisibleIndex="6">
                                </dx:GridViewDataDateColumn>
                                <dx:GridViewDataDateColumn Caption="Fecha Fin" FieldName="FECHA_FIN" ShowInCustomizationForm="True" VisibleIndex="8">
                                </dx:GridViewDataDateColumn>
                                <dx:GridViewDataTextColumn Caption="Días para ejecución" FieldName="DIAS_EJECUCION" ShowInCustomizationForm="True" VisibleIndex="7">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="Solicitante" FieldName="solicitante" ShowInCustomizationForm="True" VisibleIndex="10">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataImageColumn Caption="Estado" FieldName="url_imagen" ShowInCustomizationForm="True" VisibleIndex="9">
                                    <PropertiesImage ImageAlign="Middle" ImageHeight="30px" ImageWidth="30px">
                                    </PropertiesImage>
                                </dx:GridViewDataImageColumn>
                            </Columns>
                            <ClientSideEvents RowClick="function(s, e) { OnRowClick(e); }">
                            </ClientSideEvents>
                            <SettingsPager NumericButtonCount="2">
                            </SettingsPager>
                            <Settings ShowFilterRow="True" ShowGroupPanel="True" />
                            <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                            <Styles>
                                <Header Wrap="True">
                                </Header>
                            </Styles>
                        </dx:ASPxGridView>
                        <br />
                        <br />
                        <table style="width:100%;">
                            <tr>
                                <td style="width:200px;">Días a autorizar: </td>
                                <td>
                                    <asp:TextBox ID="TextBoxDAut" runat="server" TextMode="Number" Enabled="False">0</asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td>
                                    <dx:ASPxButton ID="ASPxButtonAceptarP" runat="server" Text="Aceptar" Enabled="False" OnClick="ASPxButtonAceptarP_Click">
                                    </dx:ASPxButton>
                                    <dx:ASPxButton id="ASPxButtonCancelarP" runat="server" Text="Cancelar" Enabled="False" OnClick="ASPxButtonCancelarP_Click">
                                    </dx:ASPxButton>
                                    <dx:ASPxLabel ID="ASPxLabelCodProrroga" runat="server" Visible="False">
                                    </dx:ASPxLabel>
                                </td>
                            </tr>
                        </table>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
        </TabPages>
    </dx:ASPxPageControl>
</asp:Content>
