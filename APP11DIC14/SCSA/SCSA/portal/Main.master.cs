using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MainMaster : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //string usuario = (Session["UserID"].ToString());
        if (String.IsNullOrEmpty(Session["UserID"].ToString()))
        {
            Response.Redirect("~/Account/logout.aspx");
        }
    }
}