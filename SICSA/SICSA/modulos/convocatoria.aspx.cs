using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SICSA.correspondencia
{
    public partial class convocatoria : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PageConvocatoria.ActiveTabIndex = 0;
                PageConvocatoria.TabPages[1].Enabled = false;
                ASPxComboBoxPeriodo.SelectedIndex = 0;
                TextBoxFecha_Registro.Text = DateTime.Today.ToString("yyyy-MM-dd");
                TextBoxFecha_Registro.ReadOnly = true;
            }
        }

        protected void btnNuevo_Click(object sender, EventArgs e)
        {
            //Nueva Convocatoria
            PageConvocatoria.TabPages[1].Enabled = true;
            PageConvocatoria.ActiveTabIndex = 1;
            lblRef.Text = "Nueva convocatoria";
            //lblAccion.Text = "n";
        }

        protected void btnSeleccionar_Click(object sender, EventArgs e)
        {

        }

        protected void btnAceptar_Click(object sender, EventArgs e)
        {

        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {

        }
    }
}