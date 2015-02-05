using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;

namespace TEGNotes.clases
{

    public class Usuario
    {
        public static List<Datos_Usr> ObtenerDatos(int id_usr)
        {
            string strquery = "";
            List<Datos_Usr> Lista = new List<Datos_Usr>();
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
                    Datos_Usr _p = new Datos_Usr();
                    
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
}