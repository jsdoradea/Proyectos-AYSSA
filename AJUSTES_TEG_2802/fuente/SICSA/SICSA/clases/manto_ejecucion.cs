using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace SICSA.clases
{
    public class datos_ejecucion
    {
        public string ds_sesion { get; set; }
        public string ds_acta { get; set; }
        public int dias_acuerdo { get; set; }
        public int num_acuerdo { get; set; }
        public int responsable { get; set; }
        public string nom_acuerdo { get; set; }
        public DateTime fecha_inicio { get; set; }
        public DateTime fecha_fin { get; set; }
    }

    public class datos_tareas
    {
        public string ds_tarea { get; set; }
        public string ds_descripcion { get; set; }
        public int cd_responsable { get; set; }
        public int predecesora { get; set; }
        public int dias_ejecucion { get; set; }
    }

    public class manto_ejecucion
    {
        public static List<datos_ejecucion> datos_ejecucion(int cd_acuerdo)
        {
            string strquery = "";
            List<datos_ejecucion> Lista_c = new List<datos_ejecucion>();
            using (SqlConnection _conn = conexion.conectarBD())
            {
                SqlCommand Com = new SqlCommand();
                SqlDataAdapter Adp = new SqlDataAdapter();
                DataTable Dt = new DataTable();

                Com.Connection = _conn;

                strquery = "SELECT c.DS_REFERENCIA, c.DS_ACTA, a.PERIODO_DIAS, a.NM_CORR_ACUERDO, a.CD_RESPONSABLE, a.DS_ACUERDO_COMP, a.FE_FECHA_INI, a.FECHA_FIN FROM dbo.ACU_ENCA_ACUERDOS a 		INNER JOIN dbo.CONV_PUNTOS_AGENDA b ON b.CD_CONVOCATORIA = a.CD_DETA_CONV 	INNER JOIN dbo.AGD_ENCA_CONVOCATORIA c ON c.CD_ENCA_CONVOCATORIA = b.CD_ENCA_CONVOCATORIA WHERE a.CD_ENCA_ACUERDOS=" + cd_acuerdo;
                SqlCommand _cmd = new SqlCommand(strquery, _conn);
                SqlDataReader _reader = _cmd.ExecuteReader();
                while (_reader.Read())
                {
                    datos_ejecucion _c = new datos_ejecucion();
                    _c.ds_sesion = _reader.GetString(0);
                    _c.ds_acta = _reader.GetString(1);
                    _c.dias_acuerdo = _reader.GetInt32(2);
                    _c.num_acuerdo= _reader.GetInt32(3);
                    _c.responsable = _reader.GetInt32(4);
                    _c.nom_acuerdo = _reader.GetString(5);
                    _c.fecha_inicio = _reader.GetDateTime(6);
                    _c.fecha_fin = _reader.GetDateTime(7);
                    Lista_c.Add(_c);
                }
            }
            return Lista_c;
        }

        public static void insertar_tarea(int accion, int cd_tarea, int cod_enca_acuerdo, string tarea, string descripcion, int responsable, int predecesora, int dias_ejecucion, int usuario, bool es_plantilla)
        {
            DateTime fecha = DateTime.Today;
            using (System.Data.SqlClient.SqlConnection con = conexion.conectarBD())
            {
                SqlCommand Com = new SqlCommand();
                SqlDataAdapter Adp = new SqlDataAdapter();
                DataTable Dt = new DataTable();

                Com.Connection = con;
                Com.CommandType = CommandType.StoredProcedure;
                Com.CommandText = "tareas_sp";
                Com.Parameters.Add(new SqlParameter("@ACCION", SqlDbType.Int));
                Com.Parameters["@ACCION"].Value = accion;
                Com.Parameters.Add(new SqlParameter("@CD_TAREA", SqlDbType.Int));
                Com.Parameters["@CD_TAREA"].Value = cd_tarea;
                Com.Parameters.Add(new SqlParameter("@CD_ENCA_ACUERDO", SqlDbType.Int));
                Com.Parameters["@CD_ENCA_ACUERDO"].Value = cod_enca_acuerdo;
                Com.Parameters.Add(new SqlParameter("@TAREA", SqlDbType.VarChar));
                Com.Parameters["@TAREA"].Value = tarea;
                Com.Parameters.Add(new SqlParameter("@DESCRIPCION", SqlDbType.VarChar));
                Com.Parameters["@DESCRIPCION"].Value = descripcion;
                Com.Parameters.Add(new SqlParameter("@RESPONSABLE", SqlDbType.Int));
                Com.Parameters["@RESPONSABLE"].Value = responsable;
                Com.Parameters.Add(new SqlParameter("@PREDECESORA", SqlDbType.Int));
                Com.Parameters["@PREDECESORA"].Value = predecesora;
                //Com.Parameters.Add(new SqlParameter("@FECHA_INI", SqlDbType.DateTime));
                //Com.Parameters["@FECHA_INI"].Value = fecha_ini;
                Com.Parameters.Add(new SqlParameter("@DIAS_EJEC", SqlDbType.Int));
                Com.Parameters["@DIAS_EJEC"].Value = dias_ejecucion;
                Com.Parameters.Add(new SqlParameter("@USUARIO", SqlDbType.Int));
                Com.Parameters["@USUARIO"].Value = usuario;
                Com.Parameters.Add(new SqlParameter("@FECHA_REG", SqlDbType.DateTime));
                Com.Parameters["@FECHA_REG"].Value = fecha;
                Com.Parameters.Add(new SqlParameter("@ES_PLANTILLA", SqlDbType.Bit));
                Com.Parameters["@ES_PLANTILLA"].Value = es_plantilla;


                Adp.SelectCommand = Com;
                Adp.Fill(Dt);
            }
        }


        public static void insertar_plantilla(int cd_plantilla, int cod_enca_acuerdo, int usuario, bool es_plantilla)
        {
            string strquery = "";
            DateTime fecha = DateTime.Today;
            using (SqlConnection _conn = conexion.conectarBD())
            {
                SqlCommand Com = new SqlCommand();
                SqlDataAdapter Adp = new SqlDataAdapter();
                DataTable Dt = new DataTable();

                Com.Connection = _conn;

                strquery = "SELECT CD_EJE_DETA_PLANTILLA, CD_PLANTILLA, NM_TAREA, DS_TAREA, DS_DESC_TAREA, CD_RESPONSABLE, CD_PREDECESORA, DIAS_EJEC FROM dbo.EJE_DETA_PLANTILLA WHERE CD_PLANTILLA=" + cd_plantilla + " and ESTADO_TAREA=1 ORDER BY NM_TAREA";
                SqlCommand _cmd = new SqlCommand(strquery, _conn);
                SqlDataReader _reader = _cmd.ExecuteReader();
                while (_reader.Read())
                {
                    int cd_eje_plant = _reader.GetInt32(0);
                    int cod_plantilla = _reader.GetInt32(1);
                    int nm_tarea = _reader.GetInt32(2);
                    string ds_tarea = _reader.GetString(3);
                    string desc_tarea = _reader.IsDBNull(4) ? String.Empty : _reader.GetString(4);
                    int cd_responsable = _reader.GetInt32(5);
                    int cd_predecesora = _reader.GetInt32(6);
                    int dias_ejec = _reader.GetInt32(7);
                    manto_ejecucion.insertar_tarea(0, 0, cod_enca_acuerdo, ds_tarea, desc_tarea, cd_responsable, cd_predecesora, dias_ejec, usuario, es_plantilla);
                }
            }
        }

        public static List<datos_tareas> datos_tareas(int cd_tarea)
        {
            string strquery = "";
            List<datos_tareas> Lista_c = new List<datos_tareas>();
            using (SqlConnection _conn = conexion.conectarBD())
            {
                SqlCommand Com = new SqlCommand();
                SqlDataAdapter Adp = new SqlDataAdapter();
                DataTable Dt = new DataTable();

                Com.Connection = _conn;

                strquery = "select DS_TAREA, DS_DESCRIPCION, CD_RESPONSABLE, PREDECESORA, DIAS_EJECUCION from dbo.ACU_TAREAS_ACUERDOS WHERE CD_TAREA=" + cd_tarea;
                SqlCommand _cmd = new SqlCommand(strquery, _conn);
                SqlDataReader _reader = _cmd.ExecuteReader();
                while (_reader.Read())
                {
                    datos_tareas _c = new datos_tareas();
                    _c.ds_tarea = _reader.GetString(0);
                    _c.ds_descripcion = _reader.IsDBNull(1) ? String.Empty : _reader.GetString(1);
                    _c.cd_responsable = _reader.GetInt32(2);
                    _c.predecesora = _reader.GetInt32(3);
                    _c.dias_ejecucion= _reader.GetInt32(4);
                    Lista_c.Add(_c);
                }
            }
            return Lista_c;
        }

        public static bool validar_plan(int cd_acuerdo)
        {
            string strquery = "";
            int dias_acuerdo = 0;
            int dias_acumulados = 0;
            using (SqlConnection _conn = conexion.conectarBD())
            {
                SqlCommand Com = new SqlCommand();
                SqlDataAdapter Adp = new SqlDataAdapter();
                DataTable Dt = new DataTable();

                Com.Connection = _conn;

                strquery = "SELECT PERIODO_DIAS   FROM ACU_ENCA_ACUERDOS  WHERE CD_ENCA_ACUERDOS=" + cd_acuerdo; 
                SqlCommand _cmd = new SqlCommand(strquery, _conn);
                SqlDataReader _reader = _cmd.ExecuteReader();
                while (_reader.Read())
                {
                    dias_acuerdo = _reader.GetInt32(0);
                }

                _reader.Close();
                _reader.Dispose();
                _cmd.Dispose();

                strquery = "SELECT MAX(DIAS_ACUMULADOS) as DIAS FROM dbo.ACU_TAREAS_ACUERDOS WHERE CD_ENCA_ACUERDOS=" + cd_acuerdo;
                //SqlCommand _cmd2 = new SqlCommand(strquery, _conn);
                _cmd = new SqlCommand(strquery, _conn);
                //SqlDataReader _reader2 = _cmd2.ExecuteReader();
                _reader = _cmd.ExecuteReader();
                while (_reader.Read())
                {
                    dias_acumulados = _reader.GetInt32(0);
                }
            }
            if (dias_acumulados <= dias_acuerdo)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    }
}