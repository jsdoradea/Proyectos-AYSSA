<%@ Page Title="Ejecución de acuerdos" Language="C#" MasterPageFile="~/portal/Main.master" AutoEventWireup="true" CodeFile="ejecucion.aspx.cs" Inherits="ejecucion_ejecucion" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v14.1, Version=14.1.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <div id="titulo" style="vertical-align: top; background-color: #003da5; width: 100%">
        <h2 style="font-family: Verdana, Geneva, Tahoma, sans-serif; font-size: medium; color: #FFFFFF">Plan de Ejecución de Acuerdo</h2>
    </div>
    <br />
    <table style="width:100%;">
        <tr>
            <td>Sesión:</td>
            <td><dx:ASPxTextBox ID="ASPxTextBox1" runat="server" Width="170px" Text="35-2014"></dx:ASPxTextBox></td>
            <td>Acta:</td>
            <td><dx:ASPxTextBox ID="ASPxTextBox2" runat="server" Width="170px" Text="6-2014"></dx:ASPxTextBox></td>
            <td>Acuerdo No.:</td>
            <td><dx:ASPxTextBox ID="ASPxTextBox3" runat="server" Width="170px" Text="8-TEG-2014"></dx:ASPxTextBox></td>
            <td>Días Ejec. Establecidos:</td>
            <td><dx:ASPxTextBox ID="ASPxTextBox4" runat="server" Width="170px" Text="10"></dx:ASPxTextBox></td>
        </tr>
        <tr>
            <td colspan="8">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="8"><dx:ASPxGridView ID="ASPxGridView1" runat="server" Theme="DevEx" Width="100%"></dx:ASPxGridView></td>
        </tr>
        <tr>
            <td colspan="8">&nbsp;</td>
        </tr>
        <tr>
            <td>Descripción:</td>
            <td colspan="7"><asp:TextBox ID="TextBox1" Width="80%" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
            <td>Detalles:</td>
            <td colspan="7"><dx:ASPxMemo ID="ASPxMemo1" runat="server" Height="71px" Width="80%" Rows="3"></dx:ASPxMemo></td>
        </tr>
        <tr>
            <td>Responsable:</td>
            <td colspan="3"><asp:DropDownList ID="DropDownList1" runat="server">
                <asp:ListItem Value="1">Salvador Quintanilla</asp:ListItem>
                </asp:DropDownList></td>
            <td>Días Ejecución:</td>
            <td colspan="3"><dx:ASPxSpinEdit ID="ASPxSpinEdit1" runat="server" Number="0" Theme="Glass">
            </dx:ASPxSpinEdit></td>
        </tr>
        <tr>
            <td colspan="8">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="2">&nbsp;</td>
            <td colspan="2">&nbsp;</td>
            <td colspan="2">&nbsp;</td>
            <td colspan="2"><dx:ASPxButton ID="ASPxButton1" runat="server" Text="Nuevo"></dx:ASPxButton>&nbsp;&nbsp;
            <dx:ASPxButton ID="ASPxButton2" runat="server" Text="Cancelar"></dx:ASPxButton></td>
        </tr>
    </table>
</asp:Content>

