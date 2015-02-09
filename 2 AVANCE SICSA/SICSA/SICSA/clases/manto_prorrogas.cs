using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace SICSA.clases
{
    public class manto_prorrogas
    {
        public static void autorizar_prorroga(int cd_prorroga, int dias_aut)
        {
            DateTime fecha = DateTime.Today;
            using (System.Data.SqlClient.SqlConnection con = conexion.conectarBD())
            {
                SqlCommand Com = new SqlCommand();
                SqlDataAdapter Adp = new SqlDataAdapter();
                DataTable Dt = new DataTable();

                Com.Connection = con;
                Com.CommandType = CommandType.StoredProcedure;
                Com.CommandText = "prorroga_tarea_sp";
                Com.Parameters.Add(new SqlParameter("@CD_PRORROGA", SqlDbType.Int));
                Com.Parameters["@CD_PRORROGA"].Value = cd_prorroga;
                Com.Parameters.Add(new SqlParameter("@DIAS_AUT", SqlDbType.Int));
                Com.Parameters["@DIAS_AUT"].Value = dias_aut;
                
                Adp.SelectCommand = Com;
                Adp.Fill(Dt);
            }
        }
    }
}