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
        int cd_agenda = Convert.ToInt32(Request.QueryString["ID"]);
        int item_periodo = Convert.ToInt32(Request.QueryString["p"]);

        DDLPeriodo.DataSource = llenar_ddl.llenar("SELECT * FROM [GLB_CIERRE_PERIODO] ORDER BY [CD_PERIODO] DESC, [CD_EJERICIO]");
        DDLPeriodo.DataBind();

        DDLEstado.DataSource = llenar_combo.llena_combo("SELECT CD_ESTADO_CORR,DS_ESTADO  FROM AGD_ESTADOS_AGENDA  ORDER BY CD_ESTADO_CORR");
        DDLEstado.DataValueField = "Id";
        DDLEstado.DataTextField = "Nombre";
        DDLEstado.DataBind();

        DDLOrigen.DataSource = llenar_combo.llena_combo("select CD_UNIDAD, DS_UNIDAD from dbo.GLB_UNIDADES_TEG order by CD_UNIDAD");
        DDLOrigen.DataValueField = "Id";
        DDLOrigen.DataTextField = "Nombre";
        DDLOrigen.DataBind();

        DDLSolicitantes.DataSource = llenar_combo.llena_combo("select CD_SOLICITANTE, DS_NOMBRE_SOLICITANTE+' '+DS_APELLIDO_SOLICITANTE as nombre from dbo.GLB_SOLICITANTES ");
        DDLSolicitantes.DataValueField = "Id";
        DDLSolicitantes.DataTextField = "Nombre";
        DDLSolicitantes.DataBind();


        if (!IsPostBack)
        {
            DDLPeriodo.SelectedIndex = 0;
            llenar_grid(Convert.ToInt32(DDLPeriodo.SelectedItem.Value));
        }

        if (cd_agenda != 0)
        {
            TabCorrespondencia.TabPages[1].Enabled = true;
            TabCorrespondencia.ActiveTabIndex = 1;
            DDLPeriodo.SelectedIndex = item_periodo;
            llenar_grid(Convert.ToInt32(DDLPeriodo.SelectedItem.Value));
            List<datos_correspondencia> lista = new List<datos_correspondencia>();
            lista = agenda.datos_agenda(Convert.ToInt32(cd_agenda));
            DDLEstado.SelectedValue = lista[0].estado.ToString();
            txtPunto.Text = lista[0].punto.ToString();
            
            //FE_SOLICITUD.Value = lista[0].fec_solicitud.ToString();
        }
        

        
    }
    protected void ASPxButton3_Click(object sender, EventArgs e)
    {
        TomaDatosSeleccionados();
        //TabCorrespondencia.TabPages[1].Visible = true;
        TabCorrespondencia.TabPages[1].Enabled = true;
        //TabCorrespondencia.TabPages[1].VisibleIndex = 1;
        TabCorrespondencia.ActiveTabIndex = 1;
    }

    protected void Button1_Click(object sender, EventArgs e)
    {

    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        TabCorrespondencia.ActiveTabIndex = 0;
        //TabCorrespondencia.TabPages[1].Visible = false;
        TabCorrespondencia.TabPages[1].Enabled = false;
    }
    protected void DDLPeriodo_SelectedIndexChanged(object sender, EventArgs e)
    {
        llenar_grid(Convert.ToInt32(DDLPeriodo.SelectedItem.Value));
    }

    private void llenar_grid(int periodo)
    {
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
         //SqlDataSource1.SelectCommand = "select * from dbo.TMP_CORRESPONDENCIA ORDER BY FECHA_RECEPCION DESC";
        
        //GridCorrespondencia.DataSource = SqlDataSource1;
        GridCorrespondencia.DataBind();
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
        Response.Redirect("~/correspondencia/registro.aspx?ID=" + cd_agenda + "&p=" + DDLPeriodo.SelectedIndex);
    }
    protected void GridCorrespondencia_SelectionChanged(object sender, EventArgs e)
    {
        TomaDatosSeleccionados();
    }
    protected void Button5_Click(object sender, EventArgs e)
    {
        TomaDatosSeleccionados();
        //Response.Redirect("~/correspondencia/registro.aspx?ID= " + GridCorrespondencia.GetRowValues(GridCorrespondencia.FocusedRowIndex, "CD_AGENDA"));
    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        div_calendario.Visible = true;
    }

    protected void CalSolicitud_SelectionChanged(object sender, EventArgs e)
    {
        txtFE_SOL.Text = CalSolicitud.SelectedDate.ToString("dd/mm/yyyy");
        div_calendario.Visible = false;
    }
    protected void CalSolicitud_ValueChanged(object sender, EventArgs e)
    {
        txtFE_SOL.Text = CalSolicitud.SelectedDate.ToString("dd/mm/yyyy");
        div_calendario.Visible = false;
    }
}