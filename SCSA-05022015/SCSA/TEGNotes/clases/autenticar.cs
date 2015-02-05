using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;


namespace TEGNotes.clases
{
    public class autenticar
    {
        public static  bool validar(string Usuario, string Pass)
        {
            DataTable dt = new DataTable();
            //string usr = "";
            //string clave = "";
            string strquery = @"SELECT * FROM dbo.conf_usuario WHERE usuario=@Usuario and clave=@Pass and estado=1";
            using (SqlConnection con = conexion.conectarBD())
            {
                SqlCommand cmd = new SqlCommand(strquery,con);
                cmd.Parameters.AddWithValue("@Usuario", Usuario);
                cmd.Parameters.AddWithValue("@Pass", Pass);
                int count = Convert.ToInt32(cmd.ExecuteScalar());
                if (count == 0)
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }
        }
        public static int IdUsr(string Usuario, string Pass)
        {
            int Id_sesion=0;
            string strquery = "SELECT * FROM dbo.conf_usuario WHERE usuario='" + Usuario + "' and clave='" + Pass + "' and estado=1";
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
                    Id_sesion = Convert.ToInt32(dt.Rows[0][0]);
                }
            }
            return Id_sesion;
        }
    }
}