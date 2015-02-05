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
    public partial class convocatoria_frame : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DDLTipoSesion.DataSource = llenar_combo.llena_combo("SELECT CD_TIPO_SESION, TIPO_SESION FROM dbo.CONV_TIPO_SESION");
            DDLTipoSesion.DataValueField = "Id";
            DDLTipoSesion.DataTextField = "Nombre";
            DDLTipoSesion.DataBind();

            DDLEstadoSesion.DataSource = llenar_combo.llena_combo("SELECT CD_ESTADO_SESION, ESTADO_SESION FROM dbo.CONV_ESTADO");
            DDLEstadoSesion.DataValueField = "Id";
            DDLEstadoSesion.DataTextField = "Nombre";
            DDLEstadoSesion.DataBind();

            ListMiembros.DataSource = llenar_combo.llena_combo("select a.CD_MIEMBRO_PLENO, b.DS_NOMBRE_EMPLEADO + ' ' + b.DS_APELLIDO_EMPLEADO as EMPLEADO from dbo.GLB_MIEMBROS_PLENO a INNER JOIN dbo.GLB_EMPLEADOS b ON b.CD_EMPLEADO=a.CD_EMPLEADO WHERE a.CD_ESTADO=1 ORDER BY EMPLEADO");
            ListMiembros.DataValueField = "Id";
            ListMiembros.DataTextField = "Nombre";
            ListMiembros.DataBind();

            DDLEstadoSolicitud.DataSource = llenar_combo.llena_combo("SELECT CD_ESTADO, ESTADO FROM dbo.GLB_ESTADO_CORRESPONDENCIA ORDER BY ESTADO");
            DDLEstadoSolicitud.DataValueField = "Id";
            DDLEstadoSolicitud.DataTextField = "Nombre";
            DDLEstadoSolicitud.DataBind();

            DDLOrigen.DataSource = llenar_combo.llena_combo("SELECT * FROM dbo.GLB_UNIDADES_TEG ORDER BY DS_UNIDAD");
            DDLOrigen.DataValueField = "Id";
            DDLOrigen.DataTextField = "Nombre";
            DDLOrigen.DataBind();
        }
    }
}