using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Security;
using TEGNotes.clases;


namespace TEGNotes.Account
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        protected void Login1_Authenticate(object sender, AuthenticateEventArgs e)
        {
            bool Autenticado = false;
            Autenticado = autenticar.validar(Login1.UserName.ToString(), Login1.Password.ToString());
            e.Authenticated = Autenticado;
            if (Autenticado)
            {
                int Id = 0;
                Id = autenticar.IdUsr(Login1.UserName.ToString(), Login1.Password.ToString());
                Session.Add("UserID", Id.ToString());
                FormsAuthentication.RedirectFromLoginPage(Login1.UserName, false);
                Response.Redirect("~/views/portal/default.aspx");
            }
        }
    }
}