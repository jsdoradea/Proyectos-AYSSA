<%@ Page Title="Informes a Pleno" Language="C#" MasterPageFile="~/portal/Main.master" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="SICSA.modulos.dashboard" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header1" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="titulo">
        <h2>Informes a Pleno</h2>
    </div>
    <dx:ASPxPageControl ID="ASPxPageInformes" runat="server" ActiveTabIndex="0" Width="100%">
        <TabPages>
            <dx:TabPage Text="Acuerdos">
                <ContentCollection>
                    <dx:ContentControl runat="server">
                        <asp:SqlDataSource ID="SqlDataAcuerdos" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="SELECT a.CD_ENCA_ACUERDOS, e.DS_ACTA, e.DS_REFERENCIA, e.FECH_CREA ,CAST(a.NM_CORR_ACUERDO as varchar(50)) + '-TEG-' + CAST((YEAR(a.FE_FECHA_INI)) as varchar(4)) AS NACUERDO, c.DS_TIPO_ACUERDO, a.DS_ACUERDO_COMP, a.FE_FECHA_INI, a.PERIODO_DIAS, a.FECHA_FIN, b.url_imagen, f.DS_NOMBRE_EMPLEADO + ' ' + f.DS_APELLIDO_EMPLEADO AS RESPONSABLE, g.DS_TAREA
  FROM ACU_ENCA_ACUERDOS a
	INNER JOIN dbo.GLB_SEMAFORO b ON b.id_semaforo = a.CD_COD_ALERTA
	INNER JOIN dbo.ACU_TIPO_ACUERDO c ON c.CD_TIPO_ACUERDO = a.CD_TIPO_ACUERDO
	INNER JOIN dbo.CONV_PUNTOS_AGENDA d ON d.CD_CONVOCATORIA = a.CD_DETA_CONV
	INNER JOIN dbo.AGD_ENCA_CONVOCATORIA e ON e.CD_ENCA_CONVOCATORIA = d.CD_ENCA_CONVOCATORIA 
	INNER JOIN dbo.GLB_EMPLEADOS f ON f.CD_EMPLEADO = a.CD_RESPONSABLE
                   INNER JOIN dbo.ACU_TAREAS_ACUERDOS g ON g.CD_ENCA_ACUERDOS = a.CD_ENCA_ACUERDOS
WHERE a.FE_FECHA_INI between @FECHA_INI and @FECHA_FIN
ORDER BY e.DS_ACTA, e.DS_REFERENCIA, a.NM_CORR_ACUERDO DESC">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="TextDesde" Name="FECHA_INI" PropertyName="Text" Type="DateTime" />
                                <asp:ControlParameter ControlID="TextHasta" Name="FECHA_FIN" PropertyName="Text" Type="DateTime" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <table style="width:100%;">
                            <tr>
                                <td>Desde:</td>
                                <td>
                                    <asp:TextBox ID="TextDesde" runat="server" TextMode="Date"></asp:TextBox>
                                </td>
                                <td>Hasta:</td>
                                <td>
                                    <asp:TextBox ID="TextHasta" runat="server" TextMode="Date"></asp:TextBox>
                                </td>
                                <td>
                                    <dx:ASPxButton ID="ASPxButtonVerInforme" runat="server" Text="Ver informe" OnClick="ASPxButtonVerInforme_Click">
                                    </dx:ASPxButton>
                                </td>
                                <td style="text-align:right;">
                                    <dx:ASPxGridViewExporter ID="gridExporter" runat="server" FileName="Acuerdos" GridViewID="ASPxGridView1">
                                    </dx:ASPxGridViewExporter>
                                    <dx:ASPxButton ID="ASPxButtonExpXls" runat="server" Text="Exportar a Excel" OnClick="ASPxButtonExpXls_Click">
                                    </dx:ASPxButton>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6">
                                    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataAcuerdos" KeyFieldName="CD_ENCA_ACUERDOS" ClientInstanceName="ASPxGridView1">
                                        <Columns>
                                            <dx:GridViewDataTextColumn FieldName="CD_ENCA_ACUERDOS" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="0">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Acta" FieldName="DS_ACTA" ShowInCustomizationForm="True" VisibleIndex="1">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Convocatoria" FieldName="DS_REFERENCIA" ShowInCustomizationForm="True" VisibleIndex="2">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataDateColumn Caption="Fecha de Acta" FieldName="FECH_CREA" ShowInCustomizationForm="True" VisibleIndex="3">
                                            </dx:GridViewDataDateColumn>
                                            <dx:GridViewDataTextColumn Caption="N° Acuerdo" FieldName="NACUERDO" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="4">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Tipo de Acuerdo" FieldName="DS_TIPO_ACUERDO" ShowInCustomizationForm="True" VisibleIndex="5" Width="150px">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Acuerdo" FieldName="DS_ACUERDO_COMP" ShowInCustomizationForm="True" VisibleIndex="6" Width="300px" GroupIndex="0" SortIndex="0" SortOrder="Ascending">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataDateColumn Caption="Fecha Inicio" FieldName="FE_FECHA_INI" ShowInCustomizationForm="True" VisibleIndex="9">
                                            </dx:GridViewDataDateColumn>
                                            <dx:GridViewDataTextColumn Caption="Período (días)" FieldName="PERIODO_DIAS" ShowInCustomizationForm="True" VisibleIndex="10">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataDateColumn Caption="Fecha Fin" FieldName="FECHA_FIN" ShowInCustomizationForm="True" VisibleIndex="11">
                                            </dx:GridViewDataDateColumn>
                                            <dx:GridViewDataImageColumn Caption="Estado" FieldName="url_imagen" ShowInCustomizationForm="True" VisibleIndex="12">
                                                <PropertiesImage ImageAlign="Middle" ImageHeight="30px" ImageWidth="30px">
                                                </PropertiesImage>
                                            </dx:GridViewDataImageColumn>
                                            <dx:GridViewDataTextColumn Caption="Responsable" FieldName="RESPONSABLE" ShowInCustomizationForm="True" VisibleIndex="7" Width="200px">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Tareas" FieldName="DS_TAREA" ShowInCustomizationForm="True" VisibleIndex="8">
                                            </dx:GridViewDataTextColumn>
                                        </Columns>
                                        <SettingsPager PageSize="5">
                                        </SettingsPager>
                                        <Settings ShowFilterRow="True" ShowGroupPanel="True" />
                                        <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                                        <Styles>
                                            <Header Wrap="True">
                                            </Header>
                                        </Styles>
                                    </dx:ASPxGridView>
                                </td>
                            </tr>
                        </table>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage Text="Estados">
                <ContentCollection>
                    <dx:ContentControl runat="server">
                        <asp:SqlDataSource ID="SqlDataEstados" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="vista_rep_estados_sp" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="TextDesde1" Name="FECHA_INI" PropertyName="Text" Type="DateTime" />
                                <asp:ControlParameter ControlID="TextHasta1" Name="FECHA_FIN" PropertyName="Text" Type="DateTime" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <table style="width:100%;">
                            <tr>
                                <td>Desde:</td>
                                <td>
                                    <asp:TextBox ID="TextDesde1" runat="server" TextMode="Date"></asp:TextBox>
                                </td>
                                <td>Hasta:</td>
                                <td>
                                    <asp:TextBox ID="TextHasta1" runat="server" TextMode="Date"></asp:TextBox>
                                </td>
                                <td>
                                    <dx:ASPxButton ID="ASPxButtonVerInforme1" runat="server" Text="Ver informe" OnClick="ASPxButtonVerInforme1_Click">
                                    </dx:ASPxButton>
                                </td>
                                <td style="text-align:right;">
                                    <dx:ASPxGridViewExporter ID="gridExporter1" runat="server" FileName="Alertas" GridViewID="ASPxGridView2">
                                    </dx:ASPxGridViewExporter>
                                    <dx:ASPxButton ID="ASPxButtonExpExcel1" runat="server" Text="Exportar a Excel" OnClick="ASPxButtonExpExcel1_Click">
                                    </dx:ASPxButton>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6">
                                    <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataEstados" Width="100%">
                                        <Columns>
                                            <dx:GridViewDataTextColumn FieldName="CD_RESPONSABLE" ShowInCustomizationForm="True" Visible="False" VisibleIndex="0">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Responsable" FieldName="RESPONSABLE" ShowInCustomizationForm="True" VisibleIndex="1">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Acuerdos en Ejecución" FieldName="TOTAL_ACUERDOS" ShowInCustomizationForm="True" VisibleIndex="2">
                                                <HeaderStyle HorizontalAlign="Right" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Al día" FieldName="VERDES" ShowInCustomizationForm="True" VisibleIndex="5">
                                                <HeaderStyle HorizontalAlign="Right" />
                                                <CellStyle BackColor="#009900">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Próximos a vencer" FieldName="AMARILLOS" ShowInCustomizationForm="True" VisibleIndex="4">
                                                <HeaderStyle HorizontalAlign="Right" />
                                                <CellStyle BackColor="Yellow">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Retrasados" FieldName="ROJOS" ShowInCustomizationForm="True" VisibleIndex="3">
                                                <HeaderStyle HorizontalAlign="Right" />
                                                <CellStyle BackColor="Red">
                                                </CellStyle>
                                            </dx:GridViewDataTextColumn>
                                        </Columns>
                                        <Settings ShowFilterRow="True" ShowGroupPanel="True" />
                                        <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                                    </dx:ASPxGridView>
                                </td>
                            </tr>
                        </table>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
        </TabPages>
    </dx:ASPxPageControl>
</asp:Content>
