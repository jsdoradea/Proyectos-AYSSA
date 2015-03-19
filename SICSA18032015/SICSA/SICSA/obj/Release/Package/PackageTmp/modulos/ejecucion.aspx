<%@ Page Title="Ejecución de acuerdos" Language="C#" MasterPageFile="~/portal/Main.master" AutoEventWireup="true" CodeBehind="ejecucion.aspx.cs" Inherits="SICSA.modulos.ejecucion" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Header1" runat="server">
    <script type="text/javascript">
        function OnRowClick(e) {
            //Unselect all rows
            ASPxGridAcuerdos._selectAllRowsOnPage(false);
            //Select the row
            ASPxGridAcuerdos.SelectRow(e.visibleIndex, true);
        }
        function OnRowClick2(e) {
            //Unselect all rows
            ASPxGridTareas._selectAllRowsOnPage(false);
            //Select the row
            ASPxGridTareas.SelectRow(e.visibleIndex, true);
        }
    </script>
    <style>
        .btn-sp
        {
            background-color: #009933;
            color: White;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="titulo">
        <h2>Relación y Notificación de Acuerdos Tomados
            <dx:ASPxLabel ID="ASPxLabelConfirmar" runat="server" Visible="False">
            </dx:ASPxLabel>
        </h2>
    </div>
    <dx:ASPxPageControl ID="ASPxPageAcuerdos" runat="server" ActiveTabIndex="0" Width="100%" >
        <TabPages>
            <dx:TabPage Text="Datos">
                <ContentCollection>
                    <dx:ContentControl runat="server">
                        <table style="width: 100%">
                            <tr>
                                <td style="width: 10%;">
                                    <label>
                                        Ejercicio:</label> </td>
                                <td>
                                    <asp:SqlDataSource ID="SqlDataEjercicio" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="SELECT DISTINCT CD_EJERICIO FROM dbo.GLB_CIERRE_PERIODO ORDER BY CD_EJERICIO DESC"></asp:SqlDataSource>
                                    <asp:SqlDataSource ID="SqlDataAcuerdos" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="ejecucion_sp" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="ASPxComboEjercicio" Name="CD_EJERCICIO" PropertyName="Value" />
                                            <asp:ControlParameter ControlID="lblUser" Name="USUARIO" PropertyName="Text" Type="Int32" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:SqlDataSource ID="SqlDataTipoAcuerdo" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="SELECT CD_TIPO_ACUERDO, DS_TIPO_ACUERDO FROM dbo.ACU_TIPO_ACUERDO WHERE CD_ESTADO_TIPO_ACU=1"></asp:SqlDataSource>
                                    <dx:ASPxComboBox ID="ASPxComboEjercicio" runat="server" ValueType="System.Int32" DataSourceID="SqlDataEjercicio" TextField="CD_EJERICIO" ValueField="CD_EJERICIO" AutoPostBack="True">
                                    </dx:ASPxComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <dx:ASPxGridView ID="ASPxGridAcuerdos" ClientInstanceName="ASPxGridAcuerdos" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataAcuerdos" KeyFieldName="CD_ENCA_ACUERDOS" Width="100%">
                                        <Columns>
                                            <dx:GridViewDataTextColumn FieldName="CD_ENCA_ACUERDOS" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="0">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataCheckColumn Name="Select" ShowInCustomizationForm="False" VisibleIndex="1" Caption=" ">
                                                <PropertiesCheckEdit DisplayFormatString="{0}" ValueChecked="1" ValueType="System.Int32" ValueUnchecked="0">
                                                </PropertiesCheckEdit>
                                                <DataItemTemplate>
                                                    <dx:ASPxButton ID="btnSeleccionar" runat="server" CommandArgument='<%# Eval("CD_ENCA_ACUERDOS") %>' OnClick="btnSeleccionar_Click" Text="Seleccionar" />
                                                </DataItemTemplate>
                                            </dx:GridViewDataCheckColumn>
                                            <dx:GridViewDataTextColumn Caption="Acta" FieldName="DS_ACTA" ShowInCustomizationForm="True" VisibleIndex="2">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Referencia" FieldName="DS_REFERENCIA" ShowInCustomizationForm="True" VisibleIndex="4" Visible="False">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="N° Acuerdo" FieldName="NM_CORR_ACUERDO" ShowInCustomizationForm="True" VisibleIndex="5">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Acuerdo" FieldName="DS_ACUERDO_COMP" ShowInCustomizationForm="True" VisibleIndex="6">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataDateColumn Caption="Fecha de Inicio" FieldName="FE_FECHA_INI" ShowInCustomizationForm="True" VisibleIndex="8">
                                            </dx:GridViewDataDateColumn>
                                            <dx:GridViewDataTextColumn Caption="Periodo (días)" FieldName="PERIODO_DIAS" ShowInCustomizationForm="True" VisibleIndex="9">
                                                <HeaderStyle HorizontalAlign="Right" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Responsable" FieldName="RESPONSABLE" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="10">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataImageColumn Caption="Estado" FieldName="url_imagen" ShowInCustomizationForm="True" VisibleIndex="11">
                                                <PropertiesImage ImageAlign="Middle" ImageHeight="30px" ImageWidth="30px">
                                                </PropertiesImage>
                                            </dx:GridViewDataImageColumn>
                                            <dx:GridViewDataComboBoxColumn Caption="Tipo de Acuerdo" FieldName="CD_TIPO_ACUERDO" ShowInCustomizationForm="True" VisibleIndex="7">
                                                <PropertiesComboBox DataSourceID="SqlDataTipoAcuerdo" TextField="DS_TIPO_ACUERDO" ValueField="CD_TIPO_ACUERDO">
                                                </PropertiesComboBox>
                                            </dx:GridViewDataComboBoxColumn>
                                            <dx:GridViewDataTextColumn Caption="CD_ENCA_CONVOCATORIA" FieldName="CD_ENCA_CONVOCATORIA" ShowInCustomizationForm="True" Visible="False" VisibleIndex="12">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataDateColumn Caption="Fecha de Acta" FieldName="FECH_CREA" ShowInCustomizationForm="True" VisibleIndex="3">
                                            </dx:GridViewDataDateColumn>
                                        </Columns>
                                        <ClientSideEvents RowClick="function(s, e) { OnRowClick(e); }">
                                        </ClientSideEvents>
                                        <SettingsPager PageSize="7">
                                        </SettingsPager>
                                        <Settings ShowFilterRow="True" ShowGroupPanel="True" />
                                        <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
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
                        <table style="width:100%;">
                            <tr>
                                <td>Sesión:</td>
                                <td>
                                    <asp:TextBox ID="TextBoxSesion" runat="server" ReadOnly="True" BackColor="#FFFF66"></asp:TextBox>
                                </td>
                                <td>Acta:</td>
                                <td>
                                    <asp:TextBox ID="TextBoxActa" runat="server" ReadOnly="True" BackColor="#FFFF66"></asp:TextBox>
                                </td>
                                <td>Acuerdo N°:</td>
                                <td>
                                    <asp:TextBox ID="TextBoxNumAcuerdo" runat="server" ReadOnly="True" Width="60px" BackColor="#FFFF66"></asp:TextBox>
                                </td>
                                <td style="text-align: right;">Días Ejec. Establecidos:</td>
                                <td style="text-align: right;">
                                    <asp:TextBox ID="TextBoxDias" runat="server" ReadOnly="True" TextMode="Number" Width="40px" BackColor="#FFFF66"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Acuerdo:</td>
                                <td colspan="3">
                                    <dx:ASPxMemo ID="ASPxMemoAcuerdo" runat="server" Rows="2" Width="98%" ReadOnly="True" BackColor="#FFFF66">
                                    </dx:ASPxMemo>
                                </td>
                                <td>Fecha de Inicio:</td>
                                <td>
                                    <asp:TextBox ID="txtF_INI_ACU" runat="server" ReadOnly="True" TextMode="Date" BackColor="#FFFF66"></asp:TextBox>
                                </td>
                                <td style="text-align: right;">Fecha Fin:</td>
                                <td style="text-align: right;">
                                    <asp:TextBox ID="txtF_FIN_ACU" runat="server" ReadOnly="True" TextMode="Date" BackColor="#FFFF66"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>
                                    <asp:SqlDataSource ID="SqlDataPlantillas" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="SELECT CD_PLANTILLA, DS_PLANTILLA FROM dbo.EJE_PLANTILLA_TAREAS WHERE ESTADO_PLANTILLA = 1 ORDER BY DS_PLANTILLA"></asp:SqlDataSource>
                                </td>
                                <td>&nbsp;</td>
                                <td>
                                    <asp:SqlDataSource ID="SqlDataTareas" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" DeleteCommand="DELETE FROM dbo.ACU_TAREAS_ACUERDOS WHERE CD_TAREA = @CD_TAREA" SelectCommand="tareas_vista_sp" SelectCommandType="StoredProcedure">
                                        <DeleteParameters>
                                            <asp:Parameter Name="CD_TAREA" />
                                        </DeleteParameters>
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="lblCodAcuerdo" Name="CD_ENCA_ACUERDOS" PropertyName="Text" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td colspan="2">&nbsp; Asignar Tareas desde plantilla:</td>
                                <td colspan="2">
                                    <dx:ASPxComboBox ID="ASPxComboPlantilla" runat="server" DataSourceID="SqlDataPlantillas" TextField="DS_PLANTILLA" ValueField="CD_PLANTILLA" ValueType="System.Int32" Width="100%">
                                    </dx:ASPxComboBox>
                                </td>
                                <td>
                                    <asp:Button ID="ButtonAsignarPlantilla" runat="server" BackColor="#84BD00" ForeColor="White" OnClick="ButtonAsignarPlantilla_Click" Text="Asignar Plantilla" />
                                </td>
                                <td>Asignar Tarea individual: </td>
                                <td>
                                    <asp:Button ID="ButtonNuevaTarea" runat="server" BackColor="#84BD00" ForeColor="White" OnClick="ButtonNuevaTarea_Click" Text="Nueva Tarea" />
                                </td>
                                <td align="right">
                                    <asp:Button ID="Button1" runat="server" Text="Cerrar y Notificar Plan" OnClientClick="return confirm('¿Esta seguro de cerrar el plan?, recuerde que una vez cerrado, no podrá agregar más tareas.')" BackColor="#84BD00" ForeColor="White" OnClick="Button1_Click" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="8">
                                    <dx:ASPxPanel ID="ASPxPanelGrid" runat="server" Width="100%" Visible="True">
                                        <PanelCollection>
                                            <dx:PanelContent ID="PanelContent2" runat="server">
                                                <dx:ASPxGridView ID="ASPxGridTareas" ClientInstanceName="ASPxGridTareas" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataTareas" KeyFieldName="CD_TAREA" Width="100%">
                                                    <Columns>
                                                        <dx:GridViewCommandColumn Caption=" " ShowDeleteButton="True" ShowInCustomizationForm="True" VisibleIndex="12" ButtonType="Button">
                                                        </dx:GridViewCommandColumn>
                                                        <dx:GridViewDataTextColumn FieldName="CD_TAREA" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="0">
                                                            <EditFormSettings Visible="False" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataCheckColumn Name="Select" ShowInCustomizationForm="False" VisibleIndex="1" Caption=" ">
                                                            <PropertiesCheckEdit DisplayFormatString="{0}" ValueChecked="1" ValueType="System.Int32" ValueUnchecked="0">
                                                            </PropertiesCheckEdit>
                                                            <DataItemTemplate>
                                                                <dx:ASPxButton ID="btnSeleccionar" runat="server" CommandArgument='<%# Eval("CD_TAREA") %>' OnClick="btnSeleccionar_Click1" Text="Seleccionar" />
                                                            </DataItemTemplate>
                                                        </dx:GridViewDataCheckColumn>
                                                        <dx:GridViewDataTextColumn Caption="N°" FieldName="NM_TAREA" ShowInCustomizationForm="True" VisibleIndex="2">
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="Acuerdo" FieldName="DS_ACUERDO_COMP" ShowInCustomizationForm="True" VisibleIndex="4" Visible="False" Width="200px">
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="Responsable" FieldName="RESPONSABLE" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="5" Width="300px">
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataDateColumn Caption="Fecha de Inicio" FieldName="FE_FECHA_INI" ShowInCustomizationForm="True" VisibleIndex="6">
                                                        </dx:GridViewDataDateColumn>
                                                        <dx:GridViewDataTextColumn Caption="T.Ejecución (días)" FieldName="DIAS_EJECUCION" ShowInCustomizationForm="True" VisibleIndex="7">
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="Tarea Predecesora" FieldName="PREDECESORA" ShowInCustomizationForm="True" VisibleIndex="9" Width="75px">
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataImageColumn Caption="Estado" FieldName="url_imagen" ShowInCustomizationForm="True" VisibleIndex="11">
                                                            <PropertiesImage ImageHeight="30px" ImageWidth="30px">
                                                            </PropertiesImage>
                                                        </dx:GridViewDataImageColumn>
                                                        <dx:GridViewDataDateColumn Caption="Fecha Fin" FieldName="FECHA_FIN" ShowInCustomizationForm="True" VisibleIndex="8">
                                                        </dx:GridViewDataDateColumn>
                                                        <dx:GridViewDataTextColumn Caption="Dias Acumulados" FieldName="DIAS_ACUMULADOS" ShowInCustomizationForm="True" VisibleIndex="10">
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="Tarea" FieldName="DS_TAREA" ShowInCustomizationForm="True" VisibleIndex="3" Width="300px">
                                                        </dx:GridViewDataTextColumn>
                                                    </Columns>
                                                    <ClientSideEvents RowClick="function(s, e) { OnRowClick2(e); }">
                                                    </ClientSideEvents>
                                                    <SettingsBehavior ConfirmDelete="True" />
                                                    <SettingsPager PageSize="5">
                                                    </SettingsPager>
                                                    <Settings ShowFilterRow="True" ShowGroupPanel="True" />
                                                    <SettingsDataSecurity AllowEdit="False" AllowInsert="False" />
                                                </dx:ASPxGridView>
                                            </dx:PanelContent>
                                        </PanelCollection>
                                    </dx:ASPxPanel>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td colspan="8">
                                    <dx:ASPxPanel ID="ASPxPanelInfo" runat="server" Width="100%" Visible="False">
                                        <PanelCollection>
                                            <dx:PanelContent ID="PanelContent1" runat="server">
                                                <table style="width:100%;">
                                                    <tr>
                                                        <td>Nombre de tarea:</td>
                                                        <td colspan="3">
                                                            <dx:ASPxTextBox ID="ASPxTextNomTarea" runat="server" Width="95%" Enabled="False">
                                                            </dx:ASPxTextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Descripcion:</td>
                                                        <td colspan="3">
                                                            <dx:ASPxMemo ID="ASPxMemoDescripcion" runat="server" Rows="2" Width="95%" Enabled="False">
                                                            </dx:ASPxMemo>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Responsable:</td>
                                                        <td>
                                                            <dx:ASPxComboBox ID="ASPxComboBoxEmpleados" runat="server" DataSourceID="SqlDataEmpleados" ValueField="CODIGO" ValueType="System.Int32" Width="98%" Enabled="False">
                                                                <Columns>
                                                                    <dx:ListBoxColumn FieldName="CODIGO" Visible="False" />
                                                                    <dx:ListBoxColumn Caption="UNIDAD" FieldName="ORIGEN" Name="ORIGEN" />
                                                                    <dx:ListBoxColumn Caption="EMPLEADO" FieldName="PERSONA" Name="PERSONA" />
                                                                </Columns>
                                                            </dx:ASPxComboBox>
                                                            <asp:SqlDataSource ID="SqlDataEmpleados" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="SELECT a.CD_EMPLEADO as CODIGO, a.DS_NOMBRE_EMPLEADO + ' ' + a.DS_APELLIDO_EMPLEADO AS PERSONA, b.DS_UNIDAD AS ORIGEN 
FROM dbo.GLB_EMPLEADOS a 	
	INNER JOIN dbo.GLB_UNIDADES_TEG b ON b.CD_UNIDAD=a.CD_UNIDAD 
	INNER JOIN dbo.ACU_NOTIFICACION_ACUERDO c ON c.CD_CALIDAD=2 and c.CD_EMPLEADO = a.CD_EMPLEADO
WHERE a.CD_ESTADO = 1 and c.CD_ENCA_ACUERDO=@CD_ENCA_ACUERDO
ORDER BY b.DS_UNIDAD, a.DS_NOMBRE_EMPLEADO, a.DS_APELLIDO_EMPLEADO">
                                                                <SelectParameters>
                                                                    <asp:ControlParameter ControlID="lblCodAcuerdo" Name="CD_ENCA_ACUERDO" PropertyName="Text" />
                                                                </SelectParameters>
                                                            </asp:SqlDataSource>
                                                        </td>
                                                        <td style="min-width:200px;">&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <td>Tarea predecesora:</td>
                                                        <td>
                                                            <asp:TextBox ID="txtPredecesora" runat="server" Enabled="False" TextMode="Number">0</asp:TextBox>
                                                        </td>
                                                        <td>Días de Ejecución:</td>
                                                        <td>
                                                            <asp:TextBox ID="TextDias" runat="server" Enabled="False" TextMode="Number">0</asp:TextBox>
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
                                                        <td style="text-align: right;">
                                                            <dx:ASPxLabel ID="lblPlantilla" runat="server" Visible="False">
                                                            </dx:ASPxLabel>
                                                            <asp:Label ID="lblCDTarea" runat="server" Visible="False"></asp:Label>
                                                            <asp:Label ID="lblAccionTarea" runat="server" Visible="False"></asp:Label>
                                                            <dx:ASPxButton ID="ASPxButtonGuardar" runat="server" Text="Guardar" Enabled="False" OnClick="ASPxButtonGuardar_Click">
                                                            </dx:ASPxButton>
                                                &nbsp;&nbsp;
                                                            <dx:ASPxButton ID="ASPxButtonCancelar" runat="server" Text="Cancelar" Enabled="False" OnClick="ASPxButtonCancelar_Click">
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
        </TabPages>
    </dx:ASPxPageControl>
    <asp:Label ID="lblCodAcuerdo" runat="server" Visible="False"></asp:Label>
    <asp:Label ID="lblUser" runat="server" Visible="False"></asp:Label>
</asp:Content>
