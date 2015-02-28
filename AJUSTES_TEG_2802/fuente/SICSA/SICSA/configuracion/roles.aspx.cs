using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SICSA.clases;

namespace SICSA.configuracion
{
    public partial class roles : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ASPxPageRoles.ActiveTabIndex = 0;
                ASPxPageRoles.TabPages[1].Enabled = false;
            }
        }

        protected void btnSeleccionar_Click(object sender, EventArgs e)
        {
             ASPxPageRoles.TabPages[1].Enabled = true;
            ASPxPageRoles.ActiveTabIndex = 1;
            //ASPxLabelAccion.Text = "m";
            DatosSeleccionadoUsuarios();
        }
        private void DatosSeleccionadoUsuarios()
        {
            Int32 inicio = ASPxGridRoles.VisibleStartIndex;
            Int32 fin = ASPxGridRoles.VisibleStartIndex + ASPxGridRoles.SettingsPager.PageSize;
            fin = (fin > ASPxGridRoles.VisibleRowCount ? ASPxGridRoles.VisibleRowCount : fin);
            int id_rol = 0;
            for (int i = inicio; i < fin; i++)
            {
                if (ASPxGridRoles.Selection.IsRowSelected(i))
                {
                    List<object> resultado = new List<object>();
                    id_rol = (int)ASPxGridRoles.GetRowValues(i, "id_rol");
                }
            }
            ASPxLabelCdRol.Text = id_rol.ToString();
            //Cargar datos en componentes de encabezado
            cargar_componentes(id_rol);
        }

        private void cargar_componentes(int id_rol)
        {
            List<datos_rol> lista = new List<datos_rol>();
            lista = manto_usuarios.datos_rol(id_rol);
            ASPxLabelNomRol.Value = lista[0].nombre_rol.ToString();
        }
    }
}