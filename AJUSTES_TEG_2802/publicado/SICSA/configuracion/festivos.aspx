<%@ Page Title="Dias Festivos" Language="C#" MasterPageFile="~/portal/Main.master" AutoEventWireup="true" CodeBehind="festivos.aspx.cs" Inherits="SICSA.configuracion.festivos" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>


<asp:Content ID="Content1" ContentPlaceHolderID="Header1" runat="server">
    <script type="text/javascript">
        function OnRowClick(e) {
            //Unselect all rows
            ASPxGridCalendario._selectAllRowsOnPage(false);
            //Select the row
            ASPxGridCalendario.SelectRow(e.visibleIndex, true);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="titulo">
        <h2>Parametrización de Ley de Asuetos, Vacaciones y Licencias de los Empleados Públicos</h2>
    </div>
    <dx:ASPxPageControl ID="ASPxPageFestivos" runat="server" ActiveTabIndex="0" Width="100%">
        <TabPages>
            <dx:TabPage Text="Periodos">
                <ContentCollection>
                    <dx:ContentControl runat="server">
                        <dx:ASPxLabel ID="ASPxLabeUsr" runat="server" Visible="False">
                        </dx:ASPxLabel>
                        <dx:ASPxLabel ID="ASPxLabelFecha" runat="server" Visible="False">
                        </dx:ASPxLabel>
                        <asp:SqlDataSource ID="SqlDataCalendarios" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" InsertCommand="Iniciar_Calendario_sp" SelectCommand="  SELECT CD_CALENDARIO, CD_ANIO, DS_NOMBRE_CALENDARIO, ESTADO_CALENDARIO FROM dbo.GLB_CALENDARIO_PERIODOS WHERE ESTADO_CALENDARIO=1" UpdateCommand="UPDATE dbo.GLB_CALENDARIO_PERIODOS SET DS_NOMBRE_CALENDARIO=@DS_NOMBRE_CALENDARIO, DS_DESC_CALENDARIO= @DS_DESC_CALENDARIO, ESTADO_CALENDARIO=@ESTADO_CALENDARIO WHERE CD_CALENDARIO=@CD_CALENDARIO" InsertCommandType="StoredProcedure">
                            <InsertParameters>
                                <asp:Parameter Name="CD_ANIO" />
                                <asp:Parameter Name="DS_NOMBRE_CALENDARIO" />
                                <asp:Parameter Name="DS_DESC_CALENDARIO" />
                                <asp:Parameter Name="ESTADO_CALENDARIO" />
                            </InsertParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="DS_NOMBRE_CALENDARIO" />
                                <asp:Parameter Name="DS_DESC_CALENDARIO" />
                                <asp:Parameter Name="ESTADO_CALENDARIO" />
                                <asp:Parameter Name="CD_CALENDARIO" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                        <dx:ASPxGridView ID="ASPxGridCalendario" ClientInstanceName="ASPxGridCalendario" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataCalendarios" KeyFieldName="CD_CALENDARIO" Width="1005px">
                            <Columns>
                                <dx:GridViewCommandColumn ButtonType="Button" ShowEditButton="True" ShowInCustomizationForm="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                                </dx:GridViewCommandColumn>
                                <dx:GridViewDataTextColumn FieldName="CD_CALENDARIO" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="1">
                                    <EditFormSettings Visible="False" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="Descripción" FieldName="DS_NOMBRE_CALENDARIO" ShowInCustomizationForm="True" VisibleIndex="3">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataCheckColumn Caption="Estado" FieldName="ESTADO_CALENDARIO" ShowInCustomizationForm="True" VisibleIndex="4" Width="100px">
                                </dx:GridViewDataCheckColumn>
                                <dx:GridViewDataSpinEditColumn Caption="Año" FieldName="CD_ANIO" ShowInCustomizationForm="True" VisibleIndex="2" Width="150px">
                                    <PropertiesSpinEdit DisplayFormatString="g" MinValue="2014" NumberType="Integer" MaxValue="3000">
                                    </PropertiesSpinEdit>
                                </dx:GridViewDataSpinEditColumn>
                                <dx:GridViewDataCheckColumn Name="Select" ShowInCustomizationForm="False" VisibleIndex="5" Caption=" " Width="100px">
                                    <PropertiesCheckEdit DisplayFormatString="{0}" ValueChecked="1" ValueType="System.Int32" ValueUnchecked="0">
                                    </PropertiesCheckEdit>
                                    <EditFormSettings Visible="False" />
                                    <DataItemTemplate>
                                        <dx:ASPxButton ID="btnSeleccionar" runat="server" CommandArgument='<%# Eval("CD_CALENDARIO") %>' OnClick="btnSeleccionar_Click" Text="Festivos" />
                                    </DataItemTemplate>
                                </dx:GridViewDataCheckColumn>
                            </Columns>
                            <ClientSideEvents RowClick="function(s, e) { OnRowClick(e); }">
                            </ClientSideEvents>
                            <SettingsPager PageSize="7">
                            </SettingsPager>
                            <SettingsDataSecurity AllowDelete="False" />
                        </dx:ASPxGridView>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage Text="Festivos">
                <ContentCollection>
                    <dx:ContentControl runat="server">
                        <asp:SqlDataSource ID="SqlDataFestivos" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" InsertCommand="INSERT INTO dbo.GLB_CALENDARIO (FE_FECHA_ANIO, DS_JUSTIF_FERIADO, CD_ESTADO) VALUES (@FE_FECHA_ANIO, @DS_JUSTIF_FERIADO, @CD_ESTADO)" SelectCommand="SELECT CD_DIA_CALENDARIO
      ,FE_FECHA_ANIO
      ,CD_ESTADO
      ,DS_JUSTIF_FERIADO
  FROM GLB_CALENDARIO
  WHERE YEAR(FE_FECHA_ANIO) = @CD_ANIO  ORDER BY FE_FECHA_ANIO DESC" UpdateCommand="UPDATE dbo.GLB_CALENDARIO SET FE_FECHA_ANIO = @FE_FECHA_ANIO, DS_JUSTIF_FERIADO = @DS_JUSTIF_FERIADO, CD_ESTADO=@CD_ESTADO WHERE CD_DIA_CALENDARIO = @CD_DIA_CALENDARIO">
                            <InsertParameters>
                                <asp:Parameter Name="FE_FECHA_ANIO" />
                                <asp:Parameter Name="DS_JUSTIF_FERIADO" />
                                <asp:Parameter Name="CD_ESTADO" />
                            </InsertParameters>
                            <SelectParameters>
                                <asp:ControlParameter ControlID="ASPxLabelPeriodo" Name="CD_ANIO" PropertyName="Text" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="FE_FECHA_ANIO" />
                                <asp:Parameter Name="DS_JUSTIF_FERIADO" />
                                <asp:Parameter Name="CD_ESTADO" />
                                <asp:Parameter Name="CD_DIA_CALENDARIO" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                        <dx:ASPxGridView ID="ASPxGridFestivos" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataFestivos" KeyFieldName="CD_DIA_CALENDARIO" Width="100%">
                            <Columns>
                                <dx:GridViewCommandColumn ButtonType="Button" ShowClearFilterButton="True" ShowEditButton="True" ShowInCustomizationForm="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                                </dx:GridViewCommandColumn>
                                <dx:GridViewDataTextColumn FieldName="CD_DIA_CALENDARIO" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="1">
                                    <EditFormSettings Visible="False" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataDateColumn Caption="Fecha de evento" FieldName="FE_FECHA_ANIO" ShowInCustomizationForm="True" VisibleIndex="2" Width="150px">
                                    <PropertiesDateEdit DisplayFormatString="dd-MM-yyyy">
                                    </PropertiesDateEdit>
                                </dx:GridViewDataDateColumn>
                                <dx:GridViewDataCheckColumn Caption="Estado" FieldName="CD_ESTADO" ShowInCustomizationForm="True" VisibleIndex="4" Width="100px">
                                </dx:GridViewDataCheckColumn>
                                <dx:GridViewDataTextColumn Caption="Decripción del evento" FieldName="DS_JUSTIF_FERIADO" ShowInCustomizationForm="True" VisibleIndex="3">
                                </dx:GridViewDataTextColumn>
                            </Columns>
                            <SettingsPager PageSize="7">
                            </SettingsPager>
                            <Settings ShowFilterRow="True" />
                            <SettingsDataSecurity AllowDelete="False" />
                        </dx:ASPxGridView>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
        </TabPages>
    </dx:ASPxPageControl>
    <dx:ASPxLabel ID="ASPxLabelPeriodo" runat="server" Text="" Visible="false">
    </dx:ASPxLabel>
</asp:Content>
