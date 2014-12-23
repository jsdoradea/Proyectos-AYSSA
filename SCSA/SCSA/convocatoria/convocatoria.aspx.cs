using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class convocatoria_convocatoria : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            TabConvocatoria.TabPages[1].Visible = false;
            TabConvocatoria.TabPages[1].Enabled = false;
        }

        DDLOrigen.DataSource = llenar_combo.llena_combo("select CD_UNIDAD, DS_UNIDAD from dbo.GLB_UNIDADES_TEG order by CD_UNIDAD");
        DDLOrigen.DataValueField = "Id";
        DDLOrigen.DataTextField = "Nombre";
        DDLOrigen.DataBind();

        DDLSolicitantes.DataSource = llenar_combo.llena_combo("select CD_SOLICITANTE, DS_NOMBRE_SOLICITANTE+' '+DS_APELLIDO_SOLICITANTE as nombre from dbo.GLB_SOLICITANTES ");
        DDLSolicitantes.DataValueField = "Id";
        DDLSolicitantes.DataTextField = "Nombre";
        DDLSolicitantes.DataBind();
    }
    protected void ASPxButton3_Click(object sender, EventArgs e)
    {
        TabConvocatoria.TabPages[1].Visible = true;
        TabConvocatoria.TabPages[1].Enabled = true;
        //TabConvocatoria.TabPages[1].VisibleIndex = 1;
        TabConvocatoria.ActiveTabIndex = 1;
        //ReportViewer1.LocalReport.Refresh();
    }
    protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
    {
        if (CheckBox1.Checked)
        {
            ListSelect.Items.Clear();
            ListSelect.Items.Add("Miembro 1 (propietario)");
            ListSelect.Items.Add("Miembro 5 (propietario)");
        }
        else
        {
            ListSelect.Items.Clear();
            ListSelect.Items.Add("--Seleccione miembros a convocar--");
        }
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        
    }
    protected void btnTodosIzq_Click(object sender, EventArgs e)
    {
        ListSelect.Items.Clear();
        ListSelect.Items.Add("--Seleccione miembros a convocar--");
    }
    protected void btnTodosDer_Click(object sender, EventArgs e)
    {
        ListSelect.Items.Clear();
        ListSelect.Items.Add("Miembro 1 (propietario)");
        ListSelect.Items.Add("Miembro 5 (propietario)");
        ListSelect.Items.Add("Miembro 6 (suplente)");
        ListSelect.Items.Add("Miembro 7 (suplente)");
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        TabConvocatoria.ActiveTabIndex = 0;
        TabConvocatoria.TabPages[1].Visible = false;
        TabConvocatoria.TabPages[1].Enabled = false;
    }
    protected void btnUnoIzq_Click(object sender, EventArgs e)
    {
        ListSelect.Items.Clear();
        ListSelect.Items.Remove(ListSelect.SelectedValue);
    }
    protected void btnUnoDer_Click(object sender, EventArgs e)
    {
        string miembro ="";

            ListSelect.Items.Clear();

        miembro = ListMiembros.SelectedItem.ToString();
        ListSelect.Items.Add(miembro);
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
}