<%@ Page Title="Correspondencia" Language="C#" MasterPageFile="~/portal/Main.master" AutoEventWireup="true" CodeBehind="correspondencia.aspx.cs" Inherits="SICSA.correspondencia.correspondencia" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="Content2" ContentPlaceHolderID="Header1" runat="server">
    <script type="text/javascript">
        function OnRowClick(e) {
            //Unselect all rows
            ASPxGridDatosCorrespondencia._selectAllRowsOnPage(false);
            //Select the row
            ASPxGridDatosCorrespondencia.SelectRow(e.visibleIndex, true);
        }
    </script>
    <style>
        .tabla
        {
            width:100%;
        }
        .c1
        {
            width:150px;
        }
        .c2
        {
            max-width:50%;
        }
        .c3
        {
            min-width:250px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <div id="titulo">
        <h2>Registro de correspondencia general y puntos de acta</h2>
    </div>
    <asp:SqlDataSource ID="SqlDataPeriodo" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="SELECT [CD_CIERRE], [DS_PERIODO], [CD_EJERICIO] FROM [GLB_CIERRE_PERIODO] ORDER  BY [CD_EJERICIO] DESC, CD_PERIODO DESC"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataTipoC" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="SELECT * FROM [GLB_TIPO_CORRESP] ORDER BY [DS_TIPO_CORRES]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataOrigenPunto" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="SELECT [CD_ORIG_PUNTO], [DS_ORIG_PUNTO] FROM [GLB_ORIGEN_PUNTOS] ORDER BY [CD_ORIG_PUNTO]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataEstado" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="SELECT CD_ESTADO_CORR,DS_ESTADO  FROM AGD_ESTADOS_AGENDA  ORDER BY CD_ESTADO_CORR"></asp:SqlDataSource>
    <dx:ASPxPageControl ID="PagerCorrespondencia" runat="server" ActiveTabIndex="0" Width="100%">
        <TabPages>
            <dx:TabPage Name="Datos" Text="Datos">
                <ContentCollection>
                    <dx:ContentControl runat="server">
                        <table style="width:100%">
                            <tr>
                                <td style="width:10%;">
                                    <label>
                                    Periodo:</label></td>
                                <td>
                                    <dx:ASPxComboBox ID="ASPxComboBoxPeriodo" runat="server" ValueType="System.String" DataSourceID="SqlDataPeriodo" ValueField="CD_CIERRE" AutoPostBack="True">
                                        <Columns>
                                            <dx:ListBoxColumn Caption="CD_CIERRE" FieldName="CD_CIERRE" Name="CD_CIERRE" Visible="False" />
                                            <dx:ListBoxColumn Caption="PERIODO" FieldName="DS_PERIODO" Name="PERIODO" />
                                            <dx:ListBoxColumn Caption="EJERCICIO" FieldName="CD_EJERICIO" Name="EJERCICIO" />
                                        </Columns>
                                    </dx:ASPxComboBox>
                                    <asp:SqlDataSource ID="SqlDataGridDatos" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" DeleteCommand="DELETE FROM dbo.AGD_PUNTOS_AGENDA WHERE CD_PUNTO_AGENDA=@CD_AGENDA

 DELETE FROM dbo.TMP_CORRESPONDENCIA WHERE CD_AGENDA=@CD_AGENDA" SelectCommand="correspondencia_sp" SelectCommandType="StoredProcedure">
                                        <DeleteParameters>
                                            <asp:Parameter Name="CD_AGENDA" />
                                        </DeleteParameters>
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="ASPxComboBoxPeriodo" DefaultValue="1" Name="Ejercicio" PropertyName="Value" Type="String" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </td>
                                <td style="text-align:right;">
                                    <dx:ASPxButton ID="btnNuevo" runat="server" Text="Nueva Correspondencia" OnClick="btnNuevo_Click">
                                    </dx:ASPxButton>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <dx:ASPxGridView ID="ASPxGridDatosCorrespondencia" ClientInstanceName="ASPxGridDatosCorrespondencia" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataGridDatos" KeyFieldName="CD_AGENDA" Width="100%">
                                        <Columns>
                                            <dx:GridViewDataTextColumn FieldName="CD_AGENDA" ShowInCustomizationForm="False" Visible="False" VisibleIndex="0">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataCheckColumn Name="Select" ShowInCustomizationForm="False" VisibleIndex="1" Caption=" ">
                                                <PropertiesCheckEdit DisplayFormatString="{0}" ValueChecked="1" ValueType="System.Int32" ValueUnchecked="0">
                                                </PropertiesCheckEdit>
                                                <DataItemTemplate>
                                                    <dx:ASPxButton ID="btnSeleccionar" runat="server" CommandArgument='<%# Eval("CD_AGENDA") %>' OnClick="btnSeleccionar_Click" Text="Seleccionar" />
                                                </DataItemTemplate>
                                            </dx:GridViewDataCheckColumn>
                                            <dx:GridViewDataDateColumn Caption="Fecha recepción" FieldName="FECHA_RECEPCION" ShowInCustomizationForm="True" VisibleIndex="3">
                                            </dx:GridViewDataDateColumn>
                                            <dx:GridViewDataTextColumn Caption="Concepto" FieldName="CONCEPTO" ShowInCustomizationForm="True" VisibleIndex="6" Width="200px">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Unidad / Institución" FieldName="UNIDAD" ShowInCustomizationForm="True" VisibleIndex="8">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Persona" FieldName="SOLICITANTE" ShowInCustomizationForm="True" VisibleIndex="9" Width="200px">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataDateColumn Caption="Fecha de registro" FieldName="FECHA_REGISTRO" ShowInCustomizationForm="True" VisibleIndex="10">
                                            </dx:GridViewDataDateColumn>
                                            <dx:GridViewDataComboBoxColumn Caption="Tipo" FieldName="TIPO_C" ShowInCustomizationForm="True" VisibleIndex="2">
                                                <PropertiesComboBox DataSourceID="SqlDataTipoC" TextField="DS_TIPO_CORRES" ValueField="CD_TIPO_CORRES">
                                                </PropertiesComboBox>
                                            </dx:GridViewDataComboBoxColumn>
                                            <dx:GridViewDataComboBoxColumn Caption="Origen" FieldName="ORIGEN" ShowInCustomizationForm="True" VisibleIndex="7">
                                                <PropertiesComboBox DataSourceID="SqlDataOrigenPunto" TextField="DS_ORIG_PUNTO" ValueField="CD_ORIG_PUNTO">
                                                </PropertiesComboBox>
                                            </dx:GridViewDataComboBoxColumn>
                                            <dx:GridViewCommandColumn ButtonType="Button" Caption=" " ShowDeleteButton="True" ShowInCustomizationForm="True" VisibleIndex="11">
                                            </dx:GridViewCommandColumn>
                                            <dx:GridViewDataTextColumn Caption="Referencia del documento" FieldName="DS_REFERENCIA" ShowInCustomizationForm="True" VisibleIndex="4" Width="120px">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataDateColumn Caption="Fecha Documento" FieldName="FE_FECHA_DOC" ShowInCustomizationForm="True" VisibleIndex="5">
                                            </dx:GridViewDataDateColumn>
                                        </Columns>
                                        <ClientSideEvents RowClick="function(s, e) { OnRowClick(e); }">
                                        </ClientSideEvents>
                                        <SettingsBehavior AllowSelectSingleRowOnly="True" ConfirmDelete="True" />
                                        <SettingsPager PageSize="5">
                                        </SettingsPager>
                                        <Settings ShowFilterRow="True" ShowGroupPanel="True" />
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
                                <td style="width:150px;">
                                    <label>
                                    Estado:</label> </td>
                                <td>
                                    <dx:ASPxComboBox ID="ASPxComboBoxEstado" runat="server" ValueType="System.Int32" DataSourceID="SqlDataEstado" TextField="DS_ESTADO" ValueField="CD_ESTADO_CORR">
                                    </dx:ASPxComboBox>
                                </td>
                                <td style="text-align:right;">
                                    <label>
                                    Fecha de registro:</label></td>
                                <td style="text-align: right; width:150px;">
                                    <asp:TextBox ID="TextBoxFecha_Registro" runat="server" TextMode="Date" BackColor="#FFFF66"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <div id="form_reg" style="border-style: solid; border-width: 1px; width:99%;">
                                        <table class="tabla">
                                            <tr>
                                                <td class="c1">
                                                    <label>
                                                    Fecha de recepción:</label> </td>
                                                <td class="c2">
                                                    <asp:TextBox ID="TextBoxFecha_Solicitud" runat="server" TextMode="Date"></asp:TextBox>
                                                </td>
                                                <td class="c3">Fecha Documento:</td>
                                                <td>
                                                    <asp:TextBox ID="TextF_Doc" runat="server" TextMode="Date"></asp:TextBox>
                                                </td>
                                                <td class="c3">&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label>
                                                    Referencia del documento:
                                                    </label>
                                                </td>
                                                <td>
                                                    <dx:ASPxTextBox ID="ASPxTextReferencia" runat="server" Width="170px">
                                                    </dx:ASPxTextBox>
                                                </td>
                                                <td>
                                                    <label>
                                                    Tipo de Correspondencia:</label></td>
                                                <td>
                                                    <dx:ASPxRadioButtonList ID="ASPxRadioButtonListTipo" runat="server" DataSourceID="SqlDataTipoC" RepeatDirection="Horizontal" Style="text-align: right" TextField="DS_TIPO_CORRES" ValueField="CD_TIPO_CORRES" ValueType="System.Int32" Width="100%">
                                                    </dx:ASPxRadioButtonList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="c1">
                                                    <label>
                                                    Procedencia:</label></td>
                                                <td class="c2">
                                                    <dx:ASPxComboBox ID="ASPxComboBoxOrigen" runat="server" ValueType="System.Int32" DataSourceID="SqlDataOrigenPunto" TextField="DS_ORIG_PUNTO" ValueField="CD_ORIG_PUNTO" AutoPostBack="True" OnSelectedIndexChanged="ASPxComboBoxOrigen_SelectedIndexChanged" >
                                                    </dx:ASPxComboBox>
                                                </td>
                                                <td class="c3"></td>
                                                <td >&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td class="c1">
                                                    <label>
                                                    Solicitante:</label></td>
                                                <td colspan="2">
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
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label>
                                                    Nombre de solicitud:</label></td>
                                                <td colspan="3">
                                                    <asp:TextBox ID="txtPunto" runat="server" Width="90%" Rows="3" TextMode="MultiLine"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtPunto" ErrorMessage="* Campo Obligatorio" Font-Size="XX-Small" ForeColor="Red"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label>
                                                    Descripción del documento:</label></td>
                                                <td colspan="3">
                                                    <asp:TextBox ID="txtJust" runat="server" TextMode="MultiLine" Rows="4" Width="90%"></asp:TextBox>
                                                </td>
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
                                    <asp:Button ID="btnAceptar" runat="server" OnClick="btnAceptar_Click" Text="Guardar" />
                                        &nbsp;&nbsp;<asp:Button ID="btnCancelar" runat="server" OnClick="brnCanelar_Click" Text="Cancelar" CausesValidation="False" />
                                </td>
                            </tr>
                        </table>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
        </TabPages>
    </dx:ASPxPageControl>
    
</asp:Content>

