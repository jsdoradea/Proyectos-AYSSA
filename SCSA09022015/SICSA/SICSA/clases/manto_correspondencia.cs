using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace SICSA.clases
{
    public class datos_correspondencia
    {
        public int estado { get; set; }
        public DateTime fec_registro { get; set; }
        public DateTime fec_solicitud { get; set; }
        public int origen { get; set; }
        public int solicitante { get; set; }
        public int unidad { get; set; }
        public int tipo_correspondencia { get; set; }
        public string punto { get; set; }
        public string justificacion { get; set; }
        public string ds_referencia { get; set; }
        public DateTime fe_documento { get; set; }
    }



    public class manto_correspondencia
    {
        public static void nuevo(string accion, int cod_agenda, string nombre_punto, string justificacion, int tipo_c, int origen, int cod_persona, int estado_corr, DateTime fecha_solicitud, DateTime fecha_registro, int usuario, string referencia, DateTime fe_doc)
        {
            using (System.Data.SqlClient.SqlConnection con = conexion.conectarBD())
            {
                SqlCommand Com = new SqlCommand();
                SqlDataAdapter Adp = new SqlDataAdapter();
                DataTable Dt = new DataTable();

                Com.Connection = con;
                Com.CommandType = CommandType.StoredProcedure;
                Com.CommandText = "manto_correspondencia_sp";
                Com.Parameters.Add(new SqlParameter("@ACCION", SqlDbType.VarChar));
                Com.Parameters["@ACCION"].Value = accion;
                Com.Parameters.Add(new SqlParameter("@CD_AGENDA", SqlDbType.Int));
                Com.Parameters["@CD_AGENDA"].Value = cod_agenda;
                Com.Parameters.Add(new SqlParameter("@DS_PUNTO", SqlDbType.VarChar));
                Com.Parameters["@DS_PUNTO"].Value = nombre_punto;
                Com.Parameters.Add(new SqlParameter("@DS_JUSTIFICACION", SqlDbType.VarChar));
                Com.Parameters["@DS_JUSTIFICACION"].Value = justificacion;
                Com.Parameters.Add(new SqlParameter("@CD_TIPO_CORREP", SqlDbType.Int));
                Com.Parameters["@CD_TIPO_CORREP"].Value = tipo_c;
                Com.Parameters.Add(new SqlParameter("@CD_ORIG_PUNTO", SqlDbType.Int));
                Com.Parameters["@CD_ORIG_PUNTO"].Value = origen;
                Com.Parameters.Add(new SqlParameter("@CD_EMP_SOLIC", SqlDbType.Int));
                Com.Parameters["@CD_EMP_SOLIC"].Value = cod_persona;
                Com.Parameters.Add(new SqlParameter("@CD_ESTADO_CORR", SqlDbType.Int));
                Com.Parameters["@CD_ESTADO_CORR"].Value = estado_corr;
                Com.Parameters.Add(new SqlParameter("@FE_FECHA_SOLIC", SqlDbType.DateTime));
                Com.Parameters["@FE_FECHA_SOLIC"].Value = fecha_solicitud;
                Com.Parameters.Add(new SqlParameter("@USUARIO", SqlDbType.Int));
                Com.Parameters["@USUARIO"].Value = usuario;
                Com.Parameters.Add(new SqlParameter("@FECHA", SqlDbType.DateTime));
                Com.Parameters["@FECHA"].Value = fecha_registro;
                Com.Parameters.Add(new SqlParameter("@REFERENCIA", SqlDbType.VarChar));
                Com.Parameters["@REFERENCIA"].Value = referencia;
                Com.Parameters.Add(new SqlParameter("@FE_DOC", SqlDbType.DateTime));
                Com.Parameters["@FE_DOC"].Value = fe_doc;

                Adp.SelectCommand = Com;
                Adp.Fill(Dt);
            }
        }

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

                strquery = "SELECT CD_ESTADO_CORR, FECH_CREA, FE_FECH_SOLIC, CD_ORIG_PUNTO, CD_EMP_SOLIC, CD_UNIDAD_INSTITUCION, CD_TIPO_CORRESP, DS_PUNTO_AGENDA, DS_JUSTIFICA, DS_REFERENCIA, FE_FECHA_DOC  FROM AGD_PUNTOS_AGENDA   WHERE CD_PUNTO_AGENDA=" + cd_agenda;
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
                    _c.ds_referencia = _reader.IsDBNull(9) ? String.Empty : _reader.GetString(9);
                    _c.fe_documento = _reader.GetDateTime(10);
                    Lista.Add(_c);
                }
            }
            return Lista;
        }
    }
}