using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SICSA.clases;

namespace SICSA.modulos
{
    public partial class ejecucion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblUser.Text = Session["UserID"].ToString();
            if (!IsPostBack)
            {
                ASPxPageAcuerdos.ActiveTabIndex = 0;
                ASPxPageAcuerdos.TabPages[1].Enabled = false;
                ASPxComboEjercicio.SelectedIndex = 0;
                ASPxComboBoxEmpleados.SelectedIndex = 0;
            }
        }

        protected void btnSeleccionar_Click(object sender, EventArgs e)
        {
            DatosSeleccionadosAcuerdos();
            ASPxPageAcuerdos.TabPages[1].Enabled = true;
            ASPxPageAcuerdos.ActiveTabIndex = 1;

        }

        private void DatosSeleccionadosAcuerdos()
        {
            Int32 inicio = ASPxGridAcuerdos.VisibleStartIndex;
            Int32 fin = ASPxGridAcuerdos.VisibleStartIndex + ASPxGridAcuerdos.SettingsPager.PageSize;
            fin = (fin > ASPxGridAcuerdos.VisibleRowCount ? ASPxGridAcuerdos.VisibleRowCount : fin);
            int cd_acuerdo = 0;
            for (int i = inicio; i < fin; i++)
            {
                if (ASPxGridAcuerdos.Selection.IsRowSelected(i))
                {
                    List<object> resultado = new List<object>();
                    cd_acuerdo = (int)ASPxGridAcuerdos.GetRowValues(i, "CD_ENCA_ACUERDOS");
                }
            }
            //Cargar datos en componentes de encabezado
            //cargar_componentes(Convert.ToInt32(cd_acuerdo));
            lblCodAcuerdo.Text = cd_acuerdo.ToString();
            List<datos_ejecucion> lista = new List<datos_ejecucion>();

            lista = manto_ejecucion.datos_ejecucion(Convert.ToInt32(cd_acuerdo));
            TextBoxSesion.Text = lista[0].ds_sesion.ToString();
            TextBoxActa.Text = lista[0].ds_acta.ToString();
            TextBoxNumAcuerdo.Text = lista[0].num_acuerdo.ToString();
            TextBoxDias.Text = lista[0].dias_acuerdo.ToString();
            ASPxMemoAcuerdo.Text = lista[0].nom_acuerdo.ToString();
            txtF_INI_ACU.Text = lista[0].fecha_inicio.ToString("yyyy-MM-dd");
            txtF_FIN_ACU.Text = lista[0].fecha_fin.ToString("yyyy-MM-dd");
            ASPxComboBoxEmpleados.SelectedIndex = 0;
        }

        protected void btnSeleccionar_Click1(object sender, EventArgs e)
        {
            ASPxTextNomTarea.Enabled = true;
            ASPxMemoDescripcion.Enabled = true;
            ASPxComboBoxEmpleados.Enabled = true;
            TextDias.Enabled = true;
            txtPredecesora.Enabled = true;
            //txtFechaInicio.Enabled = true;
            ASPxButtonGuardar.Enabled = true;
            ASPxButtonCancelar.Enabled = true;
            ASPxPanelInfo.Visible = true;
            ASPxPanelGrid.Visible = false;
            DatosSeleccionadosTareas();
        }

        private void DatosSeleccionadosTareas()
        {
            Int32 inicio = ASPxGridTareas.VisibleStartIndex;
            Int32 fin = ASPxGridTareas.VisibleStartIndex + ASPxGridTareas.SettingsPager.PageSize;
            fin = (fin > ASPxGridTareas.VisibleRowCount ? ASPxGridTareas.VisibleRowCount : fin);
            int cd_tarea = 0;
            for (int i = inicio; i < fin; i++)
            {
                if (ASPxGridTareas.Selection.IsRowSelected(i))
                {
                    List<object> resultado = new List<object>();
                    cd_tarea = (int)ASPxGridTareas.GetRowValues(i, "CD_TAREA");
                }
            }
            //Cargar datos en componentes de encabezado
            //cargar_componentes(Convert.ToInt32(cd_acuerdo));
            //lblCodAcuerdo.Text = cd_acuerdo.ToString();
            List<datos_tareas> lista = new List<datos_tareas>();

            lista = manto_ejecucion.datos_tareas(cd_tarea);
            ASPxTextNomTarea.Text = lista[0].ds_tarea.ToString();
            ASPxMemoDescripcion.Text = lista[0].ds_descripcion.ToString();
            ASPxComboBoxEmpleados.Value = Convert.ToInt32(lista[0].cd_responsable.ToString());
            txtPredecesora.Text = lista[0].predecesora.ToString();
            TextDias.Text = lista[0].dias_ejecucion.ToString();
            lblAccionTarea.Text = "m";
            lblCDTarea.Text = cd_tarea.ToString();
        }

        protected void ASPxButtonCancelar_Click(object sender, EventArgs e)
        {
            ASPxTextNomTarea.Enabled = false;
            ASPxMemoDescripcion.Enabled = false;
            ASPxComboBoxEmpleados.Enabled = false;
            TextDias.Enabled = false;
            txtPredecesora.Enabled = false;
            //txtFechaInicio.Enabled = false;
            ASPxButtonGuardar.Enabled = false;
            ASPxButtonCancelar.Enabled = false;
            ASPxTextNomTarea.Text = "";
            ASPxMemoDescripcion.Text = "";
            ASPxComboBoxEmpleados.SelectedIndex = 0;
            TextDias.Text = "";
            ASPxPanelInfo.Visible = false;
            ASPxPanelGrid.Visible = true;
            ASPxButtonNuevaTarea.Visible = true;
        }

        protected void ASPxButtonNuevaTarea_Click(object sender, EventArgs e)
        {
            ASPxPanelInfo.Visible = true;
            ASPxPanelGrid.Visible = false;
            ASPxTextNomTarea.Enabled = true;
            ASPxMemoDescripcion.Enabled = true;
            ASPxComboBoxEmpleados.Enabled = true;
            TextDias.Enabled = true;
            txtPredecesora.Enabled = true;
            //txtFechaInicio.Enabled = true;
            //txtFechaInicio.Text = DateTime.Today.ToString("yyyy-MM-dd");
            ASPxButtonGuardar.Enabled = true;
            ASPxButtonCancelar.Enabled = true;
            ASPxComboBoxEmpleados.SelectedIndex = 0;
            ASPxButtonNuevaTarea.Visible = false;
            lblAccionTarea.Text = "n";
            lblCDTarea.Text = "0";
        }

        protected void ASPxButtonGuardar_Click(object sender, EventArgs e)
        {
            if (lblAccionTarea.Text == "n")
            {
                manto_ejecucion.insertar_tarea(0, 0, Convert.ToInt32(lblCodAcuerdo.Text), ASPxTextNomTarea.Text, ASPxMemoDescripcion.Text, Convert.ToInt32(ASPxComboBoxEmpleados.Value), Convert.ToInt32(txtPredecesora.Text), Convert.ToInt32(TextDias.Text), Convert.ToInt32(Session["UserID"].ToString()));
            }
            else
            {
                manto_ejecucion.insertar_tarea(1, Convert.ToInt32(lblCDTarea.Text), Convert.ToInt32(lblCodAcuerdo.Text), ASPxTextNomTarea.Text, ASPxMemoDescripcion.Text, Convert.ToInt32(ASPxComboBoxEmpleados.Value), Convert.ToInt32(txtPredecesora.Text), Convert.ToInt32(TextDias.Text), Convert.ToInt32(Session["UserID"].ToString()));
            }
            //string script = "alert('Registro guardado');";
            //ScriptManager.RegisterStartupScript(this, typeof(Page), "Aviso", script, true);
            ASPxPanelInfo.Visible = false;
            ASPxPanelGrid.Visible = true;
            ASPxButtonNuevaTarea.Visible = true;
            ASPxGridTareas.DataBind();
            ASPxTextNomTarea.Enabled = false;
            ASPxMemoDescripcion.Enabled = false;
            ASPxComboBoxEmpleados.Enabled = false;
            TextDias.Enabled = false;
            txtPredecesora.Enabled = false;
            //txtFechaInicio.Enabled = false;
            ASPxButtonGuardar.Enabled = false;
            ASPxButtonCancelar.Enabled = false;
            ASPxTextNomTarea.Text = "";
            ASPxMemoDescripcion.Text = "";
            ASPxComboBoxEmpleados.SelectedIndex = 0;
            TextDias.Text = "";
        }
    }
}