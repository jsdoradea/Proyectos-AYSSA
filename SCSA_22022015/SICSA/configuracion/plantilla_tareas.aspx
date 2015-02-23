<%@ Page Title="" Language="C#" MasterPageFile="~/portal/Main.master" AutoEventWireup="true" CodeBehind="plantilla_tareas.aspx.cs" Inherits="SICSA.configuracion.plantilla_tareas" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header1" runat="server">
    <script type="text/javascript">
        function OnRowClick(e) {
            //Unselect all rows
            ASPxGridPlantilla._selectAllRowsOnPage(false);
            //Select the row
            ASPxGridPlantilla.SelectRow(e.visibleIndex, true);
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="titulo">
        <h2>Plantillas de Tareas</h2>
    </div>
    <dx:ASPxPageControl ID="ASPxPageTareas" runat="server" ActiveTabIndex="1" Width="100%">
        <TabPages>
            <dx:TabPage Text="Plantillas">
                <ContentCollection>
                    <dx:ContentControl runat="server">
                        <asp:SqlDataSource ID="SqlDataPlantillas" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" InsertCommand="INSERT INTO dbo.EJE_PLANTILLA_TAREAS (DS_PLANTILLA, DS_DESC_PLANTILLA, ESTADO_PLANTILLA) VALUES (@DS_PLANTILLA, @DS_DESC_PLANTILLA, @ESTADO_PLANTILLA)" SelectCommand="SELECT CD_PLANTILLA, DS_PLANTILLA, DS_DESC_PLANTILLA, ESTADO_PLANTILLA FROM dbo.EJE_PLANTILLA_TAREAS ORDER BY DS_PLANTILLA" UpdateCommand="UPDATE dbo.EJE_PLANTILLA_TAREAS SET DS_PLANTILLA = @DS_PLANTILLA, DS_DESC_PLANTILLA = @DS_DESC_PLANTILLA, ESTADO_PLANTILLA = @ESTADO_PLANTILLA WHERE CD_PLANTILLA = @CD_PLANTILLA">
                            <InsertParameters>
                                <asp:Parameter Name="DS_PLANTILLA" />
                                <asp:Parameter Name="DS_DESC_PLANTILLA" />
                                <asp:Parameter Name="ESTADO_PLANTILLA" />
                            </InsertParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="DS_PLANTILLA" />
                                <asp:Parameter Name="DS_DESC_PLANTILLA" />
                                <asp:Parameter Name="ESTADO_PLANTILLA" />
                                <asp:Parameter Name="CD_PLANTILLA" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                        <dx:ASPxGridView ID="ASPxGridPlantilla" ClientInstanceName="ASPxGridPlantilla" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataPlantillas" KeyFieldName="CD_PLANTILLA" Width="100%">
                            <Columns>
                                <dx:GridViewCommandColumn ButtonType="Button" ShowEditButton="True" ShowInCustomizationForm="True" ShowNewButtonInHeader="True" VisibleIndex="0" ShowClearFilterButton="True">
                                </dx:GridViewCommandColumn>
                                <dx:GridViewDataTextColumn FieldName="CD_PLANTILLA" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="1">
                                    <EditFormSettings Visible="False" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="Nombre de Plantilla" FieldName="DS_PLANTILLA" ShowInCustomizationForm="True" VisibleIndex="2" Width="350px">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="Descripción" FieldName="DS_DESC_PLANTILLA" ShowInCustomizationForm="True" VisibleIndex="3">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataCheckColumn Caption="Estado" FieldName="ESTADO_PLANTILLA" ShowInCustomizationForm="True" VisibleIndex="4" Width="30px">
                                </dx:GridViewDataCheckColumn>
                                <dx:GridViewDataCheckColumn Name="Select" ShowInCustomizationForm="False" VisibleIndex="5" Caption=" ">
                                    <PropertiesCheckEdit DisplayFormatString="{0}" ValueChecked="1" ValueType="System.Int32" ValueUnchecked="0">
                                    </PropertiesCheckEdit>
                                    <EditFormSettings Visible="False" />
                                    <DataItemTemplate>
                                        <dx:ASPxButton ID="btnSeleccionar" runat="server" CommandArgument='<%# Eval("CD_PLANTILLA") %>' OnClick="btnSeleccionar_Click" Text="Tareas" />
                                    </DataItemTemplate>
                                </dx:GridViewDataCheckColumn>
                            </Columns>
                            <ClientSideEvents RowClick="function(s, e) { OnRowClick(e); }">
                            </ClientSideEvents>
                            <SettingsPager PageSize="7">
                            </SettingsPager>
                            <Settings ShowFilterRow="True" />
                        </dx:ASPxGridView>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage Text="Tareas">
                <ContentCollection>
                    <dx:ContentControl runat="server">
                        <asp:SqlDataSource ID="SqlDataTareas" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" InsertCommand="INSERT INTO dbo.EJE_DETA_PLANTILLA 
(CD_PLANTILLA, NM_TAREA, DS_TAREA, DS_DESC_TAREA, CD_RESPONSABLE, CD_PREDECESORA, DIAS_EJEC, ESTADO_TAREA)
VALUES (@CD_PLANTILLA, @NM_TAREA, @DS_TAREA, @DS_DESC_TAREA, @CD_RESPONSABLE, @CD_PREDECESORA, @DIAS_EJEC, @ESTADO_TAREA)" SelectCommand="SELECT CD_EJE_DETA_PLANTILLA, CD_PLANTILLA, NM_TAREA, DS_TAREA, DS_DESC_TAREA, CD_RESPONSABLE, CD_PREDECESORA, DIAS_EJEC, ESTADO_TAREA
FROM dbo.EJE_DETA_PLANTILLA WHERE CD_PLANTILLA =  @CD_PLANTILLA  ORDER BY NM_TAREA
" UpdateCommand="UPDATE dbo.EJE_DETA_PLANTILLA 
SET CD_PLANTILLA = @CD_PLANTILLA, NM_TAREA=@NM_TAREA, DS_TAREA=@DS_TAREA, DS_DESC_TAREA=@DS_DESC_TAREA, CD_RESPONSABLE=@CD_RESPONSABLE, CD_PREDECESORA=@CD_PREDECESORA, DIAS_EJEC=@DIAS_EJEC, ESTADO_TAREA=@ESTADO_TAREA
WHERE CD_EJE_DETA_PLANTILLA = @CD_EJE_DETA_PLANTILLA">
                            <InsertParameters>
                                <asp:Parameter Name="CD_PLANTILLA" />
                                <asp:Parameter Name="NM_TAREA" />
                                <asp:Parameter Name="DS_TAREA" />
                                <asp:Parameter Name="DS_DESC_TAREA" />
                                <asp:Parameter Name="CD_RESPONSABLE" />
                                <asp:Parameter Name="CD_PREDECESORA" />
                                <asp:Parameter Name="DIAS_EJEC" />
                                <asp:Parameter Name="ESTADO_TAREA" />
                            </InsertParameters>
                            <SelectParameters>
                                <asp:ControlParameter ControlID="ASPxLabelCDPlantilla" Name="CD_PLANTILLA" PropertyName="Text" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="CD_PLANTILLA" />
                                <asp:Parameter Name="NM_TAREA" />
                                <asp:Parameter Name="DS_TAREA" />
                                <asp:Parameter Name="DS_DESC_TAREA" />
                                <asp:Parameter Name="CD_RESPONSABLE" />
                                <asp:Parameter Name="CD_PREDECESORA" />
                                <asp:Parameter Name="DIAS_EJEC" />
                                <asp:Parameter Name="ESTADO_TAREA" />
                                <asp:Parameter Name="CD_EJE_DETA_PLANTILLA" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="SELECT CD_EMPLEADO, DS_NOMBRE_EMPLEADO + ' ' + DS_APELLIDO_EMPLEADO AS EMPLEADO FROM dbo.GLB_EMPLEADOS WHERE CD_ESTADO=1 ORDER BY CD_UNIDAD, DS_NOMBRE_EMPLEADO, DS_APELLIDO_EMPLEADO"></asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="SELECT CD_PLANTILLA, DS_PLANTILLA FROM dbo.EJE_PLANTILLA_TAREAS WHERE CD_PLANTILLA = @CD_PLANTILLA  ORDER BY DS_PLANTILLA">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="ASPxLabelCDPlantilla" Name="CD_PLANTILLA" PropertyName="Text" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        |<dx:ASPxGridView ID="ASPxGridTareas" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataTareas" KeyFieldName="CD_EJE_DETA_PLANTILLA" Width="100%">
                            <Columns>
                                <dx:GridViewCommandColumn ButtonType="Button" ShowClearFilterButton="True" ShowEditButton="True" ShowInCustomizationForm="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                                </dx:GridViewCommandColumn>
                                <dx:GridViewDataTextColumn Caption="Tarea" FieldName="DS_TAREA" ShowInCustomizationForm="True" VisibleIndex="4" Width="250px">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="Descripción" FieldName="DS_DESC_TAREA" ShowInCustomizationForm="True" VisibleIndex="5">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataCheckColumn Caption="Estado" FieldName="ESTADO_TAREA" ShowInCustomizationForm="True" VisibleIndex="9" Width="15px">
                                </dx:GridViewDataCheckColumn>
                                <dx:GridViewDataComboBoxColumn Caption="Responsable" FieldName="CD_RESPONSABLE" ShowInCustomizationForm="True" VisibleIndex="6">
                                    <PropertiesComboBox DataSourceID="SqlDataSource1" TextField="EMPLEADO" ValueField="CD_EMPLEADO">
                                    </PropertiesComboBox>
                                </dx:GridViewDataComboBoxColumn>
                                <dx:GridViewDataSpinEditColumn Caption="N°" FieldName="NM_TAREA" ShowInCustomizationForm="True" VisibleIndex="3" Width="30px">
                                    <PropertiesSpinEdit DisplayFormatString="g" MaxValue="500" NumberType="Integer">
                                    </PropertiesSpinEdit>
                                </dx:GridViewDataSpinEditColumn>
                                <dx:GridViewDataSpinEditColumn Caption="Predecesora" FieldName="CD_PREDECESORA" ShowInCustomizationForm="True" VisibleIndex="7" Width="30px">
                                    <PropertiesSpinEdit DisplayFormatString="g" MaxValue="500" NumberType="Integer">
                                    </PropertiesSpinEdit>
                                </dx:GridViewDataSpinEditColumn>
                                <dx:GridViewDataSpinEditColumn Caption="Días Ejecución" FieldName="DIAS_EJEC" ShowInCustomizationForm="True" VisibleIndex="8" Width="30px">
                                    <PropertiesSpinEdit DisplayFormatString="g" MaxValue="500" NumberType="Integer">
                                    </PropertiesSpinEdit>
                                </dx:GridViewDataSpinEditColumn>
                                <dx:GridViewDataTextColumn FieldName="CD_EJE_DETA_PLANTILLA" ShowInCustomizationForm="True" Visible="False" VisibleIndex="1">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataComboBoxColumn Caption="Plantilla" FieldName="CD_PLANTILLA" ShowInCustomizationForm="True" VisibleIndex="2">
                                    <PropertiesComboBox DataSourceID="SqlDataSource2" TextField="DS_PLANTILLA" ValueField="CD_PLANTILLA">
                                    </PropertiesComboBox>
                                </dx:GridViewDataComboBoxColumn>
                            </Columns>
                            <Settings ShowFilterRow="True" />
                            <SettingsDataSecurity AllowDelete="False" />
                        </dx:ASPxGridView>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
        </TabPages>
    </dx:ASPxPageControl>
    <dx:ASPxLabel ID="ASPxLabelCDPlantilla" runat="server" Text="" Visible="false">
    </dx:ASPxLabel>
</asp:Content>
