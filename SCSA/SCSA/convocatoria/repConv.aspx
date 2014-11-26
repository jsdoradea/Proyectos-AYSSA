<%@ Page Language="C#" AutoEventWireup="true" CodeFile="repConv.aspx.cs" Inherits="convocatoria_repConv" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <rsweb:ReportViewer ID="ReportViewer2" runat="server" Font-Names="Verdana" Font-Size="8pt"
        Height="100%" InteractiveDeviceInfos="(Colección)" WaitMessageFont-Names="Verdana"
        WaitMessageFont-Size="14pt" Width="100%" AsyncRendering="False" SizeToReportContent="true">
        <LocalReport ReportPath="convocatoria/repConv.rdlc">
            <DataSources>
                <rsweb:ReportDataSource DataSourceId="" Name="" />
            </DataSources>
        </LocalReport>
    </rsweb:ReportViewer>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    </div>
    </form>
</body>
</html>
