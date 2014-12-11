using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class convocatoria_convocatoria : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DDLPeriodo.DataBind();
            DDLPeriodo.SelectedIndex = 0;
            GridConvocatoria.DataBind();

            DDLTipoSesion.DataSource = llenar_combo.llena_combo("SELECT CD_TIPO_SESION, TIPO_SESION  FROM GLB_TIPO_SESION_CONVOCATORIA ORDER BY CD_TIPO_SESION");
            DDLTipoSesion.DataValueField = "Id";
            DDLTipoSesion.DataTextField = "Nombre";
            DDLTipoSesion.DataBind();

            DDLEstadoSesion.DataSource = llenar_combo.llena_combo("SELECT CD_ESTADO_SESION, ESTADO_SESION FROM dbo.GLB_TIPO_PROGRAMACION_CONVOCATORIA ORDER BY CD_ESTADO_SESION");
            DDLEstadoSesion.DataValueField = "Id";
            DDLEstadoSesion.DataTextField = "Nombre";
            DDLEstadoSesion.DataBind();

            DDLOrigen.DataSource = llenar_combo.llena_combo("select CD_UNIDAD, DS_UNIDAD from dbo.GLB_UNIDADES_TEG order by CD_UNIDAD");
            DDLOrigen.DataValueField = "Id";
            DDLOrigen.DataTextField = "Nombre";
            DDLOrigen.DataBind();

            DDLSolicitantes.DataSource = llenar_combo.llena_combo("select CD_SOLICITANTE, DS_NOMBRE_SOLICITANTE+' '+DS_APELLIDO_SOLICITANTE as nombre from dbo.GLB_SOLICITANTES ");
            DDLSolicitantes.DataValueField = "Id";
            DDLSolicitantes.DataTextField = "Nombre";
            DDLSolicitantes.DataBind();

            txtFE_REG.Text = DateTime.Today.ToString("yyyy-MM-dd");

        }
    }
    protected void ASPxButton3_Click(object sender, EventArgs e)
    {
        //Nueva Convocatoria
        TabConvocatoria.TabPages[1].Enabled = true;
        TabConvocatoria.ActiveTabIndex = 1;
        lblAccion.Text = "n";
        lblRef.Text = "Nueva convocatoria";
        txtFecha.Text = DateTime.Today.ToString("yyyy-MM-dd");
        txtHora.Text = "08:00";
        DDLOrigen.SelectedIndex = 0;
    }
   
    protected void Button2_Click(object sender, EventArgs e)
    {
        //Guardar Convocatoria
        //Ejecutar procedimiento para guardar datos.
        int cod_convocatoria = 0;
        if (lblAccion.Text == "n")
        {
            cod_convocatoria = 0;
        }
        else
        {
            cod_convocatoria = Convert.ToInt32(lblConvocatoria.Text);
        }
        manto_convocatoria.nuevo(lblAccion.Text, cod_convocatoria, txtRef.Text, Convert.ToInt32(DDLTipoSesion.SelectedValue), Convert.ToInt32(DDLEstadoSesion.SelectedValue), txtFecha.Text, txtHora.Text, Convert.ToInt32(Session["UserID"].ToString()), txtFE_REG.Text);
        //Recargar Grid
        GridConvocatoria.DataBind();
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
        txtConv.Text = cod_conv.ToString() ;


        //Activar Tabs y bloquear los elementos de la pestaña de encabezado
        activar_pestañas(true);
    }
    
    protected void Button1_Click(object sender, EventArgs e)
    {
        //Botón Cancelar
        TabConvocatoria.ActiveTabIndex = 0;
        //TabConvocatoria.TabPages[1].Visible = false;
        TabConvocatoria.TabPages[1].Enabled = false;
        activar_pestañas(false);
    }

    private void activar_pestañas(bool estado)
    {
        if (estado == true)
        {
            txtRef.ReadOnly = true;
            txtFecha.ReadOnly = true;
            txtHora.ReadOnly = true;
            DDLTipoSesion.Enabled = false;
            DDLEstadoSesion.Enabled = false;
            lblAccion.Text = "m";
            TabSesion.TabPages[1].Enabled = true;
            TabSesion.TabPages[2].Enabled = true;
            TabSesion.TabPages[3].Enabled = true;
            TabSesion.TabPages[4].Enabled = true;
            TabSesion.TabPages[5].Enabled = true;
            TabSesion.ActiveTabIndex = 1;
        }
        else
        {
            txtRef.Text = "";
            txtRef.ReadOnly = false;
            txtFecha.ReadOnly = false;
            txtHora.ReadOnly = false;
            DDLTipoSesion.Enabled = true;
            DDLEstadoSesion.Enabled = true;
            lblAccion.Text = "n";
            TabSesion.TabPages[1].Enabled = false;
            TabSesion.TabPages[2].Enabled = false;
            TabSesion.TabPages[3].Enabled = false;
            TabSesion.TabPages[4].Enabled = false;
            TabSesion.TabPages[5].Enabled = false;
            TabSesion.ActiveTabIndex = 0;
        }
    }

    
    protected void Button6_Click(object sender, EventArgs e)
    {
        string sUrl = "Agenda.aspx" ;
        string sScript = "<script language =javascript> ";
        sScript += "window.open('" + sUrl + "',Agenda,'toolbar=0,scrollbars=1,location=0,statusbar=0,menubar=0,resizable=1,width=680,height=420,left=180,top=120');" ;
        sScript += "</script> " ;
        Response.Write(sScript);

        //Response.Write("<script>");
        //Response.Write("window.open('Agenda.aspx','_blank')");
        //Response.Write("</script>");
        //TabConvocatoria.ActiveTabIndex = 0;
    }
    protected void Button7_Click(object sender, EventArgs e)
    {
        Response.Write("<script>");
        Response.Write("window.open('repConv.aspx','_blank')");
        Response.Write("</script>");
        TabConvocatoria.ActiveTabIndex = 0;
    }
    protected void ASPxButton4_Click(object sender, EventArgs e)
    {
        string sUrl = "Agenda.aspx";
        string sScript = "<script language =javascript> ";
        sScript += "window.open('" + sUrl + "',null,'toolbar=0,titlebar=0,scrollbars=1,location=0,statusbar=0,menubar=0,resizable=1,width=680,height=450,left=120,top=100');";
        sScript += "</script> ";
        Response.Write(sScript);
    }
    protected void DDLPeriodo_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void btnDefAgenda_Click(object sender, EventArgs e)
    {
        //TabSesion.TabPages[2].Enabled = true;
        TabSesion.ActiveTabIndex = 2;
        //ListPuntos.DataBind();
    }

    protected void TabSesion_ActiveTabChanged(object source, DevExpress.Web.ASPxTabControl.TabControlEventArgs e)
    {
        //ListPuntos.DataBind();
    }
}