using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using SICSA.clases;
using System.Xml;
using SIS.Framework;
using SIS.Framework.Common;

namespace SICSA {
    public partial class Login : System.Web.UI.Page {

        public SIS.Framework.Common.ClsSistema MyDataSistema;

        protected void Page_Load(object sender, EventArgs e) {
            
        }

        protected void Login1_Authenticate(object sender, AuthenticateEventArgs e)
        {
            
            bool Autenticado = false; 
            Autenticado =  autenticar.validar(Login1.UserName.ToString(), Login1.Password.ToString());
            e.Authenticated = Autenticado;
            if (Autenticado)
            {
                int Id = 0;
                int Rol = 0;
                Id = autenticar.IdUsr(Login1.UserName.ToString(), Login1.Password.ToString());
                Rol = autenticar.Rol(Login1.UserName.ToString(), Login1.Password.ToString());
                Session.Add("UserID", Id.ToString());
                Session.Add("Rol", Rol.ToString());


                FormsAuthentication.RedirectFromLoginPage(Login1.UserName, false);
                MyDataSistema = new ClsSistema();
                MyDataSistema.ConexionBaseDato = System.Configuration.ConfigurationManager.AppSettings.Get("ConexionSIS");
                MyDataSistema.NombreAplicacion = "SIS Base";
                MyDataSistema.Cusuario = Login1.UserName.ToString();

                Session["MyDataSistema"] = MyDataSistema;

                Response.Redirect("../portal/default.aspx");
            }
        }

    }
}