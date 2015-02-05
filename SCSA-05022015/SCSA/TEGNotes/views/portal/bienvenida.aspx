<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="bienvenida.aspx.cs" Inherits="TEGNotes.portal.bienvenida" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <style>
        /* featured */
        .featured
        {
            background-color: #fff;
        }

            .featured .content-wrapper
            {
                background-color: #01a18e;
                background-image: -ms-linear-gradient(left, #01a18e 0%, #01a18e 100%);
                background-image: -o-linear-gradient(left, #01a18e 0%, #01a18e 100%);
                background-image: -webkit-gradient(linear, left top, right top, color-stop(0, #7ac0da), color-stop(1, #01a18e));
                background-image: -webkit-linear-gradient(left, #01a18e 0%, #01a18e 100%);
                background-image: linear-gradient(left, #01a18e 0%, #01a18e 100%);
                color: #3e5667;
                padding: 20px 40px 30px 40px;
            }

            .featured hgroup.title h1, .featured hgroup.title h2
            {
                color: #fff;
            }

            .featured p
            {
                font-size: 0.9em;
            }
        /* page titles */
        hgroup.title
        {
            margin-bottom: 10px;
        }

            hgroup.title h1, hgroup.title h2
            {
                display: inline;
            }

            hgroup.title h2
            {
                font-weight: normal;
                margin-left: 3px;
            }

        /* features */
        section.feature
        {
            width: 300px;
            float: left;
            padding: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <br />

            <hr style="color: Green; height: 2px; background-color: Green;" />
            <p style="text-align: center;">
                El SCSA, es una solución informática que administre y de seguimiento al proceso de toma de Acuerdos por el Pleno del Tribunal, permitiendo el monitoreo y seguimiento del cumplimiento de tales Acuerdos, considerando los requerimientos establecidos por la Unidad Solicitante.
            </p>
            <div id="img" style="margin:0 auto;text-align:center;">
                <img src="../../Images/SCSA.JPG" style="width:475px;height:280px;" />
            </div>
            <hr style="color: Green; height: 2px; background-color: Green;" />
        </div>
    </form>
</body>
</html>

