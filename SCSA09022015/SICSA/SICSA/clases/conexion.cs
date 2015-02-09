using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;

namespace SICSA.clases
{
    public class conexion
    {
        public static SqlConnection conectarBD()
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SICSA"].ConnectionString);
            con.Open();
            return con;
        }
    }
}