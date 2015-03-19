using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace SICSA.clases
{
    public class manto_desarrollo
    {
        public static void insertar(int cod_deta_conv, string ds_nombre, string ds_descripcion, string ds_ruta, int usuario)
        {
            DateTime fecha = DateTime.Today;
            using (SqlConnection _conn = conexion.conectarBD())
            {
                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "INSERT INTO dbo.SEP_DETA_SESION_PLENO_DOCUMENTOS (CD_DETA_CONV, DS_NOMBRE_ARCHIVO, DS_DESCRIPCION, DS_RUTA_ARCHIVO, USUA_CREA, FECH_CREA)  VALUES (" + cod_deta_conv + ",'" + ds_nombre + "', '"+ ds_descripcion +"', '" + ds_ruta + "', " + usuario + ", '" + fecha.ToString("yyyy-MM-dd") + "')";
                cmd.Connection = _conn;
                cmd.ExecuteNonQuery();
            }
        }
        public static void actualizar_aspecto(int cod_deta_conv, string ds_nota, int usuario)
        {
            DateTime fecha = DateTime.Today;
            using (SqlConnection _conn = conexion.conectarBD())
            {
                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "  UPDATE dbo.SEP_DETA_SESION_PLENO_MINUTA SET DS_NOTAS='" + ds_nota + "', USUA_CREA=" + usuario + ", USUA_ACTU=" + usuario + ", FECH_ACTU='" + fecha.ToString("yyyy-MM-dd") + "' WHERE CD_DETA_CONV=" + cod_deta_conv;
                cmd.Connection = _conn;
                cmd.ExecuteNonQuery();
            }
        }

        public static void actualizar_acta(int cod_deta_conv, string ds_acta)
        {
            DateTime fecha = DateTime.Today;
            using (SqlConnection _conn = conexion.conectarBD())
            {
                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "UPDATE dbo.AGD_ENCA_CONVOCATORIA SET DS_ACTA ='" + ds_acta + "' WHERE CD_ENCA_CONVOCATORIA=" + cod_deta_conv;
                cmd.Connection = _conn;
                cmd.ExecuteNonQuery();
            }
        }

        public static void enviar_correo(int usuario, int cd_enca_acu)
        {
            using (System.Data.SqlClient.SqlConnection con = conexion.conectarBD())
            {
                SqlCommand Com = new SqlCommand();
                SqlDataAdapter Adp = new SqlDataAdapter();
                DataTable Dt = new DataTable();

                Com.Connection = con;
                Com.CommandType = CommandType.StoredProcedure;
                Com.CommandText = "envio_acuerdo_SP";

                Com.Parameters.Add(new SqlParameter("@USUARIO", SqlDbType.Int));
                Com.Parameters["@USUARIO"].Value = usuario;
                Com.Parameters.Add(new SqlParameter("@CD_ENCA_ACU", SqlDbType.Int));
                Com.Parameters["@CD_ENCA_ACU"].Value = cd_enca_acu;


                Adp.SelectCommand = Com;
                Adp.Fill(Dt);
            }
        }
    }
}