using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SICSA.configuracion
{
    public partial class plantilla_tareas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ASPxPageTareas.ActiveTabIndex = 0;
                ASPxPageTareas.TabPages[1].Enabled = false;
            }
        }

        protected void btnSeleccionar_Click(object sender, EventArgs e)
        {
            ASPxPageTareas.TabPages[1].Enabled = true;
            ASPxPageTareas.ActiveTabIndex = 1;
            DatosSeleccionados();
        }

        private void DatosSeleccionados()
        {
            Int32 inicio = ASPxGridPlantilla.VisibleStartIndex;
            Int32 fin = ASPxGridPlantilla.VisibleStartIndex + ASPxGridPlantilla.SettingsPager.PageSize;
            fin = (fin > ASPxGridPlantilla.VisibleRowCount ? ASPxGridPlantilla.VisibleRowCount : fin);
            int cd_plantilla = 0;
            for (int i = inicio; i < fin; i++)
            {
                if (ASPxGridPlantilla.Selection.IsRowSelected(i))
                {
                    List<object> resultado = new List<object>();
                    cd_plantilla = (int)ASPxGridPlantilla.GetRowValues(i, "CD_PLANTILLA");
                }
            }
            ASPxLabelCDPlantilla.Text = cd_plantilla.ToString();
        }
    }
}