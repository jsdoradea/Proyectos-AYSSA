<%@ Page Title="Usuarios" Language="C#" MasterPageFile="~/portal/Main.master" AutoEventWireup="true" CodeBehind="usuarios.aspx.cs" Inherits="SICSA.configuracion.usuarios" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Header1" runat="server">
    <script type="text/javascript">
        function OnRowClick(e) {
            //Unselect all rows
            ASPxGridUsuarios._selectAllRowsOnPage(false);
            //Select the row
            ASPxGridUsuarios.SelectRow(e.visibleIndex, true);
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="titulo">
        <h2>Usuarios del sistema</h2>
    </div>
    <asp:SqlDataSource ID="SqlDataUsuarios" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="SELECT a.id_usuario, a.usuario, a.nombre, a.apellido, a.foto, a.fecha_crea, b.rol, d. DS_UNIDAD, e.DS_CARGO_INST, CASE WHEN (a.estado=1) THEN 'Activo' ELSE 'Inactivo' END AS estado
FROM CONF_USUARIO a
	INNER JOIN dbo.CONF_ROL b ON b.id_rol = a.id_rol
	INNER JOIN dbo.GLB_EMPLEADOS c ON c.CD_EMPLEADO = a.CD_EMPLEADO
	INNER JOIN dbo.GLB_UNIDADES_TEG d ON d.CD_UNIDAD = c.CD_UNIDAD
	INNER JOIN dbo.GLB_CARGOS_INSTITUCIONALES e ON e.CD_CARGO_INST = c.CD_CARGO_INST
ORDER BY a.nombre, a.apellido"></asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="  SELECT a.CD_EMPLEADO, a.DS_NOMBRE_EMPLEADO + &#39; &#39; + a.DS_APELLIDO_EMPLEADO as EMPLEADO, b.DS_UNIDAD
  from dbo.GLB_EMPLEADOS a
  INNER JOIN dbo.GLB_UNIDADES_TEG b ON b.CD_UNIDAD = a.CD_UNIDAD
  WHERE a.CD_ESTADO=1
ORDER BY b.DS_UNIDAD,  a.DS_NOMBRE_EMPLEADO, a.DS_APELLIDO_EMPLEADO" ID="SqlDataEmpleados"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataRoles" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="SELECT * FROM dbo.CONF_ROL WHERE 
estado = 1 ORDER BY rol"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataGenero" runat="server" ConnectionString="<%$ ConnectionStrings:SICSA %>" SelectCommand="  SELECT CD_GENERO, DS_GENERO FROM dbo.CONF_GENERO ORDER BY CD_GENERO"></asp:SqlDataSource>
    <dx:ASPxPageControl ID="ASPxPageUsuarios" runat="server" ActiveTabIndex="1" Width="100%">
        <TabPages>
            <dx:TabPage Text="Datos">
                <ContentCollection>
                    <dx:ContentControl runat="server">
                        <dx:ASPxButton ID="ASPxButtonNuevo" runat="server" Text="Nuevo Usuario" OnClick="ASPxButtonNuevo_Click">
                        </dx:ASPxButton>
                        <br />
                        <dx:ASPxGridView ID="ASPxGridUsuarios" runat="server" ClientInstanceName="ASPxGridUsuarios" AutoGenerateColumns="False" DataSourceID="SqlDataUsuarios" KeyFieldName="id_usuario" Width="100%">
                            <Columns>
                                <dx:GridViewDataTextColumn FieldName="id_usuario" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="0">
                                    <EditFormSettings Visible="False" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataCheckColumn Name="Select" ShowInCustomizationForm="False" VisibleIndex="1" Caption=" ">
                                    <PropertiesCheckEdit DisplayFormatString="{0}" ValueChecked="1" ValueType="System.Int32" ValueUnchecked="0">
                                    </PropertiesCheckEdit>
                                    <DataItemTemplate>
                                        <dx:ASPxButton ID="btnSeleccionar" runat="server" CommandArgument='<%# Eval("id_usuario") %>' OnClick="btnSeleccionar_Click" Text="" Image-Url="~/Content/Images/edit.png" />
                                    </DataItemTemplate>
                                </dx:GridViewDataCheckColumn>
                                <dx:GridViewDataImageColumn Caption="Foto" FieldName="foto" ShowInCustomizationForm="True" VisibleIndex="2">
                                    <PropertiesImage ImageHeight="35px" ImageWidth="35px">
                                        <Style HorizontalAlign="Center" VerticalAlign="Top">
                                        </Style>
                                    </PropertiesImage>
                                </dx:GridViewDataImageColumn>
                                <dx:GridViewDataTextColumn Caption="Usuario" FieldName="usuario" ShowInCustomizationForm="True" VisibleIndex="3">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="Nombre" FieldName="nombre" ShowInCustomizationForm="True" VisibleIndex="4">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="Apellido" FieldName="apellido" ShowInCustomizationForm="True" VisibleIndex="5">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataDateColumn Caption="Fecha de Ingreso" FieldName="fecha_crea" ShowInCustomizationForm="True" VisibleIndex="6">
                                </dx:GridViewDataDateColumn>
                                <dx:GridViewDataTextColumn Caption="Rol" FieldName="rol" ShowInCustomizationForm="True" VisibleIndex="7">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="Unidad" FieldName="DS_UNIDAD" ShowInCustomizationForm="True" VisibleIndex="8">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="Cargo Institucional" FieldName="DS_CARGO_INST" ShowInCustomizationForm="True" VisibleIndex="9">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="Estado" FieldName="estado" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="10">
                                </dx:GridViewDataTextColumn>
                            </Columns>
                            <ClientSideEvents RowClick="function(s, e) { OnRowClick(e); }">
                            </ClientSideEvents>
                            <SettingsBehavior AllowSelectSingleRowOnly="True" />
                            <SettingsPager PageSize="7">
                            </SettingsPager>
                            <Settings ShowGroupPanel="True" />
                        </dx:ASPxGridView>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage Text="Detalles">
                <ContentCollection>
                    <dx:ContentControl runat="server">
                        <table style="width:100%;">
                            <tr>
                                <td colspan="4">Usuarios del Sistema</td>
                            </tr>
                            <tr>
                                <td style="width: 25%;">&nbsp;</td>
                                <td style="width: 25%;">&nbsp;</td>
                                <td style="width: 25%;">&nbsp;</td>
                                <td style="width: 25%;">&nbsp;</td>
                            </tr>
                            <tr>
                                <td>Empleado:</td>
                                <td colspan="3">
                                    <dx:ASPxComboBox ID="ASPxComboEmpleados" runat="server" DataSourceID="SqlDataEmpleados" ValueField="CD_EMPLEADO" Width="50%" AutoPostBack="True" OnSelectedIndexChanged="ASPxComboEmpleados_SelectedIndexChanged">
                                        <Columns>
                                            <dx:ListBoxColumn Caption="CD_EMPLEADO" FieldName="CD_EMPLEADO" Name="CD_EMPLEADO" Visible="False" />
                                            <dx:ListBoxColumn Caption="Empleado" FieldName="EMPLEADO" />
                                            <dx:ListBoxColumn Caption="Unidad" FieldName="DS_UNIDAD" />
                                        </Columns>
                                    </dx:ASPxComboBox>
                                    &nbsp;&nbsp;&nbsp;
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ASPxComboEmpleados" ErrorMessage="*" Font-Size="XX-Small" ForeColor="Red"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>Nombre:</td>
                                <td>
                                    <dx:ASPxTextBox ID="ASPxTextNombre" runat="server" Width="95%" ReadOnly="True">
                                    </dx:ASPxTextBox>
                                </td>
                                <td>Apellido:</td>
                                <td>
                                    <dx:ASPxTextBox ID="ASPxTextApellido" runat="server" Width="95%" ReadOnly="True">
                                    </dx:ASPxTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Unidad:</td>
                                <td>
                                    <dx:ASPxTextBox ID="ASPxTextUnidad" runat="server" Width="95%" ReadOnly="True">
                                    </dx:ASPxTextBox>
                                </td>
                                <td>Cargo:</td>
                                <td>
                                    <dx:ASPxTextBox ID="ASPxTextCargo" runat="server" Width="95%" ReadOnly="True">
                                    </dx:ASPxTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Genero:</td>
                                <td>
                                    <dx:ASPxRadioButtonList ID="ASPxRadioGenero" runat="server" RepeatDirection="Horizontal" SelectedIndex="0" DataSourceID="SqlDataGenero" TextField="DS_GENERO" ValueField="CD_GENERO" ValueType="System.Int32">
                                    </dx:ASPxRadioButtonList>
                                </td>
                                <td>Estado:</td>
                                <td>
                                    <dx:ASPxRadioButtonList ID="ASPxRadioEstado" runat="server" RepeatDirection="Horizontal" SelectedIndex="0" ValueType="System.Int32">
                                        <Items>
                                            <dx:ListEditItem Selected="True" Text="Activo" Value="1" />
                                            <dx:ListEditItem Text="Inactivo" Value="0" />
                                        </Items>
                                    </dx:ASPxRadioButtonList>
                                </td>
                            </tr>
                            <tr>
                                <td>Correo Electrónico:</td>
                                <td colspan="3">
                                    <asp:TextBox ID="TextBoxCorreo" runat="server" TextMode="Email" Width="400px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Foto:</td>
                                <td>
                                    <asp:FileUpload ID="FileUpload1" runat="server" Width="95%" Enabled="False" />
                                </td>
                                <td>
                                    <dx:ASPxCheckBox ID="ASPxCheckBoxAvatar" runat="server" Checked="True" CheckState="Checked" Text="Usar Avatar" AutoPostBack="True" OnCheckedChanged="ASPxCheckBoxAvatar_CheckedChanged" style="height: 21px">
                                    </dx:ASPxCheckBox>
                                </td>
                                <td>
                                    <dx:ASPxImage ID="ASPxImage1" runat="server" Height="30px" ShowLoadingImage="True" Width="30px" ImageUrl="~/Content/Images/fotos/avatar.png">
                                    </dx:ASPxImage>
                                </td>
                            </tr>
                            <tr>
                                <td>Usuario:</td>
                                <td>
                                    <dx:ASPxTextBox ID="ASPxTextUsuario" runat="server" Width="95%">
                                    </dx:ASPxTextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ASPxTextUsuario" ErrorMessage="*" Font-Size="XX-Small" ForeColor="Red"></asp:RequiredFieldValidator>
                                    &nbsp;</td>
                                <td>Contraseña:</td>
                                <td>
                                    <dx:ASPxTextBox ID="ASPxTextPass" runat="server" Password="True" Width="95%">
                                    </dx:ASPxTextBox>
                                    &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ASPxTextPass" ErrorMessage="*" Font-Size="XX-Small" ForeColor="Red"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>Rol:</td>
                                <td>
                                    <dx:ASPxComboBox ID="ASPxComboRoles" runat="server" DataSourceID="SqlDataRoles" TextField="rol" ValueField="id_rol" ValueType="System.Int32">
                                    </dx:ASPxComboBox>
                                </td>
                                <td>&nbsp;</td>
                                <td>
                                    <dx:ASPxCheckBox ID="ASPxCheckBox1" runat="server" CheckState="Checked" Text="Exigir cambio de contraseña" Checked="True">
                                    </dx:ASPxCheckBox>
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td style="text-align: right">
                                    <dx:ASPxButton ID="ASPxButtonGuardar" runat="server" Text="Guardar" OnClick="ASPxButtonGuardar_Click">
                                    </dx:ASPxButton>
                                    &nbsp;&nbsp;&nbsp; </td>
                                <td>&nbsp;
                                    <dx:ASPxButton ID="ASPxButtonCancelar" runat="server" CausesValidation="False" OnClick="ASPxButtonCancelar_Click" Text="Cancelar">
                                    </dx:ASPxButton>
                                </td>
                                <td>
                                    <dx:ASPxLabel ID="ASPxLabelAccion" runat="server" Visible="False">
                                    </dx:ASPxLabel>
                                    <dx:ASPxLabel ID="ASPxLabelIDUSR" runat="server" Visible="False">
                                    </dx:ASPxLabel>
                                </td>
                            </tr>
                        </table>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
        </TabPages>
    </dx:ASPxPageControl>
</asp:Content>
