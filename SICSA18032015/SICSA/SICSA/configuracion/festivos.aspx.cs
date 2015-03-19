using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SICSA.configuracion
{
    public partial class festivos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ASPxPageFestivos.ActiveTabIndex = 0;
                ASPxPageFestivos.TabPages[1].Enabled = false;
                ASPxLabelFecha.Text = DateTime.Today.ToString("yyyy-MM-dd");
                ASPxLabeUsr.Text = Session["UserID"].ToString();
            }
        }

        protected void btnSeleccionar_Click(object sender, EventArgs e)
        {
            DatosSeleccionadosAcuerdos();
            ASPxPageFestivos.TabPages[1].Enabled = true;
            ASPxPageFestivos.ActiveTabIndex = 1;

        }

        private void DatosSeleccionadosAcuerdos()
        {
            Int32 inicio = ASPxGridCalendario.VisibleStartIndex;
            Int32 fin = ASPxGridCalendario.VisibleStartIndex + ASPxGridCalendario.SettingsPager.PageSize;
            fin = (fin > ASPxGridCalendario.VisibleRowCount ? ASPxGridCalendario.VisibleRowCount : fin);
            int cd_calendario = 0;
            for (int i = inicio; i < fin; i++)
            {
                if (ASPxGridCalendario.Selection.IsRowSelected(i))
                {
                    List<object> resultado = new List<object>();
                    cd_calendario = (int)ASPxGridCalendario.GetRowValues(i, "CD_ANIO");
                }
            }
            ASPxLabelPeriodo.Text = cd_calendario.ToString();
        }
    }
}