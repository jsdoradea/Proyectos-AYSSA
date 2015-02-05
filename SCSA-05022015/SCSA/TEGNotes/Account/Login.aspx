<%@ Page Title="Iniciar sesión" Language="C#" MasterPageFile="~/portal/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TEGNotes.Account.Login" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <hgroup class="title">
        <%--<h1><%: Title %>.</h1>--%>
    </hgroup>
    <section id="loginForm">
        <p>&nbsp;</p>
        <p>&nbsp;</p>
        <h2>Por favor digite sus datos</h2>
        
        <p>&nbsp;</p>
        <p>
            <asp:Login ID="Login1" runat="server" DestinationPageUrl="~/Portal/default.aspx" DisplayRememberMe="False" EnableTheming="True" FailureText="Datos Incorrectos. Intente de nuevo." LoginButtonText="Entrar" PasswordLabelText="Contraseña:" PasswordRequiredErrorMessage="Contraseña?" RememberMeText="Recuerdame" TitleText="Ingreso al sistema" ToolTip="Log in" UserNameLabelText="Usuario:" UserNameRequiredErrorMessage="Usuario?" OnAuthenticate="Login1_Authenticate">
            </asp:Login>
        </p>
 <%--       <p>
            <asp:HyperLink runat="server" ID="RegisterHyperLink" ViewStateMode="Disabled">Register</asp:HyperLink>
            if you don't have an account.
        </p>--%>
    </section>
    <p>&nbsp;</p>
<%--    <section id="socialLoginForm">
        <h2>Use another service to log in.</h2>
        <uc:OpenAuthProviders runat="server" ID="OpenAuthLogin" />
    </section>--%>

</asp:Content>
