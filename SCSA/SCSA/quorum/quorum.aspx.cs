using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class quorum_quorum : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            tabQuorum.TabPages[1].Visible = false;
            tabQuorum.TabPages[1].Enabled = false;
        }

        DDLOrigen.DataSource = llenar_combo.llena_combo("select CD_UNIDAD, DS_UNIDAD from dbo.GLB_UNIDADES_TEG order by CD_UNIDAD");
        DDLOrigen.DataValueField = "Id";
        DDLOrigen.DataTextField = "Nombre";
        DDLOrigen.DataBind();

        DDLSolicitante.DataSource = llenar_combo.llena_combo("select CD_SOLICITANTE, DS_NOMBRE_SOLICITANTE+' '+DS_APELLIDO_SOLICITANTE as nombre from dbo.GLB_SOLICITANTES ");
        DDLSolicitante.DataValueField = "Id";
        DDLSolicitante.DataTextField = "Nombre";
        DDLSolicitante.DataBind();
    }
    protected void ASPxButton3_Click(object sender, EventArgs e)
    {
        tabQuorum.TabPages[1].Visible = true;
        tabQuorum.TabPages[1].Enabled = true;
        tabQuorum.ActiveTabIndex = 1;
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
       
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        tabQuorum.ActiveTabIndex = 0;
        tabQuorum.TabPages[1].Visible = false;
        tabQuorum.TabPages[1].Enabled = false;
    }
}