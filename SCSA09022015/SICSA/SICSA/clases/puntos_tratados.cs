using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;

namespace SICSA.clases
{
    public class puntos_tratados
    {
        public static List<datos_puntos_tratados> datos_puntos_tratados(int cd_convocatoria)
        {
            string strquery = "";
            List<datos_puntos_tratados> Lista_c = new List<datos_puntos_tratados>();
            using (SqlConnection _conn = conexion.conectarBD())
            {
                SqlCommand Com = new SqlCommand();
                SqlDataAdapter Adp = new SqlDataAdapter();
                DataTable Dt = new DataTable();

                Com.Connection = _conn;

                strquery = "EXEC info_puntos_tratados_sp @CD_PUNTO_CONV = " + cd_convocatoria;
                SqlCommand _cmd = new SqlCommand(strquery, _conn);
                SqlDataReader _reader = _cmd.ExecuteReader();
                while (_reader.Read())
                {
                    datos_puntos_tratados _c = new datos_puntos_tratados();
                    _c.cd_convocatoria = _reader.GetInt32(0);
                    _c.orden = _reader.GetInt32(1);
                    _c.ds_punto_ag = _reader.GetString(2);
                    _c.solicitante = _reader.GetString(3);
                    _c.aspectos = _reader.GetString(4);

                    Lista_c.Add(_c);
                }
            }
            return Lista_c;
        }
    }
}