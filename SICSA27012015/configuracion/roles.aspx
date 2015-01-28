<%@ Page Title="" Language="C#" MasterPageFile="~/portal/Main.master" AutoEventWireup="true" CodeBehind="roles.aspx.cs" Inherits="SICSA.configuracion.roles" %>
<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="Content2" ContentPlaceHolderID="Header1" runat="server">
    <script type="text/javascript">
        function OnRowClick(e) {
            //Unselect all rows
            ASPxGridRoles._selectAllRowsOnPage(false);
            //Select the row
            ASPxGridRoles.SelectRow(e.visibleIndex, true);
        }
    </script>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div id="titulo">
        <h2>Roles y permisos</h2>
    </div>
    <asp:SqlDataSource ID="SqlDataRoles" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" InsertCommand="INSERT INTO dbo.CONF_ROL (rol, estado) VALUES (@rol, @estado)" SelectCommand="SELECT id_rol, rol, estado FROM dbo.CONF_ROL WHERE NOT(id_rol=1) ORDER BY rol" UpdateCommand="UPDATE dbo.CONF_ROL SET rol=@rol, estado=@estado WHERE id_rol=@id_rol">
        <InsertParameters>
            <asp:Parameter Name="rol" />
            <asp:Parameter Name="estado" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="rol" />
            <asp:Parameter Name="estado" />
            <asp:Parameter Name="id_rol" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataEstado" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="SELECT 0 AS Id, 'Inactivo' AS estado UNION SELECT 1 AS Id, 'Activo' AS estado"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataPermisos" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="  SELECT a.menu_id, c.DS_MODULO, a.nombre, b.estado, b.id_rol
  FROM dbo.CONF_MENU a 
	INNER JOIN dbo.CONF_PERMISO b ON b.menu_id = a.menu_id
	INNER JOIN dbo.CONF_MODULOS c ON c.CD_MODULO = a.n1
  where a.estado=1 and b.id_rol=@id_rol" UpdateCommand="  UPDATE dbo.CONF_PERMISO SET estado = @estado WHERE menu_id=@menu_id and id_rol=@id_rol">
        <SelectParameters>
            <asp:ControlParameter ControlID="ASPxLabelCdRol" Name="id_rol" PropertyName="Text" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="estado" />
            <asp:Parameter Name="menu_id" />
            <asp:Parameter Name="id_rol" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataPermisoEstado" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="  SELECT 0 as ID, 'Denegar' as estado UNION SELECT 1 as ID, 'Permitir' as estado "></asp:SqlDataSource>
    <br />
    <dx:ASPxPageControl ID="ASPxPageRoles" runat="server" ActiveTabIndex="0" Width="100%">
        <TabPages>
            <dx:TabPage Text="Roles">
                <ContentCollection>
                    <dx:ContentControl runat="server">
                        <dx:ASPxGridView ID="ASPxGridRoles" ClientInstanceName="ASPxGridRoles" runat="server" Width="100%" AutoGenerateColumns="False" DataSourceID="SqlDataRoles" KeyFieldName="id_rol">
                            <Columns>
                                <dx:GridViewCommandColumn ButtonType="Button" ShowEditButton="True" ShowInCustomizationForm="True" ShowNewButtonInHeader="True" VisibleIndex="0">
                                </dx:GridViewCommandColumn>
                                <dx:GridViewDataTextColumn FieldName="id_rol" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="1">
                                    <EditFormSettings Visible="False" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="Nombre de Rol" FieldName="rol" ShowInCustomizationForm="True" VisibleIndex="2">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataComboBoxColumn Caption="Estado" FieldName="estado" ShowInCustomizationForm="True" VisibleIndex="3">
                                    <PropertiesComboBox DataSourceID="SqlDataEstado" EnableFocusedStyle="False" TextField="estado" ValueField="Id">
                                    </PropertiesComboBox>
                                </dx:GridViewDataComboBoxColumn>
                                <dx:GridViewDataCheckColumn Name="Select" ShowInCustomizationForm="False" VisibleIndex="4" Caption=" ">
                                    <PropertiesCheckEdit DisplayFormatString="{0}" ValueChecked="1" ValueType="System.Int32" ValueUnchecked="0">
                                    </PropertiesCheckEdit>
                                    <EditFormSettings Visible="False" />
                                    <DataItemTemplate>
                                        <dx:ASPxButton ID="btnSeleccionar" runat="server" CommandArgument='<%# Eval("id_rol") %>' OnClick="btnSeleccionar_Click" Text="Asignar Permisos" />
                                    </DataItemTemplate>
                                </dx:GridViewDataCheckColumn>
                            </Columns>
                            <ClientSideEvents RowClick="function(s, e) { OnRowClick(e); }">
                            </ClientSideEvents>
                            <SettingsPager PageSize="7">
                            </SettingsPager>
                            <Settings ShowFilterRow="True" />
                            <SettingsDataSecurity AllowDelete="False" />
                            <SettingsSearchPanel ShowClearButton="True" />
                        </dx:ASPxGridView>
                        <br />
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage Text="Permisos">
                <ContentCollection>
                    <dx:ContentControl runat="server">
                        <table style="width:100%;">
                            <tr>
                                <td style="width: 200px">Asignar permisos a Rol:</td>
                                <td>
                                    <dx:ASPxLabel ID="ASPxLabelNomRol" runat="server" Font-Bold="True" Font-Size="Medium">
                                    </dx:ASPxLabel>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataPermisos" KeyFieldName="menu_id" Width="100%">
                                        <Columns>
                                            <dx:GridViewCommandColumn ButtonType="Button" ShowEditButton="True" ShowInCustomizationForm="True" VisibleIndex="0">
                                            </dx:GridViewCommandColumn>
                                            <dx:GridViewDataTextColumn FieldName="menu_id" ReadOnly="True" ShowInCustomizationForm="False" Visible="False" VisibleIndex="1">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Nombre de Módulo" FieldName="DS_MODULO" ShowInCustomizationForm="False" VisibleIndex="2">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Nombre de Opción" FieldName="nombre" ShowInCustomizationForm="False" VisibleIndex="3">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn FieldName="id_rol" ShowInCustomizationForm="False" Visible="False" VisibleIndex="5">
                                                <EditFormSettings Visible="False" />
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataCheckColumn Caption="Permitir" FieldName="estado" ShowInCustomizationForm="True" VisibleIndex="4">
                                                <EditFormSettings Visible="True" />
                                            </dx:GridViewDataCheckColumn>
                                        </Columns>
                                        <SettingsDataSecurity AllowDelete="False" AllowInsert="False" />
                                    </dx:ASPxGridView>
                                </td>
                            </tr>
                        </table>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
        </TabPages>
    </dx:ASPxPageControl>
    <dx:ASPxLabel ID="ASPxLabelCdRol" runat="server" Visible="False">
    </dx:ASPxLabel>
</asp:Content>
