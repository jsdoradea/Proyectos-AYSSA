<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/portal/Light.master" CodeBehind="Login.aspx.cs" Inherits="SICSA.Login" %>

<%@ Register Assembly="DevExpress.Web.v14.2, Version=14.2.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="accountHeader">
        <h1>Tribunal de Etica Gubernamental</h1>
        <hr style="background-color: #003da5" />
        <br />
        <h2>Bienvenido</h2>
        <hr style="background-color: #84bd00" />
        <br />
    </div>
    <div class="form-field">
        <asp:Login ID="Login1" runat="server" BackColor="#F7F6F3" BorderColor="#E6E2D8" BorderPadding="4" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="Medium" ForeColor="#333333" DisplayRememberMe="False" Height="200px" OnAuthenticate="Login1_Authenticate">
            <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
            <LoginButtonStyle BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284775" />
            <TextBoxStyle Font-Size="Small" Width="200px" />
            <TitleTextStyle BackColor="#5D7B9D" Font-Bold="True" Font-Size="0.9em" ForeColor="White" />
        </asp:Login>
    </div>
</asp:Content>
