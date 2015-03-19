using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using SICSA.clases;

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
                ASPxDocumentViewerConvocatoria.Visible = false;
                txtFechaRep.Text = DateTime.Today.ToString("yyyy-MM-dd");
                txtHoraRep.Text = "08:00";
                TextBoxFecha_Solicitud.Text = DateTime.Today.ToString("yyyy-MM-dd");
                TextF_Doc.Text = DateTime.Today.ToString("yyyy-MM-dd");
                ASPxComboBoxOrigen.SelectedIndex = 0;
                //ASPxRadioButtonListTipo.SelectedIndex = 0;
            }
        }

        protected void btnNuevo_Click(object sender, EventArgs e)
        {
            //Nueva Convocatoria
            PageConvocatoria.TabPages[1].Enabled = true;
            PageConvocatoria.ActiveTabIndex = 1;
            lblRef.Text = "Nueva convocatoria";
            lblAccion.Text = "n";
            ASPxPageSesion.ActiveTabIndex = 0;
            ASPxPageSesion.TabPages[1].Enabled = false;
            ASPxPageSesion.TabPages[2].Enabled = false;
            ASPxPageSesion.TabPages[3].Enabled = false;
            ASPxPageSesion.TabPages[4].Enabled = false;
            ASPxPageSesion.TabPages[5].Enabled = false;
            txtFecha.Text = DateTime.Today.ToString("yyyy-MM-dd");
            txtHora.Text = "08:00";
            ASPxComboBoxEstadoSesion.SelectedIndex = 0;
            ASPxComboBoxTipoSesion.SelectedIndex = 0;
            ASPxComboLugar.SelectedIndex = 0;
            txtRef.ReadOnly = false;
            txtFecha.ReadOnly = false;
            txtHora.ReadOnly = false;
            ASPxComboBoxTipoSesion.Enabled = true;
            ASPxComboBoxEstadoSesion.Enabled = true;
            ASPxComboLugar.Enabled = true;
            btnAceptar.Enabled = true;
            txtRef.Text = "";
            //ASPxRadioButtonListTipo.Value = 1;
            ASPxComboBoxOrigen.Value = 1;
            //SqlDataSolicitantes.DataBind();
            //ASPxComboBoxSolicitantes.DataBind();
            ASPxComboBoxSolicitantes.SelectedIndex = 0;
            TextBoxFecha_Solicitud.Text = DateTime.Today.ToString("yyyy-MM-dd");
            
        }

        protected void btnSeleccionar_Click(object sender, EventArgs e)
        {
            lblAccion.Text = "m";
            //obtener codigo de convocatoria.

            //obtener datos de encabezado
            DatosSeleccionadoConvocatoria();

        }

        private void DatosSeleccionadoConvocatoria()
        {
            Int32 inicio = ASPxGridConvocatoria.VisibleStartIndex;
            Int32 fin = ASPxGridConvocatoria.VisibleStartIndex + ASPxGridConvocatoria.SettingsPager.PageSize;
            fin = (fin > ASPxGridConvocatoria.VisibleRowCount ? ASPxGridConvocatoria.VisibleRowCount : fin);
            int cd_conv = 0;
            for (int i = inicio; i < fin; i++)
            {
                if (ASPxGridConvocatoria.Selection.IsRowSelected(i))
                {
                    List<object> resultado = new List<object>();
                    cd_conv = (int)ASPxGridConvocatoria.GetRowValues(i, "CD_ENCA_CONVOCATORIA");
                }
            }
            //Cargar datos en componentes de encabezado
            cargar_componentes(Convert.ToInt32(cd_conv));
        }
        private void cargar_componentes(int cd_conv)
        {
            TextBoxFecha_Registro.ReadOnly = true;
            PageConvocatoria.TabPages[1].Enabled = true;
            PageConvocatoria.ActiveTabIndex = 1;

            //llenar_grid(Convert.ToInt32(DDLPeriodo.SelectedItem.Value));
            List<datos_convocatoria> lista = new List<datos_convocatoria>();
   
            lista = convocatoria_m.datos_convocatoria(Convert.ToInt32(cd_conv));
            txtRef.Text = lista[0].ds_ref.ToString();
            lblRef.Text = txtRef.Text;
            ASPxComboBoxTipoSesion.Value = lista[0].cd_sesion;
            ASPxComboBoxEstadoSesion.Value = lista[0].cd_estado;
            txtFecha.Text = lista[0].fe_prop.ToString("yyyy-MM-dd");
            txtHora.Text = lista[0].hora_prop.ToString();
            ASPxComboLugar.Value = lista[0].cd_lugar;

            //setear controles
            lblConvocatoria.Text = cd_conv.ToString();
            txtRef.ReadOnly = true;
            txtRef.ReadOnly = true;
            txtFecha.ReadOnly = true;
            txtHora.ReadOnly = true;
            ASPxComboBoxTipoSesion.Enabled = false;
            ASPxComboBoxEstadoSesion.Enabled = false;
            btnAceptar.Enabled = false;
            lblAccion.Text = "m";
            ASPxComboLugar.Enabled = false;
            ASPxPageSesion.ActiveTabIndex = 0;
        }


        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            int cod_convocatoria = 0;
            if (lblAccion.Text == "n")
            {
                cod_convocatoria = 0;
            }
            else
            {
                cod_convocatoria = Convert.ToInt32(lblConvocatoria.Text);
            }
            //Validar fecha
            bool v_fecha = manto_convocatoria.validar_fecha(Convert.ToDateTime(txtFecha.Text));

            if (!v_fecha)
            {
                //dia festivo
                string script = "alert('La fecha de convocatoria es un día No Laboral, Intente con otro día');";
                ScriptManager.RegisterStartupScript(this, typeof(Page), "Aviso", script, true);
            }
            else
            {
                //procede
                manto_convocatoria.nuevo(lblAccion.Text, cod_convocatoria, txtRef.Text, Convert.ToInt32(ASPxComboBoxTipoSesion.Value), Convert.ToInt32(ASPxComboBoxEstadoSesion.Value), txtFecha.Text, txtHora.Text, Convert.ToInt32(ASPxComboLugar.Value), Convert.ToInt32(Session["UserID"].ToString()), TextBoxFecha_Registro.Text);
                //Recargar Grid
                ASPxGridConvocatoria.DataBind();

                //Inicializar página
                lblRef.Text = txtRef.Text;

                //Obtener codigo de convocatoria para activar las demás tabs
                string strquery = "  SELECT TOP 1 CD_ENCA_CONVOCATORIA FROM dbo.AGD_ENCA_CONVOCATORIA WHERE DS_REFERENCIA = '" + lblRef.Text + "' ORDER BY FECH_CREA DESC";
                int cod_conv = 0;
                SqlDataAdapter da = new SqlDataAdapter();
                DataTable dt = new DataTable();

                using (SqlConnection con = conexion.conectarBD())
                {
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = con;
                    cmd.CommandText = strquery;
                    da.SelectCommand = cmd;
                    da.Fill(dt);
                    if (dt.Rows.Count > 0)
                    {
                        cod_conv = Convert.ToInt32(dt.Rows[0][0]);
                    }
                }

                lblConvocatoria.Text = cod_conv.ToString();
                txtConv.Text = cod_conv.ToString();


                //Activar Tabs y bloquear los elementos de la pestaña de encabezado
                //activar_pestañas(true);
                ASPxPageSesion.TabPages[1].Enabled = true;
                ASPxPageSesion.TabPages[2].Enabled = true;
                ASPxPageSesion.TabPages[3].Enabled = true;
                ASPxPageSesion.TabPages[4].Enabled = true;
                ASPxPageSesion.TabPages[5].Enabled = true;
                lblAccion.Text = "m";
                txtRef.ReadOnly = true;
                txtFecha.ReadOnly = true;
                txtHora.ReadOnly = true;
                ASPxComboBoxTipoSesion.Enabled = false;
                ASPxComboBoxEstadoSesion.Enabled = false;
                ASPxPageSesion.ActiveTabIndex = 1;
                btnAceptar.Enabled = false;
                ASPxComboLugar.Enabled = false;
                ASPxGridConvocatoria.DataBind();
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            PageConvocatoria.TabPages[1].Enabled = false;
            PageConvocatoria.ActiveTabIndex = 0;
        }

        protected void ASPxPageSesion_ActiveTabChanged(object source, DevExpress.Web.TabControlEventArgs e)
        {
            GridPuntosAgenda.DataBind();
            repAgenda.reporte_Agenda(Convert.ToInt32(lblConvocatoria.Text));
            ASPxDocumentViewerAgenda.DataBind();
            //Llenar reprogramaciones
            ASPxGridReprogramaciones.DataBind();
            txtFechaOrg.Text = txtFecha.Text;
            txtHoraOrg.Text = txtHora.Text;
            lblTipoSesion.Text = ASPxComboBoxTipoSesion.SelectedItem.Text;
            ASPxGridPuntos.DataBind();
            if (ASPxPageSesion.ActiveTabIndex == 5)
            {
                TextBoxFecha_Solicitud.Text = DateTime.Today.ToString("yyyy-MM-dd");
                TextF_Doc.Text = DateTime.Today.ToString("yyyy-MM-dd");
                ASPxComboBoxOrigen.SelectedIndex = 0;
                ASPxComboBoxSolicitantes.SelectedIndex = 0;
            }
        }
        private void TomaDatosSeleccionados(int accion)
        {
            // accion: 0=quitar, 1=arriba, 2=abajo
            Int32 inicio = GridPuntosAgenda.VisibleStartIndex;
            Int32 fin = GridPuntosAgenda.VisibleStartIndex + GridPuntosAgenda.SettingsPager.PageSize;
            fin = (fin > GridPuntosAgenda.VisibleRowCount ? GridPuntosAgenda.VisibleRowCount : fin);
            int cd_conv = 0;
            for (int i = inicio; i < fin; i++)
            {
                if (GridPuntosAgenda.Selection.IsRowSelected(i))
                {
                    List<object> resultado = new List<object>();
                    cd_conv = (int)GridPuntosAgenda.GetRowValues(i, "CD_CONVOCATORIA");
                }
            }
            //Ejecutar orden
            Ejecutar_ordenamiento(accion, cd_conv);
        }

        private void Ejecutar_ordenamiento(int accion, int cd_conv)
        {
            using (System.Data.SqlClient.SqlConnection con = conexion.conectarBD())
            {
                SqlCommand Com = new SqlCommand();
                SqlDataAdapter Adp = new SqlDataAdapter();
                DataTable Dt = new DataTable();

                Com.Connection = con;
                Com.CommandType = CommandType.StoredProcedure;
                Com.CommandText = "ordenar_puntos_agenda_sp";
                Com.Parameters.Add(new SqlParameter("@accion", SqlDbType.VarChar));
                Com.Parameters["@accion"].Value = accion;
                Com.Parameters.Add(new SqlParameter("@cd_conv", SqlDbType.Int));
                Com.Parameters["@cd_conv"].Value = cd_conv;

                Adp.SelectCommand = Com;
                Adp.Fill(Dt);
            }

            GridPuntosAgenda.DataBind();
            ASPxGridPuntos.DataBind();
        }

        protected void imgSubir_Click(object sender, ImageClickEventArgs e)
        {
            TomaDatosSeleccionados(1);
            repAgenda.reporte_Agenda(Convert.ToInt32(lblConvocatoria.Text));
            ASPxDocumentViewerAgenda.DataBind();
        }

        protected void imgBajar_Click(object sender, ImageClickEventArgs e)
        {
            TomaDatosSeleccionados(2);
            repAgenda.reporte_Agenda(Convert.ToInt32(lblConvocatoria.Text));
            ASPxDocumentViewerAgenda.DataBind();
        }

        protected void imgQuitar_Click(object sender, ImageClickEventArgs e)
        {
            TomaDatosSeleccionados(0);
            repAgenda.reporte_Agenda(Convert.ToInt32(lblConvocatoria.Text));
            ASPxDocumentViewerAgenda.DataBind();
        }

        private void MiembrosSeleccionados()
        {
            // accion: 0=quitar, 1=arriba, 2=abajo
            Int32 inicio = ASPxGridViewMiembrosPleno.VisibleStartIndex;
            Int32 fin = ASPxGridViewMiembrosPleno.VisibleStartIndex + ASPxGridViewMiembrosPleno.SettingsPager.PageSize;
            fin = (fin > ASPxGridViewMiembrosPleno.VisibleRowCount ? ASPxGridViewMiembrosPleno.VisibleRowCount : fin);
            int cd_mimebro = 0;
            List<object> resultado = new List<object>();
            convocatoria_miembros.suprimir(Convert.ToInt32(lblConvocatoria.Text));
            for (int i = inicio; i < fin; i++)
            {
                if (ASPxGridViewMiembrosPleno.Selection.IsRowSelected(i))
                {
                    cd_mimebro = (int)ASPxGridViewMiembrosPleno.GetRowValues(i, "CD_MIEMBRO_PLENO");
                    resultado.Add(cd_mimebro);
                    convocatoria_miembros.insertar(Convert.ToInt32(lblConvocatoria.Text), cd_mimebro, Convert.ToInt32(Session["UserID"].ToString()));
                }
            }
        }

        protected void ASPxButtonConvocatoria_Click(object sender, EventArgs e)
        {
            MiembrosSeleccionados();
            ASPxDocumentViewerConvocatoria.Visible = true;
            rep_convocatoria.reporte_Convocatoria(Convert.ToInt32(lblConvocatoria.Text));
            repAgenda.reporte_Agenda(Convert.ToInt32(lblConvocatoria.Text));

            //Enviar correos
            manto_convocatoria.enviar_correo(Convert.ToInt32(Session["UserID"].ToString()));

            ASPxDocumentViewerConvocatoria.DataBind();
        }

        protected void ASPxButtonRNotificar_Click(object sender, EventArgs e)
        {
            ASPxPageSesion.ActiveTabIndex = 3;
        }

        protected void ASPxButtonPosponer_Click(object sender, EventArgs e)
        {
            bool v_fecha = manto_convocatoria.validar_fecha(Convert.ToDateTime(txtFecha.Text));

            if (!v_fecha)
            {
                //dia festivo
                string script = "alert('La fecha de convocatoria es un día No Laboral, Intente con otro día');";
                ScriptManager.RegisterStartupScript(this, typeof(Page), "Aviso", script, true);
            }
            else
            {
                convocatoria_miembros.reprogramar(Convert.ToInt32(lblConvocatoria.Text), Convert.ToDateTime(txtFechaRep.Text), txtHoraRep.Text, ASPxMemoRJust.Text, Convert.ToInt32(Session["UserID"]));
                ASPxGridReprogramaciones.DataBind();
                rep_convocatoria.reporte_Convocatoria(Convert.ToInt32(lblConvocatoria.Text));
                ASPxDocumentViewerConvocatoria.DataBind();
            }
        }

        protected void ASPxButtonAgregar_Click(object sender, EventArgs e)
        {
            int cod_agenda = 0;
            if (lblAccion.Text == "n")
            {
                cod_agenda = 0;
            }
            else
            {
                //cod_agenda = Convert.ToInt32(lblCodAgenda.Text);
            }
            //bool v_fecha = manto_convocatoria.validar_fecha(Convert.ToDateTime(txtFecha.Text));

            //if (!v_fecha)
            //{
            //    //dia festivo
            //    string script = "alert('La fecha de convocatoria es un día No Laboral, Intente con otro día');";
            //    ScriptManager.RegisterStartupScript(this, typeof(Page), "Aviso", script, true);
            //}
            //else
            //{
            if (txtPunto.Text == "")
            {
                string script = "alert('Debe proporcionar la información de los campos solicitados');";
                ScriptManager.RegisterStartupScript(this, typeof(Page), "Aviso", script, true);
            }
            else
            {
                manto_correspondencia.nuevo("n", cod_agenda, txtPunto.Text, txtJust.Text, 2, Convert.ToInt32(ASPxComboBoxOrigen.Value), Convert.ToInt32(ASPxComboBoxSolicitantes.SelectedItem.Value), 1, Convert.ToDateTime(TextBoxFecha_Solicitud.Text), Convert.ToDateTime(TextBoxFecha_Registro.Text), Convert.ToInt32(Session["UserID"]), ASPxTextReferencia.Text, Convert.ToDateTime(TextF_Doc.Text));
                ASPxTextReferencia.Text = "";
                txtPunto.Text = "";
                txtJust.Text = "";
                ASPxGridPuntos.DataBind();
                ASPxPageSesion.ActiveTabIndex = 1;
            }
        //    }
        }

        protected void ASPxComboBoxOrigen_SelectedIndexChanged(object sender, EventArgs e)
        {
            ASPxComboBoxSolicitantes.SelectedIndex = 0;
        }

        protected void ASPxCheckBox1_CheckedChanged(object sender, EventArgs e)
        {
            if (ASPxCheckBox1.Checked)
            {
                for (int i = 0; i <= 4; i++)
                {
                    ASPxGridViewMiembrosPleno.Selection.SetSelection(i, true);
                }
            }
            else
            {
                for (int i = 0; i <= 4; i++)
                {
                    ASPxGridViewMiembrosPleno.Selection.SetSelection(i, false);
                }
            }
        }
    }
}