using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SICSA.clases;

namespace SICSA.correspondencia
{
    public partial class correspondencia : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PagerCorrespondencia.ActiveTabIndex = 0;
                PagerCorrespondencia.TabPages[1].Enabled = false;
                ASPxComboBoxPeriodo.SelectedIndex = 0;
                ASPxComboBoxEstado.SelectedIndex = 0;
                TextBoxFecha_Registro.Text = DateTime.Today.ToString("yyyy-MM-dd");
                //ASPxComboBoxOrigen.SelectedIndex = 0;
                //SqlDataSolicitantes.DataBind();
                //ASPxComboBoxSolicitantes.DataBind();
                //ASPxComboBoxSolicitantes.SelectedIndex = 0;
                TextBoxFecha_Solicitud.Text = DateTime.Today.ToString("yyyy-MM-dd");
                ASPxRadioButtonListTipo.SelectedIndex = 0;
            }
        }

        protected void btnNuevo_Click(object sender, EventArgs e)
        {
            //Nueva Correspondencia
            PagerCorrespondencia.TabPages[1].Enabled = true;
            PagerCorrespondencia.ActiveTabIndex = 1;
            ASPxComboBoxEstado.SelectedIndex = 0;
            ASPxComboBoxEstado.Enabled = false;
            TextBoxFecha_Registro.Text = DateTime.Today.ToString("yyyy-MM-dd");
            TextBoxFecha_Registro.ReadOnly = true;
            TextBoxFecha_Solicitud.Text = DateTime.Today.ToString("yyyy-MM-dd");
            ASPxRadioButtonListTipo.SelectedIndex = 1;
            ASPxComboBoxOrigen.SelectedIndex = 0;
            //SqlDataSolicitantes.DataBind();
            //ASPxComboBoxSolicitantes.DataBind();
            ASPxComboBoxSolicitantes.SelectedIndex = 0;
            txtPunto.Text = "";
            txtJust.Text = "";
            lblAccion.Text = "n";
            TextF_Doc.Text = DateTime.Today.ToString("yyyy-MM-dd");
            ASPxTextReferencia.Text = "";
        }

        protected void btnSeleccionar_Click(object sender, EventArgs e)
        {
            TomaDatosSeleccionados();
        }

        private void TomaDatosSeleccionados()
        {
            Int32 inicio = ASPxGridDatosCorrespondencia.VisibleStartIndex;
            Int32 fin = ASPxGridDatosCorrespondencia.VisibleStartIndex + ASPxGridDatosCorrespondencia.SettingsPager.PageSize;
            fin = (fin > ASPxGridDatosCorrespondencia.VisibleRowCount ? ASPxGridDatosCorrespondencia.VisibleRowCount : fin);
            int? cd_agenda = 0;
            for (int i = inicio; i < fin; i++)
            {
                if (ASPxGridDatosCorrespondencia.Selection.IsRowSelected(i))
                {
                    List<object> resultado = new List<object>();
                    cd_agenda = (int?)ASPxGridDatosCorrespondencia.GetRowValues(i, "CD_AGENDA");
                }
            }
            //Cargar info de componentes.
            cargar_componentes(Convert.ToInt32(cd_agenda));
        }
        private void cargar_componentes(int cod_agenda)
        {
            TextBoxFecha_Registro.ReadOnly = true;
            PagerCorrespondencia.TabPages[1].Enabled = true;
            PagerCorrespondencia.ActiveTabIndex = 1;
            ASPxComboBoxEstado.SelectedIndex = 0;
            //llenar_grid(Convert.ToInt32(DDLPeriodo.SelectedItem.Value));
            List<datos_correspondencia> lista = new List<datos_correspondencia>();
            lista = manto_correspondencia.datos_agenda(Convert.ToInt32(cod_agenda));
            ASPxComboBoxEstado.Value = Convert.ToInt32(lista[0].estado.ToString());
            txtPunto.Text = lista[0].punto.ToString();
            TextBoxFecha_Solicitud.Text = lista[0].fec_solicitud.ToString("yyyy-MM-dd");
            TextBoxFecha_Registro.Text = lista[0].fec_registro.ToString("yyyy-MM-dd");
            //ASPxComboBoxOrigen.DataBind();
            //ASPxComboBoxOrigen.SelectedItem = ASPxComboBoxOrigen.Items.FindByValue(lista[0].origen.ToString());
            ASPxComboBoxOrigen.Value = Convert.ToInt32(lista[0].origen.ToString());
            //ASPxComboBoxSolicitantes.DataBind();
            ASPxComboBoxSolicitantes.Value = lista[0].solicitante.ToString();
            ASPxRadioButtonListTipo.Value = Convert.ToInt32(lista[0].tipo_correspondencia.ToString());
            txtJust.Text = lista[0].justificacion.ToString();

            TextF_Doc.Text = lista[0].fe_documento.ToString("yyyy-MM-dd");
            ASPxTextReferencia.Text = lista[0].ds_referencia.ToString();

            lblAccion.Text = "m";
            lblCodAgenda.Text = cod_agenda.ToString();
        }

        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            //guardar Cambios.
            //Ejecutar procedimiento para guardar datos.
            int cod_agenda = 0;
            if (lblAccion.Text == "n")
            {
                cod_agenda = 0;
            }
            else
            {
                cod_agenda = Convert.ToInt32(lblCodAgenda.Text);
            }
            manto_correspondencia.nuevo(lblAccion.Text, cod_agenda, txtPunto.Text, txtJust.Text, Convert.ToInt32(ASPxRadioButtonListTipo.Value), Convert.ToInt32(ASPxComboBoxOrigen.Value), Convert.ToInt32(ASPxComboBoxSolicitantes.SelectedItem.Value), Convert.ToInt32(ASPxComboBoxEstado.Value), Convert.ToDateTime(TextBoxFecha_Solicitud.Text), Convert.ToDateTime(TextBoxFecha_Registro.Text), Convert.ToInt32(Session["UserID"]), ASPxTextReferencia.Text, Convert.ToDateTime(TextF_Doc.Text));
            //Inicializar página
            Response.Redirect("~/modulos/correspondencia.aspx");
        }

        protected void brnCanelar_Click(object sender, EventArgs e)
        {
            PagerCorrespondencia.ActiveTabIndex = 0;
            PagerCorrespondencia.TabPages[1].Enabled = false;
        }

        protected void ASPxComboBoxOrigen_SelectedIndexChanged(object sender, EventArgs e)
        {
            ASPxComboBoxSolicitantes.SelectedIndex = 0;
        }
    }
}