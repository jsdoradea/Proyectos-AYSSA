<%@ Page Title="Cambio de contraseña" Language="C#" MasterPageFile="~/portal/Light.master" AutoEventWireup="true" CodeBehind="cambio_clave.aspx.cs" Inherits="SICSA.Account.cambio_calve" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div id="titulo">
        <h2>Cambio de contraseña</h2>
    </div>
    <br />
    <table style="width:100%;">
        <tr>
            <td>
                Nombre:
            </td>
            <td>
                <dx:ASPxTextBox ID="ASPxTextBoxNombre" runat="server" Width="170px" ReadOnly="True" ReadOnlyStyle-BackColor="#FFFF66"></dx:ASPxTextBox>
            </td>
            <td>Apellido:</td>
            <td>
            <dx:ASPxTextBox ID="ASPxTextBoxApellido" runat="server" Width="170px" ReadOnly="True" ReadOnlyStyle-BackColor="#FFFF66"></dx:ASPxTextBox></td>
        </tr>
        <tr>
            <td>Digite contraseña anterior:</td>
            <td>
            <dx:ASPxTextBox ID="ASPxTextBoxOldPass" runat="server" Width="170px" Password="True"></dx:ASPxTextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ASPxTextBoxOldPass" ErrorMessage="* Campo requerido" Font-Size="X-Small" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
            <td>Digite Nueva Contraseña:</td>
            <td>
            <dx:ASPxTextBox ID="ASPxTextBoxNewPass" runat="server" Width="170px" Password="True"></dx:ASPxTextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ASPxTextBoxNewPass" ErrorMessage="* Campo requerido" Font-Size="X-Small" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td colspan="4">&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td colspan="2" style="text-align:center;"><dx:ASPxButton ID="ASPxButtonAceptar" runat="server" Text="Aceptar" OnClick="ASPxButtonAceptar_Click"></dx:ASPxButton></td>
            <td>&nbsp;</td>
        </tr>
    </table>
</asp:Content>
