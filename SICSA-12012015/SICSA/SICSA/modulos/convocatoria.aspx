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
    <style>
        .tabla
        {
            width:100%;
        }
        .c1
        {
            min-width:150px;
        }
        .c2
        {
            max-width:50%;
        }
        .c3
        {
            min-width:300px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div id="titulo">
        <h2>Convocatoria a Sesión de Pleno</h2>
    </div>
    <asp:SqlDataSource ID="SqlDataPeriodo" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="SELECT [CD_CIERRE], [DS_PERIODO], [CD_EJERICIO] FROM [GLB_CIERRE_PERIODO] ORDER  BY [CD_EJERICIO] DESC, CD_PERIODO DESC"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataTipoSesion" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="SELECT CD_TIPO_SESION, TIPO_SESION  FROM GLB_TIPO_SESION_CONVOCATORIA ORDER BY CD_TIPO_SESION"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataEstado" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="SELECT CD_ESTADO_SESION, ESTADO_SESION FROM dbo.GLB_TIPO_PROGRAMACION_CONVOCATORIA ORDER BY CD_ESTADO_SESION"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataLugar" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="SELECT CD_LUGAR, DS_LUGAR FROM dbo.GLB_LUGARES ORDER BY DEFECTO desc, DS_LUGAR"></asp:SqlDataSource>
    <dx:ASPxPageControl ID="PageConvocatoria" runat="server" ActiveTabIndex="1" Width="100%">
        <TabPages>
            <dx:TabPage Name="Datos" Text="Datos">
                <ContentCollection>
                    <dx:ContentControl runat="server">
                        <table style="width: 100%">
                            <tr>
                                <td style="width: 10%;">
                                    <label>
                                    Periodo:</label></td>
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
                                    <dx:ASPxButton ID="btnNuevo" runat="server" Text="Nueva convocatoria" OnClick="btnNuevo_Click">
                                    </dx:ASPxButton>
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
                                            <dx:GridViewDataTextColumn Caption="Estado" FieldName="ESTADO_SESION" ShowInCustomizationForm="True" VisibleIndex="7">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewCommandColumn ButtonType="Button" Caption=" " ShowClearFilterButton="True" ShowDeleteButton="True" ShowInCustomizationForm="True" VisibleIndex="8">
                                            </dx:GridViewCommandColumn>
                                            <dx:GridViewDataTimeEditColumn Caption="Hora" FieldName="HO_HORA_PROP_INI" ShowInCustomizationForm="True" VisibleIndex="5">
                                            </dx:GridViewDataTimeEditColumn>
                                            <dx:GridViewDataTextColumn Caption="Lugar" FieldName="DS_LUGAR" ShowInCustomizationForm="True" VisibleIndex="6">
                                            </dx:GridViewDataTextColumn>
                                        </Columns>
                                        <ClientSideEvents RowClick="function(s, e) { OnRowClick(e); }">
                                        </ClientSideEvents>
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
                        <div id="detalles" style="width:98%; padding:5px 5px 5px 5px;">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <label>
                                        Referencia:&nbsp;&nbsp;</label>
                                        <dx:ASPxLabel ID="lblRef" runat="server" Font-Bold="True" Font-Size="Small" ForeColor="#84BD00">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td style="text-align: right;">
                                        <label>
                                        Fecha de registro:&nbsp;&nbsp;</label>
                                        <asp:TextBox ID="TextBoxFecha_Registro" runat="server" TextMode="Date"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="max-width:800px;">
                                        <dx:ASPxPageControl ID="ASPxPageSesion" runat="server" ActiveTabIndex="1" Width="100%" OnActiveTabChanged="ASPxPageSesion_ActiveTabChanged" AutoPostBack="True">
                                            <TabPages>
                                                <dx:TabPage Name="Crear" Text="Crear Sesión">
                                                    <ContentCollection>
                                                        <dx:ContentControl ID="ContentControl1" runat="server">
                                                            <table style="width:100%">
                                                                <tr>
                                                                    <td>
                                                                        <label>
                                                                        Referencia:</label></td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtRef" runat="server"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <label>
                                                                        Fecha de sesión:</label></td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtFecha" runat="server" TextMode="Date"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <label>
                                                                        Tipo de sesión:</label></td>
                                                                    <td>
                                                                        <dx:ASPxComboBox ID="ASPxComboBoxTipoSesion" runat="server" ValueType="System.Int32" DataSourceID="SqlDataTipoSesion" TextField="TIPO_SESION" ValueField="CD_TIPO_SESION">
                                                                        </dx:ASPxComboBox>
                                                                    </td>
                                                                    <td>
                                                                        <label>
                                                                        Hora de sesión:</label></td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtHora" runat="server" TextMode="Time"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <label>
                                                                        Estado:</label></td>
                                                                    <td>
                                                                        <dx:ASPxComboBox ID="ASPxComboBoxEstadoSesion" runat="server" ValueType="System.Int32" DataSourceID="SqlDataEstado" TextField="ESTADO_SESION" ValueField="CD_ESTADO_SESION">
                                                                        </dx:ASPxComboBox>
                                                                    </td>
                                                                    <td>Lugar:</td>
                                                                    <td>
                                                                        <dx:ASPxComboBox ID="ASPxComboLugar" runat="server" DataSourceID="SqlDataLugar" TextField="DS_LUGAR" ValueField="CD_LUGAR" ValueType="System.Int32" Width="100%">
                                                                        </dx:ASPxComboBox>
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
                                                                    <td>
                                                                        <asp:Button ID="btnAceptar" runat="server" OnClick="btnAceptar_Click" Text="Guardar" />
                                                                        &nbsp;&nbsp;
                                                                        <asp:Button ID="btnCancelar" runat="server" OnClick="btnCancelar_Click" Text="Cancelar" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </dx:ContentControl>
                                                    </ContentCollection>
                                                </dx:TabPage>
                                                <dx:TabPage Name="Puntos" Text="Puntos de Acta">
                                                    <ContentCollection>
                                                        <dx:ContentControl ID="ContentControl2" runat="server">
                                                            <div id="tema" style="width:100%;">
                                                                <label>
                                                                Puntos solicitados a tratar:</label>
                                                            </div>
                                                            <dx:ASPxGridView ID="ASPxGridPuntos" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataPuntos"  Width="100%" KeyFieldName="CD_PUNTO_AGENDA">
                                                                <Columns>
                                                                    <dx:GridViewCommandColumn Caption=" " ShowEditButton="True" ShowInCustomizationForm="True" VisibleIndex="0">
                                                                    </dx:GridViewCommandColumn>
                                                                    <dx:GridViewDataTextColumn FieldName="CD_PUNTO_AGENDA" ShowInCustomizationForm="True" VisibleIndex="1" ReadOnly="True" Visible="False">
                                                                        <EditFormSettings Visible="False" />
                                                                    </dx:GridViewDataTextColumn>
                                                                    <dx:GridViewDataTextColumn FieldName="CD_ENCA_CONVOCATORIA" ShowInCustomizationForm="True" VisibleIndex="2" ReadOnly="True" Visible="False">
                                                                    </dx:GridViewDataTextColumn>
                                                                    <dx:GridViewDataTextColumn Caption="Nombre de punto" FieldName="DS_PUNTO_AGENDA" ShowInCustomizationForm="True" VisibleIndex="3" Width="400px">
                                                                        <EditFormSettings Visible="False" />
                                                                    </dx:GridViewDataTextColumn>
                                                                    <dx:GridViewDataDateColumn FieldName="FE_FECH_SOLIC" ShowInCustomizationForm="True" VisibleIndex="4" Caption="Fecha de solicitud">
                                                                        <EditFormSettings Visible="False" />
                                                                    </dx:GridViewDataDateColumn>
                                                                    <dx:GridViewDataDateColumn FieldName="FECH_CREA" ShowInCustomizationForm="True" VisibleIndex="5" Caption="Fecha de registro">
                                                                        <EditFormSettings Visible="False" />
                                                                    </dx:GridViewDataDateColumn>
                                                                    <dx:GridViewDataComboBoxColumn Caption="Incluir punto como:" FieldName="CD_TIPO_INCLUSION" ShowInCustomizationForm="True" VisibleIndex="6">
                                                                        <PropertiesComboBox DataSourceID="SqlDataTipoInclusion" TextField="DS_TIPO_INCLUSION" ValueField="CD_TIPO_PUNTO_CONV">
                                                                        </PropertiesComboBox>
                                                                    </dx:GridViewDataComboBoxColumn>
                                                                </Columns>
                                                                <SettingsPager PageSize="7">
                                                                </SettingsPager>
                                                                <Settings ShowFilterRow="True" ShowGroupPanel="True" />
                                                                <SettingsCommandButton>
                                                                    <EditButton Text="Asignar">
                                                                    </EditButton>
                                                                </SettingsCommandButton>
                                                            </dx:ASPxGridView>
                                                            <asp:SqlDataSource ID="SqlDataPuntos" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="SELECT a.CD_PUNTO_AGENDA,  @CD_CONV as CD_ENCA_CONVOCATORIA,  a.DS_PUNTO_AGENDA, a.FE_FECH_SOLIC, a.FECH_CREA, 3 as CD_TIPO_INCLUSION
FROM dbo.AGD_PUNTOS_AGENDA a
WHERE NOT(a.CD_ESTADO_CORR = 2 OR a.CD_ESTADO_CORR=3)
ORDER BY a.FE_FECH_SOLIC, a.CD_PUNTO_AGENDA" UpdateCommand="EXEC	dbo.puntos_convocatoria_sp 	@COD_AGENDA = @CD_PUNTO_AGENDA,  @COD_TIPO_INCLUSION = @CD_TIPO_INCLUSION,  @COD_ENCA_CONV = @CD_ENCA_CONVOCATORIA">
                                                                <SelectParameters>
                                                                    <asp:ControlParameter ControlID="txtConv"  DefaultValue="1" Name="CD_CONV" PropertyName="Text" />
                                                                </SelectParameters>
                                                                <UpdateParameters>
                                                                    <asp:Parameter Name="COD_AGENDA" />
                                                                    <asp:Parameter Name="CD_PUNTO_AGENDA" />
                                                                    <asp:Parameter Name="COD_TIPO_INCLUSION" />
                                                                    <asp:Parameter Name="CD_TIPO_INCLUSION" Type="Int32" />
                                                                    <asp:Parameter Name="COD_ENCA_CONV" />
                                                                    <asp:Parameter Name="CD_ENCA_CONVOCATORIA" />
                                                                </UpdateParameters>
                                                            </asp:SqlDataSource>
                                                            <asp:SqlDataSource ID="SqlDataTipoInclusion" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="SELECT CD_TIPO_PUNTO_CONV, DS_TIPO_INCLUSION FROM dbo.CONV_TIPO_PUNTO_INCLUSION"></asp:SqlDataSource>
                                                        </dx:ContentControl>
                                                    </ContentCollection>
                                                </dx:TabPage>
                                                <dx:TabPage Name="Agenda" Text="Agenda sugerida">
                                                    <ContentCollection>
                                                        <dx:ContentControl ID="ContentControl3" runat="server">
                                                            <table style="width: 100%;">
                                                                <tr>
                                                                    <td style="width: 50%; vertical-align: top;">
                                                                        <asp:Panel ID="Panel2" runat="server" Height="350px" Width="100%">
                                                                            <asp:SqlDataSource ID="SqlDataPuntosIncluidos" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="SELECT a.CD_CONVOCATORIA, b.DS_PUNTO_AGENDA, c.DS_TIPO_INCLUSION, a.ORDEN
FROM CONV_PUNTOS_AGENDA a
	INNER JOIN dbo.AGD_PUNTOS_AGENDA b ON b.CD_PUNTO_AGENDA = a.CD_PUNTO_AGENDA
	INNER JOIN dbo.CONV_TIPO_PUNTO_INCLUSION c ON c.CD_TIPO_PUNTO_CONV = a.CD_TIPO_PUNTO
WHERE a.CD_ENCA_CONVOCATORIA=@CD_ENCA_CONVOCATORIA
ORDER BY a.ORDEN">
                                                                                <SelectParameters>
                                                                                    <asp:ControlParameter ControlID="txtConv" DefaultValue="0" Name="CD_ENCA_CONVOCATORIA" PropertyName="Text" />
                                                                                </SelectParameters>
                                                                            </asp:SqlDataSource>
                                                                            <table style="width:100%">
                                                                                <tr>
                                                                                    <td style="text-align:center;">
                                                                                        <dx:ASPxGridView ID="GridPuntosAgenda" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataPuntosIncluidos" KeyFieldName="CD_CONVOCATORIA"  Width="100%">
                                                                                            <Columns>
                                                                                                <dx:GridViewCommandColumn SelectAllCheckboxMode="Page" ShowInCustomizationForm="True" ShowSelectCheckbox="True" VisibleIndex="0" Caption=" ">
                                                                                                </dx:GridViewCommandColumn>
                                                                                                <dx:GridViewDataTextColumn FieldName="CD_CONVOCATORIA" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="1">
                                                                                                    <EditFormSettings Visible="False" />
                                                                                                </dx:GridViewDataTextColumn>
                                                                                                <dx:GridViewDataTextColumn Caption="Nombre de punto" FieldName="DS_PUNTO_AGENDA" ShowInCustomizationForm="True" VisibleIndex="2">
                                                                                                </dx:GridViewDataTextColumn>
                                                                                                <dx:GridViewDataTextColumn Caption="Incluido como:" FieldName="DS_TIPO_INCLUSION" ShowInCustomizationForm="True" VisibleIndex="3">
                                                                                                </dx:GridViewDataTextColumn>
                                                                                                <dx:GridViewDataTextColumn FieldName="ORDEN" ShowInCustomizationForm="True" Visible="False" VisibleIndex="4">
                                                                                                </dx:GridViewDataTextColumn>
                                                                                            </Columns>
                                                                                            <SettingsBehavior AllowSelectSingleRowOnly="True" />
                                                                                            <SettingsPager Visible="False">
                                                                                            </SettingsPager>
                                                                                            <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                                                                                            <Styles>
                                                                                                <Cell HorizontalAlign="Left">
                                                                                                </Cell>
                                                                                            </Styles>
                                                                                        </dx:ASPxGridView>
                                                                                    </td>
                                                                                    <td style="text-align:right; vertical-align:top;">
                                                                                        <asp:ImageButton ID="imgSubir" runat="server" ImageUrl="~/Content/Images/flecha_arriba.png" ToolTip="Subir Nivel" Width="32px" OnClick="imgSubir_Click" />
                                                                                        <br />
                                                                                        <asp:ImageButton ID="imgBajar" runat="server" ImageUrl="~/Content/Images/abajo_t.png" ToolTip="Bajar Nivel" Width="32px" OnClick="imgBajar_Click" />
                                                                                        <br />
                                                                                        <asp:ImageButton ID="imgQuitar" runat="server" ImageUrl="~/Content/Images/quitar2.png" ToolTip="Quitar punto" Width="32px" OnClick="imgQuitar_Click" />
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </asp:Panel>
                                                                    </td>
                                                                    <td style="width: 50%; vertical-align: top;text-align:center; vertical-align:top;">
                                                                        <dx:ASPxPanel ID="ASPxPanel1" runat="server" Height="350px" ScrollBars="Vertical" Width="100%">
                                                                            <PanelCollection>
                                                                                <dx:PanelContent runat="server">
                                                                                    <dx:ASPxDocumentViewer ID="ASPxDocumentViewerAgenda" runat="server" ReportTypeName="SICSA.reportes.XtraReportAgenda">
                                                                                        <StylesViewer>
                                                                                            <Paddings Padding="10px">
                                                                                            </Paddings>
                                                                                        </StylesViewer>
                                                                                        <StylesReportViewer>
                                                                                            <Paddings Padding="10px">
                                                                                            </Paddings>
                                                                                        </StylesReportViewer>
                                                                                    </dx:ASPxDocumentViewer>
                                                                                </dx:PanelContent>
                                                                            </PanelCollection>
                                                                        </dx:ASPxPanel>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </dx:ContentControl>
                                                    </ContentCollection>
                                                </dx:TabPage>
                                                <dx:TabPage Name="Convocar" Text="Convocar">
                                                    <ContentCollection>
                                                        <dx:ContentControl ID="ContentControl4" runat="server">
                                                            <table style="width:100%">
                                                                <tr>
                                                                    <td colspan="2">Miembros Pleno a convocar</td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 50%; vertical-align: top;text-align:center; vertical-align:top;">
                                                                        <asp:SqlDataSource ID="SqlDataMiembros" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="SELECT a.CD_MIEMBRO_PLENO, b.DS_NOMBRE_EMPLEADO + ' ' + b.DS_APELLIDO_EMPLEADO AS EMPLEADO, c.DS_TIPO_MIEMBRO
FROM dbo.GLB_MIEMBROS_PLENO a
	INNER JOIN dbo.GLB_EMPLEADOS b ON a.CD_EMPLEADO = b.CD_EMPLEADO
	INNER JOIN dbo.GLB_TIPO_MIEMBRO c ON c.CD_TIPO_MIEMBRO = a.CD_TIPO
WHERE a.CD_ESTADO = 1
ORDER BY a.CD_TIPO, b.DS_NOMBRE_EMPLEADO, b.DS_APELLIDO_EMPLEADO"></asp:SqlDataSource>
                                                                        <dx:ASPxPanel ID="ASPxPanel3" runat="server" Height="320px" ScrollBars="Vertical" Width="100%">
                                                                            <PanelCollection>
                                                                                <dx:PanelContent ID="PanelContent1" runat="server">
                                                                                    <dx:ASPxGridView ID="ASPxGridViewMiembrosPleno" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataMiembros" KeyFieldName="CD_MIEMBRO_PLENO" Width="100%">
                                                                                        <Columns>
                                                                                            <dx:GridViewCommandColumn SelectAllCheckboxMode="AllPages" ShowInCustomizationForm="True" ShowSelectCheckbox="True" VisibleIndex="0" ShowClearFilterButton="True">
                                                                                            </dx:GridViewCommandColumn>
                                                                                            <dx:GridViewDataTextColumn FieldName="CD_MIEMBRO_PLENO" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="1">
                                                                                                <EditFormSettings Visible="False" />
                                                                                            </dx:GridViewDataTextColumn>
                                                                                            <dx:GridViewDataTextColumn Caption="Miembro" FieldName="EMPLEADO" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="2">
                                                                                            </dx:GridViewDataTextColumn>
                                                                                            <dx:GridViewDataTextColumn Caption="Tipo" FieldName="DS_TIPO_MIEMBRO" ShowInCustomizationForm="True" VisibleIndex="3">
                                                                                            </dx:GridViewDataTextColumn>
                                                                                        </Columns>
                                                                                        <Settings ShowFilterRow="True" />
                                                                                        <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                                                                                    </dx:ASPxGridView>
                                                                                </dx:PanelContent>
                                                                            </PanelCollection>
                                                                        </dx:ASPxPanel>
                                                                    </td>
                                                                    <td>
                                                                        <dx:ASPxPanel ID="ASPxPanel4" runat="server" Height="320px" ScrollBars="Vertical" Width="100%">
                                                                            <PanelCollection>
                                                                                <dx:PanelContent ID="PanelContent2" runat="server">
                                                                                    <dx:ASPxButton ID="ASPxButtonConvocatoria" runat="server" Text="Generar Convocatoria" OnClick="ASPxButtonConvocatoria_Click">
                                                                                    </dx:ASPxButton>
                                                                                    <dx:ASPxDocumentViewer ID="ASPxDocumentViewerConvocatoria" runat="server" ReportTypeName="SICSA.reportes.XtraReportConvocatoria">
                                                                                        <StylesViewer>
                                                                                            <Paddings Padding="10px" />
                                                                                        </StylesViewer>
                                                                                        <StylesReportViewer>
                                                                                            <Paddings Padding="10px" />
                                                                                        </StylesReportViewer>
                                                                                    </dx:ASPxDocumentViewer>
                                                                                </dx:PanelContent>
                                                                            </PanelCollection>
                                                                        </dx:ASPxPanel>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>&nbsp;</td>
                                                                    <td>&nbsp;</td>
                                                                </tr>
                                                            </table>
                                                        </dx:ContentControl>
                                                    </ContentCollection>
                                                </dx:TabPage>
                                                <dx:TabPage Name="Reprogramacion" Text="Reprogramación de Sesión">
                                                    <ContentCollection>
                                                        <dx:ContentControl ID="ContentControl5" runat="server">
                                                            <div id="controles" style="width:100%">
                                                                <table style="width: 100%;">
                                                                    <tr>
                                                                        <td colspan="3"><strong>Posponer convocatoria actual</strong></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Fecha / Hora de Sesión:</td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtFechaOrg" runat="server" ReadOnly="True" TextMode="Date"></asp:TextBox>
                                                                            &nbsp;
                                                                            <asp:TextBox ID="txtHoraOrg" runat="server" ReadOnly="True" TextMode="Time"></asp:TextBox>
                                                                        </td>
                                                                        <td>
                                                                            <dx:ASPxButton ID="ASPxButtonPosponer" runat="server" Text="Posponer Convocatoria" Width="150px" OnClick="ASPxButtonPosponer_Click">
                                                                            </dx:ASPxButton>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Tipo de Sesión:</td>
                                                                        <td>
                                                                            <asp:Label ID="lblTipoSesion" runat="server"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <dx:ASPxButton ID="ASPxButtonRNotificar" runat="server" Text="Convocar" Width="150px" OnClick="ASPxButtonRNotificar_Click">
                                                                            </dx:ASPxButton>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Fecha / hora reprogramada</td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtFechaRep" runat="server" TextMode="Date"></asp:TextBox>
                                                                            &nbsp;
                                                                            <asp:TextBox ID="txtHoraRep" runat="server" TextMode="Time"></asp:TextBox>
                                                                        </td>
                                                                        <td>&nbsp;</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>Motivo - razón:</td>
                                                                        <td>
                                                                            <dx:ASPxMemo ID="ASPxMemoRJust" runat="server" Rows="2" Width="100%">
                                                                            </dx:ASPxMemo>
                                                                        </td>
                                                                        <td>&nbsp;</td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                            <div id="grid" style="width:100%">
                                                                <asp:SqlDataSource ID="SqlDataReprogramaciones" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="SELECT  ROW_NUMBER() OVER(ORDER BY a.CD_DETA_CONV_REPRO) AS CORRELATIVO, b.DS_REFERENCIA, a.FE_FECH_PROP, a.HO_HORA_PROP, a.DS_MOTIVO_REPRO 
FROM dbo.AGD_DETA_CONVOCATORIA_REPROG a
INNER JOIN dbo.AGD_ENCA_CONVOCATORIA b ON b.CD_ENCA_CONVOCATORIA = a.CD_ENCA_CONVOCATORIA
WHERE a.CD_ENCA_CONVOCATORIA = @CD_CONVOCATORIA">
                                                                    <SelectParameters>
                                                                        <asp:ControlParameter ControlID="lblConvocatoria" Name="CD_CONVOCATORIA" PropertyName="Text" />
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>
                                                                <dx:ASPxGridView ID="ASPxGridReprogramaciones" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataReprogramaciones" Width="100%">
                                                                    <Columns>
                                                                        <dx:GridViewDataTextColumn Caption="N° Reprogramación" FieldName="CORRELATIVO" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="0">
                                                                        </dx:GridViewDataTextColumn>
                                                                        <dx:GridViewDataTextColumn Caption="Convocatoria" FieldName="DS_REFERENCIA" ShowInCustomizationForm="True" VisibleIndex="1">
                                                                        </dx:GridViewDataTextColumn>
                                                                        <dx:GridViewDataDateColumn Caption="Fecha de reprogramación" FieldName="FE_FECH_PROP" ShowInCustomizationForm="True" VisibleIndex="2">
                                                                            <PropertiesDateEdit DisplayFormatString="D">
                                                                            </PropertiesDateEdit>
                                                                        </dx:GridViewDataDateColumn>
                                                                        <dx:GridViewDataTextColumn Caption="Motivo - Razón" FieldName="DS_MOTIVO_REPRO" ShowInCustomizationForm="True" VisibleIndex="3">
                                                                        </dx:GridViewDataTextColumn>
                                                                    </Columns>
                                                                    <SettingsPager PageSize="3">
                                                                    </SettingsPager>
                                                                    <SettingsDataSecurity AllowEdit="False" AllowInsert="False" />
                                                                </dx:ASPxGridView>
                                                            </div>
                                                        </dx:ContentControl>
                                                    </ContentCollection>
                                                </dx:TabPage>
                                                <dx:TabPage Name="Solicitudes" Text="Puntos de Acta adicionales">
                                                    <ContentCollection>
                                                        <dx:ContentControl ID="ContentControl6" runat="server">
                                                            <div id="form_reg" style="border-style: solid; border-width: 1px; width:99%;">
                                                                <asp:SqlDataSource ID="SqlDataTipoC" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="SELECT * FROM [GLB_TIPO_CORRESP] ORDER BY [DS_TIPO_CORRES]"></asp:SqlDataSource>
                                                                <asp:SqlDataSource ID="SqlDataOrigenPunto" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="SELECT [CD_ORIG_PUNTO], [DS_ORIG_PUNTO] FROM [GLB_ORIGEN_PUNTOS] ORDER BY [CD_ORIG_PUNTO]"></asp:SqlDataSource>
                                                                <table class="tabla">
                                                                    <tr>
                                                                        <td class="c1">
                                                                            <label>
                                                                            Fecha de Solicitud:</label> </td>
                                                                        <td class="c2">
                                                                            <asp:TextBox ID="TextBoxFecha_Solicitud" runat="server" TextMode="Date"></asp:TextBox>
                                                                        </td>
                                                                        <td class="c3">
                                                                            <label>
                                                                            Tipo de Correspondencia:</label></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="c1">
                                                                            <label>
                                                                            Origen de Solicitud:</label></td>
                                                                        <td class="c2">
                                                                            <dx:ASPxComboBox ID="ASPxComboBoxOrigen" runat="server" ValueType="System.Int32" DataSourceID="SqlDataOrigenPunto" TextField="DS_ORIG_PUNTO" ValueField="CD_ORIG_PUNTO" AutoPostBack="True" >
                                                                            </dx:ASPxComboBox>
                                                                        </td>
                                                                        <td rowspan="2" class="c3">
                                                                            <div id="radios">
                                                                                <dx:ASPxRadioButtonList ID="ASPxRadioButtonListTipo" runat="server" Style="text-align: right" DataSourceID="SqlDataTipoC" TextField="DS_TIPO_CORRES" ValueField="CD_TIPO_CORRES" ValueType="System.Int32" Width="100%">
                                                                                </dx:ASPxRadioButtonList>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="c1">
                                                                            <label>
                                                                            Solicitante:</label></td>
                                                                        <td class="c2">
                                                                            <asp:SqlDataSource ID="SqlDataSolicitantes" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="IF @CD_ORIG_PUNTO=1
BEGIN
SELECT a.CD_EMPLEADO as CODIGO, a.DS_NOMBRE_EMPLEADO + ' ' + a.DS_APELLIDO_EMPLEADO AS PERSONA, b.DS_UNIDAD AS ORIGEN FROM dbo.GLB_EMPLEADOS a 	INNER JOIN dbo.GLB_UNIDADES_TEG b ON b.CD_UNIDAD=a.CD_UNIDAD WHERE a.CD_ESTADO = 1 ORDER BY b.DS_UNIDAD, a.DS_NOMBRE_EMPLEADO, a.DS_APELLIDO_EMPLEADO
END
ELSE
BEGIN
SELECT a.CD_SOLICITANTE as CODIGO, a.DS_NOMBRE_SOLICITANTE + ' ' + a.DS_APELLIDO_SOLICITANTE AS PERSONA, b.DS_INSTITUCION AS ORIGEN FROM dbo.GLB_SOLICITANTES a 	INNER JOIN dbo.GLB_INSTITUCION b ON b.CD_INSTITUCION = a.CD_INSTITUCION ORDER BY b.DS_INSTITUCION, a.DS_NOMBRE_SOLICITANTE, a.DS_APELLIDO_SOLICITANTE
END">
                                                                                <SelectParameters>
                                                                                    <asp:ControlParameter ControlID="ASPxComboBoxOrigen" Name="CD_ORIG_PUNTO" PropertyName="Value" />
                                                                                </SelectParameters>
                                                                            </asp:SqlDataSource>
                                                                            <dx:ASPxComboBox ID="ASPxComboBoxSolicitantes" runat="server" DataSourceID="SqlDataSolicitantes" Width="95%" ValueField="CODIGO" ValueType="System.String">
                                                                                <Columns>
                                                                                    <dx:ListBoxColumn FieldName="CODIGO" Name="CODIGO" Visible="False" />
                                                                                    <dx:ListBoxColumn Caption="UNIDAD/INSTITUCION" FieldName="ORIGEN" Name="ORIGEN" />
                                                                                    <dx:ListBoxColumn Caption="SOLICITANTE" FieldName="PERSONA" Name="PERSONA" />
                                                                                </Columns>
                                                                            </dx:ASPxComboBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <label>
                                                                            Nombre de solicitud:</label></td>
                                                                        <td colspan="2">
                                                                            <asp:TextBox ID="txtPunto" runat="server" Width="90%" Rows="3" TextMode="MultiLine"></asp:TextBox>
                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtPunto" ErrorMessage="* Campo Obligatorio" Font-Size="XX-Small" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <label>
                                                                            Justificación:</label></td>
                                                                        <td colspan="2">
                                                                            <asp:TextBox ID="txtJust" runat="server" TextMode="MultiLine" Rows="4" Width="90%"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>&nbsp;</td>
                                                                        <td colspan="2">
                                                                            <dx:ASPxButton ID="ASPxButtonAgregar" runat="server" Text="Agregar" OnClick="ASPxButtonAgregar_Click">
                                                                            </dx:ASPxButton>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                                <br />
                                                            </div>
                                                        </dx:ContentControl>
                                                    </ContentCollection>
                                                </dx:TabPage>
                                            </TabPages>
                                        </dx:ASPxPageControl>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
        </TabPages>
    </dx:ASPxPageControl>
    <table style="width: 100%">
        <tr>
            <td style="text-align: right">
                <asp:TextBox ID="txtConv" runat="server" TextMode="Number" Visible="False" ReadOnly="True"></asp:TextBox>
                <asp:Label ID="lblConvocatoria" runat="server" Visible="False"></asp:Label>
                <asp:Label ID="lblAccion" runat="server" Visible="False"></asp:Label>
                                    &nbsp;&nbsp;
                                </td>
        </tr>
    </table>
</asp:Content>
