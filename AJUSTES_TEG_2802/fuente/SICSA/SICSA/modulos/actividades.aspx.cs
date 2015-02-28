using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SICSA.clases;

namespace SICSA.modulos
{
    public partial class actividades : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ASPxPageActividades.ActiveTabIndex = 0;
                ASPxPageActividades.TabPages[1].Enabled = false;
                ASPxPageActividades.TabPages[2].Enabled = false;
            }
        }

        protected void btnSeleccionar_Click(object sender, EventArgs e)
        {
            ASPxPageActividades.TabPages[1].Enabled = true;
            ASPxPageActividades.TabPages[2].Enabled = false;
            ASPxPageActividades.ActiveTabIndex = 1;
        }

        protected void btnProrroga_Click(object sender, EventArgs e)
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
            if (manto_tareas.validar_prorroga(cd_tarea))
            {
                ASPxPageActividades.TabPages[1].Enabled = false;
                ASPxPageActividades.TabPages[2].Enabled = true;
                ASPxPageActividades.ActiveTabIndex = 2;
            }
            else
            {
                string script = "alert('¡La prórroga se debe solicitar con 48 días antes de su vencimiento!');";
                ScriptManager.RegisterStartupScript(this, typeof(Page), "Aviso", script, true);
            }
        }

        protected void btnSeleccionar_Click1(object sender, EventArgs e)
        {
            ASPxPageActividades.TabPages[1].Enabled = true;
            ASPxPageActividades.TabPages[2].Enabled = false;
            ASPxPageActividades.ActiveTabIndex = 1;
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
            ASPxLabelCodTarea.Text = cd_tarea.ToString();
            
            List<datos_tarea_acu> lista = new List<datos_tarea_acu>();
            lista = manto_tareas.datos_tarea_acu(cd_tarea);

            ASPxTextBoxSesion.Text = lista[0].ds_referencia.ToString();
            ASPxTextBoxActa.Text = lista[0].ds_acta.ToString();
            ASPxTextBoxNAcu.Text = lista[0].n_acuerdo.ToString();
            ASPxMemoAcuerdo.Text = lista[0].ds_acuerdo.ToString();
            ASPxMemoTarea.Text = lista[0].ds_tarea.ToString();
            TextBoxFE_INI.Text = lista[0].fecha_inicio.ToString("yyyy-MM-dd");
            TextBoxFE_FIN.Text = lista[0].fecha_fin.ToString("yyyy-MM-dd");
            ASPxMemoDesc.Text = lista[0].ds_descripcion.ToString();
            TextBoxDiasEJE.Text = lista[0].dias_ejec.ToString();
            ASPxTextBoxNAcuerdo.Text = lista[0].n_acuerdo.ToString();
        }

        protected void ASPxButton2_Click(object sender, EventArgs e)
        {
            //Cancelar
            ASPxPageActividades.ActiveTabIndex = 0;
            ASPxPageActividades.TabPages[1].Enabled = false;
            ASPxPageActividades.TabPages[2].Enabled = false;
        }

        protected void ASPxButton1_Click(object sender, EventArgs e)
        {
            string nombre_doc = "";
            string sURL = "";
            bool guardar = false;
            if (FileUpload1.HasFile)
            {
                nombre_doc = FileUpload1.FileName;
                DateTime fecha_hoy = DateTime.Now;
                string prefijo = fecha_hoy.ToString("ddMMyyyyHHmmss") + "-";
                sURL = "~/Content/documentos/" + prefijo + nombre_doc;
                FileUpload1.PostedFile.SaveAs(Server.MapPath(sURL));
            }
            //Validar procedencia de tarea. Si viene de plantilla no es obligación escribir comentario, de lo contrario es mandatorio.
            if (manto_tareas.validar_procedencia_tarea(Convert.ToInt32(ASPxLabelCodTarea.Text)))
            {
                //tarea proviende de plantilla ==> validar si campo comentario trae datos
                if (ASPxMemo4.Text == "")
                {
                    // Exigir campo
                    guardar = false;
                }
                else
                {
                    // Dejar guardar
                    guardar = true;
                }
            }
            else
            {
                //tarea es independiente, dejar guardar como venga
                guardar = true;
            }
            if (guardar == true)
            {
                manto_tareas.insertar_avance(Convert.ToInt32(ASPxLabelCodTarea.Text), Convert.ToInt32(ASPxRadioButtonList1.Value), ASPxMemo4.Text, nombre_doc, sURL, Convert.ToInt32(Session["UserID"].ToString()));
                string script = "alert('¡El registro se ha guardado!');";
                ScriptManager.RegisterStartupScript(this, typeof(Page), "Aviso", script, true);
            }
            else
            {
                string script = "alert('¡El campo comentario es obligatorio!');";
                ScriptManager.RegisterStartupScript(this, typeof(Page), "Aviso", script, true);
            }
        }

        protected void ASPxButtonGuardar_Click(object sender, EventArgs e)
        {
            manto_tareas.solicitar_prorroga(Convert.ToInt32(ASPxLabelCodTarea.Text), ASPxMemoJust.Text, Convert.ToInt32(ASPxTextBoxNAcuerdo.Text), Convert.ToInt32(Session["UserID"].ToString()));
            string script = "alert('¡Se ha registrado la solicitud de prórroga!');";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "Aviso", script, true);
        }

        protected void ASPxButtonCancelar_Click(object sender, EventArgs e)
        {
            //Cancelar
            ASPxPageActividades.ActiveTabIndex = 0;
            ASPxPageActividades.TabPages[1].Enabled = false;
            ASPxPageActividades.TabPages[2].Enabled = false;
        }
    }
}