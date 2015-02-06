using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace SICSA {
    public partial class MainMaster : System.Web.UI.MasterPage {
        protected void Page_Load(object sender, EventArgs e) {
            if (!this.Page.User.Identity.IsAuthenticated)
            {
                FormsAuthentication.RedirectToLoginPage();
            }
            if(Session["UserID"] != null)
            {
              //do something
            }
            else
            {
               //create the session
                Response.Redirect("~/Account/logout.aspx");

            }
            //ASPxSiteMapDatosMenu.
        }
    }
}