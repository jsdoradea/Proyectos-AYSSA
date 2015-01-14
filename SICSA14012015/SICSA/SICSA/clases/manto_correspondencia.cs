using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace SICSA.clases
{
    public class manto_correspondencia
    {
        public static void nuevo(string accion, int cod_agenda, string nombre_punto, string justificacion, int tipo_c, int origen, int cod_persona, int estado_corr, DateTime fecha_solicitud, DateTime fecha_registro, int usuario)
        {
            using (System.Data.SqlClient.SqlConnection con = conexion.conectarBD())
            {
                SqlCommand Com = new SqlCommand();
                SqlDataAdapter Adp = new SqlDataAdapter();
                DataTable Dt = new DataTable();

                Com.Connection = con;
                Com.CommandType = CommandType.StoredProcedure;
                Com.CommandText = "manto_correspondencia_sp";
                Com.Parameters.Add(new SqlParameter("@ACCION", SqlDbType.VarChar));
                Com.Parameters["@ACCION"].Value = accion;
                Com.Parameters.Add(new SqlParameter("@CD_AGENDA", SqlDbType.Int));
                Com.Parameters["@CD_AGENDA"].Value = cod_agenda;
                Com.Parameters.Add(new SqlParameter("@DS_PUNTO", SqlDbType.VarChar));
                Com.Parameters["@DS_PUNTO"].Value = nombre_punto;
                Com.Parameters.Add(new SqlParameter("@DS_JUSTIFICACION", SqlDbType.VarChar));
                Com.Parameters["@DS_JUSTIFICACION"].Value = justificacion;
                Com.Parameters.Add(new SqlParameter("@CD_TIPO_CORREP", SqlDbType.Int));
                Com.Parameters["@CD_TIPO_CORREP"].Value = tipo_c;
                Com.Parameters.Add(new SqlParameter("@CD_ORIG_PUNTO", SqlDbType.Int));
                Com.Parameters["@CD_ORIG_PUNTO"].Value = origen;
                Com.Parameters.Add(new SqlParameter("@CD_EMP_SOLIC", SqlDbType.Int));
                Com.Parameters["@CD_EMP_SOLIC"].Value = cod_persona;
                Com.Parameters.Add(new SqlParameter("@CD_ESTADO_CORR", SqlDbType.Int));
                Com.Parameters["@CD_ESTADO_CORR"].Value = estado_corr;
                Com.Parameters.Add(new SqlParameter("@FE_FECHA_SOLIC", SqlDbType.DateTime));
                Com.Parameters["@FE_FECHA_SOLIC"].Value = fecha_solicitud;
                Com.Parameters.Add(new SqlParameter("@USUARIO", SqlDbType.Int));
                Com.Parameters["@USUARIO"].Value = usuario;
                Com.Parameters.Add(new SqlParameter("@FECHA", SqlDbType.DateTime));
                Com.Parameters["@FECHA"].Value = fecha_registro;

                Adp.SelectCommand = Com;
                Adp.Fill(Dt);
            }
        }
    }
}