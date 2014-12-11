<%@ Page Title="Convocatoria" Language="C#" MasterPageFile="~/portal/Main.master" AutoEventWireup="true" CodeFile="convocatoria.aspx.cs" Inherits="convocatoria_convocatoria" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridLookup" TagPrefix="dx" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxClasses" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>



<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">

    <div id="titulo" style="vertical-align: top; background-color: #003da5; width: 100%">
        <h2 style="font-family: Verdana, Geneva, Tahoma, sans-serif; font-size: medium; color: #FFFFFF">Convocatoria a sesión de pleno</h2>
    </div>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <dx:ASPxPageControl ID="TabConvocatoria" runat="server" ActiveTabIndex="0" Width="100%" Theme="Glass">
        <TabPages>
            <dx:TabPage Name="datos" Text="Datos">
                <ContentCollection>
                    <dx:ContentControl runat="server">
                        <table style="width:100%">
                            <tr>
                                <td>
                                    <label>Periodo:</label></td>
                                <td>
                                    <dx:ASPxComboBox ID="DDLPeriodo" runat="server"  EnableTheming="True" Theme="Glass" ValueField="CD_CIERRE" AutoPostBack="True" OnSelectedIndexChanged="DDLPeriodo_SelectedIndexChanged" DataSourceID="SQLDS_Periodo">
                                        <Columns>
                                            <dx:ListBoxColumn FieldName="CD_CIERRE" Visible="False" />
                                            <dx:ListBoxColumn Caption="PERIODO" FieldName="DS_PERIODO" Name="PERIODO" />
                                            <dx:ListBoxColumn Caption="EJERCICIO" FieldName="CD_EJERICIO" Name="EJERCICIO" />
                                        </Columns>
                                    </dx:ASPxComboBox>
                                    <asp:SqlDataSource ID="SQLDS_Periodo" runat="server" ConnectionString="<%$ ConnectionStrings:SCSA %>" SelectCommand="SELECT [CD_CIERRE], [DS_PERIODO], [CD_EJERICIO] FROM [GLB_CIERRE_PERIODO] ORDER  BY [CD_EJERICIO] DESC, CD_PERIODO DESC"></asp:SqlDataSource>
                                </td>
                                <td>
                                    <dx:ASPxButton ID="ASPxButton3" runat="server" Text="Nueva convocatoria" OnClick="ASPxButton3_Click"></dx:ASPxButton>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">&nbsp;</td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <dx:ASPxGridView ID="GridConvocatoria" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" Theme="DevEx" KeyFieldName="CD_ENCA_CONVOCATORIA" Width="100%">
                                        <Columns>
                                            <dx:GridViewCommandColumn ButtonType="Button" Caption=" " ShowClearFilterButton="True" ShowDeleteButton="True" ShowInCustomizationForm="True" VisibleIndex="6">
                                            </dx:GridViewCommandColumn>
                                            <dx:GridViewDataTextColumn FieldName="CD_ENCA_CONVOCATORIA" ShowInCustomizationForm="True" VisibleIndex="0" ReadOnly="True" Visible="False">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="DS_REFERENCIA" ShowInCustomizationForm="True" VisibleIndex="1" Caption="Convocatoria">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Tipo de sesión" FieldName="TIPO_SESION" ShowInCustomizationForm="True" VisibleIndex="2">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataDateColumn FieldName="FE_FECHA_PROP_INI" ShowInCustomizationForm="True" VisibleIndex="3" Caption="Fecha de convocatoria">
                                            </dx:GridViewDataDateColumn>
                                            <dx:GridViewDataTextColumn Caption="Estado" FieldName="ESTADO_SESION" ShowInCustomizationForm="True" VisibleIndex="5">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTimeEditColumn Caption="Hora convocatoria" FieldName="HO_HORA_PROP_INI" ShowInCustomizationForm="True" VisibleIndex="4">
                                            </dx:GridViewDataTimeEditColumn>
                                        </Columns>
                                        <SettingsBehavior ConfirmDelete="True" />
                                        <SettingsPager PageSize="7">
                                        </SettingsPager>
                                        <Settings ShowFilterRow="True" ShowGroupPanel="True" />
                                        <SettingsDataSecurity AllowEdit="False" AllowInsert="False" />
                                    </dx:ASPxGridView>
                                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SCSA %>" SelectCommand="convocatoria" SelectCommandType="StoredProcedure" DeleteCommand="DELETE FROM dbo.AGD_ENCA_CONVOCATORIA WHERE CD_ENCA_CONVOCATORIA =@CD_ENCA_CONVOCATORIA ">
                                        <DeleteParameters>
                                            <asp:Parameter Name="CD_ENCA_CONVOCATORIA" />
                                        </DeleteParameters>
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="DDLPeriodo" DefaultValue="2" Name="PERIODO" PropertyName="Value" Type="Int32" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </td>
                            </tr>
                        </table>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage Name="detalles" Text="Detalles" Enabled="False">
                <ContentCollection>
                    <dx:ContentControl runat="server">
                        <div id="detalles">
                            <table style="width: 100%;">
                                <tr>
                                    <td>
                                        <label>Referencia:</label></td>
                                    <td>
                                        <dx:ASPxLabel ID="lblRef" runat="server">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td style="text-align: right" class="auto-style1">
                                        <label>Fecha de registro:</label></td>
                                    <td style="text-align: right">
                                        <asp:TextBox ID="txtFE_REG" runat="server" TextMode="Date" ReadOnly="True"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                            <div id="tabs">
                                <dx:ASPxPageControl ID="TabSesion" runat="server" Width="100%" Theme="DevEx" ActiveTabIndex="0" AutoPostBack="True" OnActiveTabChanged="TabSesion_ActiveTabChanged">

                                    <TabPages>
                                        <dx:TabPage Text="Crear Sesión">
                                            <ContentCollection>
                                                <dx:ContentControl runat="server">
                                                    <table style="width: 100%">
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
                                                                <asp:DropDownList ID="DDLTipoSesion" runat="server">
                                                                </asp:DropDownList></td>
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
                                                                <asp:DropDownList ID="DDLEstadoSesion" runat="server">
                                                                </asp:DropDownList></td>
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
                                                            <td align="right">
                                                                <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Guardar" />
                                                                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Cancelar" />
                                                            </td>
                                                        </tr>
                                                        

                                                    </table>
                                                </dx:ContentControl>
                                            </ContentCollection>
                                        </dx:TabPage>

                                        <dx:TabPage Text="Puntos a tratar" Enabled="False">
                                            <ContentCollection>
                                                <dx:ContentControl runat="server">
                                                    <table style="width:100%">
                                                        <tr>
                                                            <td><label>Puntos solicitados a tratar:</label></td>
                                                            <td>
                                                                <div id="siguiente" style="text-align: right;">
                                                                    <br />
                                                                    <dx:ASPxButton ID="btnDefAgenda" runat="server" OnClick="btnDefAgenda_Click" Text="Definir agenda">
                                                                    </dx:ASPxButton>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        
                                                    </table>

                                                    <dx:ASPxGridView ID="ASPxGridView3" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource4" EnableTheming="True" Theme="DevEx" Width="100%" KeyFieldName="CD_PUNTO_AGENDA">
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
                                                                <PropertiesComboBox DataSourceID="SqlDataSource5" TextField="DS_TIPO_INCLUSION" ValueField="CD_TIPO_PUNTO_CONV">
                                                                </PropertiesComboBox>
                                                            </dx:GridViewDataComboBoxColumn>
                                                        </Columns>
                                                        <SettingsPager PageSize="5">
                                                        </SettingsPager>
                                                        <Settings ShowFilterRow="True" ShowGroupPanel="True" />
                                                    </dx:ASPxGridView>
                                                    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:SCSA %>" SelectCommand="SELECT a.CD_PUNTO_AGENDA,  @CD_CONV as CD_ENCA_CONVOCATORIA,  a.DS_PUNTO_AGENDA, a.FE_FECH_SOLIC, a.FECH_CREA, 3 as CD_TIPO_INCLUSION
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

                                                    <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:SCSA %>" SelectCommand="SELECT CD_TIPO_PUNTO_CONV, DS_TIPO_INCLUSION FROM dbo.CONV_TIPO_PUNTO_INCLUSION"></asp:SqlDataSource>

                                                    

                                                </dx:ContentControl>
                                            </ContentCollection>
                                        </dx:TabPage>
                                        <dx:TabPage Text="Agenda Sugerida" Enabled="False">
                                            <ContentCollection>
                                                <dx:ContentControl runat="server">
                                                    <table style="width: 100%;">
                                                        <tr>
                                                            <td style="width: 50%; vertical-align: top;">
                                                                
                                                                
                                                                <asp:Panel ID="Panel1" runat="server" Height="400px" Width="100%">
                                                                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:SCSA %>" SelectCommand="SELECT a.CD_CONVOCATORIA, b.DS_PUNTO_AGENDA 
FROM dbo.CONV_PUNTOS_AGENDA a 
	INNER JOIN dbo.AGD_PUNTOS_AGENDA b ON b.CD_PUNTO_AGENDA = a.CD_PUNTO_AGENDA
WHERE a.CD_ENCA_CONVOCATORIA=@COD_CONVOCATORIA">
                                                                        <SelectParameters>
                                                                            <asp:ControlParameter ControlID="txtConv" DefaultValue="0" Name="COD_CONVOCATORIA" PropertyName="Text" Type="Int32" />
                                                                        </SelectParameters>
                                                                    </asp:SqlDataSource>
                                                                    <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:SCSA %>" SelectCommand="SELECT a.CD_CONVOCATORIA, b.DS_PUNTO_AGENDA, c.DS_TIPO_INCLUSION, a.ORDEN
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
                                                                                <dx:ASPxButton ID="ASPxButton5" runat="server" Theme="Glass" Wrap="True">
                                                                                    <BackgroundImage HorizontalPosition="center" ImageUrl="~/Content/Images/arrow_up.png" Repeat="NoRepeat" VerticalPosition="top" />
                                                                                </dx:ASPxButton>
                                                                            </td>
                                                                            <td style="text-align:center;">
                                                                                <dx:ASPxButton ID="btnUp" runat="server" Theme="Glass" Wrap="True">
                                                                                    <BackgroundImage HorizontalPosition="center" ImageUrl="~/Content/Images/arrow_down.png" Repeat="NoRepeat" VerticalPosition="bottom" />
                                                                                </dx:ASPxButton>
                                                                            </td>
                                                                            <td style="text-align:center;">
                                                                                <dx:ASPxButton ID="btnCancel" runat="server" Theme="Glass" Wrap="True">
                                                                                    <BackgroundImage HorizontalPosition="center" ImageUrl="~/Content/Images/quitar.png" Repeat="NoRepeat" VerticalPosition="center" />
                                                                                </dx:ASPxButton>
                                                                            </td>
                                                                            <td style="text-align:right;">
                                                                                
                                                                                <dx:ASPxButton ID="ASPxButton6" runat="server" Text="Generar Agenda Preliminar" Theme="Glass">
                                                                                </dx:ASPxButton>
                                                                                
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="4" style="text-align:center;">
                                                                                <dx:ASPxGridView ID="ASPxGridView4" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource6" EnableTheming="True" KeyFieldName="CD_CONVOCATORIA" Theme="Glass" Width="100%">
                                                                                    <Columns>
                                                                                        <dx:GridViewDataTextColumn FieldName="CD_CONVOCATORIA" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="0">
                                                                                            <EditFormSettings Visible="False" />
                                                                                        </dx:GridViewDataTextColumn>
                                                                                        <dx:GridViewDataTextColumn Caption="Nombre de punto" FieldName="DS_PUNTO_AGENDA" ShowInCustomizationForm="True" VisibleIndex="1">
                                                                                        </dx:GridViewDataTextColumn>
                                                                                        <dx:GridViewDataTextColumn Caption="Incluido como:" FieldName="DS_TIPO_INCLUSION" ShowInCustomizationForm="True" VisibleIndex="2">
                                                                                        </dx:GridViewDataTextColumn>
                                                                                        <dx:GridViewDataTextColumn FieldName="ORDEN" ShowInCustomizationForm="True" Visible="False" VisibleIndex="3">
                                                                                        </dx:GridViewDataTextColumn>
                                                                                    </Columns>
                                                                                    <SettingsPager Visible="False">
                                                                                    </SettingsPager>
                                                                                    <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                                                                                </dx:ASPxGridView>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:Panel>
                                                                
                                                            </td>
                                                            <td style="width: 50%; vertical-align: top;" align="center" valign="middle">
                                                                <%--<asp:SqlDataSource ID="SqlDataSource2" runat="server" SelectCommand="select agenda"></asp:SqlDataSource>

                                                                <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Height="325px" Width="100%">
                                                                    <LocalReport ReportEmbeddedResource="ReptAgenda.rdlc" ReportPath="convocatoria/ReptAgenda.rdlc">
                                                                        <DataSources>
                                                                            <rsweb:ReportDataSource DataSourceId="SqlDataSource2" Name="" />
                                                                        </DataSources>
                                                                    </LocalReport>
                                                                </rsweb:ReportViewer>--%>
                                                                <br />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </dx:ContentControl>
                                            </ContentCollection>
                                        </dx:TabPage>
                                        <dx:TabPage Text="Notificar" Enabled="False">
                                            <ContentCollection>
                                                <dx:ContentControl runat="server">
                                                    <table>
                                                        <tr>
                                                            <td class="dxeCaptionHACSys">
                                                                <label>Miembros convocados </label>
                                                            </td>
                                                            <td class="dxeCaptionHACSys">
                                                                <label>Puntos sugeridos </label>
                                                            </td>
                                                            <td></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="dxeCaptionHACSys">
                                                                <asp:ListBox ID="ListBox1" runat="server">
                                                                    <asp:ListItem>Miembro 1</asp:ListItem>
                                                                    <asp:ListItem>Miembro 2</asp:ListItem>
                                                                    <asp:ListItem>Miembro 3</asp:ListItem>
                                                                </asp:ListBox></td>
                                                            <td class="dxeCaptionHACSys">
                                                                <asp:ListBox ID="ListBox2" runat="server">
                                                                    <asp:ListItem>UACI</asp:ListItem>
                                                                    <asp:ListItem>Permisos</asp:ListItem>
                                                                </asp:ListBox></td>
                                                            <td>
                                                                <asp:Button ID="Button7" runat="server" OnClick="Button7_Click" Text="Generar Convocatoria" />
                                                            </td>
                                                        </tr>
                                                    </table>

                                                </dx:ContentControl>
                                            </ContentCollection>
                                        </dx:TabPage>
                                        <dx:TabPage Text="Reprogramaciones" Enabled="False">
                                            <ContentCollection>
                                                <dx:ContentControl runat="server">
                                                    <table>
                                                        <tr>
                                                            <td colspan="4"><strong>Posponer convocatoria actual:</strong></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Fecha y hora de sesión</td>
                                                            <td>
                                                                <input type="date" id="c1" /></td>
                                                            <td>
                                                                <input type="time" id="h1" /></td>
                                                            <td>
                                                                <asp:Button ID="Button4" runat="server" Text="Posponer convocatoria" Width="200px" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Tipo Sesión:</td>
                                                            <td>
                                                                <asp:DropDownList ID="DropDownList1" runat="server">
                                                                    <asp:ListItem>Ordinaria</asp:ListItem>
                                                                    <asp:ListItem>Extraordinaria</asp:ListItem>
                                                                </asp:DropDownList></td>
                                                            <td>&nbsp;</td>
                                                            <td>
                                                                <asp:Button ID="Button5" runat="server" Text="Notificar nuevamente" Width="200px" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Fecha y hora de reprogramación</td>
                                                            <td>
                                                                <input type="date" id="Date2" /></td>
                                                            <td>
                                                                <input type="time" id="Time2" /></td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                            <td>Motivo o razón:</td>
                                                            <td colspan="3">
                                                                <dx:ASPxMemo ID="ASPxMemoMotivo" runat="server" Width="100%" Rows="3"></dx:ASPxMemo>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="4">
                                                                <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource3" EnableTheming="True" Theme="DevEx">
                                                                    <Columns>
                                                                        <dx:GridViewDataTextColumn Caption="N° Convocatoria" FieldName="Convocatoria" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="0">
                                                                        </dx:GridViewDataTextColumn>
                                                                        <dx:GridViewDataDateColumn Caption="Fecha para reprogramación" FieldName="FE_FECH_PROP" ShowInCustomizationForm="True" VisibleIndex="1">
                                                                        </dx:GridViewDataDateColumn>
                                                                        <dx:GridViewDataTextColumn Caption="Hora de reprogramación" FieldName="HO_HORA_PROP" ShowInCustomizationForm="True" VisibleIndex="2">
                                                                        </dx:GridViewDataTextColumn>
                                                                        <dx:GridViewDataTextColumn Caption="Motivo" FieldName="DS_MOTIVO_REPRO" ShowInCustomizationForm="True" VisibleIndex="3">
                                                                        </dx:GridViewDataTextColumn>
                                                                    </Columns>
                                                                </dx:ASPxGridView>
                                                                <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:SCSA %>" SelectCommand="select ROW_NUMBER() OVER(ORDER BY CD_DETA_CONV_REPRO DESC) AS Convocatoria, FE_FECH_PROP, HO_HORA_PROP, DS_MOTIVO_REPRO from dbo.AGD_DETA_CONVOCATORIA_REPROG"></asp:SqlDataSource>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </dx:ContentControl>
                                            </ContentCollection>
                                        </dx:TabPage>
                                        <dx:TabPage Text="Solicitudes" Enabled="False">
                                            <ContentCollection>
                                                <dx:ContentControl ID="ContentControl1" runat="server">
                                                    <div style="margin: 0 auto;">
                                                        <table style="width: 100%">
                                                            <tr>
                                                                <td style="width: 20%">
                                                                    <label>Estado:</label></td>
                                                                <td style="width: 80%">
                                                                    <asp:DropDownList ID="DDLEstadoSolicitud" runat="server">
                                                                        <asp:ListItem Value="0">DIGITADO</asp:ListItem>
                                                                    </asp:DropDownList></td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2">
                                                                    <div style="width: 100%; border-style: solid; border-width: 1px;">
                                                                        <table style="width: 100%">
                                                                            <tr>
                                                                                <td style="width: 20%">
                                                                                    <label>Fecha de Solicitud:</label></td>
                                                                                <td style="width: 80%">
                                                                                    <input type="date" /></td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="width: 20%">
                                                                                    <label>Nombre de solicitud:</label></td>
                                                                                <td style="width: 80%">
                                                                                    <asp:TextBox ID="TextBox3" runat="server" Width="90%" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="width: 20%">
                                                                                    <label>Justificación:</label></td>
                                                                                <td style="width: 80%">
                                                                                    <asp:TextBox ID="TextBox4" runat="server" Width="90%" TextMode="MultiLine" Rows="3"></asp:TextBox></td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="width: 20%">
                                                                                    <label>Orígen de Solicitud:</label></td>
                                                                                <td style="width: 80%">
                                                                                    <asp:DropDownList ID="DDLOrigen" runat="server"></asp:DropDownList></td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="width: 20%">
                                                                                    <label>Solicitante:</label></td>
                                                                                <td style="width: 80%">
                                                                                    <asp:DropDownList ID="DDLSolicitantes" runat="server" Width="500px">
                                                                                    </asp:DropDownList>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </dx:ContentControl>
                                            </ContentCollection>
                                        </dx:TabPage>
                                    </TabPages>

                                </dx:ASPxPageControl>
                            </div>
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
                        </div>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
        </TabPages>
    </dx:ASPxPageControl>
</asp:Content>

<asp:Content ID="Content2" runat="server" contentplaceholderid="Header1">
    
    <style type="text/css">
        .auto-style1
        {
            width: 520px;
        }
    </style>
    
</asp:Content>


