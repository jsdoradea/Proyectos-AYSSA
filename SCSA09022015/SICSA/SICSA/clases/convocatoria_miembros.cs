using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace SICSA.clases
{
    public class convocatoria_miembros
    {
        public static void suprimir(int cod_convocatoria)
        {
            using (SqlConnection _conn = conexion.conectarBD())
            {
                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "  DELETE FROM dbo.AGD_DETA_CONVOCATORIA_MIEMBROS_CONVOCADOS WHERE CD_ENCA_CONVOCATORIA = " + cod_convocatoria;
                cmd.Connection = _conn;
                cmd.ExecuteNonQuery();
            }
        }

        public static void insertar(int cod_convocatoria, int cod_miembro, int usuario)
        {
            DateTime fecha = DateTime.Today;
            using (SqlConnection _conn = conexion.conectarBD())
            {
                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = " INSERT INTO dbo.AGD_DETA_CONVOCATORIA_MIEMBROS_CONVOCADOS   (CD_ENCA_CONVOCATORIA, CD_MIEMBRO_PLENO, USUA_CREA, FECH_CREA)   VALUES   (" + cod_convocatoria + "," + cod_miembro + "," + usuario + ",'" + fecha.ToString("yyyy-MM-dd") + "')";
                cmd.Connection = _conn;
                cmd.ExecuteNonQuery();
            }
        }

        public static void quitarmiembro(int cod_convocatoria, int cod_miembro)
        {
            using (SqlConnection _conn = conexion.conectarBD())
            {
                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "DELETE FROM dbo.AGD_DETA_CONVOCATORIA_MIEMBROS_CONVOCADOS WHERE CD_ENCA_CONVOCATORIA = " + cod_convocatoria + " and CD_MIEMBRO_PLENO=" + cod_miembro;
                cmd.Connection = _conn;
                cmd.ExecuteNonQuery();
            }
        }

        public static void reprogramar(int cod_convocatoria, DateTime fecha_rep, string hora_rep, string motivo, int usuario)
        {
            DateTime fecha_hoy = DateTime.Today;
            using (System.Data.SqlClient.SqlConnection con = conexion.conectarBD())
            {
                SqlCommand Com = new SqlCommand();
                SqlDataAdapter Adp = new SqlDataAdapter();
                DataTable Dt = new DataTable();

                Com.Connection = con;
                Com.CommandType = CommandType.StoredProcedure;
                Com.CommandText = "reprogramar_convocatoria_sp";
                Com.Parameters.Add(new SqlParameter("@CD_CONVOCATORIA", SqlDbType.Int));
                Com.Parameters["@CD_CONVOCATORIA"].Value = cod_convocatoria;
                Com.Parameters.Add(new SqlParameter("@FECHA", SqlDbType.Date));
                Com.Parameters["@FECHA"].Value = fecha_rep;
                Com.Parameters.Add(new SqlParameter("@HORA", SqlDbType.VarChar));
                Com.Parameters["@HORA"].Value = hora_rep;
                Com.Parameters.Add(new SqlParameter("@MOTIVO", SqlDbType.VarChar));
                Com.Parameters["@MOTIVO"].Value = motivo;
                Com.Parameters.Add(new SqlParameter("@USUARIO", SqlDbType.Int));
                Com.Parameters["@USUARIO"].Value = usuario;

                Adp.SelectCommand = Com;
                Adp.Fill(Dt);
            }
        }
    }
}