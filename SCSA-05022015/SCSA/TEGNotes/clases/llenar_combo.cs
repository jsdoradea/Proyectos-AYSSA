using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace TEGNotes.clases
{
    public class llenar_combo
    {
        public static List<datos_combo> llena_combo(string consulta)
        {
            string strquery = "";
            List<datos_combo> _combo = new List<datos_combo>();
            using (SqlConnection _conn = conexion.conectarBD())
            {

                strquery = consulta;
                SqlCommand _cmd = new SqlCommand(strquery, _conn);
                SqlDataReader _reader = _cmd.ExecuteReader();
                while (_reader.Read())
                {
                    datos_combo _p = new datos_combo();
                    _p.Id = _reader.GetInt32(0);
                    _p.Nombre = _reader.GetString(1);
                    _combo.Add(_p);
                }
            }
            return _combo;
        }
    }
}