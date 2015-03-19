using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace SICSA.clases
{
    public class datos_tarea_acu
    {
        public int cd_tarea { get; set; }
        public int cd_enca_acu { get; set; }
        public string ds_tarea { get; set; }
        public string ds_descripcion { get; set; }
        public DateTime fecha_inicio { get; set; }
        public DateTime fecha_fin { get; set; }
        public int dias_ejec { get; set; }
        public string ds_acuerdo { get; set; }
        public int n_acuerdo { get; set; }
        public string ds_acta { get; set; }
        public string ds_referencia { get; set; }
    }
    public class manto_tareas
    {
        public static List<datos_tarea_acu> datos_tarea_acu(int cd_tarea)
        {
            string strquery = "";
            List<datos_tarea_acu> Lista_c = new List<datos_tarea_acu>();
            using (SqlConnection _conn = conexion.conectarBD())
            {
                SqlCommand Com = new SqlCommand();
                SqlDataAdapter Adp = new SqlDataAdapter();
                DataTable Dt = new DataTable();

                Com.Connection = _conn;

                strquery = "SELECT a.CD_TAREA, a.CD_ENCA_ACUERDOS, a.DS_TAREA, a.DS_DESCRIPCION, a.FE_FECHA_INI, a.FECHA_FIN, a.DIAS_EJECUCION, 		b.DS_ACUERDO_COMP, b.NM_CORR_ACUERDO, d.DS_ACTA, d.DS_REFERENCIA FROM dbo.ACU_TAREAS_ACUERDOS a 	INNER JOIN dbo.ACU_ENCA_ACUERDOS b ON b.CD_ENCA_ACUERDOS = a.CD_ENCA_ACUERDOS 	INNER JOIN dbo.CONV_PUNTOS_AGENDA c ON c.CD_CONVOCATORIA = b.CD_DETA_CONV 	INNER JOIN dbo.AGD_ENCA_CONVOCATORIA d ON d.CD_ENCA_CONVOCATORIA = c.CD_ENCA_CONVOCATORIA WHERE a.CD_TAREA=" + cd_tarea;
                SqlCommand _cmd = new SqlCommand(strquery, _conn);
                SqlDataReader _reader = _cmd.ExecuteReader();
                while (_reader.Read())
                {
                    datos_tarea_acu _c = new datos_tarea_acu();

                    _c.cd_tarea = _reader.GetInt32(0);
                    _c.cd_enca_acu = _reader.GetInt32(1);
                    _c.ds_tarea= _reader.GetString(2);
                    _c.ds_descripcion = _reader.GetString(3);
                    _c.fecha_inicio = _reader.GetDateTime(4);
                    _c.fecha_fin = _reader.GetDateTime(5);
                    _c.dias_ejec = _reader.GetInt32(6);
                    _c.ds_acuerdo = _reader.GetString(7);
                    _c.n_acuerdo = _reader.GetInt32(8);
                    _c.ds_acta = _reader.GetString(9);
                    _c.ds_referencia = _reader.GetString(10);

                    Lista_c.Add(_c);
                }
            }
            return Lista_c;
        }

        public static bool validar_prorroga(int cd_tarea)
        {
            string strquery = "";
            DateTime fecha_max = DateTime.Today;
            DateTime fecha_hoy = DateTime.Today;
            using (SqlConnection _conn = conexion.conectarBD())
            {
                SqlCommand Com = new SqlCommand();
                SqlDataAdapter Adp = new SqlDataAdapter();
                DataTable Dt = new DataTable();

                Com.Connection = _conn;

                strquery = "SELECT DATEADD(DAY,-2,FECHA_FIN)   FROM ACU_TAREAS_ACUERDOS   WHERE CD_TAREA=" + cd_tarea;
                SqlCommand _cmd = new SqlCommand(strquery, _conn);
                SqlDataReader _reader = _cmd.ExecuteReader();
                while (_reader.Read())
                {
                    fecha_max = _reader.GetDateTime(0);
                }
            }
            if (fecha_hoy <= fecha_max)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public static void insertar_avance(int cd_tarea, int estado_tarea, string comentario, string nom_archivo, string url_archivo, int usuario)
        {
            DateTime fecha = DateTime.Today;
            using (System.Data.SqlClient.SqlConnection con = conexion.conectarBD())
            {
                SqlCommand Com = new SqlCommand();
                SqlDataAdapter Adp = new SqlDataAdapter();
                DataTable Dt = new DataTable();

                Com.Connection = con;
                Com.CommandType = CommandType.StoredProcedure;
                Com.CommandText = "terminar_tarea_sp";
                Com.Parameters.Add(new SqlParameter("@CD_TAREA", SqlDbType.Int));
                Com.Parameters["@CD_TAREA"].Value = cd_tarea;
                Com.Parameters.Add(new SqlParameter("@ESTADO_TAREA", SqlDbType.Int));
                Com.Parameters["@ESTADO_TAREA"].Value = estado_tarea;
                Com.Parameters.Add(new SqlParameter("@COMENTARIO", SqlDbType.VarChar));
                Com.Parameters["@COMENTARIO"].Value = comentario;
                Com.Parameters.Add(new SqlParameter("@NOM_ARCHIVO", SqlDbType.VarChar));
                Com.Parameters["@NOM_ARCHIVO"].Value = nom_archivo;
                Com.Parameters.Add(new SqlParameter("@URL_ARCHIVO", SqlDbType.VarChar));
                Com.Parameters["@URL_ARCHIVO"].Value = url_archivo;
                Com.Parameters.Add(new SqlParameter("@USUARIO", SqlDbType.Int));
                Com.Parameters["@USUARIO"].Value = usuario;


                Adp.SelectCommand = Com;
                Adp.Fill(Dt);
            }
        }

        public static void solicitar_prorroga(int cd_tarea, string justificacion, int num_dias, int usuario)
        {
            DateTime fecha = DateTime.Today;
            using (System.Data.SqlClient.SqlConnection con = conexion.conectarBD())
            {
                SqlCommand Com = new SqlCommand();
                SqlDataAdapter Adp = new SqlDataAdapter();
                DataTable Dt = new DataTable();

                Com.Connection = con;
                Com.CommandType = CommandType.StoredProcedure;
                Com.CommandText = "solicitar_prorroga_tarea";
                Com.Parameters.Add(new SqlParameter("@CD_TAREA", SqlDbType.Int));
                Com.Parameters["@CD_TAREA"].Value = cd_tarea;
                Com.Parameters.Add(new SqlParameter("@DS_JUSTIFICACION", SqlDbType.VarChar));
                Com.Parameters["@DS_JUSTIFICACION"].Value = justificacion;
                Com.Parameters.Add(new SqlParameter("@NUM_DIAS_PRORROGA", SqlDbType.Int));
                Com.Parameters["@NUM_DIAS_PRORROGA"].Value = num_dias;
                Com.Parameters.Add(new SqlParameter("@USUARIO", SqlDbType.Int));
                Com.Parameters["@USUARIO"].Value = usuario;


                Adp.SelectCommand = Com;
                Adp.Fill(Dt);
            }
        }

        public static void autorizar_actividad(int cd_eje_plan, int cd_estado_plan, string comentarios, int usuario)
        {
            DateTime fecha = DateTime.Today;
            using (System.Data.SqlClient.SqlConnection con = conexion.conectarBD())
            {
                SqlCommand Com = new SqlCommand();
                SqlDataAdapter Adp = new SqlDataAdapter();
                DataTable Dt = new DataTable();

                Com.Connection = con;
                Com.CommandType = CommandType.StoredProcedure;
                Com.CommandText = "autorizar_actividad_plan_sp";
                Com.Parameters.Add(new SqlParameter("@EJE_PLAN_EJEC_ACTIV", SqlDbType.Int));
                Com.Parameters["@EJE_PLAN_EJEC_ACTIV"].Value = cd_eje_plan;
                Com.Parameters.Add(new SqlParameter("@ESTADO_AUT", SqlDbType.Int));
                Com.Parameters["@ESTADO_AUT"].Value = cd_estado_plan;

                Com.Parameters.Add(new SqlParameter("@DS_COMENTARIOS", SqlDbType.VarChar));
                Com.Parameters["@DS_COMENTARIOS"].Value = comentarios;

                Com.Parameters.Add(new SqlParameter("@USUARIO", SqlDbType.Int));
                Com.Parameters["@USUARIO"].Value = usuario;


                Adp.SelectCommand = Com;
                Adp.Fill(Dt);
            }
        }

        public static bool validar_procedencia_tarea(int cd_tarea)
        {
            string strquery = "";
            bool es_plant = false;
            using (SqlConnection _conn = conexion.conectarBD())
            {
                SqlCommand Com = new SqlCommand();
                SqlDataAdapter Adp = new SqlDataAdapter();
                DataTable Dt = new DataTable();

                Com.Connection = _conn;

                strquery = "SELECT ES_PLANTILLA   FROM ACU_TAREAS_ACUERDOS   WHERE CD_TAREA = " + cd_tarea;
                SqlCommand _cmd = new SqlCommand(strquery, _conn);
                SqlDataReader _reader = _cmd.ExecuteReader();
                while (_reader.Read())
                {
                    es_plant = _reader.GetBoolean(0);
                }
            }
            if (es_plant==true)
            { 
                //tarea proviene de plantilla
                return true;
            }
            else
            {
                //tarea es independiente
                return false;
            }
        }

        public static void enviar_correo(int usuario, int cd_tarea, int estado_tarea, string justificacion)
        {
            using (System.Data.SqlClient.SqlConnection con = conexion.conectarBD())
            {
                SqlCommand Com = new SqlCommand();
                SqlDataAdapter Adp = new SqlDataAdapter();
                DataTable Dt = new DataTable();

                Com.Connection = con;
                Com.CommandType = CommandType.StoredProcedure;
                Com.CommandText = "envio_avance_tarea_SP";

                Com.Parameters.Add(new SqlParameter("@USUARIO", SqlDbType.Int));
                Com.Parameters["@USUARIO"].Value = usuario;
                Com.Parameters.Add(new SqlParameter("@CD_TAREA", SqlDbType.Int));
                Com.Parameters["@CD_TAREA"].Value = cd_tarea;
                Com.Parameters.Add(new SqlParameter("@ESTADO_TAREA", SqlDbType.Int));
                Com.Parameters["@ESTADO_TAREA"].Value = estado_tarea;
                Com.Parameters.Add(new SqlParameter("@JUSTIFICACION", SqlDbType.VarChar));
                Com.Parameters["@JUSTIFICACION"].Value = justificacion;


                Adp.SelectCommand = Com;
                Adp.Fill(Dt);
            }
        }
    }
}