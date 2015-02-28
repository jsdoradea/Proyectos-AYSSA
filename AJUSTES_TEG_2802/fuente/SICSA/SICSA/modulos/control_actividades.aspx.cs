using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SICSA.clases;

namespace SICSA.modulos
{
    public partial class control_actividades : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ASPxPageControlActividades.ActiveTabIndex = 0;
                int rol = Convert.ToInt32(Session["Rol"].ToString());
                if (rol == 1)
                {
                    ASPxPageControlActividades.TabPages[1].Visible = true;
                }
                else
                {
                    ASPxPageControlActividades.TabPages[1].Visible = false;
                }
            }
        }

        protected void btnAutProrroga_Click(object sender, EventArgs e)
        {
            TextBoxDAut.Enabled = true;
            ASPxButtonAceptarP.Enabled = true;
            ASPxButtonCancelarP.Enabled = true;
            DatosSeleccionadosProrrogas();
        }

        private void DatosSeleccionadosProrrogas()
        {
            Int32 inicio = ASPxGridProrrogas.VisibleStartIndex;
            Int32 fin = ASPxGridProrrogas.VisibleStartIndex + ASPxGridProrrogas.SettingsPager.PageSize;
            fin = (fin > ASPxGridProrrogas.VisibleRowCount ? ASPxGridProrrogas.VisibleRowCount : fin);
            int cd_prorroga = 0;
            for (int i = inicio; i < fin; i++)
            {
                if (ASPxGridProrrogas.Selection.IsRowSelected(i))
                {
                    List<object> resultado = new List<object>();
                    cd_prorroga = (int)ASPxGridProrrogas.GetRowValues(i, "CD_PRORROGA");
                }
            }
            ASPxLabelCodProrroga.Text = cd_prorroga.ToString();
        }

        protected void ASPxButtonCancelarP_Click(object sender, EventArgs e)
        {
            TextBoxDAut.Text = "0";
            TextBoxDAut.Enabled = false;
            ASPxButtonAceptarP.Enabled = false;
            ASPxButtonCancelarP.Enabled = false;

        }

        protected void ASPxButtonAceptarP_Click(object sender, EventArgs e)
        {
            manto_prorrogas.autorizar_prorroga(Convert.ToInt32(ASPxLabelCodProrroga.Text), Convert.ToInt32(TextBoxDAut.Text));
            TextBoxDAut.Enabled = false;
            ASPxButtonAceptarP.Enabled = false;
            ASPxButtonCancelarP.Enabled = false;
            string script = "alert('¡La prorroga se ha procesado!');";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "Aviso", script, true);
            ASPxGridProrrogas.DataBind();
        }

        protected void btnSeleccionar_Click(object sender, EventArgs e)
        {
            ASPxRadioButtonList1.Enabled = true;
            ASPxMemo1.Enabled = true;
            ASPxButtonGuardarAprob.Enabled = true;
            ASPxButtonCancelarApro.Enabled = true;
            DatosSeleccionadosActividades();
        }

        private void DatosSeleccionadosActividades()
        {
            Int32 inicio = ASPxGridActComp.VisibleStartIndex;
            Int32 fin = ASPxGridActComp.VisibleStartIndex + ASPxGridActComp.SettingsPager.PageSize;
            fin = (fin > ASPxGridActComp.VisibleRowCount ? ASPxGridActComp.VisibleRowCount : fin);
            int cd_ejec_plan = 0;
            for (int i = inicio; i < fin; i++)
            {
                if (ASPxGridActComp.Selection.IsRowSelected(i))
                {
                    List<object> resultado = new List<object>();
                    cd_ejec_plan = (int)ASPxGridActComp.GetRowValues(i, "CD_DETA_PLAN_EJECUCION_ACTIVIDAD");
                }
            }
            ASPxLabelCD_EJE_ACT.Text = cd_ejec_plan.ToString();
        }

        protected void ASPxButtonCancelarApro_Click(object sender, EventArgs e)
        {
            ASPxRadioButtonList1.Enabled = false;
            ASPxMemo1.Enabled = false;
            ASPxButtonGuardarAprob.Enabled = false;
            ASPxButtonCancelarApro.Enabled = false;
        }

        protected void ASPxButtonGuardarAprob_Click(object sender, EventArgs e)
        {
            manto_tareas.autorizar_actividad(Convert.ToInt32(ASPxLabelCD_EJE_ACT.Text), Convert.ToInt32(ASPxRadioButtonList1.Value), ASPxMemo1.Text, Convert.ToInt32(Session["UserID"]));
            ASPxRadioButtonList1.Enabled = false;
            ASPxMemo1.Enabled = false;
            ASPxButtonGuardarAprob.Enabled = false;
            ASPxButtonCancelarApro.Enabled = false;
            string script = "alert('¡El registro se ha guardado!');";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "Aviso", script, true);
        }

    }
}