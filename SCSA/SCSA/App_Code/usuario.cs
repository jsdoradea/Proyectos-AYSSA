using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;


/// <summary>
/// Descripción breve de usuario
/// </summary>
public class usuario
{

    public static List<datos_usr> ObtenerDatos(int id_usr)
    {
        string strquery = "";
        List<datos_usr> Lista = new List<datos_usr>();
        using (SqlConnection _conn = conexion.conectarBD())
        {
            SqlCommand Com = new SqlCommand();
            SqlDataAdapter Adp = new SqlDataAdapter();
            DataTable Dt = new DataTable();

            Com.Connection = _conn;

            strquery = "Select usuario, nombre, apellido, foto from conf_usuario where id_usuario=" + id_usr;
            SqlCommand _cmd = new SqlCommand(strquery, _conn);
            SqlDataReader _reader = _cmd.ExecuteReader();
            while (_reader.Read())
            {
                datos_usr _p = new datos_usr();

                _p.usuario = _reader.GetString(0);
                _p.nombre = _reader.GetString(1);
                _p.apellido = _reader.GetString(2);
                _p.foto = _reader.GetString(3);
                Lista.Add(_p);
            }
        }
        return Lista;
    }
}
