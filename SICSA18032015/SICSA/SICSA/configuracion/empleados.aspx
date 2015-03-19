<%@ Page Title="Manteminiento Empleados" Language="C#" MasterPageFile="~/portal/Main.master" AutoEventWireup="true" CodeBehind="empleados.aspx.cs" Inherits="SICSA.configuracion.empleados" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header1" runat="server">
    <script type="text/javascript">
        function OnRowClick(e) {
            //Unselect all rows
            ASPxGridView1._selectAllRowsOnPage(false);
            //Select the row
            ASPxGridView1.SelectRow(e.visibleIndex, true);
        }
    </script>
    <style type="text/css">
        .auto-style1
        {
            height: 23px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="titulo">
        <h2>Manteminiento Empleados</h2>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="SELECT [CD_CARGO_INST], [DS_CARGO_INST] FROM [GLB_CARGOS_INSTITUCIONALES] ORDER BY [DS_CARGO_INST]"></asp:SqlDataSource>
    <dx:ASPxPageControl ID="ASPxPageEmpleados" runat="server" ActiveTabIndex="1" Width="100%">
        <TabPages>
            <dx:TabPage Text="Datos">
                <ContentCollection>
                    <dx:ContentControl runat="server">
                        <asp:SqlDataSource ID="SqlDataEmpleados" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="PRAL_DATA_EMPLEADOS" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataTitulos" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="SELECT [CD_TITULO], [DS_TITULO] FROM [GLB_TITULOS_ACADEMICOS] ORDER BY [DS_TITULO]"></asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataUnidades" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="SELECT [CD_UNIDAD], [DS_UNIDAD] FROM [GLB_UNIDADES_TEG] ORDER BY [DS_UNIDAD]"></asp:SqlDataSource>
                        <dx:ASPxButton ID="ASPxButtonNuevo" runat="server" Text="Agregar" OnClick="ASPxButtonNuevo_Click">
                        </dx:ASPxButton>
                        <dx:ASPxGridView ID="ASPxGridView1" ClientInstanceName="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataEmpleados" KeyFieldName="CD_EMPLEADO" Width="100%">
                            <Columns>
                                <dx:GridViewDataCheckColumn Name="Select" ShowInCustomizationForm="False" VisibleIndex="1" Caption=" ">
                                    <PropertiesCheckEdit DisplayFormatString="{0}" ValueChecked="1" ValueType="System.Int32" ValueUnchecked="0">
                                    </PropertiesCheckEdit>
                                    <DataItemTemplate>
                                        <dx:ASPxButton ID="btnSeleccionarEmp" runat="server" CommandArgument='<%# Eval("CD_EMPLEADO") %>' OnClick="btnSeleccionarEmp_Click" Text="" Image-Url="~/Content/Images/edit.png" />
                                    </DataItemTemplate>
                                </dx:GridViewDataCheckColumn>
                                <dx:GridViewDataTextColumn FieldName="CD_EMPLEADO" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="0">
                                    <EditFormSettings Visible="False" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="Nombre de Empleado" FieldName="DS_NOMBRE_EMPLEADO" ShowInCustomizationForm="True" VisibleIndex="3">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="Apellido" FieldName="DS_APELLIDO_EMPLEADO" ShowInCustomizationForm="True" VisibleIndex="4">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataCheckColumn Caption="Estado (S/N)" FieldName="CD_ESTADO" ShowInCustomizationForm="True" VisibleIndex="9" Width="30px">
                                </dx:GridViewDataCheckColumn>
                                <dx:GridViewDataTextColumn Caption="Correo" FieldName="DS_CORREO" ShowInCustomizationForm="True" VisibleIndex="8">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataComboBoxColumn Caption="Título" FieldName="CD_TITULO" ShowInCustomizationForm="True" VisibleIndex="2" Width="10%">
                                    <PropertiesComboBox DataSourceID="SqlDataTitulos" TextField="DS_TITULO" ValueField="CD_TITULO">
                                    </PropertiesComboBox>
                                </dx:GridViewDataComboBoxColumn>
                                <dx:GridViewDataComboBoxColumn Caption="Unidad" FieldName="CD_UNIDAD" ShowInCustomizationForm="True" VisibleIndex="5">
                                    <PropertiesComboBox DataSourceID="SqlDataUnidades" TextField="DS_UNIDAD" ValueField="CD_UNIDAD">
                                    </PropertiesComboBox>
                                </dx:GridViewDataComboBoxColumn>
                                <dx:GridViewDataComboBoxColumn Caption="Cargo" FieldName="CD_CARGO_INST" ShowInCustomizationForm="True" VisibleIndex="7">
                                    <PropertiesComboBox DataSourceID="SqlDataSource1" TextField="DS_CARGO_INST" ValueField="CD_CARGO_INST">
                                    </PropertiesComboBox>
                                </dx:GridViewDataComboBoxColumn>
                            </Columns>
                            <ClientSideEvents RowClick="function(s, e) { OnRowClick(e); }">
                            </ClientSideEvents>
                            <SettingsPager PageSize="8">
                            </SettingsPager>
                            <Settings ShowFilterRow="True" ShowGroupPanel="True" />
                            <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                        </dx:ASPxGridView>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage Text="Detalles">
                <ContentCollection>
                    <dx:ContentControl runat="server">
                        <table style="width:100%;">
                            <tr>
                                <td>Nombre:</td>
                                <td>
                                    <dx:ASPxTextBox ID="ASPxTextBox1" runat="server" Width="170px">
                                        <ValidationSettings CausesValidation="True" ErrorText="Requerido" SetFocusOnError="True">
                                            <RequiredField IsRequired="True" />
                                        </ValidationSettings>
                                        <ReadOnlyStyle BackColor="#FFFF99">
                                        </ReadOnlyStyle>
                                    </dx:ASPxTextBox>
                                </td>
                                <td>Apellido:</td>
                                <td>
                                    <dx:ASPxTextBox ID="ASPxTextBox2" runat="server" Width="170px">
                                    </dx:ASPxTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style1">Cargo:</td>
                                <td class="auto-style1">
                                    <dx:ASPxComboBox ID="ASPxComboBox1" runat="server" DataSourceID="SqlDataSource1" TextField="DS_CARGO_INST" ValueField="CD_CARGO_INST" ValueType="System.Int32" Width="80%">
                                    </dx:ASPxComboBox>
                                </td>
                                <td class="auto-style1">Estado:</td>
                                <td class="auto-style1">
                                    <dx:ASPxCheckBox ID="ASPxCheckBox1" runat="server" CheckState="Unchecked">
                                    </dx:ASPxCheckBox>
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
                                <td>
                                    <dx:ASPxButton ID="ASPxButton1" runat="server" OnClick="ASPxButton1_Click" Text="Aceptar">
                                    </dx:ASPxButton>
                                </td>
                                <td>
                                    <dx:ASPxButton ID="ASPxButton2" runat="server" CausesValidation="False" OnClick="ASPxButton2_Click" Text="Cancelar">
                                    </dx:ASPxButton>
                                </td>
                                <td>&nbsp;</td>
                            </tr>
                        </table>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
        </TabPages>
    </dx:ASPxPageControl>
    <dx:ASPxLabel ID="ASPxLabelAccion" runat="server" Text="" Visible="false">
    </dx:ASPxLabel>
    <dx:ASPxLabel ID="ASPxLabelCD" runat="server" Text="" Visible="false">
    </dx:ASPxLabel>
</asp:Content>
