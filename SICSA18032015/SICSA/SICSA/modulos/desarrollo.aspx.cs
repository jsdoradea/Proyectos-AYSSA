using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using SICSA.clases;

namespace SICSA.modulos
{
    public partial class desarrollo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ASPxPageDesarrollo.ActiveTabIndex = 0;
                ASPxPageDesarrollo.TabPages[1].Enabled = false;
                ASPxComboBoxPeriodo.SelectedIndex = 0;
                TextBoxFecha_Registro.Text = DateTime.Today.ToString("yyyy-MM-dd");
            }
        }
        protected void btnSeleccionar_Click(object sender, EventArgs e)
        {

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
            ASPxPageDesarrollo.TabPages[1].Enabled = true;
            ASPxPageDesarrollo.ActiveTabIndex = 1;
            ASPxPagePuntosDesarrollo.ActiveTabIndex = 0;

            //llenar_grid(Convert.ToInt32(DDLPeriodo.SelectedItem.Value));
            List<datos_convocatoria> lista = new List<datos_convocatoria>();

            lista = convocatoria_m.datos_convocatoria(Convert.ToInt32(cd_conv));
            lblRef.Text = lista[0].ds_ref.ToString();
            //setear controles
            lblConvocatoria.Text = cd_conv.ToString();
            repAgenda.reporte_Agenda(Convert.ToInt32(lblConvocatoria.Text));
            ASPxDocumentViewerAgenda.DataBind();
        }

        protected void ASPxButtonAgregar_Click(object sender, EventArgs e)
        {
            //obtener codigos de miembros
            DatosSeleccionadoNoConvocados(Convert.ToInt32(lblConvocatoria.Text));
            ASPxCheckMiembrosVotan.DataBind();
        }
        private void DatosSeleccionadoNoConvocados(int cod_convocatoria)
        {
            Int32 inicio = ASPxGridNoConvocados.VisibleStartIndex;
            Int32 fin = ASPxGridNoConvocados.VisibleStartIndex + ASPxGridNoConvocados.SettingsPager.PageSize;
            fin = (fin > ASPxGridNoConvocados.VisibleRowCount ? ASPxGridNoConvocados.VisibleRowCount : fin);
            int cd_miembro = 0;
            for (int i = inicio; i < fin; i++)
            {
                if (ASPxGridNoConvocados.Selection.IsRowSelected(i))
                {
                    List<object> resultado = new List<object>();
                    cd_miembro = (int)ASPxGridNoConvocados.GetRowValues(i, "CD_MIEMBRO_PLENO");
                    convocatoria_miembros.insertar(cod_convocatoria, cd_miembro, Convert.ToInt32(Session["UserID"]));
                }
            }
            //Actualizar Grids
            ASPxGridNoConvocados.DataBind();
            ASPxGridConvocados.DataBind();
        }

        protected void ASPxButtonQuitar_Click(object sender, EventArgs e)
        {
            //obtener codigos de miembros de miembros convocados
            DatosSeleccionadoConvocados(Convert.ToInt32(lblConvocatoria.Text));
            ASPxCheckMiembrosVotan.DataBind();
        }
        private void DatosSeleccionadoConvocados(int cod_convocatoria)
        {
            Int32 inicio = ASPxGridConvocados.VisibleStartIndex;
            Int32 fin = ASPxGridConvocados.VisibleStartIndex + ASPxGridConvocados.SettingsPager.PageSize;
            fin = (fin > ASPxGridConvocados.VisibleRowCount ? ASPxGridConvocados.VisibleRowCount : fin);
            int cd_miembro = 0;
            for (int i = inicio; i < fin; i++)
            {
                if (ASPxGridConvocados.Selection.IsRowSelected(i))
                {
                    List<object> resultado = new List<object>();
                    cd_miembro = (int)ASPxGridConvocados.GetRowValues(i, "CD_MIEMBRO_PLENO");
                    convocatoria_miembros.quitarmiembro(cod_convocatoria, cd_miembro);
                }
            }
            //Actualizar Grids
            ASPxGridNoConvocados.DataBind();
            ASPxGridConvocados.DataBind();
        }

        protected void ASPxButtonAgendaDef_Click(object sender, EventArgs e)
        {
            repAgenda.reporte_Agenda(Convert.ToInt32(lblConvocatoria.Text));
            ASPxDocumentViewerAgenda.DataBind();
        }

        protected void ASPxButtonAdicion_Click(object sender, EventArgs e)
        {
            ASPxComboBoxOrigen.Enabled = true;
            ASPxComboBoxOrigen.SelectedIndex = 0;
            ASPxComboBoxSolicitantes.Enabled = true;
            ASPxComboBoxSolicitantes.SelectedIndex = 0;
            TextBoxNombre.Enabled = true;
            TextBoxNombre.Text = "";
            TextBoxJust.Enabled = true;
            TextBoxJust.Text = "";
            ASPxRadioButtonList1.Enabled = true;
            ASPxRadioButtonList1.SelectedIndex = 0;
            ASPxButtonGuardar.Enabled = true;
            ASPxButtonCancelar.Enabled = true;
            ASPxTextBoxRef.Enabled = true;
            TextBoxFDoc.Enabled = true;
            TextBoxFDoc.Text = DateTime.Today.ToString("yyyy-MM-dd");
        }

        protected void ASPxButtonCancelar_Click(object sender, EventArgs e)
        {
            ASPxComboBoxOrigen.Enabled = false;
            ASPxComboBoxOrigen.SelectedIndex = 0;
            ASPxComboBoxSolicitantes.Enabled = false;
            ASPxComboBoxSolicitantes.SelectedIndex = 0;
            TextBoxNombre.Enabled = false;
            TextBoxNombre.Text = "";
            TextBoxJust.Enabled = false;
            TextBoxJust.Text = "";
            ASPxRadioButtonList1.Enabled = false;
            ASPxRadioButtonList1.SelectedIndex = 0;
            ASPxButtonGuardar.Enabled = false;
            ASPxButtonCancelar.Enabled = false;
            ASPxTextBoxRef.Enabled = false;
            TextBoxFDoc.Enabled = false;
        }
        protected void btnSeleccionarPuntos_Click(object sender, EventArgs e)
        {
            DatosSeleccionadoPuntos();
        }
        private void DatosSeleccionadoPuntos()
        {
            Int32 inicio = ASPxGridPuntos.VisibleStartIndex;
            Int32 fin = ASPxGridPuntos.VisibleStartIndex + ASPxGridPuntos.SettingsPager.PageSize;
            fin = (fin > ASPxGridPuntos.VisibleRowCount ? ASPxGridPuntos.VisibleRowCount : fin);
            int cd_punto = 0;
            for (int i = inicio; i < fin; i++)
            {
                if (ASPxGridPuntos.Selection.IsRowSelected(i))
                {
                    List<object> resultado = new List<object>();
                    cd_punto = (int)ASPxGridPuntos.GetRowValues(i, "CD_CONVOCATORIA");
                }
            }
            //llenar datos
            llenar_info_punto(cd_punto);
            lblCdPunto.Text = cd_punto.ToString();
            ASPxGridViewDocumentos.DataBind();

        }
        private void llenar_info_punto(int cd_punto)
        {
            List<datos_conv_puntos> lista = new List<datos_conv_puntos>();
            lista = conv_puntos.datos_conv_puntos(Convert.ToInt32(cd_punto));


            ASPxComboBoxOrigen.Enabled = true;
            ASPxComboBoxOrigen.Value = Convert.ToInt32(lista[0].cd_origen_punto.ToString());

            ASPxComboBoxSolicitantes.Enabled = true;
            ASPxComboBoxSolicitantes.Value = Convert.ToInt32(lista[0].cd_unidad_inst.ToString());
            TextBoxNombre.Enabled = true;
            TextBoxNombre.Text = lista[0].ds_punto.ToString();
            TextBoxJust.Enabled = true;
            TextBoxJust.Text = lista[0].ds_justifica;
            ASPxRadioButtonList1.Enabled = true;
            ASPxRadioButtonList1.Value = Convert.ToInt32(lista[0].cd_tipo_punto.ToString());
            ASPxButtonGuardar.Enabled = true;
            ASPxButtonCancelar.Enabled = true;
            lblAccionAgenda.Text = "m";
            lblCDPt.Text = lista[0].cod_punto.ToString();
            ASPxTextBoxRef.Enabled = true;
            TextBoxFDoc.Enabled = true;
            ASPxTextBoxRef.Text = lista[0].referencia.ToString();
            TextBoxFDoc.Text = lista[0].fec_doc.ToString("yyyy-MM-dd");
        }

        protected void ASPxButtonGuardar_Click(object sender, EventArgs e)
        {
            if (lblAccionAgenda.Text == "m")
            {
                manto_correspondencia.nuevo("m", Convert.ToInt32(lblCDPt.Text), TextBoxNombre.Text, TextBoxJust.Text, 1, Convert.ToInt32(ASPxComboBoxOrigen.Value), Convert.ToInt32(ASPxComboBoxSolicitantes.Value), 1, DateTime.Today, Convert.ToDateTime(TextBoxFecha_Registro.Text), Convert.ToInt32(Session["UserID"]), ASPxTextBoxRef.Text, Convert.ToDateTime(TextBoxFDoc.Text));
                conv_puntos_desarrollo.actualizar_tipo_punto(Convert.ToInt32(lblCdPunto.Text), Convert.ToInt32(ASPxRadioButtonList1.Value)); 
            }
            else
            {
                manto_correspondencia.nuevo("n", 0, TextBoxNombre.Text, TextBoxJust.Text, 1, Convert.ToInt32(ASPxComboBoxOrigen.Value), Convert.ToInt32(ASPxComboBoxSolicitantes.SelectedItem.Value), 3, DateTime.Today, Convert.ToDateTime(TextBoxFecha_Registro.Text), Convert.ToInt32(Session["UserID"]), ASPxTextBoxRef.Text, Convert.ToDateTime(TextBoxFDoc.Text));
                conv_puntos_desarrollo.nuevo(Convert.ToInt32(lblConvocatoria.Text), TextBoxNombre.Text, Convert.ToInt32(ASPxComboBoxOrigen.Value), Convert.ToInt32(ASPxRadioButtonList1.Value));
            }
            ASPxGridPuntos.DataBind();
            repAgenda.reporte_Agenda(Convert.ToInt32(lblConvocatoria.Text));
            ASPxDocumentViewerAgenda.DataBind();
            ASPxComboBoxOrigen.Enabled = false;
            ASPxComboBoxOrigen.SelectedIndex = 0;
            ASPxComboBoxSolicitantes.Enabled = false;
            ASPxComboBoxSolicitantes.SelectedIndex = 0;
            TextBoxNombre.Enabled = false;
            TextBoxNombre.Text = "";
            TextBoxJust.Enabled = false;
            TextBoxJust.Text = "";
            ASPxRadioButtonList1.Enabled = false;
            ASPxRadioButtonList1.SelectedIndex = 0;
            ASPxTextBoxRef.Enabled = false;
            TextBoxFDoc.Enabled = false;
            ASPxButtonGuardar.Enabled = false;
            ASPxButtonCancelar.Enabled = false;
            ASPxGridViewPuntosTratados.DataBind();
        }

        protected void btnSeleccionarPT_Click(object sender, EventArgs e)
        {
            DatosSeleccionadoPuntosTratados();
        }
        private void DatosSeleccionadoPuntosTratados()
        {
            Int32 inicio = ASPxGridViewPuntosTratados.VisibleStartIndex;
            Int32 fin = ASPxGridViewPuntosTratados.VisibleStartIndex + ASPxGridViewPuntosTratados.SettingsPager.PageSize;
            fin = (fin > ASPxGridViewPuntosTratados.VisibleRowCount ? ASPxGridViewPuntosTratados.VisibleRowCount : fin);
            int cd_punto = 0;
            for (int i = inicio; i < fin; i++)
            {
                if (ASPxGridViewPuntosTratados.Selection.IsRowSelected(i))
                {
                    List<object> resultado = new List<object>();
                    cd_punto = (int)ASPxGridViewPuntosTratados.GetRowValues(i, "CD_CONVOCATORIA");
                }
            }
            //llenar datos
            llenar_info_punto_tratado(cd_punto);

        }


        private void llenar_info_punto_tratado(int cd_punto)
        {
            ASPxPanelGrid.Visible = false;
            ASPxPanelTabs.Visible = true;
            ASPxPageControl1.ActiveTabIndex = 0;
            ASPxLabelCodPunto.Text  = cd_punto.ToString();
            List<datos_puntos_tratados> lista = new List<datos_puntos_tratados>();
            lista =  puntos_tratados.datos_puntos_tratados(Convert.ToInt32(cd_punto));

            ASPxLabelPunto.Text = "Punto N°: " + lista[0].orden.ToString();
            ASPxLabelNombre.Text = lista[0].ds_punto_ag.ToString();
            ASPxLabelSolicitante.Text = "Solicita: " + lista[0].solicitante.ToString();
            ASPxHtmlEditor1.Html = lista[0].aspectos.ToString().Replace("\\\"","\""); ;

        }

        protected void ASPxButtonCancelarPT_Click(object sender, EventArgs e)
        {
            ASPxPanelGrid.Visible = true;
            ASPxPanelTabs.Visible = false;
        }

        protected void ASPxButtonSubirDoc_Click(object sender, EventArgs e)
        {
            if (ASPxTextBoxNombreDoc.Text == "")
            {
                ASPxLabelError.Text = "Debe asignar un nombre al archivo";
                ASPxLabelError.Visible = true;
            }
            else
            {
                if (FileUpload1.HasFile)
                {
                    string nombre_doc = FileUpload1.FileName;
                    DateTime fecha_hoy = DateTime.Now;
                    string prefijo = fecha_hoy.ToString("ddMMyyyyHHmmss") + "-";
                    string sURL = "~/Content/documentos/" + prefijo + nombre_doc;
                    FileUpload1.PostedFile.SaveAs(Server.MapPath(sURL));
                    manto_desarrollo.insertar(Convert.ToInt32(ASPxLabelCodPunto.Text), ASPxTextBoxNombreDoc.Text, ASPxTextBoxDescDoc.Text, sURL, Convert.ToInt32(Session["UserID"].ToString()));
                    ASPxGridViewDocumentos.DataBind();
                    ASPxTextBoxNombreDoc.Text = "";
                    ASPxTextBoxDescDoc.Text = "";
                    ASPxLabelError.Text = "";
                    ASPxLabelError.Visible = false;
                }
                else
                {
                    ASPxLabelError.Text = "No se ha seleccionado archivo";
                    ASPxLabelError.Visible = true;
                }
            }
        }

        protected void ASPxButtonGuardarAspecto_Click(object sender, EventArgs e)
        {
            string textoAspecto = ASPxHtmlEditor1.Html;
            string ds_nota = textoAspecto.Replace("'", "");
            ds_nota = ds_nota.Replace("\"", "\\\"");
            manto_desarrollo.actualizar_aspecto((Convert.ToInt32(ASPxLabelCodPunto.Text)), ds_nota, Convert.ToInt32(Session["UserID"].ToString()));
        }

        protected void btnSeleccionarACU_Click(object sender, EventArgs e)
        {
            lblAccionAcuerdo.Text = "m";
            ASPxLabelAccionVoto.Text = "m";
            DatosSeleccionadoAcuerdo();
            ASPxLabelAccionVoto.Text = "m";
        }

        private void DatosSeleccionadoAcuerdo()
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
            //llenar datos
            ASPxLabelCodAcuerdo.Text = cd_acuerdo.ToString();
            ASPxGridNotificados.DataBind();
            llenar_info_acuerdo(cd_acuerdo);
        }


        private void llenar_info_acuerdo(int cd_acuerdo)
        {
            //Datos del acuerdo
            List<datos_acuerdo> lista = new List<datos_acuerdo>();

            lista = manto_acuerdos.datos_acuerdo(Convert.ToInt32(cd_acuerdo));
            ASPxTextNomAcuerdo.Text = lista[0].ds_acuerdo_comp.ToString();
            ASPxTextNomAcuerdo.Enabled = true;
            ASPxMemoAcuerdoLargo.Text = lista[0].ds_acuerdo_corto.ToString();
            ASPxMemoAcuerdoLargo.Enabled = true;
            ASPxComboTipoAcuerdo.Value = Convert.ToInt32(lista[0].tipo_acuerdo.ToString());
            ASPxComboTipoAcuerdo.Enabled = true;
            TextFechaAcuerdo.Text = lista[0].fecha_inicio.ToString("yyyy-MM-dd");
            TextFechaAcuerdo.Enabled = true;
            TextDuracionAcuerdo.Text = lista[0].periodo.ToString();
            TextDuracionAcuerdo.Enabled = true;
            ASPxButtonGuardarAcuerdo.Enabled = true;
            ASPxComboEmpleados.SelectedIndex = 0;
            ASPxComboEmpleados.Enabled = true;
            ASPxRadioButtonList2.Enabled = true;
            ASPxButtonNotificar.Enabled = true;
            ASPxCheckMiembrosVotan.Enabled = true;
            ASPxButtonTerminarVotacion.Enabled = true;
            ASPxComboEmpleados0.Enabled = true;
            ASPxComboEmpleados0.Value = lista[0].responsable.ToString();
        }




        protected void ASPxButtonNuevoAcuerdo_Click(object sender, EventArgs e)
        {
            ASPxTextNomAcuerdo.Enabled = true;
            ASPxTextNomAcuerdo.Text = "";
            ASPxMemoAcuerdoLargo.Enabled = true;
            ASPxMemoAcuerdoLargo.Text = "";
            ASPxComboTipoAcuerdo.Enabled = true;
            ASPxComboTipoAcuerdo.SelectedIndex = 0;
            TextFechaAcuerdo.Enabled = true;
            TextFechaAcuerdo.Text = DateTime.Today.ToString("yyyy-MM-dd");
            TextDuracionAcuerdo.Enabled = true;
            TextDuracionAcuerdo.Text = "10";
            ASPxComboEmpleados0.Enabled = true;
            ASPxComboEmpleados0.SelectedIndex = 0;
            ASPxButtonGuardarAcuerdo.Enabled = true;
            lblAccionAcuerdo.Text = "n";
            ASPxLabelCodAcuerdo.Text = "0";
            ASPxLabelAccionVoto.Text = "n";
        }

        protected void ASPxButtonGuardarAcuerdo_Click(object sender, EventArgs e)
        {
            //Validar fecha
            bool v_fecha = manto_convocatoria.validar_fecha(Convert.ToDateTime(TextFechaAcuerdo.Text));

            if (!v_fecha)
            {
                //dia festivo
                string script = "alert('La fecha de convocatoria es un día No Laboral, Intente con otro día');";
                ScriptManager.RegisterStartupScript(this, typeof(Page), "Aviso", script, true);
            }
            else
            {
                //procede

                int cod_acuerdo = 0;
                manto_acuerdos.nuevo_acuerdo(lblAccionAcuerdo.Text, Convert.ToInt32(ASPxLabelCodPunto.Text), Convert.ToDateTime(TextBoxFecha_Registro.Text), ASPxTextNomAcuerdo.Text, ASPxMemoAcuerdoLargo.Text, Convert.ToDateTime(TextFechaAcuerdo.Text), Convert.ToInt32(TextDuracionAcuerdo.Text), Convert.ToInt32(Session["UserID"].ToString()), Convert.ToInt32(ASPxLabelCodAcuerdo.Text), Convert.ToInt32(ASPxComboTipoAcuerdo.Value), Convert.ToInt32(ASPxComboEmpleados0.Value));
                ASPxGridAcuerdos.DataBind();
                lblAccionAcuerdo.Text = "m";
                ASPxLabelAccionVoto.Text = "n";
                cod_acuerdo = manto_acuerdos.obterner_cd_acuerdo(Convert.ToInt32(ASPxLabelCodPunto.Text), Convert.ToDateTime(TextBoxFecha_Registro.Text), ASPxTextNomAcuerdo.Text, Convert.ToInt32(ASPxComboTipoAcuerdo.Value), Convert.ToDateTime(TextFechaAcuerdo.Text), Convert.ToInt32(TextDuracionAcuerdo.Text), Convert.ToInt32(Session["UserID"].ToString()));
                ASPxLabelCodAcuerdo.Text = cod_acuerdo.ToString();
                ASPxComboEmpleados.Enabled = true;
                ASPxComboEmpleados.SelectedIndex = 0;
                ASPxRadioButtonList2.Enabled = true;
                ASPxButtonNotificar.Enabled = true;
                ASPxCheckMiembrosVotan.Enabled = true;
                ASPxButtonTerminarVotacion.Enabled = true;
            }
        }

        protected void ASPxButtonNotificar_Click(object sender, EventArgs e)
        {
            manto_acuerdos.insertar_notificacion(Convert.ToInt32(ASPxLabelCodAcuerdo.Text), Convert.ToInt32(ASPxComboEmpleados.Value), Convert.ToInt32(ASPxRadioButtonList2.Value));
            ASPxGridNotificados.DataBind();
        }

        protected void ASPxButtonTerminarVotacion_Click(object sender, EventArgs e)
        {
            string votantes = "";
            string votos = "";
            int votos_favor = 0;

            for (int j = 0; j < ASPxCheckMiembrosVotan.Items.Count; j++)
            {
                
                votantes = votantes + ASPxCheckMiembrosVotan.Items[j].Value + ",";
                votos = votos + ASPxCheckMiembrosVotan.Items[j].Selected + ",";
                if (ASPxCheckMiembrosVotan.Items[j].Selected)
                {
                    votos_favor += 1;
                }
            }
            votos = votos.Replace("True", "1");
            votos = votos.Replace("False", "0");

            int estado_acuerdo = 0;

            if (votos_favor < 3)
            {
                ASPxLabelResultadoVotacion.Text = "Denegado";
                estado_acuerdo = 0;
            }
            else
            {
                ASPxLabelResultadoVotacion.Text = "Aprobado";
                estado_acuerdo = 1;
            }

            manto_acuerdos.votacion_acuerdo(votantes, votos, ASPxLabelAccionVoto.Text, Convert.ToInt32(ASPxLabelCodAcuerdo.Text), Convert.ToInt32(Session["UserID"].ToString()), Convert.ToDateTime(TextBoxFecha_Registro.Text));
            ASPxLabelAccionVoto.Text = "m";
            string script = "alert('Votación Registrada, El acuerdo ha sido: " + ASPxLabelResultadoVotacion.Text + "');";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "Aviso", script, true);
        }

        //protected void ASPxButtonGenDocSesion_Click(object sender, EventArgs e)
        //{
        //    ASPxDocumentViewerCierre.Visible = true;
        //    ASPxDocumentViewerCierre.DataBind();
        //}

        protected void ASPxButtonRegCierre_Click(object sender, EventArgs e)
        {
            string script = "";
            if (ASPxTextNumActa.Text == "")
            {
                script = "alert('Debe asignar un acta');";
            }
            else
            {
                manto_desarrollo.actualizar_acta(Convert.ToInt32(lblConvocatoria.Text), ASPxTextNumActa.Text);
                script = "alert('Se ha asignado el numero de acta correctamente');";
            }
            ScriptManager.RegisterStartupScript(this, typeof(Page), "Aviso", script, true);
        }

        private void OrdenarDatos(int accion)
        {
            // accion: 0=quitar, 1=arriba, 2=abajo
            Int32 inicio = ASPxGridPuntos.VisibleStartIndex;
            Int32 fin = ASPxGridPuntos.VisibleStartIndex + ASPxGridPuntos.SettingsPager.PageSize;
            fin = (fin > ASPxGridPuntos.VisibleRowCount ? ASPxGridPuntos.VisibleRowCount : fin);
            int cd_conv = 0;
            for (int i = inicio; i < fin; i++)
            {
                if (ASPxGridPuntos.Selection.IsRowSelected(i))
                {
                    List<object> resultado = new List<object>();
                    cd_conv = (int)ASPxGridPuntos.GetRowValues(i, "CD_CONVOCATORIA");
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

            ASPxGridPuntos.DataBind();
        }

        protected void imgSubir_Click(object sender, ImageClickEventArgs e)
        {
            OrdenarDatos(1);
            repAgenda.reporte_Agenda(Convert.ToInt32(lblConvocatoria.Text));
            ASPxDocumentViewerAgenda.DataBind();
        }

        protected void imgBajar_Click(object sender, ImageClickEventArgs e)
        {
            OrdenarDatos(2);
            repAgenda.reporte_Agenda(Convert.ToInt32(lblConvocatoria.Text));
            ASPxDocumentViewerAgenda.DataBind();
        }

        protected void imgQuitar_Click(object sender, ImageClickEventArgs e)
        {
            OrdenarDatos(0);
            repAgenda.reporte_Agenda(Convert.ToInt32(lblConvocatoria.Text));
            ASPxDocumentViewerAgenda.DataBind();
        }

        protected void ASPxButtonGenRep_Click(object sender, EventArgs e)
        {
            //ObtenerDatosAcuerdo();
        }

        private void ObtenerDatosAcuerdo()
        {
            Int32 inicio = ASPxGridViewRepAcuerdos.VisibleStartIndex;
            Int32 fin = ASPxGridViewRepAcuerdos.VisibleStartIndex + ASPxGridViewRepAcuerdos.SettingsPager.PageSize;
            fin = (fin > ASPxGridViewRepAcuerdos.VisibleRowCount ? ASPxGridViewRepAcuerdos.VisibleRowCount : fin);
            int cd_enca_acu = 0;
            for (int i = inicio; i < fin; i++)
            {
                if (ASPxGridViewRepAcuerdos.Selection.IsRowSelected(i))
                {
                    List<object> resultado = new List<object>();
                    cd_enca_acu = (int)ASPxGridViewRepAcuerdos.GetRowValues(i, "CD_ENCA_ACUERDOS");
                }
            }
            manto_acuerdos.reporte_acuerdos_conv(cd_enca_acu, Convert.ToInt32(Session["UserID"].ToString()));
            manto_desarrollo.enviar_correo(Convert.ToInt32(Session["UserID"].ToString()), cd_enca_acu);
            ASPxDocumentViewerCierre.Visible = true;
            ASPxDocumentViewerCierre.DataBind();
        }

        protected void btnVerDoc_Click(object sender, EventArgs e)
        {
            ObtenerDatosAcuerdo();
        }
    }
}