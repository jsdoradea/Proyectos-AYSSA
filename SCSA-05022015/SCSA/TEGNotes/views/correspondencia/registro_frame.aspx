<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="registro_frame.aspx.cs" Inherits="TEGNotes.views.convocatoria.registro_frame" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table style="width:100%;">
            <tr>
                <td><label>Estado:</label></td>
                <td><asp:DropDownList ID="DDLEstado" runat="server"></asp:DropDownList></td>
                <td style="text-align: right"><label>Fecha de registro:</label></td>
                <td style="text-align: right"><input type="date" id="f_reg" /></td>
            </tr>
            <tr>
                <td colspan="4">
                    <div id="form_reg" style="border-style:solid; border-width:1px;">
                        <table style="width:100%;">
                            <tr>
                                <td style="width:20%"><label>Fecha de Solicitud:</label></td>
                                <td style="width:80%"><input type="date" /></td>
                            </tr>
                            <tr>
                                <td style="width:20%"><label>Nombre:</label></td>
                                <td style="width:80%"><asp:TextBox ID="TextBox1" runat="server" Width="90%" Rows="3" TextMode="MultiLine"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td style="width:20%"><label>Justificación:</label></td>
                                <td style="width:80%"><asp:TextBox ID="TextBox2" runat="server" TextMode="MultiLine" Rows="4" Width="90%"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td style="width:20%"><label>Origen de Solicitud:</label></td>
                                <td style="width:80%">
                                    <table style="width:100%;">
                                        <tr>
                                            <td><asp:DropDownList ID="DDLOrigen" runat="server"></asp:DropDownList></td>
                                            <td><asp:RadioButtonList ID="RadioButtonList1" runat="server">
                                                <asp:ListItem Value="0" Selected="True">Soporte de acta</asp:ListItem>
                                                <asp:ListItem Value="1">Correspondencia Normal</asp:ListItem>
                                                </asp:RadioButtonList>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td style="width:20%"><label>Solicitante:</label></td>
                                <td style="width:80%"><asp:TextBox ID="TextBox3" runat="server" Width="90%"></asp:TextBox></td>
                            </tr>
                        </table><br />
                    </div>
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
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td style="text-align: right">
                    <asp:Button ID="Button2" runat="server" Text="Guardar" />&nbsp;&nbsp;
                    <asp:Button ID="Button1" runat="server" Text="Cancelar" />
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
