using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SICSA.clases;

namespace SICSA.Account
{
    public partial class cambio_calve : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            List<datos_usuario> lista = new List<datos_usuario>();
            lista = manto_usuarios.nom_usuario(Convert.ToInt32(Session["UserID"].ToString()));
            ASPxTextBoxNombre.Text = lista[0].nombre_usuario.ToString();
            ASPxTextBoxApellido.Text = lista[0].apellido_usuario.ToString();
        }

        protected void ASPxButtonAceptar_Click(object sender, EventArgs e)
        {
            if (manto_usuarios.validar_pass(Convert.ToInt32(Session["UserID"].ToString()), ASPxTextBoxOldPass.Text))
            {
                //cambiar clave
                manto_usuarios.actualizar_contraseña(Convert.ToInt32(Session["UserID"].ToString()), ASPxTextBoxNewPass.Text);
                Response.Redirect("../portal/default.aspx");
            }
            else
            {
                //Clave anterior no coincide
                string script = "alert('¡La contraseña actual no coincide!');";
                ScriptManager.RegisterStartupScript(this, typeof(Page), "Aviso", script, true);
            }
        }
    }
}