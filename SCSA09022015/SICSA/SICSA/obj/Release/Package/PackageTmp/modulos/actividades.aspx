<%@ Page Title="Ejecución de actividades" Language="C#" MasterPageFile="~/portal/Main.master" AutoEventWireup="true" CodeBehind="actividades.aspx.cs" Inherits="SICSA.modulos.actividades" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Header1" runat="server">
    <script type="text/javascript">
        function OnRowClick(e) {
            //Unselect all rows
            ASPxGridTareas._selectAllRowsOnPage(false);
            //Select the row
            ASPxGridTareas.SelectRow(e.visibleIndex, true);
        }
    </script>
    <style type="text/css">
        .auto-style1
        {
            width: 330px;
        }
        .auto-style2
        {
            height: 26px;
        }
        .auto-style3
        {
            width: 330px;
            height: 26px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="titulo">
        <h2>Ejecución de actividades</h2>
    </div>
    <dx:ASPxPageControl ID="ASPxPageActividades" runat="server" ActiveTabIndex="1" Width="100%">
        <TabPages>
            <dx:TabPage Text="Tareas">
                <ContentCollection>
                    <dx:ContentControl runat="server">
                        <asp:SqlDataSource ID="SqlDataTareas" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="SELECT a.CD_TAREA, d.DS_ACUERDO_COMP, a.DS_TAREA, a.FE_FECHA_INI, a.DIAS_EJECUCION, a.NM_TAREA, a.FECHA_FIN, c.url_imagen
FROM dbo.ACU_TAREAS_ACUERDOS a
	INNER JOIN dbo.CONF_USUARIO b ON b.CD_EMPLEADO = a.CD_RESPONSABLE
	INNER JOIN dbo.GLB_SEMAFORO c ON c.id_semaforo = a.ESTADO_TAREA
	INNER JOIN dbo.ACU_ENCA_ACUERDOS d ON d.CD_ENCA_ACUERDOS = a.CD_ENCA_ACUERDOS
WHERE b.id_usuario=@id_usuario ORDER BY a.FECHA_FIN">
                            <SelectParameters>
                                <asp:SessionParameter Name="id_usuario" SessionField="UserID" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <dx:ASPxGridView ID="ASPxGridTareas" ClientInstanceName="ASPxGridTareas" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataTareas" KeyFieldName="CD_TAREA" Width="100%">
                            <Columns>
                                <dx:GridViewDataTextColumn FieldName="CD_TAREA" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="0">
                                    <EditFormSettings Visible="False" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataCheckColumn Name="Select" ShowInCustomizationForm="False" VisibleIndex="1" Caption=" ">
                                    <PropertiesCheckEdit DisplayFormatString="{0}" ValueChecked="1" ValueType="System.Int32" ValueUnchecked="0">
                                    </PropertiesCheckEdit>
                                    <DataItemTemplate>
                                        <dx:ASPxButton ID="btnSeleccionar" runat="server" CommandArgument='<%# Eval("CD_TAREA") %>' OnClick="btnSeleccionar_Click1" Text="Informar" />
                                    </DataItemTemplate>
                                </dx:GridViewDataCheckColumn>
                                <dx:GridViewDataTextColumn Caption="Tarea / Actividad" FieldName="DS_TAREA" ShowInCustomizationForm="True" VisibleIndex="4" Width="300px">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataDateColumn Caption="Fecha Inicio" FieldName="FE_FECHA_INI" ShowInCustomizationForm="True" VisibleIndex="5">
                                </dx:GridViewDataDateColumn>
                                <dx:GridViewDataTextColumn Caption="Días Ejecución" FieldName="DIAS_EJECUCION" ShowInCustomizationForm="True" VisibleIndex="6">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="N° Tarea" FieldName="NM_TAREA" ShowInCustomizationForm="True" VisibleIndex="3">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataDateColumn Caption="Fecha Fin" FieldName="FECHA_FIN" ShowInCustomizationForm="True" VisibleIndex="7">
                                </dx:GridViewDataDateColumn>
                                <dx:GridViewDataImageColumn Caption="Estado" FieldName="url_imagen" ShowInCustomizationForm="True" VisibleIndex="8">
                                    <PropertiesImage ImageHeight="30px" ImageWidth="30px">
                                    </PropertiesImage>
                                </dx:GridViewDataImageColumn>
                                <dx:GridViewDataTextColumn Caption="Acuerdo" FieldName="DS_ACUERDO_COMP" ShowInCustomizationForm="True" VisibleIndex="2" Width="300px">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataCheckColumn Name="Select" ShowInCustomizationForm="False" VisibleIndex="9" Caption=" ">
                                    <PropertiesCheckEdit DisplayFormatString="{0}" ValueChecked="1" ValueType="System.Int32" ValueUnchecked="0">
                                    </PropertiesCheckEdit>
                                    <DataItemTemplate>
                                        <dx:ASPxButton ID="btnProrroga" runat="server" CommandArgument='<%# Eval("CD_TAREA") %>' OnClick="btnProrroga_Click" Text="Solicitar Prorroga" />
                                    </DataItemTemplate>
                                </dx:GridViewDataCheckColumn>
                            </Columns>
                            <ClientSideEvents RowClick="function(s, e) { OnRowClick(e); }">
                            </ClientSideEvents>
                            <SettingsPager PageSize="7">
                            </SettingsPager>
                            <Settings ShowFilterRow="True" ShowGroupPanel="True" />
                            <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                        </dx:ASPxGridView>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage Text="Informes">
                <ContentCollection>
                    <dx:ContentControl runat="server">
                        <asp:SqlDataSource ID="SqlDataDatosTarea" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="SELECT a.CD_TAREA, a.CD_ENCA_ACUERDOS, a.DS_TAREA, a.DS_DESCRIPCION, a.FE_FECHA_INI, a.FECHA_FIN, a.DIAS_EJECUCION,
		b.DS_ACUERDO_COMP, b.NM_CORR_ACUERDO, d.DS_ACTA, d.DS_REFERENCIA
FROM dbo.ACU_TAREAS_ACUERDOS a
	INNER JOIN dbo.ACU_ENCA_ACUERDOS b ON b.CD_ENCA_ACUERDOS = a.CD_ENCA_ACUERDOS
	INNER JOIN dbo.CONV_PUNTOS_AGENDA c ON c.CD_CONVOCATORIA = b.CD_DETA_CONV
	INNER JOIN dbo.AGD_ENCA_CONVOCATORIA d ON d.CD_ENCA_CONVOCATORIA = c.CD_ENCA_CONVOCATORIA
WHERE a.CD_TAREA=@CD_TAREA">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="ASPxLabelCodTarea" Name="CD_TAREA" PropertyName="Text" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <table style="width:100%;">
                            <tr>
                                <td>Sesión:</td>
                                <td>
                                    <dx:ASPxTextBox ID="ASPxTextBoxSesion" runat="server" Width="170px" ReadOnly="True">
                                    </dx:ASPxTextBox>
                                </td>
                                <td>Acta:</td>
                                <td>
                                    <dx:ASPxTextBox ID="ASPxTextBoxActa" runat="server" Width="170px" ReadOnly="True">
                                    </dx:ASPxTextBox>
                                </td>
                                <td>N° Acuerdo:</td>
                                <td>
                                    <dx:ASPxTextBox ID="ASPxTextBoxNAcu" runat="server" Width="170px" ReadOnly="True">
                                    </dx:ASPxTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Acuerdo:</td>
                                <td colspan="5">
                                    <dx:ASPxMemo ID="ASPxMemoAcuerdo" runat="server" Rows="3" Width="90%" ReadOnly="True">
                                    </dx:ASPxMemo>
                                </td>
                            </tr>
                            <tr>
                                <td>Tarea:</td>
                                <td>
                                    <dx:ASPxMemo ID="ASPxMemoTarea" runat="server" Rows="3" Width="90%" ReadOnly="True">
                                    </dx:ASPxMemo>
                                </td>
                                <td>Fecha Incio:</td>
                                <td>
                                    <asp:TextBox ID="TextBoxFE_INI" runat="server" TextMode="Date" ReadOnly="True"></asp:TextBox>
                                </td>
                                <td>Fecha Fin:</td>
                                <td>
                                    <asp:TextBox ID="TextBoxFE_FIN" runat="server" TextMode="Date" ReadOnly="True"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Descripción:</td>
                                <td colspan="3">
                                    <dx:ASPxMemo ID="ASPxMemoDesc" runat="server" Rows="3" Width="90%" ReadOnly="True">
                                    </dx:ASPxMemo>
                                </td>
                                <td>Dias Ejecución:</td>
                                <td>
                                    <asp:TextBox ID="TextBoxDiasEJE" runat="server" ReadOnly="True"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td colspan="6">
                                    <div id="Div1" style="border-style:solid; border-width:1px; border-color:black; width:100%; padding: 1px 1px 1px 1px;">
                                        <table style="width: 100%;">
                                            <tr>
                                                <td style="width: 150px;">Estado:</td>
                                                <td class="auto-style1">
                                                    <dx:ASPxRadioButtonList ID="ASPxRadioButtonList1" runat="server" RepeatDirection="Horizontal" SelectedIndex="0" ValueType="System.Int32">
                                                        <Items>
                                                            <dx:ListEditItem Text="Pendiente" Value="1" Selected="True" />
                                                            <dx:ListEditItem Text="Terminada" Value="2" />
                                                        </Items>
                                                    </dx:ASPxRadioButtonList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Comentario: (solo al completar)</td>
                                                <td class="auto-style1">
                                                    <dx:ASPxMemo ID="ASPxMemo4" runat="server" Rows="3" Width="90%">
                                                    </dx:ASPxMemo>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="auto-style2">Archivo Adjunto (opcional):</td>
                                                <td class="auto-style3">
                                                    <asp:FileUpload ID="FileUpload1" runat="server" Width="90%" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="auto-style2">&nbsp;</td>
                                                <td class="auto-style3">
                                                    <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Guardar" OnClick="ASPxButton1_Click">
                                                    </dx:ASPxButton>
                                                    &nbsp;&nbsp;
                                                    <dx:ASPxButton ID="ASPxButton2" runat="server" Text="Cancelar" OnClick="ASPxButton2_Click">
                                                    </dx:ASPxButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage Text="Prórrogas">
                <ContentCollection>
                    <dx:ContentControl runat="server">
                        <table style="width:100%;">
                            <tr>
                                <td>Solicitud de Prórrogas</td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <div id="datos" style="border-style:solid; border-width:1px; border-color:black; width:100%; padding: 1px 1px 1px 1px;">
                                        <table style="width:100%;">
                                            <tr>
                                                <td>Acuerdo N°:</td>
                                                <td>
                                                    <dx:ASPxTextBox ID="ASPxTextBoxNAcuerdo" runat="server" Width="170px" ReadOnly="True">
                                                    </dx:ASPxTextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Días Solicitados:</td>
                                                <td>
                                                    <asp:TextBox ID="TextBoxDias" runat="server" TextMode="Number" Text="1"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Justificación:
                                                </td>
                                                <td>
                                                    <dx:ASPxMemo ID="ASPxMemoJust" runat="server" Height="71px" Width="80%" Rows="4">
                                                    </dx:ASPxMemo>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>&nbsp;</td>
                                                <td>
                                                    <dx:ASPxButton ID="ASPxButtonGuardar" runat="server" Text="Guardar" OnClick="ASPxButtonGuardar_Click">
                                                    </dx:ASPxButton>
                                                    &nbsp;&nbsp;&nbsp;
                                                    <dx:ASPxButton ID="ASPxButtonCancelar" runat="server" Text="Cancelar" OnClick="ASPxButtonCancelar_Click">
                                                    </dx:ASPxButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
        </TabPages>
    </dx:ASPxPageControl>
    <dx:ASPxLabel ID="ASPxLabelCodTarea" runat="server" Text="" Visible="false">
    </dx:ASPxLabel>
</asp:Content>
