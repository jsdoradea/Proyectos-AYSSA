using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace SICSA.clases
{
    public class conv_puntos_desarrollo
    {
        public static void nuevo(int cod_convocatoria, string punto_agenda, int cd_origen_punto, int cd_tipo_inc)
        {
            using (System.Data.SqlClient.SqlConnection con = conexion.conectarBD())
            {
                SqlCommand Com = new SqlCommand();
                SqlDataAdapter Adp = new SqlDataAdapter();
                DataTable Dt = new DataTable();

                Com.Connection = con;
                Com.CommandType = CommandType.StoredProcedure;
                Com.CommandText = "puntos_convocatoria_desarrollo_sp";

                Com.Parameters.Add(new SqlParameter("@COD_ENCA_CONV", SqlDbType.Int));
                Com.Parameters["@COD_ENCA_CONV"].Value = cod_convocatoria;
                Com.Parameters.Add(new SqlParameter("@DS_PUNTO_AGENDA", SqlDbType.VarChar));
                Com.Parameters["@DS_PUNTO_AGENDA"].Value = punto_agenda;
                Com.Parameters.Add(new SqlParameter("@CD_ORIGEN_PUNTO", SqlDbType.Int));
                Com.Parameters["@CD_ORIGEN_PUNTO"].Value = cd_origen_punto;
                //Com.Parameters.Add(new SqlParameter("@CD_UNIDAD_INSTITUCION", SqlDbType.Int));
                //Com.Parameters["@CD_UNIDAD_INSTITUCION"].Value = cd_unidad_inst;
                //Com.Parameters.Add(new SqlParameter("@CD_EMP_SOLIC", SqlDbType.Int));
                //Com.Parameters["@CD_EMP_SOLIC"].Value = cd_emp_solicitante;
                Com.Parameters.Add(new SqlParameter("@CD_TIPO_INCLUSION", SqlDbType.Int));
                Com.Parameters["@CD_TIPO_INCLUSION"].Value = cd_tipo_inc;

                Adp.SelectCommand = Com;
                Adp.Fill(Dt);
            }
        }

        public static void actualizar_tipo_punto(int cod_convocatoria, int tipo_inclusion)
        {
            DateTime fecha = DateTime.Today;
            using (SqlConnection _conn = conexion.conectarBD())
            {
                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "UPDATE dbo.CONV_PUNTOS_AGENDA SET CD_TIPO_PUNTO = " + tipo_inclusion + " WHERE CD_CONVOCATORIA =" + cod_convocatoria;
                cmd.Connection = _conn;
                cmd.ExecuteNonQuery();
            }
        }
    }
}