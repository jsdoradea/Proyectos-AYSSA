using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using TEGNotes.clases;

namespace TEGNotes.views.convocatoria
{
    public partial class registro_frame : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DDLEstado.DataSource = llenar_combo.llena_combo("SELECT CD_ESTADO, ESTADO FROM dbo.GLB_ESTADO_CORRESPONDENCIA ORDER BY ESTADO");
            DDLEstado.DataValueField = "Id";
            DDLEstado.DataTextField = "Nombre";
            DDLEstado.DataBind();

            DDLOrigen.DataSource = llenar_combo.llena_combo("SELECT a.CD_SOLICITANTE, a.DS_NOMBRE_SOLICITANTE +' ' + a.DS_APELLIDO_SOLICITANTE AS SOLICITANTE FROM dbo.GLB_SOLICITANTES a INNER JOIN dbo.GLB_EMPLEADOS b ON b.CD_EMPLEADO = a.CD_EMPLEADO WHERE b.CD_ESTADO=1 ORDER BY SOLICITANTE");
            DDLOrigen.DataValueField = "Id";
            DDLOrigen.DataTextField = "Nombre";
            DDLOrigen.DataBind();
        }
    }
}