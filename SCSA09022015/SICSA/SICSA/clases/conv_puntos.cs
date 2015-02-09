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
    public class datos_conv_puntos
    {
        public string ds_punto { get; set; }
        public string ds_justifica { get; set; }
        public int cd_tipo_punto { get; set; }
        public int cd_origen_punto { get; set; }
        public int cd_unidad_inst { get; set; }
        public int cod_punto { get; set; }
        public string referencia { get; set; }
        public DateTime fec_doc { get; set; }
    }

    public class conv_puntos
    {

        public static List<datos_conv_puntos> datos_conv_puntos(int cd_punto)
        {
            string strquery = "";
            List<datos_conv_puntos> Lista_p = new List<datos_conv_puntos>();
            using (SqlConnection _conn = conexion.conectarBD())
            {
                SqlCommand Com = new SqlCommand();
                SqlDataAdapter Adp = new SqlDataAdapter();
                DataTable Dt = new DataTable();

                Com.Connection = _conn;

                strquery = "SELECT b.DS_PUNTO_AGENDA, b.DS_JUSTIFICA, a.CD_TIPO_PUNTO, b.CD_ORIG_PUNTO, b.CD_UNIDAD_INSTITUCION, a.CD_PUNTO_AGENDA, b.DS_REFERENCIA, b.FE_FECHA_DOC FROM CONV_PUNTOS_AGENDA a 	INNER JOIN dbo.AGD_PUNTOS_AGENDA b ON b.CD_PUNTO_AGENDA = a.CD_PUNTO_AGENDA WHERE a.CD_CONVOCATORIA=" + cd_punto;
                SqlCommand _cmd = new SqlCommand(strquery, _conn);
                SqlDataReader _reader = _cmd.ExecuteReader();
                while (_reader.Read())
                {
                    datos_conv_puntos _c = new datos_conv_puntos();

                    _c.ds_punto = _reader.GetString(0);
                    _c.ds_justifica = _reader.IsDBNull(1) ? String.Empty : _reader.GetString(1);
                    _c.cd_tipo_punto = _reader.GetInt32(2);
                    _c.cd_origen_punto = _reader.GetInt32(3);
                    _c.cd_unidad_inst = _reader.GetInt32(4);
                    _c.cod_punto = _reader.GetInt32(5);
                    _c.referencia = _reader.GetString(6);
                    _c.fec_doc = _reader.GetDateTime(7);
                    Lista_p.Add(_c);
                }
            }
            return Lista_p;
        }
    }
}