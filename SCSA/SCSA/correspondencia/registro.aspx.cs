using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class correspondencia_registro : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            TabCorrespondencia.TabPages[1].Visible = false;
            TabCorrespondencia.TabPages[1].Enabled = false;
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
        TabCorrespondencia.TabPages[1].Visible = true;
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
        TabCorrespondencia.TabPages[1].Visible = false;
        TabCorrespondencia.TabPages[1].Enabled = false;
    }
}