using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SICSA.clases;

namespace SICSA.configuracion
{
    public partial class empleados : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ASPxPageEmpleados.ActiveTabIndex = 0;
                ASPxPageEmpleados.TabPages[1].Enabled = false;
            }
        }

        protected void btnSeleccionarEmp_Click(object sender, EventArgs e)
        {
            ASPxPageEmpleados.TabPages[1].Enabled = true;
            ASPxPageEmpleados.ActiveTabIndex = 1;
            ASPxLabelAccion.Text = "m";
            DatosSeleccionadoUsuarios();
        }
        private void DatosSeleccionadoUsuarios()
        {
            Int32 inicio = ASPxGridView1.VisibleStartIndex;
            Int32 fin = ASPxGridView1.VisibleStartIndex + ASPxGridView1.SettingsPager.PageSize;
            fin = (fin > ASPxGridView1.VisibleRowCount ? ASPxGridView1.VisibleRowCount : fin);
            int CD_EMPLEADO = 0;
            for (int i = inicio; i < fin; i++)
            {
                if (ASPxGridView1.Selection.IsRowSelected(i))
                {
                    List<object> resultado = new List<object>();
                    CD_EMPLEADO = (int)ASPxGridView1.GetRowValues(i, "CD_EMPLEADO");
                }
            }
            ASPxLabelCD.Text = CD_EMPLEADO.ToString();
            //Cargar datos en componentes de encabezado
            cargar_empleados(CD_EMPLEADO);
        }

        protected void ASPxButtonNuevo_Click(object sender, EventArgs e)
        {
            ASPxPageEmpleados.TabPages[1].Enabled = true;
            ASPxPageEmpleados.ActiveTabIndex = 1;
            ASPxComboBox1.SelectedIndex = 0;
            ASPxLabelAccion.Text = "n";
            ASPxLabelCD.Text = "0";
        }

        protected void ASPxButton2_Click(object sender, EventArgs e)
        {
            ASPxPageEmpleados.ActiveTabIndex = 0;
            ASPxPageEmpleados.TabPages[1].Enabled = false;
        }

        private void cargar_empleados(int CD_EMP)
        {
            List<datos_empleados> lista = new List<datos_empleados>();
            lista = manto_empleados.datos_emp(CD_EMP);
            ASPxTextBox1.Text = lista[0].nombre_emp.ToString();
            ASPxTextBox2.Text = lista[0].apellido_emp.ToString();
            ASPxComboBox1.Value = Convert.ToInt32(lista[0].cargo_emp.ToString());
            ASPxCheckBox1.Value = Convert.ToBoolean(lista[0].estado_emp.ToString());
        }

        protected void ASPxButton1_Click(object sender, EventArgs e)
        {
            DateTime fecha_hoy = DateTime.Today;
            manto_empleados.mto_emp(ASPxLabelAccion.Text, ASPxTextBox1.Text, ASPxTextBox2.Text, Convert.ToBoolean(ASPxCheckBox1.Value), Convert.ToInt32(ASPxComboBox1.Value), Convert.ToInt32(Session["UserID"].ToString()), fecha_hoy, Convert.ToInt32(ASPxLabelCD.Text));
            ASPxPageEmpleados.ActiveTabIndex = 0;
            ASPxPageEmpleados.TabPages[1].Enabled = false;
            ASPxGridView1.DataBind();
        }
    }
}