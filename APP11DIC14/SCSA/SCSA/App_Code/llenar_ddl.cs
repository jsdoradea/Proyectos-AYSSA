using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Descripción breve de llenar_ddl
/// </summary>
public class llenar_ddl
{
    public static DataTable llenar(string query)
	{
		//
		// TODO: Agregar aquí la lógica del constructor
		//
        DataTable dt = new System.Data.DataTable();

        using (System.Data.SqlClient.SqlConnection con = conexion.conectarBD())
        {
            System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand();
            cmd.Connection = con;
            cmd.CommandText = query;

            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = cmd;
            da.Fill(dt);
          
        }
        return dt;
	}
}