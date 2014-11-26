using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web.ASPxClasses;

    public partial class RootMaster : System.Web.UI.MasterPage {
        protected void Page_Load(object sender, EventArgs e) {
            ASPxSplitter1.GetPaneByName("Header").Size = ASPxWebControl.GlobalTheme == "Moderno" ? 95 : 83;
            ASPxSplitter1.GetPaneByName("Header").MinSize = ASPxWebControl.GlobalTheme == "Moderno" ? 95 : 83;
            ASPxLabel2.Text = Server.HtmlDecode(" &copy; " + DateTime.Now.Year + " - SISTEMA DE SEGUIMIENTO Y CONTROL DE ACUERDOS DEL PLENO DEL TRIBUNAL DE �TICA GUBERNAMENTAL");
        }
    }