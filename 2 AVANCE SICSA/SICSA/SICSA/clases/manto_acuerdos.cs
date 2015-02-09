using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace SICSA.clases
{
    public class manto_acuerdos
    {
        public static void nuevo_acuerdo(string accion, int cod_punto, DateTime fecha_registro, string acuerdo_largo, string acuerdo_corto, DateTime fecha_ini, int periodo, int usuario, int cd_acuerdo, int cd_tipo_acuerdo, int cd_responsable)
        {
            using (System.Data.SqlClient.SqlConnection con = conexion.conectarBD())
            {
                SqlCommand Com = new SqlCommand();
                SqlDataAdapter Adp = new SqlDataAdapter();
                DataTable Dt = new DataTable();

                Com.Connection = con;
                Com.CommandType = CommandType.StoredProcedure;
                Com.CommandText = "acuerdos_sp";
                Com.Parameters.Add(new SqlParameter("@ACCION", SqlDbType.VarChar));
                Com.Parameters["@ACCION"].Value = accion;
                Com.Parameters.Add(new SqlParameter("@CD_DETA_CONV", SqlDbType.Int));
                Com.Parameters["@CD_DETA_CONV"].Value = cod_punto;
                Com.Parameters.Add(new SqlParameter("@FECHA_REG", SqlDbType.DateTime));
                Com.Parameters["@FECHA_REG"].Value = fecha_registro;
                Com.Parameters.Add(new SqlParameter("@ACUERDO_LARGO", SqlDbType.VarChar));
                Com.Parameters["@ACUERDO_LARGO"].Value = acuerdo_largo;
                Com.Parameters.Add(new SqlParameter("@ACUERDO_CORTO", SqlDbType.VarChar));
                Com.Parameters["@ACUERDO_CORTO"].Value = acuerdo_corto;
                Com.Parameters.Add(new SqlParameter("@FECHA_INI", SqlDbType.DateTime));
                Com.Parameters["@FECHA_INI"].Value = fecha_ini;
                Com.Parameters.Add(new SqlParameter("@PERIODO", SqlDbType.Int));
                Com.Parameters["@PERIODO"].Value = periodo;
                Com.Parameters.Add(new SqlParameter("@USUARIO", SqlDbType.Int));
                Com.Parameters["@USUARIO"].Value = usuario;
                Com.Parameters.Add(new SqlParameter("@CD_ENCA_ACUERDOS", SqlDbType.Int));
                Com.Parameters["@CD_ENCA_ACUERDOS"].Value = cd_acuerdo;
                Com.Parameters.Add(new SqlParameter("@CD_TIPO_ACUERDO", SqlDbType.Int));
                Com.Parameters["@CD_TIPO_ACUERDO"].Value = cd_tipo_acuerdo;
                Com.Parameters.Add(new SqlParameter("@CD_RESPONSABLE", SqlDbType.Int));
                Com.Parameters["@CD_RESPONSABLE"].Value = cd_responsable;

                Adp.SelectCommand = Com;
                Adp.Fill(Dt);
            }
        }

        public static int obterner_cd_acuerdo(int cod_punto, DateTime fecha_registro, string acuerdo_corto, int cd_tipo_acuerdo, DateTime fecha_ini, int periodo, int usuario)
        {
            int cd_acuerdo=0;

            DateTime fecha = DateTime.Today;
            int anio_acu = fecha_registro.Year;
            string strquery = "";

            using (SqlConnection _conn = conexion.conectarBD())
            {
                SqlCommand Com = new SqlCommand();
                SqlDataAdapter Adp = new SqlDataAdapter();
                DataTable Dt = new DataTable();

                Com.Connection = _conn;

                strquery = "SELECT CD_ENCA_ACUERDOS FROM dbo.ACU_ENCA_ACUERDOS  WHERE  CD_DETA_CONV=" + cod_punto + " and DS_ANIO_ACUERDO=" + anio_acu + " and DS_ACUERDO_COMP = '" + acuerdo_corto + "' and CD_TIPO_ACUERDO=" + cd_tipo_acuerdo + " and PERIODO_DIAS=" + periodo + " and USUA_CREA=" + usuario + " and FE_FECHA_INI='" + fecha_ini.ToString("yyyy-MM-dd") + "' and FECH_CREA='" + fecha_registro.ToString("yyyy-MM-dd") + "'";
                SqlCommand _cmd = new SqlCommand(strquery, _conn);
                SqlDataReader _reader = _cmd.ExecuteReader();
                while (_reader.Read())
                {
                    cd_acuerdo = _reader.GetInt32(0);
                }
            }
            return cd_acuerdo;
        }

        public static void insertar_notificacion(int cod_enca_acuerdo, int cd_empleado, int cd_calidad)
        {
            DateTime fecha = DateTime.Today;
            using (SqlConnection _conn = conexion.conectarBD())
            {
                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "INSERT INTO dbo.ACU_NOTIFICACION_ACUERDO (CD_ENCA_ACUERDO, CD_EMPLEADO, CD_CALIDAD) VALUES (" + cod_enca_acuerdo + "," + cd_empleado + "," + cd_calidad + ")";
                cmd.Connection = _conn;
                cmd.ExecuteNonQuery();
            }
        }
        public static void votacion_acuerdo(string cod_votantes, string estados_votos, string accion, int cd_acuerdo, int usuario, DateTime fecha_registro)
        {
            DateTime fecha = DateTime.Today;
            using (System.Data.SqlClient.SqlConnection con = conexion.conectarBD())
            {
                SqlCommand Com = new SqlCommand();
                SqlDataAdapter Adp = new SqlDataAdapter();
                DataTable Dt = new DataTable();

                Com.Connection = con;
                Com.CommandType = CommandType.StoredProcedure;
                Com.CommandText = "acuerdos_votacion";
                Com.Parameters.Add(new SqlParameter("@CODS_VOTANTES", SqlDbType.VarChar));
                Com.Parameters["@CODS_VOTANTES"].Value = cod_votantes;
                Com.Parameters.Add(new SqlParameter("@ESTADO_VOTACION", SqlDbType.VarChar));
                Com.Parameters["@ESTADO_VOTACION"].Value = estados_votos;
                Com.Parameters.Add(new SqlParameter("@ACCION", SqlDbType.VarChar));
                Com.Parameters["@ACCION"].Value = accion;
                Com.Parameters.Add(new SqlParameter("@CD_ACUERDO", SqlDbType.Int));
                Com.Parameters["@CD_ACUERDO"].Value = cd_acuerdo;
                Com.Parameters.Add(new SqlParameter("@USUARIO", SqlDbType.Int));
                Com.Parameters["@USUARIO"].Value = usuario;
                Com.Parameters.Add(new SqlParameter("@FECHA", SqlDbType.DateTime));
                Com.Parameters["@FECHA"].Value = fecha_registro;


                Adp.SelectCommand = Com;
                Adp.Fill(Dt);
            }
        }


        public static List<datos_acuerdo> datos_acuerdo(int cd_acuerdo)
        {
            string strquery = "";
            List<datos_acuerdo> Lista_c = new List<datos_acuerdo>();
            using (SqlConnection _conn = conexion.conectarBD())
            {
                SqlCommand Com = new SqlCommand();
                SqlDataAdapter Adp = new SqlDataAdapter();
                DataTable Dt = new DataTable();

                Com.Connection = _conn;

                strquery = "SELECT DS_ACUERDO_COMP, DS_ACUERDO_CORTO, CD_TIPO_ACUERDO, FE_FECHA_INI, PERIODO_DIAS, CD_RESPONSABLE  FROM ACU_ENCA_ACUERDOS   WHERE CD_ENCA_ACUERDOS = " + cd_acuerdo;
                SqlCommand _cmd = new SqlCommand(strquery, _conn);
                SqlDataReader _reader = _cmd.ExecuteReader();
                while (_reader.Read())
                {
                    datos_acuerdo _c = new datos_acuerdo();
                    _c.ds_acuerdo_comp = _reader.GetString(0);
                    _c.ds_acuerdo_corto = _reader.GetString(1);
                    _c.tipo_acuerdo = _reader.GetInt32(2);
                    _c.fecha_inicio = _reader.GetDateTime(3);
                    _c.periodo = _reader.GetInt32(4);
                    _c.responsable = _reader.GetInt32(5);

                    Lista_c.Add(_c);
                }
            }
            return Lista_c;
        }


        public static void reporte_acuerdos_conv(int cod_acuerdo, int usuario)
        {
            using (System.Data.SqlClient.SqlConnection con = conexion.conectarBD())
            {
                SqlCommand Com = new SqlCommand();
                SqlDataAdapter Adp = new SqlDataAdapter();
                DataTable Dt = new DataTable();

                Com.Connection = con;
                Com.CommandType = CommandType.StoredProcedure;
                Com.CommandText = "rep_convocatoria_sp";

                Com.Parameters.Add(new SqlParameter("@CD_ENCA_ACUERDO", SqlDbType.Int));
                Com.Parameters["@CD_ENCA_ACUERDO"].Value = cod_acuerdo;
                Com.Parameters.Add(new SqlParameter("@USR_ID", SqlDbType.Int));
                Com.Parameters["@USR_ID"].Value = usuario;

                Adp.SelectCommand = Com;
                Adp.Fill(Dt);
            }
        }
    }
}