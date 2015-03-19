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
    public class convocatoria_m
    {
        public static List<datos_convocatoria> datos_convocatoria(int cd_convocatoria)
        {
            string strquery = "";
            List<datos_convocatoria> Lista_c = new List<datos_convocatoria>();
            using (SqlConnection _conn = conexion.conectarBD())
            {
                SqlCommand Com = new SqlCommand();
                SqlDataAdapter Adp = new SqlDataAdapter();
                DataTable Dt = new DataTable();

                Com.Connection = _conn;

                strquery = "select DS_REFERENCIA, CD_TIPO_SESION, CD_ESTADO, FE_FECHA_PROP_INI, HO_HORA_PROP_INI, CD_LUGAR  from dbo.AGD_ENCA_CONVOCATORIA where CD_ENCA_CONVOCATORIA= " + cd_convocatoria ; 
                SqlCommand _cmd = new SqlCommand(strquery, _conn);
                SqlDataReader _reader = _cmd.ExecuteReader();
                while (_reader.Read())
                {
                    datos_convocatoria _c = new datos_convocatoria();

                    _c.ds_ref = _reader.GetString(0);
                    _c.cd_sesion = _reader.GetInt32(1);
                    _c.cd_estado = _reader.GetInt32(2);
                    _c.fe_prop = _reader.GetDateTime(3);
                    _c.hora_prop = _reader.GetTimeSpan(4);
                    _c.cd_lugar = _reader.GetInt32(5);
                    Lista_c.Add(_c);
                }
            }
            return Lista_c;
        }
    }
}