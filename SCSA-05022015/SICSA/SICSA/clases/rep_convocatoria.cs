using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace SICSA.clases
{
    public class rep_convocatoria
    {
        public static void reporte_Convocatoria(int cod_convocatoria)
        {
            using (System.Data.SqlClient.SqlConnection con = conexion.conectarBD())
            {
                SqlCommand Com = new SqlCommand();
                SqlDataAdapter Adp = new SqlDataAdapter();
                DataTable Dt = new DataTable();

                Com.Connection = con;
                Com.CommandType = CommandType.StoredProcedure;
                Com.CommandText = "Reporte_Convocatoria_SP";
                Com.Parameters.Add(new SqlParameter("@CD_CONVOCATORIA", SqlDbType.Int));
                Com.Parameters["@CD_CONVOCATORIA"].Value = cod_convocatoria;
                Adp.SelectCommand = Com;
                Adp.Fill(Dt);
            }
        }
    }
}