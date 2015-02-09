using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SICSA.clases;

namespace SICSA.configuracion
{
    public partial class usuarios : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ASPxPageUsuarios.ActiveTabIndex = 0;
                ASPxPageUsuarios.TabPages[1].Enabled = false;
            }
        }

        protected void btnSeleccionar_Click(object sender, EventArgs e)
        {
            ASPxPageUsuarios.TabPages[1].Enabled = true;
            ASPxPageUsuarios.ActiveTabIndex = 1;
            ASPxLabelAccion.Text = "m";
            DatosSeleccionadoUsuarios();
        }
        private void DatosSeleccionadoUsuarios()
        {
            Int32 inicio = ASPxGridUsuarios.VisibleStartIndex;
            Int32 fin = ASPxGridUsuarios.VisibleStartIndex + ASPxGridUsuarios.SettingsPager.PageSize;
            fin = (fin > ASPxGridUsuarios.VisibleRowCount ? ASPxGridUsuarios.VisibleRowCount : fin);
            int id_usr = 0;
            for (int i = inicio; i < fin; i++)
            {
                if (ASPxGridUsuarios.Selection.IsRowSelected(i))
                {
                    List<object> resultado = new List<object>();
                    id_usr = (int)ASPxGridUsuarios.GetRowValues(i, "id_usuario");
                }
            }
            ASPxLabelIDUSR.Text = id_usr.ToString();
            //Cargar datos en componentes de encabezado
            cargar_componentes(id_usr);
        }

        private void cargar_componentes(int id_usr)
        {
            List<datos_act_usuario> lista = new List<datos_act_usuario>();
            lista = manto_usuarios.datos_act_usuario(id_usr);
            ASPxComboEmpleados.Value = lista[0].cd_empleado.ToString();

            List<datos_usuario> lista_emp = new List<datos_usuario>();

            lista_emp = manto_usuarios.datos_usuario(Convert.ToInt32(ASPxComboEmpleados.Value));
            ASPxTextNombre.Text = lista_emp[0].nombre_usuario.ToString();
            ASPxTextApellido.Text = lista_emp[0].apellido_usuario.ToString();
            ASPxTextUnidad.Text = lista_emp[0].unidad.ToString();
            ASPxTextCargo.Text = lista_emp[0].cargo.ToString();

            ASPxRadioGenero.Value = Convert.ToInt32(lista[0].genero.ToString());

            ASPxRadioEstado.Value = Convert.ToInt32(lista[0].estado.ToString());

            ASPxTextUsuario.Text = lista[0].usuario.ToString();
            TextBoxCorreo.Text = lista[0].correo.ToString();
            ASPxComboRoles.Value = Convert.ToInt32(lista[0].rol.ToString());
            ASPxCheckBoxAvatar.Checked = true;
            ASPxImage1.Visible = true;
            ASPxTextUsuario.ReadOnly = true;
        }

        protected void ASPxButtonNuevo_Click(object sender, EventArgs e)
        {
            ASPxPageUsuarios.TabPages[1].Enabled = true;
            ASPxPageUsuarios.ActiveTabIndex = 1;
            ASPxComboRoles.SelectedIndex = 0;
            ASPxRadioGenero.SelectedIndex = 0;
            ASPxTextUsuario.Text = "";
            ASPxCheckBoxAvatar.Checked = true;
            ASPxImage1.Visible = true;
            ASPxLabelAccion.Text = "n";
        }

        protected void ASPxComboEmpleados_SelectedIndexChanged(object sender, EventArgs e)
        {
            List<datos_usuario> lista = new List<datos_usuario>();

            lista = manto_usuarios.datos_usuario(Convert.ToInt32(ASPxComboEmpleados.Value));
            ASPxTextNombre.Text = lista[0].nombre_usuario.ToString();
            ASPxTextApellido.Text = lista[0].apellido_usuario.ToString();
            ASPxTextUnidad.Text = lista[0].unidad.ToString();
            ASPxTextCargo.Text = lista[0].cargo.ToString();
        }

        protected void ASPxCheckBoxAvatar_CheckedChanged(object sender, EventArgs e)
        {
            if (ASPxCheckBoxAvatar.Checked)
            {
                FileUpload1.Enabled = false;
                ASPxImage1.Visible = true;
            }
            else
            {
                FileUpload1.Enabled = true;
                ASPxImage1.Visible = false;
            }
        }

        protected void ASPxButtonCancelar_Click(object sender, EventArgs e)
        {
            ASPxPageUsuarios.ActiveTabIndex = 0;
            ASPxPageUsuarios.TabPages[1].Enabled = false;
        }

        protected void ASPxButtonGuardar_Click(object sender, EventArgs e)
        {
            string url_foto = "";
            int cambio = 0;
            DateTime fecha_hoy = DateTime.Now;
            if (ASPxCheckBoxAvatar.Checked)
            {
                url_foto = "~/Content/Images/fotos/avatar.png";
            }
            else
            {
                if (FileUpload1.HasFile)
                {
                    string nombre_doc = FileUpload1.FileName;
                    string prefijo = fecha_hoy.ToString("ddMMyyyyHHmmss") + "-";
                    url_foto = "~/Content/Images/fotos/" + prefijo + nombre_doc;
                    FileUpload1.PostedFile.SaveAs(Server.MapPath(url_foto));
                }
                else
                {
                    url_foto = "~/Content/Images/fotos/avatar.png";
                }
            }
            if (ASPxCheckBox1.Checked)
            {
                cambio = 1;
            }
            else
            {
                cambio = 0;
            }
            if (ASPxLabelAccion.Text == "n")
            {
                bool existe = manto_usuarios.validar_usuario(ASPxTextUsuario.Text);
                if (existe == false)
                {
                    //usuario no existe, se procede a registrar nuevo
                    manto_usuarios.insertar_usuario(ASPxTextUsuario.Text, ASPxTextPass.Text, Convert.ToInt32(ASPxComboEmpleados.Value), ASPxTextNombre.Text, ASPxTextApellido.Text, TextBoxCorreo.Text, url_foto, ASPxRadioGenero.Value.ToString(), Convert.ToInt32(ASPxComboRoles.Value), Convert.ToInt32(ASPxRadioEstado.Value), cambio);
                    ASPxPageUsuarios.ActiveTabIndex = 0;
                    ASPxPageUsuarios.TabPages[1].Enabled = false;
                    ASPxGridUsuarios.DataBind();
                }
                else
                {
                    //usuario ya existe, enviar mensaje
                    string script = "alert('El Usuario " + ASPxTextUsuario.Text + ", ya existe!');";
                    ScriptManager.RegisterStartupScript(this, typeof(Page), "Aviso", script, true);
                }
            }
            else
            {
                //actualizar usuario
                //bool existe = manto_usuarios.validar_usuario(ASPxTextUsuario.Text);
                //if (existe == false)
                //{
                    //usuario no existe, se procede a registrar nuevo
                    manto_usuarios.actualizar_usuario(Convert.ToInt32(ASPxLabelIDUSR.Text), ASPxTextUsuario.Text, ASPxTextPass.Text, Convert.ToInt32(ASPxComboEmpleados.Value), ASPxTextNombre.Text, ASPxTextApellido.Text, TextBoxCorreo.Text, url_foto, ASPxRadioGenero.Value.ToString(), Convert.ToInt32(ASPxComboRoles.Value), Convert.ToInt32(ASPxRadioEstado.Value), cambio);
                    ASPxPageUsuarios.ActiveTabIndex = 0;
                    ASPxPageUsuarios.TabPages[1].Enabled = false;
                    ASPxGridUsuarios.DataBind();
                //}
                //else
                //{
                //    //usuario ya existe, enviar mensaje
                //    string script = "alert('El Usuario " + ASPxTextUsuario.Text + ", ya existe!');";
                //    ScriptManager.RegisterStartupScript(this, typeof(Page), "Aviso", script, true);
                //}
            }
        }
    }
}