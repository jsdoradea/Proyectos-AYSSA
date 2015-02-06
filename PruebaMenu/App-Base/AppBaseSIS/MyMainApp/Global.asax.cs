using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using SIS.Framework;
using SIS.Framework.Common;


namespace MyMainApp
{
    public class Global : System.Web.HttpApplication
    {
        public SIS.Framework.Common.ClsSistema MyDataSistema;

        protected void Application_Start(object sender, EventArgs e)
        {

        }

        protected void Session_Start(object sender, EventArgs e)
        {
            MyDataSistema = new ClsSistema();
            MyDataSistema.ConexionBaseDato = System.Configuration.ConfigurationManager.AppSettings.Get("ConexionSIS");
            MyDataSistema.NombreAplicacion = "SIS Base";
            MyDataSistema.Cusuario = "largueta";

            Session["MyDataSistema"] = MyDataSistema;
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {
            
        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}