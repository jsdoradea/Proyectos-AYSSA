using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ClsFormas;

namespace MyMainApp
{
    public partial class DefaultLoader : System.Web.UI.Page
    {
        public DefaultLoader()
        {
            

        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ASPxButton1_Click(object sender, EventArgs e)
        {
            Response.Redirect("GLBM0099.aspx");
        }

        protected void ASPxButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("/GLB/GLBM0010.aspx");
        }

        protected void ASPxButton3_Click(object sender, EventArgs e)
        {
            Response.Redirect("/GLB/GLBM0011.aspx");
        }
    }
}