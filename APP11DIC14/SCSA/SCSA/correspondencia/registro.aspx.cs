using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class correspondencia_registro : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //int cd_agenda = Convert.ToInt32(Request.QueryString["ID"]);
        //int item_periodo = Convert.ToInt32(Request.QueryString["p"]);
        //string accion = Request.QueryString["a"];

        if (!IsPostBack)
        {

            DDLOrigen.DataSource = llenar_combo.llena_combo("select CD_ORIG_PUNTO, DS_ORIG_PUNTO from dbo.GLB_ORIGEN_PUNTOS ORDER BY CD_ORIG_PUNTO");
            DDLOrigen.DataValueField = "Id";
            DDLOrigen.DataTextField = "Nombre";
            DDLOrigen.DataBind();

            DDLEstado.DataSource = llenar_combo.llena_combo("SELECT CD_ESTADO_CORR,DS_ESTADO  FROM AGD_ESTADOS_AGENDA  ORDER BY CD_ESTADO_CORR");
            DDLEstado.DataValueField = "Id";
            DDLEstado.DataTextField = "Nombre";
            DDLEstado.DataBind();

            DDLPeriodo.DataBind();
            DDLPeriodo.SelectedIndex = 0;
            llenar_grid(Convert.ToInt32(DDLPeriodo.SelectedItem.Value));
            
            ComboSolicitantes.SelectedIndex = 0;
            txtFE_REG.Text = DateTime.Today.ToShortDateString();
        }
    }

    protected void DDLPeriodo_SelectedIndexChanged(object sender, EventArgs e)
    {
        //Postback selección de periodo
        llenar_grid(Convert.ToInt32(DDLPeriodo.SelectedItem.Value));
    }

    private void llenar_grid(int periodo)
    {
        //Carga de la grid cada vez que sea necesario.

        using (System.Data.SqlClient.SqlConnection con = conexion.conectarBD())
        {
            SqlCommand Com = new SqlCommand();
            SqlDataAdapter Adp = new SqlDataAdapter();
            DataTable Dt = new DataTable();

            Com.Connection = con;
            Com.CommandType = CommandType.StoredProcedure;
            Com.CommandText = "correspondencia_sp";
            Com.Parameters.Add(new SqlParameter("@Ejercicio", SqlDbType.Int));
            Com.Parameters["@Ejercicio"].Value = periodo;

            Adp.SelectCommand = Com;
            Adp.Fill(Dt);
        }
        GridCorrespondencia.DataBind();
    }

    protected void DDLOrigen_SelectedIndexChanged(object sender, EventArgs e)
    {
        int codigo = Convert.ToInt32(DDLOrigen.SelectedValue);
        ComboSolicitantes.SelectedIndex = 0;
    }


    protected void Button2_Click(object sender, EventArgs e)
    {
        //Botón Cancelar
        TabCorrespondencia.ActiveTabIndex = 0;
        TabCorrespondencia.TabPages[1].Enabled = false;
    }

    protected void ASPxButton3_Click(object sender, EventArgs e)
    {
        //Nueva Correspondencia
        TabCorrespondencia.TabPages[1].Enabled = true;
        TabCorrespondencia.ActiveTabIndex = 1;
        DDLEstado.Enabled = false;
        ComboSolicitantes.SelectedIndex = 0;
        lblAccion.Text = "n";
        DDLEstado.SelectedIndex = 0;
    }

    protected void Button1_Click(object sender, EventArgs e)
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
        manto_correspondencia.nuevo(lblAccion.Text, cod_agenda, txtPunto.Text, txtJust.Text, Convert.ToInt32(RdTipo.Value), Convert.ToInt32(DDLOrigen.SelectedValue), Convert.ToInt32(ComboSolicitantes.SelectedItem.Value), Convert.ToInt32(DDLEstado.SelectedValue), Convert.ToDateTime(txtFE_SOL.Text), Convert.ToDateTime(txtFE_REG.Text), Convert.ToInt32(Session["UserID"]));
        //Inicializar página
        Response.Redirect("~/correspondencia/registro.aspx");
    }

    protected void Button5_Click(object sender, EventArgs e)
    {
        TomaDatosSeleccionados();
    }

    private void TomaDatosSeleccionados()
    {
        Int32 inicio = GridCorrespondencia.VisibleStartIndex;
        Int32 fin = GridCorrespondencia.VisibleStartIndex + GridCorrespondencia.SettingsPager.PageSize;
        fin = (fin > GridCorrespondencia.VisibleRowCount ? GridCorrespondencia.VisibleRowCount : fin);
        int? cd_agenda = 0;
        for (int i = inicio; i < fin; i++)
        {
            if (GridCorrespondencia.Selection.IsRowSelected(i))
            {
                List<object> resultado = new List<object>();
                cd_agenda = (int?)GridCorrespondencia.GetRowValues(i, "CD_AGENDA");
            }
        }
        //Cargar info de componentes.
        cargar_componentes(Convert.ToInt32(cd_agenda));
    }

    private void cargar_componentes(int cod_agenda)
    {
        TabCorrespondencia.TabPages[1].Enabled = true;
        TabCorrespondencia.ActiveTabIndex = 1;

        llenar_grid(Convert.ToInt32(DDLPeriodo.SelectedItem.Value));
        List<datos_correspondencia> lista = new List<datos_correspondencia>();
        lista = agenda.datos_agenda(Convert.ToInt32(cod_agenda));
        DDLEstado.SelectedValue = lista[0].estado.ToString();
        txtPunto.Text = lista[0].punto.ToString();
        txtFE_SOL.Text = lista[0].fec_solicitud.ToString("dd/MM/yyyy");
        txtFE_REG.Text = lista[0].fec_registro.ToString("dd/MM/yyyy");
        DDLOrigen.SelectedValue = lista[0].origen.ToString();
        ComboSolicitantes.DataBind();
        ComboSolicitantes.Value = lista[0].solicitante.ToString();
        RdTipo.Value = lista[0].tipo_correspondencia.ToString();
        txtJust.Text = lista[0].justificacion.ToString();

        lblAccion.Text = "m";
        lblCodAgenda.Text = cod_agenda.ToString();
    }

    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        div_calendario.Visible = true;
        CalSolicitud.Visible = true;
    }
    protected void CalSolicitud_SelectionChanged(object sender, EventArgs e)
    {
        CalSolicitud.Visible = false;
        div_calendario.Visible = false;
        txtFE_SOL.Text = CalSolicitud.SelectedDate.ToShortDateString();
    }



}