using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace SICSA.clases
{
    public class manto_convocatoria
    {
        public static void nuevo(string accion, int cod_convocatoria, string referencia, int tipo_sesion, int estado_sesion, string fecha_sesion, string hora_sesion, int lugar, int usuario, string fecha_registro)
        {
            using (System.Data.SqlClient.SqlConnection con = conexion.conectarBD())
            {
                SqlCommand Com = new SqlCommand();
                SqlDataAdapter Adp = new SqlDataAdapter();
                DataTable Dt = new DataTable();

                Com.Connection = con;
                Com.CommandType = CommandType.StoredProcedure;
                Com.CommandText = "manto_convocatoria_sp";
                Com.Parameters.Add(new SqlParameter("@ACCION", SqlDbType.VarChar));
                Com.Parameters["@ACCION"].Value = accion;
                Com.Parameters.Add(new SqlParameter("@CD_CONVOCATORIA", SqlDbType.Int));
                Com.Parameters["@CD_CONVOCATORIA"].Value = cod_convocatoria;
                Com.Parameters.Add(new SqlParameter("@DS_REF", SqlDbType.VarChar));
                Com.Parameters["@DS_REF"].Value = referencia;
                Com.Parameters.Add(new SqlParameter("@CD_TIPO_SESION", SqlDbType.Int));
                Com.Parameters["@CD_TIPO_SESION"].Value = tipo_sesion;
                Com.Parameters.Add(new SqlParameter("@CD_ESTADO", SqlDbType.Int));
                Com.Parameters["@CD_ESTADO"].Value = estado_sesion;
                Com.Parameters.Add(new SqlParameter("@FE_FECHA_PROP", SqlDbType.VarChar));
                Com.Parameters["@FE_FECHA_PROP"].Value = fecha_sesion;
                Com.Parameters.Add(new SqlParameter("@HO_HORA", SqlDbType.VarChar));
                Com.Parameters["@HO_HORA"].Value = hora_sesion;
                Com.Parameters.Add(new SqlParameter("@LUGAR", SqlDbType.Int));
                Com.Parameters["@LUGAR"].Value = lugar;
                Com.Parameters.Add(new SqlParameter("@USUARIO", SqlDbType.Int));
                Com.Parameters["@USUARIO"].Value = usuario;
                Com.Parameters.Add(new SqlParameter("@FECHA", SqlDbType.VarChar));
                Com.Parameters["@FECHA"].Value = fecha_registro;

                Adp.SelectCommand = Com;
                Adp.Fill(Dt);
            }
        }
    }
}