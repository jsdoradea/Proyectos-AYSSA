using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using DevExpress.Web;
using SIS.Framework;
using SIS.Framework.Common;

    namespace SICSA {
        public class Global_asax : System.Web.HttpApplication {
            void Application_Start(object sender, EventArgs e) {
                DevExpress.Web.ASPxWebControl.CallbackError += new EventHandler(Application_Error);
            }

            void Application_End(object sender, EventArgs e) {
                // Code that runs on application shutdown
            }

            void Application_Error(object sender, EventArgs e) {
                // Code that runs when an unhandled error occurs
            }

            public SIS.Framework.Common.ClsSistema MyDataSistema;

            void Session_Start(object sender, EventArgs e) {
                // Code that runs when a new session is started
                //MyDataSistema = new ClsSistema();
                //MyDataSistema.ConexionBaseDato = System.Configuration.ConfigurationManager.AppSettings.Get("ConexionSIS");
                //MyDataSistema.NombreAplicacion = "SIS Base";
                //MyDataSistema.Cusuario = "Admin";

                //Session["MyDataSistema"] = MyDataSistema;
            }

            void Session_End(object sender, EventArgs e) {
                // Code that runs when a session ends. 
                // Note: The Session_End event is raised only when the sessionstate mode
                // is set to InProc in the Web.config file. If session mode is set to StateServer 
                // or SQLServer, the event is not raised.
            }
        }
    }