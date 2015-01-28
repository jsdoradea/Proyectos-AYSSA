<%@ Page Title="" Language="C#" MasterPageFile="~/portal/Main.master" AutoEventWireup="true" CodeBehind="desarrollo.aspx.cs" Inherits="SICSA.modulos.desarrollo" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.XtraReports.v14.2.Web, Version=14.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraReports.Web" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxRichEdit.v14.2, Version=14.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxRichEdit" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxHtmlEditor.v14.2, Version=14.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxHtmlEditor" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxSpellChecker.v14.2, Version=14.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxSpellChecker" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Header1" runat="server">
    <script type="text/javascript">
        function OnRowClick(e) {
            //Unselect all rows
            ASPxGridDatosConvocatoria._selectAllRowsOnPage(false);
            //Select the row
            ASPxGridDatosConvocatoria.SelectRow(e.visibleIndex, true);
        }
        function OnRowClick2(e) {
            //Unselect all rows
            ASPxGridPuntos._selectAllRowsOnPage(false);
            //Select the row
            ASPxGridPuntos.SelectRow(e.visibleIndex, true);
            //alert('hola');
        }
        function OnRowClick3(e) {
            //Unselect all rows
            ASPxGridViewPuntosTratados._selectAllRowsOnPage(false);
            //Select the row
            ASPxGridViewPuntosTratados.SelectRow(e.visibleIndex, true);
            //alert('hola');
        }

        function OnRowClick4(e) {
            //Unselect all rows
            ASPxGridAcuerdos._selectAllRowsOnPage(false);
            //Select the row
            ASPxGridAcuerdos.SelectRow(e.visibleIndex, true);
            //alert('hola');
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="titulo">
        <h2>Desarrollo de Sesión de Pleno</h2>
    </div>
    <asp:SqlDataSource ID="SqlDataPeriodo" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="SELECT [CD_CIERRE], [DS_PERIODO], [CD_EJERICIO] FROM [GLB_CIERRE_PERIODO] ORDER  BY [CD_EJERICIO] DESC, CD_PERIODO DESC"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataOrigenPunto" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="SELECT [CD_ORIG_PUNTO], [DS_ORIG_PUNTO] FROM [GLB_ORIGEN_PUNTOS] ORDER BY [CD_ORIG_PUNTO]"></asp:SqlDataSource>
    <dx:ASPxPageControl ID="ASPxPageDesarrollo" runat="server" ActiveTabIndex="1" Width="100%">
        <TabPages>
            <dx:TabPage Text="Datos">
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
                                <td style="text-align: right;">&nbsp;</td>
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
            <dx:TabPage Text="Detalles">
                <ContentCollection>
                    <dx:ContentControl runat="server">
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
                                <td colspan="2" style="max-width: 800px;">
                                    <dx:ASPxPageControl ID="ASPxPagePuntosDesarrollo" runat="server" ActiveTabIndex="2" Width="100%">
                                        <TabPages>
                                            <dx:TabPage Text="Quorum">
                                                <ContentCollection>
                                                    <dx:ContentControl runat="server">
                                                        <table style="width: 100%;">
                                                            <tr>
                                                                <td>Miembros del Pleno<asp:SqlDataSource ID="SqlDataNoConvocados" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="SELECT DISTINCT a.CD_MIEMBRO_PLENO, c.DS_NOMBRE_EMPLEADO + ' ' + c.DS_APELLIDO_EMPLEADO AS MIEMBRO, d.DS_TIPO_MIEMBRO, a.JERARQUIA
FROM dbo.GLB_MIEMBROS_PLENO a (nolock)
INNER JOIN dbo.AGD_DETA_CONVOCATORIA_MIEMBROS_CONVOCADOS b ON b.CD_MIEMBRO_PLENO=a.CD_MIEMBRO_PLENO
Left outer join
      (SELECT CD_MIEMBRO_PLENO FROM dbo.AGD_DETA_CONVOCATORIA_MIEMBROS_CONVOCADOS b (nolock) WHERE CD_ENCA_CONVOCATORIA=@CD_CONVOCATORIA Group by CD_MIEMBRO_PLENO) X ON a.CD_MIEMBRO_PLENO=X.CD_MIEMBRO_PLENO
INNER JOIN dbo.GLB_EMPLEADOS c ON c.CD_EMPLEADO = a.CD_EMPLEADO
INNER JOIN dbo.GLB_TIPO_MIEMBRO d ON d.CD_TIPO_MIEMBRO = a.CD_TIPO
WHERE X.CD_MIEMBRO_PLENO is null
ORDER BY a.JERARQUIA">
                                                                    <SelectParameters>
                                                                        <asp:ControlParameter ControlID="lblConvocatoria" DefaultValue="0" Name="CD_CONVOCATORIA" PropertyName="Text" />
                                                                    </SelectParameters>
                                                                    </asp:SqlDataSource>
                                                                </td>
                                                                <td>&nbsp;</td>
                                                                <td>Miembros de Pleno convocados<asp:SqlDataSource ID="SqlDataConvocados" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="SELECT a.CD_MIEMBRO_PLENO, c.DS_NOMBRE_EMPLEADO + ' ' + c.DS_APELLIDO_EMPLEADO AS MIEMBRO, d.DS_TIPO_MIEMBRO
FROM dbo.GLB_MIEMBROS_PLENO a
	INNER JOIN dbo.AGD_DETA_CONVOCATORIA_MIEMBROS_CONVOCADOS b ON b.CD_MIEMBRO_PLENO = a.CD_MIEMBRO_PLENO
	INNER JOIN dbo.GLB_EMPLEADOS c on c.CD_EMPLEADO = a.CD_EMPLEADO
	INNER JOIN dbo.GLB_TIPO_MIEMBRO d ON d.CD_TIPO_MIEMBRO = a.CD_TIPO
WHERE b.CD_ENCA_CONVOCATORIA = @CD_CONVOCATORIA
ORDER BY a.JERARQUIA">
                                                                    <SelectParameters>
                                                                        <asp:ControlParameter ControlID="lblConvocatoria" DefaultValue="0" Name="CD_CONVOCATORIA" PropertyName="Text" />
                                                                    </SelectParameters>
                                                                    </asp:SqlDataSource>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="vertical-align: top; width: 40%;">
                                                                    <dx:ASPxGridView ID="ASPxGridNoConvocados" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataNoConvocados" KeyFieldName="CD_MIEMBRO_PLENO" Width="100%">
                                                                        <Columns>
                                                                            <dx:GridViewCommandColumn SelectAllCheckboxMode="AllPages" ShowInCustomizationForm="True" ShowSelectCheckbox="True" VisibleIndex="0">
                                                                            </dx:GridViewCommandColumn>
                                                                            <dx:GridViewDataTextColumn FieldName="CD_MIEMBRO_PLENO" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="1">
                                                                                <EditFormSettings Visible="False" />
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn Caption="Miembro" FieldName="MIEMBRO" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="2">
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn Caption="Tipo" FieldName="DS_TIPO_MIEMBRO" ShowInCustomizationForm="True" VisibleIndex="3">
                                                                            </dx:GridViewDataTextColumn>
                                                                        </Columns>
                                                                        <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                                                                    </dx:ASPxGridView>
                                                                </td>
                                                                <td style="text-align: center; width: 20%;">
                                                                    <dx:ASPxButton ID="ASPxButtonAgregar" runat="server" Text="&gt;" OnClick="ASPxButtonAgregar_Click">
                                                                    </dx:ASPxButton>
                                                                    <br />
                                                                    <br />
                                                                    <dx:ASPxButton ID="ASPxButtonQuitar" runat="server" Text="&lt;" OnClick="ASPxButtonQuitar_Click">
                                                                    </dx:ASPxButton>
                                                                </td>
                                                                <td style="vertical-align: top; width: 40%;">
                                                                    <dx:ASPxGridView ID="ASPxGridConvocados" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataConvocados" KeyFieldName="CD_MIEMBRO_PLENO" Width="100%">
                                                                        <Columns>
                                                                            <dx:GridViewCommandColumn SelectAllCheckboxMode="Page" ShowInCustomizationForm="True" ShowSelectCheckbox="True" VisibleIndex="0">
                                                                            </dx:GridViewCommandColumn>
                                                                            <dx:GridViewDataTextColumn FieldName="CD_MIEMBRO_PLENO" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="1">
                                                                                <EditFormSettings Visible="False" />
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn Caption="Miembro" FieldName="MIEMBRO" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="2">
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn Caption="Tipo" FieldName="DS_TIPO_MIEMBRO" ShowInCustomizationForm="True" VisibleIndex="3">
                                                                            </dx:GridViewDataTextColumn>
                                                                        </Columns>
                                                                        <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                                                                    </dx:ASPxGridView>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </dx:ContentControl>
                                                </ContentCollection>
                                            </dx:TabPage>
                                            <dx:TabPage Text="Agenda definitiva">
                                                <ContentCollection>
                                                    <dx:ContentControl runat="server">
                                                        <table style="width: 100%;">
                                                            <tr>
                                                                <td style="vertical-align: top; width: 40%">
                                                                    <asp:SqlDataSource ID="SqlDataPuntosAgenda" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="SELECT a.CD_CONVOCATORIA, a.CD_PUNTO_AGENDA, a.ORDEN, b.DS_PUNTO_AGENDA, c.DS_TIPO_INCLUSION
FROM dbo.CONV_PUNTOS_AGENDA  a
	INNER JOIN dbo.AGD_PUNTOS_AGENDA b ON b.CD_PUNTO_AGENDA = a.CD_PUNTO_AGENDA
	INNER JOIN dbo.CONV_TIPO_PUNTO_INCLUSION c ON c.CD_TIPO_PUNTO_CONV = a.CD_TIPO_PUNTO
WHERE a.CD_ENCA_CONVOCATORIA=@CD_CONVOCATORIA
ORDER BY a.ORDEN">
                                                                        <SelectParameters>
                                                                            <asp:ControlParameter ControlID="lblConvocatoria" Name="CD_CONVOCATORIA" PropertyName="Text" />
                                                                        </SelectParameters>
                                                                    </asp:SqlDataSource>
                                                                    <dx:ASPxPanel ID="ASPxPanel1" runat="server" Height="200px" Width="100%" ScrollBars="Vertical">
                                                                        <PanelCollection>
                                                                            <dx:PanelContent ID="PanelContent1" runat="server">
                                                                                <dx:ASPxGridView ID="ASPxGridPuntos" runat="server" ClientInstanceName="ASPxGridPuntos" AutoGenerateColumns="False" DataSourceID="SqlDataPuntosAgenda" Width="100%" KeyFieldName="CD_CONVOCATORIA">
                                                                                    <ClientSideEvents RowClick="function(s, e) { OnRowClick2(e); }">
                                                                                    </ClientSideEvents>
                                                                                    <Columns>
                                                                                        <dx:GridViewCommandColumn SelectAllCheckboxMode="Page" ShowInCustomizationForm="True" ShowSelectCheckbox="True" VisibleIndex="0">
                                                                                        </dx:GridViewCommandColumn>
                                                                                        <dx:GridViewDataTextColumn FieldName="CD_CONVOCATORIA" ShowInCustomizationForm="True" VisibleIndex="1" ReadOnly="True" Visible="False">
                                                                                            <EditFormSettings Visible="False" />
                                                                                        </dx:GridViewDataTextColumn>
                                                                                        <dx:GridViewDataCheckColumn Name="Select" ShowInCustomizationForm="False" VisibleIndex="2" Caption=" ">
                                                                                            <PropertiesCheckEdit DisplayFormatString="{0}" ValueChecked="1" ValueType="System.Int32" ValueUnchecked="0">
                                                                                            </PropertiesCheckEdit>
                                                                                            <DataItemTemplate>
                                                                                                <dx:ASPxButton ID="btnSeleccionarPuntos" runat="server" CommandArgument='<%# Eval("CD_CONVOCATORIA") %>' OnClick="btnSeleccionarPuntos_Click" Text="Ver" />
                                                                                            </DataItemTemplate>
                                                                                        </dx:GridViewDataCheckColumn>
                                                                                        <dx:GridViewDataTextColumn Caption="Orden" FieldName="ORDEN" ShowInCustomizationForm="True" VisibleIndex="3">
                                                                                        </dx:GridViewDataTextColumn>
                                                                                        <dx:GridViewDataTextColumn Caption="Punto sugerido de acta" FieldName="DS_PUNTO_AGENDA" ShowInCustomizationForm="True" VisibleIndex="4">
                                                                                        </dx:GridViewDataTextColumn>
                                                                                        <dx:GridViewDataTextColumn Caption="Tipo" FieldName="DS_TIPO_INCLUSION" ShowInCustomizationForm="True" VisibleIndex="5">
                                                                                        </dx:GridViewDataTextColumn>
                                                                                        <dx:GridViewDataTextColumn FieldName="CD_PUNTO_AGENDA" ShowInCustomizationForm="True" Visible="False" VisibleIndex="6">
                                                                                        </dx:GridViewDataTextColumn>
                                                                                    </Columns>
                                                                                    <SettingsBehavior AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" />
                                                                                    <SettingsPager PageSize="4">
                                                                                    </SettingsPager>
                                                                                    <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                                                                                </dx:ASPxGridView>
                                                                            </dx:PanelContent>
                                                                        </PanelCollection>
                                                                    </dx:ASPxPanel>
                                                                </td>
                                                                <td style="text-align: right; vertical-align: top;">
                                                                    <asp:ImageButton ID="imgSubir" runat="server" ImageUrl="~/Content/Images/flecha_arriba.png" ToolTip="Subir Nivel" Width="32px" OnClick="imgSubir_Click" />
                                                                    <br />
                                                                    <asp:ImageButton ID="imgBajar" runat="server" ImageUrl="~/Content/Images/abajo_t.png" ToolTip="Bajar Nivel" Width="32px" OnClick="imgBajar_Click" />
                                                                    <br />
                                                                    <asp:ImageButton ID="imgQuitar" runat="server" ImageUrl="~/Content/Images/quitar2.png" ToolTip="Quitar punto" Width="32px" OnClick="imgQuitar_Click" />
                                                                </td>
                                                                <td style="width: 20%; vertical-align: top; text-align: center;">
                                                                    <dx:ASPxButton ID="ASPxButtonAgendaDef" runat="server" Text="Establecer Agenda definitiva" OnClick="ASPxButtonAgendaDef_Click" Height="40px" Width="120px" Wrap="True">
                                                                    </dx:ASPxButton>
                                                                    <br />
                                                                    <br />
                                                                    <dx:ASPxButton ID="ASPxButtonAdicion" runat="server" Text="Adición de Punto de Agenda" OnClick="ASPxButtonAdicion_Click" Width="120px" Wrap="True">
                                                                    </dx:ASPxButton>
                                                                </td>
                                                                <td rowspan="3" style="width: 40%; vertical-align: top">
                                                                    <dx:ASPxPanel ID="ASPxPanel2" runat="server" Height="320px" ScrollBars="Both" Width="100%">
                                                                        <PanelCollection>
                                                                            <dx:PanelContent runat="server">
                                                                                <dx:ASPxDocumentViewer ID="ASPxDocumentViewerAgenda" runat="server" ReportTypeName="SICSA.reportes.XtraReportAgenda" Width="100%">
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
                                                                <td colspan="3">
                                                                    <div id="formulario" style="width: 100%">
                                                                        <table style="width: 100%;">
                                                                            <tr>
                                                                                <td colspan="2">
                                                                                    <table style="width:100%;">
                                                                                        <tr>
                                                                                            <td>Referencia :</td>
                                                                                            <td>
                                                                                                <dx:ASPxTextBox ID="ASPxTextBoxRef" runat="server" Width="170px" Enabled="False">
                                                                                                </dx:ASPxTextBox>
                                                                                            </td>
                                                                                            <td style="text-align: right;">Fec. Doc.:</td>
                                                                                            <td style="text-align: right;">
                                                                                                <asp:TextBox ID="TextBoxFDoc" runat="server" TextMode="Date" Enabled="False"></asp:TextBox>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>Origen:</td>
                                                                                <td colspan="1">
                                                                                    <dx:ASPxComboBox ID="ASPxComboBoxOrigen" runat="server" AutoPostBack="True" DataSourceID="SqlDataOrigenPunto" TextField="DS_ORIG_PUNTO" ValueField="CD_ORIG_PUNTO" ValueType="System.Int32" Enabled="False">
                                                                                    </dx:ASPxComboBox>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>Solicitante:</td>
                                                                                <td>
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
                                                                                    <dx:ASPxComboBox ID="ASPxComboBoxSolicitantes" runat="server" DataSourceID="SqlDataSolicitantes" ValueField="CODIGO" Width="95%" Enabled="False" ValueType="System.Int32">
                                                                                        <Columns>
                                                                                            <dx:ListBoxColumn FieldName="CODIGO" Name="CODIGO" Visible="False" />
                                                                                            <dx:ListBoxColumn Caption="UNIDAD/INSTITUCION" FieldName="ORIGEN" Name="ORIGEN" />
                                                                                            <dx:ListBoxColumn Caption="SOLICITANTE" FieldName="PERSONA" Name="PERSONA" />
                                                                                        </Columns>
                                                                                    </dx:ASPxComboBox>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>Nombre de solicitud:</td>
                                                                                <td>
                                                                                    <asp:TextBox ID="TextBoxNombre" runat="server" Width="95%" Enabled="False"></asp:TextBox>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>Justificación:</td>
                                                                                <td>
                                                                                    <asp:TextBox ID="TextBoxJust" runat="server" Width="95%" Enabled="False"></asp:TextBox>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>Tipo:</td>
                                                                                <td>
                                                                                    <dx:ASPxRadioButtonList ID="ASPxRadioButtonList1" runat="server" Enabled="False" RepeatDirection="Horizontal" SelectedIndex="0" ValueType="System.Int32">
                                                                                        <Items>
                                                                                            <dx:ListEditItem Selected="True" Text="Punto de Agenda" Value="1" />
                                                                                            <dx:ListEditItem Text="Varios" Value="2" />
                                                                                        </Items>
                                                                                    </dx:ASPxRadioButtonList>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="3" style="text-align: right">&nbsp;<asp:Label ID="lblCdPunto" runat="server" Visible="False"></asp:Label>
&nbsp;<asp:Label ID="lblCDPt" runat="server" Visible="False"></asp:Label>
                                                                    <asp:Label ID="lblAccionAgenda" runat="server" Visible="False"></asp:Label>
                                                                    <dx:ASPxButton ID="ASPxButtonGuardar" runat="server" Text="Guardar" Enabled="False" OnClick="ASPxButtonGuardar_Click">
                                                                    </dx:ASPxButton>
                                                                    &nbsp;<dx:ASPxButton ID="ASPxButtonCancelar" runat="server" Text="Cancelar" Enabled="False" OnClick="ASPxButtonCancelar_Click">
                                                                    </dx:ASPxButton>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </dx:ContentControl>
                                                </ContentCollection>
                                            </dx:TabPage>
                                            <dx:TabPage Text="Minuta de sesión">
                                                <ContentCollection>
                                                    <dx:ContentControl runat="server">
                                                        <table style="width: 100%;">
                                                            <tr>
                                                                <td>
                                                                    <dx:ASPxPanel ID="ASPxPanelGrid" runat="server" Width="100%">
                                                                        <PanelCollection>
                                                                            <dx:PanelContent runat="server">
                                                                                <asp:SqlDataSource ID="SqlDataMinuta" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="SELECT a.CD_CONVOCATORIA, b.DS_PUNTO_AGENDA, a.ORDEN 
FROM dbo.CONV_PUNTOS_AGENDA a
	INNER JOIN dbo.AGD_PUNTOS_AGENDA b ON b.CD_PUNTO_AGENDA = a.CD_PUNTO_AGENDA
WHERE a.CD_ENCA_CONVOCATORIA=@CD_CONV
ORDER BY a.ORDEN">
                                                                                    <SelectParameters>
                                                                                        <asp:ControlParameter ControlID="lblConvocatoria" Name="CD_CONV" PropertyName="Text" />
                                                                                    </SelectParameters>
                                                                                </asp:SqlDataSource>
                                                                                <dx:ASPxGridView ID="ASPxGridViewPuntosTratados" ClientInstanceName="ASPxGridViewPuntosTratados" runat="server" Width="100%" AutoGenerateColumns="False" DataSourceID="SqlDataMinuta" KeyFieldName="CD_CONVOCATORIA">
                                                                                    <Columns>
                                                                                        <dx:GridViewDataTextColumn FieldName="CD_CONVOCATORIA" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="0">
                                                                                            <EditFormSettings Visible="False" />
                                                                                        </dx:GridViewDataTextColumn>
                                                                                        <dx:GridViewDataCheckColumn Name="Select" ShowInCustomizationForm="False" VisibleIndex="1" Caption=" " Width="75px">
                                                                                            <PropertiesCheckEdit DisplayFormatString="{0}" ValueChecked="1" ValueType="System.Int32" ValueUnchecked="0">
                                                                                            </PropertiesCheckEdit>
                                                                                            <DataItemTemplate>
                                                                                                <dx:ASPxButton ID="btnSeleccionarPT" runat="server" CommandArgument='<%# Eval("CD_CONVOCATORIA") %>' OnClick="btnSeleccionarPT_Click" Text="Mostrar" />
                                                                                            </DataItemTemplate>
                                                                                        </dx:GridViewDataCheckColumn>
                                                                                        <dx:GridViewDataTextColumn Caption="Puntos tratados en Sesión" FieldName="DS_PUNTO_AGENDA" ShowInCustomizationForm="True" VisibleIndex="3">
                                                                                        </dx:GridViewDataTextColumn>
                                                                                        <dx:GridViewDataTextColumn Caption="Orden" FieldName="ORDEN" ShowInCustomizationForm="True" VisibleIndex="2" Width="75px">
                                                                                            <CellStyle HorizontalAlign="Center">
                                                                                            </CellStyle>
                                                                                        </dx:GridViewDataTextColumn>
                                                                                    </Columns>
                                                                                    <ClientSideEvents RowClick="function(s, e) { OnRowClick3(e); }">
                                                                                    </ClientSideEvents>
                                                                                    <SettingsBehavior AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" />
                                                                                    <SettingsPager PageSize="8">
                                                                                    </SettingsPager>
                                                                                    <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                                                                                </dx:ASPxGridView>
                                                                            </dx:PanelContent>
                                                                        </PanelCollection>
                                                                    </dx:ASPxPanel>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <dx:ASPxPanel ID="ASPxPanelTabs" runat="server" Width="100%" Visible="false">
                                                                        <PanelCollection>
                                                                            <dx:PanelContent runat="server">
                                                                                <table style="width: 100%;">
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dx:ASPxLabel ID="ASPxLabelPunto" runat="server" Font-Bold="True">
                                                                                            </dx:ASPxLabel>
                                                                                        </td>
                                                                                        <td>
                                                                                            <dx:ASPxLabel ID="ASPxLabelNombre" runat="server" Font-Bold="True">
                                                                                            </dx:ASPxLabel>
                                                                                        </td>
                                                                                        <td>
                                                                                            <dx:ASPxLabel ID="ASPxLabelSolicitante" runat="server" Font-Bold="True">
                                                                                            </dx:ASPxLabel>
                                                                                            <br />
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td colspan="3" style="max-width: 950px;">
                                                                                            <dx:ASPxPageControl ID="ASPxPageControl1" runat="server" ActiveTabIndex="2" Width="100%">
                                                                                                <TabPages>
                                                                                                    <dx:TabPage Text="Aspectos Relevantes">
                                                                                                        <ContentCollection>
                                                                                                            <dx:ContentControl runat="server">
                                                                                                                <div id="editor" style="max-width: 1000px;">
                                                                                                                    <dx:ASPxButton ID="ASPxButtonGuardarAspecto" runat="server" Text="Guardar" OnClick="ASPxButtonGuardarAspecto_Click">
                                                                                                                    </dx:ASPxButton>
                                                                                                                    <dx:ASPxHtmlEditor ID="ASPxHtmlEditor1" runat="server" Height="285px" Width="100%">
                                                                                                                        <Settings AllowHtmlView="False" AllowPreview="False" />
                                                                                                                        <SettingsImageUpload UploadFolder="~/Content/editor/" UploadImageFolder="~/Content/editor/">
                                                                                                                        </SettingsImageUpload>
                                                                                                                        <SettingsFlashUpload UploadFolder="~/Content/editor/">
                                                                                                                        </SettingsFlashUpload>
                                                                                                                        <SettingsAudioUpload UploadFolder="~/Content/editor/">
                                                                                                                        </SettingsAudioUpload>
                                                                                                                    </dx:ASPxHtmlEditor>
                                                                                                                </div>
                                                                                                            </dx:ContentControl>
                                                                                                        </ContentCollection>
                                                                                                    </dx:TabPage>
                                                                                                    <dx:TabPage Text="Documentación">
                                                                                                        <ContentCollection>
                                                                                                            <dx:ContentControl runat="server">
                                                                                                                <table style="width: 100%;">
                                                                                                                    <tr>
                                                                                                                        <td style="width: 50%; vertical-align: top;">
                                                                                                                            <asp:SqlDataSource ID="SqlDataDocumentos" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="  select CD_DETA_SESION_DOCS, ROW_NUMBER() OVER (ORDER BY CD_DETA_SESION_DOCS) AS Numero, DS_NOMBRE_ARCHIVO, DS_DESCRIPCION, DS_RUTA_ARCHIVO  from dbo.SEP_DETA_SESION_PLENO_DOCUMENTOS WHERE CD_DETA_CONV=@CD_PUNTO_CV order by FECH_CREA, DS_NOMBRE_ARCHIVO ">
                                                                                                                                <SelectParameters>
                                                                                                                                    <asp:ControlParameter ControlID="ASPxLabelCodPunto" Name="CD_PUNTO_CV" PropertyName="Text" />
                                                                                                                                </SelectParameters>
                                                                                                                            </asp:SqlDataSource>
                                                                                                                            <dx:ASPxGridView ID="ASPxGridViewDocumentos" runat="server" AutoGenerateColumns="False" Width="90%" DataSourceID="SqlDataDocumentos" KeyFieldName="CD_DETA_SESION_DOCS">
                                                                                                                                <Columns>
                                                                                                                                    <dx:GridViewDataTextColumn FieldName="CD_DETA_SESION_DOCS" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="0">
                                                                                                                                        <EditFormSettings Visible="False" />
                                                                                                                                    </dx:GridViewDataTextColumn>
                                                                                                                                    <dx:GridViewDataTextColumn Caption="N°" FieldName="Numero" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="1">
                                                                                                                                    </dx:GridViewDataTextColumn>
                                                                                                                                    <dx:GridViewDataTextColumn Caption="Nombre Documento" FieldName="DS_NOMBRE_ARCHIVO" ShowInCustomizationForm="True" VisibleIndex="2">
                                                                                                                                    </dx:GridViewDataTextColumn>
                                                                                                                                    <dx:GridViewDataTextColumn Caption="Descripción" FieldName="DS_DESCRIPCION" ShowInCustomizationForm="True" VisibleIndex="3">
                                                                                                                                    </dx:GridViewDataTextColumn>
                                                                                                                                    <dx:GridViewDataHyperLinkColumn Caption="Documento" FieldName="DS_RUTA_ARCHIVO" ShowInCustomizationForm="True" VisibleIndex="4">
                                                                                                                                        <PropertiesHyperLinkEdit Target="_blank" Text="Ver">
                                                                                                                                        </PropertiesHyperLinkEdit>
                                                                                                                                        <CellStyle HorizontalAlign="Center">
                                                                                                                                        </CellStyle>
                                                                                                                                    </dx:GridViewDataHyperLinkColumn>
                                                                                                                                </Columns>
                                                                                                                                <SettingsPager PageSize="7">
                                                                                                                                </SettingsPager>
                                                                                                                                <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                                                                                                                            </dx:ASPxGridView>
                                                                                                                        </td>
                                                                                                                        <td style="width: 50%; vertical-align: top;">
                                                                                                                            <table style="width: 100%">
                                                                                                                                <tr>
                                                                                                                                    <td colspan="2" style="text-align: center; font-weight: bold;">Subir Documentos</td>
                                                                                                                                </tr>
                                                                                                                                <tr>
                                                                                                                                    <td>Nombre:</td>
                                                                                                                                    <td>
                                                                                                                                        <dx:ASPxTextBox ID="ASPxTextBoxNombreDoc" runat="server" Width="90%">
                                                                                                                                        </dx:ASPxTextBox>
                                                                                                                                    </td>
                                                                                                                                </tr>
                                                                                                                                <tr>
                                                                                                                                    <td>Descripción:</td>
                                                                                                                                    <td>
                                                                                                                                        <dx:ASPxTextBox ID="ASPxTextBoxDescDoc" runat="server" Width="90%">
                                                                                                                                        </dx:ASPxTextBox>
                                                                                                                                    </td>
                                                                                                                                </tr>
                                                                                                                                <tr>
                                                                                                                                    <td>Seleccionar archivo:</td>
                                                                                                                                    <td>
                                                                                                                                        <asp:FileUpload ID="FileUpload1" runat="server" Width="100%" />
                                                                                                                                    </td>
                                                                                                                                </tr>
                                                                                                                                <tr>
                                                                                                                                    <td>
                                                                                                                                        <dx:ASPxButton ID="ASPxButtonSubirDoc" runat="server" OnClick="ASPxButtonSubirDoc_Click" Text="Guardar">
                                                                                                                                        </dx:ASPxButton>
                                                                                                                                    </td>
                                                                                                                                    <td>&nbsp;</td>
                                                                                                                                </tr>
                                                                                                                                <tr>
                                                                                                                                    <td colspan="2" style="text-align: center; color: #FF0000">
                                                                                                                                        <dx:ASPxLabel ID="ASPxLabelError" runat="server" Visible="False">
                                                                                                                                        </dx:ASPxLabel>
                                                                                                                                    </td>
                                                                                                                                </tr>
                                                                                                                            </table>
                                                                                                                        </td>
                                                                                                                    </tr>
                                                                                                                </table>
                                                                                                            </dx:ContentControl>
                                                                                                        </ContentCollection>
                                                                                                    </dx:TabPage>
                                                                                                    <dx:TabPage Text="Acuerdos">
                                                                                                        <ContentCollection>
                                                                                                            <dx:ContentControl runat="server">
                                                                                                                <table style="width: 100%; border-spacing: 1px; border-collapse: collapse;">
                                                                                                                    <tr>
                                                                                                                        <td style="vertical-align: top; padding: 1px 1px 1px 1px; width: 35%;">
                                                                                                                            <dx:ASPxPanel ID="ASPxPanel3" runat="server" Height="290px" Width="100%" Paddings-Padding="1px">
                                                                                                                                <Paddings Padding="1px">
                                                                                                                                </Paddings>
                                                                                                                                <PanelCollection>
                                                                                                                                    <dx:PanelContent runat="server">
                                                                                                                                        <dx:ASPxButton ID="ASPxButtonNuevoAcuerdo" runat="server" Text="Nuevo Acuerdo" OnClick="ASPxButtonNuevoAcuerdo_Click">
                                                                                                                                        </dx:ASPxButton>
                                                                                                                                        <dx:ASPxGridView ID="ASPxGridAcuerdos" ClientInstanceName="ASPxGridAcuerdos" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataAcuerdos" KeyFieldName="CD_ENCA_ACUERDOS" Width="98%">
                                                                                                                                            <Columns>
                                                                                                                                                <dx:GridViewCommandColumn ButtonType="Image" ShowClearFilterButton="True" ShowDeleteButton="True" ShowInCustomizationForm="True" VisibleIndex="4" Caption=" " Width="30px">
                                                                                                                                                </dx:GridViewCommandColumn>
                                                                                                                                                <dx:GridViewDataTextColumn FieldName="CD_ENCA_ACUERDOS" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="0">
                                                                                                                                                    <EditFormSettings Visible="False" />
                                                                                                                                                </dx:GridViewDataTextColumn>
                                                                                                                                                <dx:GridViewDataCheckColumn Name="Select" ShowInCustomizationForm="False" VisibleIndex="1" Caption=" " Width="30px">
                                                                                                                                                    <PropertiesCheckEdit DisplayFormatString="{0}" ValueChecked="1" ValueType="System.Int32" ValueUnchecked="0">
                                                                                                                                                    </PropertiesCheckEdit>
                                                                                                                                                    <DataItemTemplate>
                                                                                                                                                        <dx:ASPxButton ID="btnSeleccionarACU" runat="server" CommandArgument='<%# Eval("CD_ENCA_ACUERDOS") %>' OnClick="btnSeleccionarACU_Click" Text="" Image-Url="~/Content/Images/edit.png" ToolTip="Editar" />
                                                                                                                                                    </DataItemTemplate>
                                                                                                                                                </dx:GridViewDataCheckColumn>
                                                                                                                                                <dx:GridViewDataTextColumn Caption="N° Ac." FieldName="NM_CORR_ACUERDO" ShowInCustomizationForm="True" VisibleIndex="2" Width="40px">
                                                                                                                                                </dx:GridViewDataTextColumn>
                                                                                                                                                <dx:GridViewDataTextColumn Caption="Acuerdo" FieldName="DS_ACUERDO_COMP" ShowInCustomizationForm="True" VisibleIndex="3">
                                                                                                                                                </dx:GridViewDataTextColumn>
                                                                                                                                            </Columns>
                                                                                                                                            <ClientSideEvents RowClick="function(s, e) { OnRowClick4(e); }">
                                                                                                                                            </ClientSideEvents>
                                                                                                                                            <SettingsBehavior ConfirmDelete="True" />
                                                                                                                                            <SettingsPager PageSize="4">
                                                                                                                                            </SettingsPager>
                                                                                                                                            <Settings ShowFilterRow="True" />
                                                                                                                                            <SettingsCommandButton>
                                                                                                                                                <DeleteButton>
                                                                                                                                                    <Image Url="~/Content/Images/cancel.png">
                                                                                                                                                    </Image>
                                                                                                                                                </DeleteButton>
                                                                                                                                            </SettingsCommandButton>
                                                                                                                                            <SettingsDataSecurity AllowEdit="False" AllowInsert="False" />
                                                                                                                                        </dx:ASPxGridView>
                                                                                                                                        <asp:SqlDataSource ID="SqlDataAcuerdos" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" DeleteCommand="DELETE FROM dbo.ACU_ENCA_ACUERDOS WHERE CD_ENCA_ACUERDOS = @CD_ENCA_ACUERDOS" SelectCommand="select CD_ENCA_ACUERDOS, NM_CORR_ACUERDO , DS_ACUERDO_COMP from dbo.ACU_ENCA_ACUERDOS WHERE CD_DETA_CONV=@COD_CONV ORDER BY NM_CORR_ACUERDO  DESC">
                                                                                                                                            <DeleteParameters>
                                                                                                                                                <asp:Parameter Name="CD_ENCA_ACUERDOS" />
                                                                                                                                            </DeleteParameters>
                                                                                                                                            <SelectParameters>
                                                                                                                                                <asp:ControlParameter ControlID="ASPxLabelCodPunto" Name="COD_CONV" PropertyName="Text" />
                                                                                                                                            </SelectParameters>
                                                                                                                                        </asp:SqlDataSource>
                                                                                                                                    </dx:PanelContent>
                                                                                                                                </PanelCollection>
                                                                                                                                <Border BorderStyle="None" />
                                                                                                                            </dx:ASPxPanel>
                                                                                                                        </td>
                                                                                                                        <td style="width: 65%; vertical-align: top; padding: 1px 1px 1px 1px;">
                                                                                                                            <dx:ASPxPanel ID="ASPxPanel4" runat="server" Height="290px" Width="100%" Style="margin-bottom: 0px">
                                                                                                                                <PanelCollection>
                                                                                                                                    <dx:PanelContent ID="PanelContent2" runat="server">
                                                                                                                                        <table style="width: 100%;">
                                                                                                                                            <tr>
                                                                                                                                                <td style="width: 130px">Acuerdo:
                                                                                                                                                    <br />
                                                                                                                                                    (texto descriptivo)</td>
                                                                                                                                                <td style="min-width: 200px">
                                                                                                                                                    <dx:ASPxTextBox ID="ASPxTextNomAcuerdo" runat="server" Width="95%" Enabled="False">
                                                                                                                                                    </dx:ASPxTextBox>
                                                                                                                                                </td>
                                                                                                                                            </tr>
                                                                                                                                            <tr>
                                                                                                                                                <td>Acuerdo: (texto definitivo)</td>
                                                                                                                                                <td>
                                                                                                                                                    <dx:ASPxMemo ID="ASPxMemoAcuerdoLargo" runat="server" Rows="2" Width="95%" Enabled="False">
                                                                                                                                                    </dx:ASPxMemo>
                                                                                                                                                </td>
                                                                                                                                            </tr>
                                                                                                                                            <tr>
                                                                                                                                                <td>Tipo de Acuerdo:<asp:SqlDataSource ID="SqlDataTipoAcuerdo" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="  SELECT CD_TIPO_ACUERDO, DS_TIPO_ACUERDO FROM dbo.ACU_TIPO_ACUERDO WHERE CD_ESTADO_TIPO_ACU=1"></asp:SqlDataSource>
                                                                                                                                                </td>
                                                                                                                                                <td>
                                                                                                                                                    <dx:ASPxComboBox ID="ASPxComboTipoAcuerdo" runat="server" DataSourceID="SqlDataTipoAcuerdo" TextField="DS_TIPO_ACUERDO" ValueField="CD_TIPO_ACUERDO" ValueType="System.Int32" Width="95%" Enabled="False">
                                                                                                                                                    </dx:ASPxComboBox>
                                                                                                                                                </td>
                                                                                                                                            </tr>
                                                                                                                                            <tr>
                                                                                                                                                <td>Fecha:</td>
                                                                                                                                                <td>
                                                                                                                                                    <table style="width: 100%">
                                                                                                                                                        <tr>
                                                                                                                                                            <td>
                                                                                                                                                                <asp:TextBox ID="TextFechaAcuerdo" runat="server" TextMode="Date" Enabled="False"></asp:TextBox>
                                                                                                                                                            </td>
                                                                                                                                                            <td>Duración: (días)</td>
                                                                                                                                                            <td>
                                                                                                                                                                <asp:TextBox ID="TextDuracionAcuerdo" runat="server" TextMode="Number" Width="50px" Enabled="False"></asp:TextBox>
                                                                                                                                                            </td>
                                                                                                                                                        </tr>
                                                                                                                                                    </table>
                                                                                                                                                </td>
                                                                                                                                            </tr>
                                                                                                                                            <tr>
                                                                                                                                                <td>Encargado:
                                                                                                                                                    <asp:SqlDataSource ID="SqlDataEmpleados" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="  SELECT a.CD_EMPLEADO, a.DS_NOMBRE_EMPLEADO + ' ' + a.DS_APELLIDO_EMPLEADO as EMPLEADO, b.DS_UNIDAD
  from dbo.GLB_EMPLEADOS a
  INNER JOIN dbo.GLB_UNIDADES_TEG b ON b.CD_UNIDAD = a.CD_UNIDAD
  WHERE a.CD_ESTADO=1
ORDER BY b.DS_UNIDAD,  a.DS_NOMBRE_EMPLEADO, a.DS_APELLIDO_EMPLEADO"></asp:SqlDataSource>
                                                                                                                                                </td>
                                                                                                                                                <td>
                                                                                                                                                    <table style="width:100%">
                                                                                                                                                        <tr>
                                                                                                                                                            <td>
                                                                                                                                                                <dx:ASPxComboBox ID="ASPxComboEmpleados0" runat="server" DataSourceID="SqlDataEmpleados" Enabled="False" ValueField="CD_EMPLEADO" Width="95%">
                                                                                                                                                                    <Columns>
                                                                                                                                                                        <dx:ListBoxColumn Caption="CD_EMPLEADO" FieldName="CD_EMPLEADO" Name="CD_EMPLEADO" Visible="False" />
                                                                                                                                                                        <dx:ListBoxColumn Caption="Empleado" FieldName="EMPLEADO" />
                                                                                                                                                                        <dx:ListBoxColumn Caption="Unidad" FieldName="DS_UNIDAD" />
                                                                                                                                                                    </Columns>
                                                                                                                                                                </dx:ASPxComboBox>
                                                                                                                                                            </td>
                                                                                                                                                            <td style="text-align:right;width:100px;">
                                                                                                                                                                <dx:ASPxButton ID="ASPxButtonGuardarAcuerdo" runat="server" Text="Guardar" Enabled="False" OnClick="ASPxButtonGuardarAcuerdo_Click">
                                                                                                                                                                </dx:ASPxButton>
                                                                                                                                                                    &nbsp;&nbsp; 
                                                                                                                                                                </td>
                                                                                                                                                        </tr>
                                                                                                                                                    </table>
                                                                                                                                                </td>
                                                                                                                                            </tr>
                                                                                                                                            <tr>
                                                                                                                                                <td colspan="2">
                                                                                                                                                    <hr />
                                                                                                                                                </td>
                                                                                                                                            </tr>
                                                                                                                                            <tr>
                                                                                                                                                <td colspan="2">
                                                                                                                                                    <table style="width: 100%;">
                                                                                                                                                        <tr>
                                                                                                                                                            <td style="width: 60%">
                                                                                                                                                                <table style="width: 100%;">
                                                                                                                                                                    <tr>
                                                                                                                                                                        <td style="width: 100px">Notifíquese a:</td>
                                                                                                                                                                        <td>
                                                                                                                                                                            <table style="width:100%;">
                                                                                                                                                                                <tr>
                                                                                                                                                                                    <td>
                                                                                                                                                                                        <dx:ASPxComboBox ID="ASPxComboEmpleados" runat="server" DataSourceID="SqlDataEmpleados" Width="98%" Enabled="False" ValueField="CD_EMPLEADO">
                                                                                                                                                                                            <Columns>
                                                                                                                                                                                                <dx:ListBoxColumn Caption="CD_EMPLEADO" FieldName="CD_EMPLEADO" Name="CD_EMPLEADO" Visible="False" />
                                                                                                                                                                                                <dx:ListBoxColumn Caption="Empleado" FieldName="EMPLEADO" />
                                                                                                                                                                                                <dx:ListBoxColumn Caption="Unidad" FieldName="DS_UNIDAD" />
                                                                                                                                                                                            </Columns>
                                                                                                                                                                                        </dx:ASPxComboBox>
                                                                                                                                                                                    </td>
                                                                                                                                                                                </tr>
                                                                                                                                                                            </table>
                                                                                                                                                                        </td>
                                                                                                                                                                    </tr>
                                                                                                                                                                    <tr>
                                                                                                                                                                        <td>En calidad de:</td>
                                                                                                                                                                        <td>
                                                                                                                                                                            <table style="width: 100%">
                                                                                                                                                                                <tr>
                                                                                                                                                                                    <td>
                                                                                                                                                                                        <dx:ASPxRadioButtonList ID="ASPxRadioButtonList2" runat="server" RepeatDirection="Horizontal" ValueType="System.Int32" SelectedIndex="1" Enabled="False">
                                                                                                                                                                                            <Items>
                                                                                                                                                                                                <dx:ListEditItem Text="Interesado" Value="1" />
                                                                                                                                                                                                <dx:ListEditItem Text="Responsable" Value="2" Selected="True" />
                                                                                                                                                                                            </Items>
                                                                                                                                                                                        </dx:ASPxRadioButtonList>
                                                                                                                                                                                    </td>
                                                                                                                                                                                    <td>
                                                                                                                                                                                        <dx:ASPxButton ID="ASPxButtonNotificar" runat="server" Enabled="False" OnClick="ASPxButtonNotificar_Click" Text="Notificar">
                                                                                                                                                                                        </dx:ASPxButton>
                                                                                                                                                                                    </td>
                                                                                                                                                                                </tr>
                                                                                                                                                                            </table>
                                                                                                                                                                        </td>
                                                                                                                                                                    </tr>
                                                                                                                                                                </table>
                                                                                                                                                            </td>
                                                                                                                                                            <td style="width: 40%; vertical-align: top;" rowspan="3">
                                                                                                                                                                <asp:SqlDataSource ID="SqlDataNotificacionAcuerdo" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" DeleteCommand="  DELETE FROM dbo.ACU_NOTIFICACION_ACUERDO WHERE CD_ACU_NOTIFICACION=@CD_ACU_NOTIFICACION" SelectCommand="  SELECT a.CD_ACU_NOTIFICACION, b.DS_NOMBRE_EMPLEADO + ' ' + b.DS_APELLIDO_EMPLEADO AS EMPLEADO, c.DS_CALIDAD_ACU
  FROM dbo.ACU_NOTIFICACION_ACUERDO a
	INNER JOIN dbo.GLB_EMPLEADOS b ON b.CD_EMPLEADO = a.CD_EMPLEADO
	INNER JOIN dbo.ACU_NOTIFICACION_CALIDAD c ON c.CD_ACU_CALIDAD = a.CD_CALIDAD
  WHERE CD_ENCA_ACUERDO= @CD_ENCA_ACUERDO">
                                                                                                                                                                    <DeleteParameters>
                                                                                                                                                                        <asp:Parameter Name="CD_ACU_NOTIFICACION" />
                                                                                                                                                                    </DeleteParameters>
                                                                                                                                                                    <SelectParameters>
                                                                                                                                                                        <asp:ControlParameter ControlID="ASPxLabelCodAcuerdo" DefaultValue="0" Name="CD_ENCA_ACUERDO" PropertyName="Text" />
                                                                                                                                                                    </SelectParameters>
                                                                                                                                                                </asp:SqlDataSource>
                                                                                                                                                                <dx:ASPxGridView ID="ASPxGridNotificados" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataNotificacionAcuerdo" KeyFieldName="CD_ACU_NOTIFICACION" Width="100%">
                                                                                                                                                                    <Columns>
                                                                                                                                                                        <dx:GridViewCommandColumn ButtonType="Image" ShowDeleteButton="True" ShowInCustomizationForm="True" VisibleIndex="0" Caption=" ">
                                                                                                                                                                        </dx:GridViewCommandColumn>
                                                                                                                                                                        <dx:GridViewDataTextColumn FieldName="CD_ACU_NOTIFICACION" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="1">
                                                                                                                                                                            <EditFormSettings Visible="False" />
                                                                                                                                                                        </dx:GridViewDataTextColumn>
                                                                                                                                                                        <dx:GridViewDataTextColumn Caption="Notificado" FieldName="EMPLEADO" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="2">
                                                                                                                                                                        </dx:GridViewDataTextColumn>
                                                                                                                                                                        <dx:GridViewDataTextColumn Caption="Calidad" FieldName="DS_CALIDAD_ACU" ShowInCustomizationForm="True" VisibleIndex="3">
                                                                                                                                                                        </dx:GridViewDataTextColumn>
                                                                                                                                                                    </Columns>
                                                                                                                                                                    <SettingsBehavior ConfirmDelete="True" />
                                                                                                                                                                    <SettingsPager PageSize="3">
                                                                                                                                                                    </SettingsPager>
                                                                                                                                                                    <SettingsCommandButton>
                                                                                                                                                                        <DeleteButton>
                                                                                                                                                                            <Image Url="~/Content/Images/cancel.png">
                                                                                                                                                                            </Image>
                                                                                                                                                                        </DeleteButton>
                                                                                                                                                                    </SettingsCommandButton>
                                                                                                                                                                    <SettingsDataSecurity AllowEdit="False" AllowInsert="False" />
                                                                                                                                                                </dx:ASPxGridView>
                                                                                                                                                            </td>
                                                                                                                                                        </tr>
                                                                                                                                                        <tr>
                                                                                                                                                            <td>Votación:&nbsp;&nbsp; 
                                                                                                                                                                <dx:ASPxLabel ID="ASPxLabelResultadoVotacion" runat="server" Font-Bold="True">
                                                                                                                                                                </dx:ASPxLabel>
                                                                                                                                                                &nbsp;&nbsp; 
                                                                                                                                                                &nbsp;&nbsp; 
                                                                                                                                                                <dx:ASPxButton ID="ASPxButtonTerminarVotacion" runat="server" Text="Cierre" OnClick="ASPxButtonTerminarVotacion_Click" Enabled="False">
                                                                                                                                                                </dx:ASPxButton>
                                                                                                                                                            </td>
                                                                                                                                                        </tr>
                                                                                                                                                        <tr>
                                                                                                                                                            <td>
                                                                                                                                                                <asp:SqlDataSource ID="SqlDataMiembrosVotan" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="  SELECT a.CD_DETA_MIEMBROS_CONV, a.CD_MIEMBRO_PLENO, b.CD_TIPO, c.DS_NOMBRE_EMPLEADO + ' ' + c.DS_APELLIDO_EMPLEADO AS MIEMBRO, d.DS_TIPO_MIEMBRO
  FROM dbo.AGD_DETA_CONVOCATORIA_MIEMBROS_CONVOCADOS a
	INNER JOIN dbo.GLB_MIEMBROS_PLENO b ON b.CD_MIEMBRO_PLENO = a.CD_MIEMBRO_PLENO 
	INNER JOIN dbo.GLB_EMPLEADOS c ON c.CD_EMPLEADO = b.CD_EMPLEADO
	INNER JOIN dbo.GLB_TIPO_MIEMBRO d ON d.CD_TIPO_MIEMBRO = b.CD_TIPO
  WHERE CD_ENCA_CONVOCATORIA = @CD_ENCA_CONVOCATORIA">
                                                                                                                                                                    <SelectParameters>
                                                                                                                                                                        <asp:ControlParameter ControlID="lblConvocatoria" Name="CD_ENCA_CONVOCATORIA" PropertyName="Text" />
                                                                                                                                                                    </SelectParameters>
                                                                                                                                                                </asp:SqlDataSource>
                                                                                                                                                                <dx:ASPxCheckBoxList ID="ASPxCheckMiembrosVotan" runat="server" DataSourceID="SqlDataMiembrosVotan" RepeatDirection="Horizontal" TextField="MIEMBRO" ValueField="CD_DETA_MIEMBROS_CONV" ValueType="System.Int32" Width="100%" Enabled="False" Font-Size="XX-Small">
                                                                                                                                                                </dx:ASPxCheckBoxList>
                                                                                                                                                            </td>
                                                                                                                                                        </tr>
                                                                                                                                                    </table>
                                                                                                                                                </td>
                                                                                                                                            </tr>
                                                                                                                                        </table>
                                                                                                                                    </dx:PanelContent>
                                                                                                                                </PanelCollection>
                                                                                                                                <Border BorderStyle="Solid" BorderColor="#333399" BorderWidth="1px" />
                                                                                                                            </dx:ASPxPanel>
                                                                                                                        </td>
                                                                                                                    </tr>
                                                                                                                    <tr>
                                                                                                                        <td colspan="2">&nbsp;</td>
                                                                                                                    </tr>
                                                                                                                </table>
                                                                                                            </dx:ContentControl>
                                                                                                        </ContentCollection>
                                                                                                    </dx:TabPage>
                                                                                                </TabPages>
                                                                                            </dx:ASPxPageControl>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <dx:ASPxLabel ID="ASPxLabelCodPunto" runat="server" Visible="False">
                                                                                            </dx:ASPxLabel>
                                                                                            <dx:ASPxLabel ID="ASPxLabelCodAcuerdo" runat="server" Visible="False">
                                                                                            </dx:ASPxLabel>
                                                                                            <asp:Label ID="lblAccionAcuerdo" runat="server" Visible="False"></asp:Label>
                                                                                            <dx:ASPxLabel ID="ASPxLabelAccionVoto" runat="server" Visible="False">
                                                                                            </dx:ASPxLabel>
                                                                                        </td>
                                                                                        <td colspan="2" style="text-align: right">
                                                                                            <dx:ASPxButton ID="ASPxButtonCancelarPT" runat="server" Text="Cancelar" OnClick="ASPxButtonCancelarPT_Click">
                                                                                            </dx:ASPxButton>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </dx:PanelContent>
                                                                        </PanelCollection>
                                                                    </dx:ASPxPanel>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </dx:ContentControl>
                                                </ContentCollection>
                                            </dx:TabPage>
                                            <dx:TabPage Text="Cierre de Sesión">
                                                <ContentCollection>
                                                    <dx:ContentControl runat="server">
                                                        <table style="width: 100%;">
                                                            <tr>
                                                                <td style="width: 50%; vertical-align: top;">
                                                                    <dx:ASPxPanel ID="ASPxPanel5" runat="server" Height="285px" Width="100%">
                                                                        <PanelCollection>
                                                                            <dx:PanelContent runat="server">
                                                                                <table style="width: 100%;">
                                                                                    <tr>
                                                                                        <td>Acta: </td>
                                                                                        <td>
                                                                                            <dx:ASPxTextBox ID="ASPxTextNumActa" runat="server" Width="170px">
                                                                                            </dx:ASPxTextBox>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>&nbsp;</td>
                                                                                        <td>
                                                                                            <dx:ASPxButton ID="ASPxButtonRegCierre" runat="server" OnClick="ASPxButtonRegCierre_Click" Text="Registrar cierre de Sesión" Width="200px">
                                                                                            </dx:ASPxButton>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td>&nbsp;</td>
                                                                                        <td>&nbsp;</td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td colspan="2">
                                                                                            <asp:SqlDataSource ID="SqlDataRepAcuerdos" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="SELECT c.CD_ENCA_ACUERDOS, a.CD_CONVOCATORIA, a.ORDEN + 2 AS N_PUNTO_AGENDA, b.DS_PUNTO_AGENDA, c.NM_CORR_ACUERDO, c.DS_ACUERDO_COMP
FROM dbo.CONV_PUNTOS_AGENDA a 
	INNER JOIN dbo.AGD_PUNTOS_AGENDA b ON b.CD_PUNTO_AGENDA = a.CD_PUNTO_AGENDA
	INNER JOIN dbo.ACU_ENCA_ACUERDOS c ON c.CD_DETA_CONV = a.CD_CONVOCATORIA
WHERE a.CD_ENCA_CONVOCATORIA=@CD_ENCA_CONVOCATORIA
ORDER BY a.ORDEN DESC">
                                                                                                <SelectParameters>
                                                                                                    <asp:ControlParameter ControlID="lblConvocatoria" Name="CD_ENCA_CONVOCATORIA" PropertyName="Text" Type="Int32" />
                                                                                                </SelectParameters>
                                                                                            </asp:SqlDataSource>
                                                                                            <dx:ASPxGridView ID="ASPxGridViewRepAcuerdos" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataRepAcuerdos" KeyFieldName="CD_ENCA_ACUERDOS" Width="98%">
                                                                                                <Columns>
                                                                                                    <dx:GridViewCommandColumn SelectAllCheckboxMode="Page" ShowInCustomizationForm="True" ShowSelectCheckbox="True" VisibleIndex="0">
                                                                                                    </dx:GridViewCommandColumn>
                                                                                                    <dx:GridViewDataTextColumn FieldName="CD_CONVOCATORIA" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="2">
                                                                                                        <EditFormSettings Visible="False" />
                                                                                                    </dx:GridViewDataTextColumn>
                                                                                                    <dx:GridViewDataTextColumn Caption="N° Punto de Agenda" FieldName="N_PUNTO_AGENDA" GroupIndex="0" ReadOnly="True" ShowInCustomizationForm="True" SortIndex="0" SortOrder="Ascending" VisibleIndex="3">
                                                                                                    </dx:GridViewDataTextColumn>
                                                                                                    <dx:GridViewDataTextColumn Caption="Punto de Agenda" FieldName="DS_PUNTO_AGENDA" ShowInCustomizationForm="True" VisibleIndex="4">
                                                                                                    </dx:GridViewDataTextColumn>
                                                                                                    <dx:GridViewDataTextColumn Caption="N° Acuerdo" FieldName="NM_CORR_ACUERDO" ShowInCustomizationForm="True" VisibleIndex="5">
                                                                                                    </dx:GridViewDataTextColumn>
                                                                                                    <dx:GridViewDataTextColumn Caption="Acuerdo" FieldName="DS_ACUERDO_COMP" ShowInCustomizationForm="True" VisibleIndex="6">
                                                                                                    </dx:GridViewDataTextColumn>
                                                                                                    <dx:GridViewDataTextColumn Caption="CD_ENCA_ACUERDOS" FieldName="CD_ENCA_ACUERDOS" ShowInCustomizationForm="True" Visible="False" VisibleIndex="1">
                                                                                                    </dx:GridViewDataTextColumn>
                                                                                                </Columns>
                                                                                                <SettingsBehavior AllowSelectSingleRowOnly="True" />
                                                                                                <SettingsPager PageSize="4">
                                                                                                </SettingsPager>
                                                                                                <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                                                                                            </dx:ASPxGridView>
                                                                                            <br />
                                                                                            <dx:ASPxButton ID="ASPxButtonGenRep" runat="server" Text="Generar Documentación" OnClick="ASPxButtonGenRep_Click">
                                                                                            </dx:ASPxButton>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </dx:PanelContent>
                                                                        </PanelCollection>
                                                                    </dx:ASPxPanel>
                                                                </td>
                                                                <td style="width: 50%; vertical-align: top;">
                                                                    <dx:ASPxPanel ID="ASPxPanel6" runat="server" Height="285px" ScrollBars="Vertical" Width="100%">
                                                                        <PanelCollection>
                                                                            <dx:PanelContent runat="server">
                                                                                <dx:ASPxDocumentViewer ID="ASPxDocumentViewerCierre" runat="server" ReportTypeName="SICSA.reportes.XtraReportCierreSesion" Visible="False">
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
                                                        </table>
                                                    </dx:ContentControl>
                                                </ContentCollection>
                                            </dx:TabPage>
                                        </TabPages>
                                    </dx:ASPxPageControl>
                                    <asp:Label ID="lblConvocatoria" runat="server" Visible="False"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
        </TabPages>
    </dx:ASPxPageControl>
</asp:Content>
