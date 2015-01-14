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
    public class agenda
    {
        public static List<datos_correspondencia> datos_agenda(int cd_agenda)
        {
            string strquery = "";
            List<datos_correspondencia> Lista = new List<datos_correspondencia>();
            using (SqlConnection _conn = conexion.conectarBD())
            {
                SqlCommand Com = new SqlCommand();
                SqlDataAdapter Adp = new SqlDataAdapter();
                DataTable Dt = new DataTable();

                Com.Connection = _conn;

                strquery = "SELECT CD_ESTADO_CORR, FECH_CREA, FE_FECH_SOLIC, CD_ORIG_PUNTO, CD_EMP_SOLIC, CD_UNIDAD_INSTITUCION, CD_TIPO_CORRESP, DS_PUNTO_AGENDA, DS_JUSTIFICA  FROM AGD_PUNTOS_AGENDA   WHERE CD_PUNTO_AGENDA=" + cd_agenda;
                SqlCommand _cmd = new SqlCommand(strquery, _conn);
                SqlDataReader _reader = _cmd.ExecuteReader();
                while (_reader.Read())
                {
                    datos_correspondencia _c = new datos_correspondencia();

                    _c.estado = _reader.GetInt32(0);
                    _c.fec_registro = _reader.GetDateTime(1);
                    _c.fec_solicitud = _reader.GetDateTime(2);
                    _c.origen = _reader.GetInt32(3);
                    _c.solicitante = _reader.GetInt32(4);
                    _c.unidad = _reader.GetInt32(5);
                    _c.tipo_correspondencia = _reader.GetInt32(6);
                    _c.punto = _reader.GetString(7);
                    _c.justificacion = _reader.IsDBNull(8) ? String.Empty : _reader.GetString(8);
                    Lista.Add(_c);
                }
            }
            return Lista;
        }
    }
}