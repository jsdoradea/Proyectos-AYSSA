using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class acuerdos_acuerdos : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            tabAcuerdos.TabPages[1].Visible = false;
            tabAcuerdos.TabPages[1].Enabled = false;
            //DDLTipo.Items.Add("Acuerdo por licencia de personal");
            //DDLNotificacion.Items.Add("María Cruz - Notificaciones");
           
            //Radio.Items.Add("Interesado");
            //Radio.Items.Add("Responsable");
            //Radio.SelectedIndex = 0;

        }
    }
    protected void ASPxButton3_Click(object sender, EventArgs e)
    {
        tabAcuerdos.TabPages[1].Visible = true;
        tabAcuerdos.TabPages[1].Enabled = true;
        tabAcuerdos.ActiveTabIndex = 1;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        tabAcuerdos.ActiveTabIndex = 0;
        tabAcuerdos.TabPages[1].Visible = false;
        tabAcuerdos.TabPages[1].Enabled = false;
    }
    protected void Button2_Click(object sender, EventArgs e)
    {

    }
}