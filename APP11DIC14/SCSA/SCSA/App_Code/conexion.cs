using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;

/// <summary>
/// Descripción breve de conexion
/// </summary>
public class conexion
{
	public static SqlConnection conectarBD()
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SCSA"].ConnectionString);
        con.Open();
        return con;
    }
}
