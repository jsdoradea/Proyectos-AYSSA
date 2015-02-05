<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="convocatoria_frame.aspx.cs" Inherits="TEGNotes.views.convocatoria.convocatoria_frame" %>

<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="../../Content/jqtheme/jquery-1.9.1.js"></script>
    <link href="../../Content/jqtheme/jquery-ui.css" rel="stylesheet" />
    <script src="../../Content/jqtheme/jquery-ui.js"></script>
    <link href="../../Content/jqtheme/jquery-ui.min.css" rel="stylesheet" />
    <script src="../../Content/jqtheme/jquery-ui.min.js"></script>
    <link href="../../Content/jqtheme/jquery-ui.structure.css" rel="stylesheet" />
    <link href="../../Content/jqtheme/jquery-ui.structure.min.css" rel="stylesheet" />
    <link href="../../Content/jqtheme/jquery-ui.theme.css" rel="stylesheet" />
    <link href="../../Content/jqtheme/jquery-ui.theme.min.css" rel="stylesheet" />
    <script>
        $(function () {
            $("#tabs").tabs();
        });
    </script>
    <style>
        .tabla
        {
            border: 1px solid #000000;
            width: 100%;
            border-collapse: collapse;
        }

            .tabla th
            {
                border: 1px solid #000000;
                background-color: gainsboro;
                text-align: center;
            }

            .tabla td
            {
                border: 1px solid #000000;
                text-align: center;
            }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table style="width: 100%;">
                <tr>
                    <td>
                        <label>Referencia:</label></td>
                    <td>
                        <asp:TextBox ID="TextBox1" runat="server" BackColor="#FF9900"></asp:TextBox></td>
                    <td style="text-align: right">
                        <label>Fecha de registro:</label></td>
                    <td style="text-align: right">
                        <input type="date" id="f_reg" /></td>
                </tr>
            </table>
            <div id="tabs">
                <ul>
                    <li><a href="#tabs-1">Convocatoria Sesión</a></li>
                    <li><a href="#tabs-2">Solicitudes</a></li>
                    <li><a href="#tabs-3">Puntos a tratar</a></li>
                    <li><a href="#tabs-4">Agenda Sugerida</a></li>
                    <li><a href="#tabs-5">Notificar</a></li>
                    <li><a href="#tabs-6">Reprogramaciones</a></li>
                </ul>
                <div id="tabs-1">
                    <table style="width: 100%">
                        <tr>
                            <td>
                                <label>Referencia:</label></td>
                            <td>
                                <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox></td>
                            <td>
                                <label>Fecha de sesión:</label></td>
                            <td>
                                <input type="date" /></td>
                        </tr>
                        <tr>
                            <td>
                                <label>Tipo de sesión:</label></td>
                            <td>
                                <asp:DropDownList ID="DDLTipoSesion" runat="server"></asp:DropDownList></td>
                            <td>
                                <label>Hora de sesión:</label></td>
                            <td>
                                <input type="time" /></td>
                        </tr>
                        <tr>
                            <td>
                                <label>Estado:</label></td>
                            <td>
                                <asp:DropDownList ID="DDLEstadoSesion" runat="server"></asp:DropDownList></td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <label>Miembros del pleno a convocar:</label></td>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                            <td>
                                <asp:CheckBox ID="CheckBox1" runat="server" Checked="True" Text="Todo el pleno" />
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center;">
                                <asp:ListBox ID="ListMiembros" runat="server"></asp:ListBox>
                            </td>
                            <td colspan="2" style="text-align: center;">
                                <asp:Button ID="btnTodosIzq" runat="server" Text="<<" /><br />
                                <asp:Button ID="btnUnoIzq" runat="server" Text=" < " /><br />
                                <asp:Button ID="btnUnoDer" runat="server" Text=" > " /><br />
                                <asp:Button ID="btnTodosDer" runat="server" Text=">>" />
                            </td>
                            <td>
                                <asp:ListBox ID="ListSelect" runat="server">
                                    <asp:ListItem Value="0">--Seleccione miembros a convocar--</asp:ListItem>
                                </asp:ListBox>
                            </td>
                        </tr>

                    </table>
                </div>
                <div id="tabs-2">
                    <div style="margin: 0 auto;">
                        <table style="width: 100%">
                            <tr>
                                <td style="width: 20%">
                                    <label>Estado:</label></td>
                                <td style="width: 80%">
                                    <asp:DropDownList ID="DDLEstadoSolicitud" runat="server"></asp:DropDownList></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <div style="width: 100%; border-style: solid; border-width: 1px;">
                                        <table style="width: 100%">
                                            <tr>
                                                <td style="width: 20%">
                                                    <label>Fecha de Solicitud:</label></td>
                                                <td style="width: 80%">
                                                    <input type="date" /></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 20%">
                                                    <label>Nombre:</label></td>
                                                <td style="width: 80%">
                                                    <asp:TextBox ID="TextBox3" runat="server" Width="90%" TextMode="MultiLine" Rows="2"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 20%">
                                                    <label>Justificación:</label></td>
                                                <td style="width: 80%">
                                                    <asp:TextBox ID="TextBox4" runat="server" Width="90%" TextMode="MultiLine" Rows="3"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 20%">
                                                    <label>Orígen de Solicitud:</label></td>
                                                <td style="width: 80%">
                                                    <asp:DropDownList ID="DDLOrigen" runat="server"></asp:DropDownList></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 20%">
                                                    <label>Solicitante:</label></td>
                                                <td style="width: 80%">
                                                    <asp:TextBox ID="TextBox5" runat="server" Width="90%"></asp:TextBox></td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div id="tabs-3">
                    Puntos solicitados a tratar:<br />
                    <asp:Panel ID="Panel1" runat="server" Style="border-collapse: collapse; border-spacing: 0px; border-style: solid; border-width: 1px; width: 98%; height: 130px" ScrollBars="Vertical">
                        <table class="tabla">
                            <thead>
                                <tr>
                                    <th>Editar</th>
                                    <th style="text-align: left;">Nombre de punto</th>
                                    <th>Fecha de solicitud</th>
                                    <th>Fecha de registro</th>
                                    <th>Punto</th>
                                    <th>Varios</th>
                                    <th>Eliminar</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><a href="#">
                                        <img src="../../Images/edit.png" /></a></td>
                                    <td style="text-align: left;">Inventario - Solicitud de Consumibles para impresoras</td>
                                    <td>13/10/2014</td>
                                    <td>15/10/2014</td>
                                    <td>
                                        <input id="Checkbox2" type="checkbox" checked="checked" /></td>
                                    <td>
                                        <input id="Checkbox3" type="checkbox" /></td>
                                    <td><a href="#">
                                        <img src="../../Images/trash.png" style="width: 16px; height: 16px" /></a></td>
                                </tr>
                                <tr>
                                    <td><a href="#">
                                        <img src="../../Images/edit.png" /></a></td>
                                    <td style="text-align: left;">ISTA – Nombramiento de miembro suplente de Comisión</td>
                                    <td>10/10/2014</td>
                                    <td>15/10/2014</td>
                                    <td>
                                        <input id="Checkbox4" type="checkbox" /></td>
                                    <td>
                                        <input id="Checkbox5" type="checkbox" /></td>
                                    <td><a href="#">
                                        <img src="../../Images/trash.png" style="width: 16px; height: 16px" /></a></td>
                                </tr>
                                <tr>
                                    <td><a href="#">
                                        <img src="../../Images/edit.png" /></a></td>
                                    <td style="text-align: left;">Juan Pérez – Solicitud Licencia por 5 días a causa de Viaje</td>
                                    <td>12/10/2014</td>
                                    <td>14/10/2014</td>
                                    <td>
                                        <input id="Checkbox6" type="checkbox" checked="checked" /></td>
                                    <td>
                                        <input id="Checkbox7" type="checkbox" /></td>
                                    <td><a href="#">
                                        <img src="../../Images/trash.png" style="width: 16px; height: 16px" /></a></td>
                                </tr>
                                <tr>
                                    <td><a href="#">
                                        <img src="../../Images/edit.png" /></a></td>
                                    <td style="text-align: left;">Informática - Autorización Planes Mantenimiento Preventivo</td>
                                    <td>13/09/2014</td>
                                    <td>16/09/2014</td>
                                    <td>
                                        <input id="Checkbox8" type="checkbox" /></td>
                                    <td>
                                        <input id="Checkbox9" type="checkbox" /></td>
                                    <td><a href="#">
                                        <img src="../../Images/trash.png" style="width: 16px; height: 16px" /></a></td>
                                </tr>
                            </tbody>
                        </table>
                    </asp:Panel>
                    <asp:Panel ID="Panel2" runat="server" Style="border-collapse: collapse; border-spacing: 0px; border-style: solid; border-width: 1px; width: 98%; height: 115px" ScrollBars="Vertical">
                        Subpuntos incluidos en Varios
                        <table>
                            <tr>
                                <td>
                                    <asp:Button ID="Button3" runat="server" Text="Nuevo" /></td>
                                <td>
                                    <label>Sub punto:</label></td>
                                <td>
                                    <asp:TextBox ID="TextBox6" runat="server" Width="300px"></asp:TextBox></td>
                                <td>
                                    <label>Descripción:</label></td>
                                <td>
                                    <asp:TextBox ID="TextBox7" runat="server" Width="300px"></asp:TextBox></td>
                            </tr>
                        </table>
                        <br />
                        <table class="tabla">
                            <thead>
                                <tr>
                                    <th>Editar</th>
                                    <th style="text-align: left;">Subpunto</th>
                                    <th style="text-align: left;">Descripción</th>
                                    <th>Eliminar</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><a href="#">
                                        <img src="../../Images/edit.png" /></a></td>
                                    <td style="text-align: left;">Mención Honorifica</td>
                                    <td style="text-align: left;">Reconocimiento a Luisa Gomez</td>
                                    <td><a href="#">
                                        <img src="../../Images/trash.png" style="width: 16px; height: 16px" /></a></td>
                                </tr>
                            </tbody>
                        </table>
                    </asp:Panel>
                </div>
                <div id="tabs-4">
                    <table style="width: 100%;">
                        <tr>
                            <td style="width: 50%;">
                                <div class="toggler">
                                    <div id="effect" class="ui-widget-content ui-corner-all">
                                        <h3 class="ui-widget-header ui-corner-all">Agenda a Notificar</h3>
                                        <asp:ListBox ID="ListAgenda" runat="server">
                                            <asp:ListItem Value="1">Inventario – Solicitud Consumibles para Impresoras</asp:ListItem>
                                            <asp:ListItem Value="2">Juan Pérez – Solicitud Licencia por 5 días a causa de Viaje</asp:ListItem>
                                            <asp:ListItem Selected="True" Value="3">Varios</asp:ListItem>
                                        </asp:ListBox>
                                    </div>
                                </div>
                                <br />
                                <table class="tabla">
                            <thead>
                                <tr>
                                    <th style="text-align: left;">Subpunto</th>
                                    <th style="text-align: left;">Descripción</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td style="text-align: left;">Mención Honorifica</td>
                                    <td style="text-align: left;">Reconocimiento a Luisa Gomez</td>
                                </tr>
                                <tr>
                                    <td style="text-align: left;">Celebración Nacional</td>
                                    <td style="text-align: left;">Pronunciación sobre Feriado Nacional</td>
                                </tr>
                            </tbody>
                        </table>
                            </td>
                            <td style="width: 50%;vertical-align:top;">
                                <iframe id="pdf" src="~/views/convocatoria/02_Diseño de Sistema - SCSA.pdf" runat="server" style="height:250px;width:100%;" ></iframe></td>
                        </tr>
                    </table>
                </div>
                <table style="width: 100%">
                    <tr>
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
