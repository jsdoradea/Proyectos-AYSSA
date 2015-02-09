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
    public class datos_usuario
    {
        public string nombre_usuario { get; set; }
        public string apellido_usuario { get; set; }
        public string unidad { get; set; }
        public string cargo { get; set; }
    }
    public class datos_act_usuario
    {
        public string usuario { get; set; }
        public int cd_empleado { get; set; }
        public int genero { get; set; }
        public int estado { get; set; }
        public string foto { get; set; }
        public int rol { get; set; }
    }
    public class datos_rol
    {
        public string nombre_rol { get; set; }
    }

    public class manto_usuarios
    {
        public static List<datos_usuario> datos_usuario(int cd_empleado)
        {
            string strquery = "";
            List<datos_usuario> Lista_c = new List<datos_usuario>();
            using (SqlConnection _conn = conexion.conectarBD())
            {
                SqlCommand Com = new SqlCommand();
                SqlDataAdapter Adp = new SqlDataAdapter();
                DataTable Dt = new DataTable();

                Com.Connection = _conn;

                strquery = "SELECT a.DS_NOMBRE_EMPLEADO, a.DS_APELLIDO_EMPLEADO, b.DS_UNIDAD, c.DS_CARGO_INST FROM dbo.GLB_EMPLEADOS a 	INNER JOIN dbo.GLB_UNIDADES_TEG b ON b.CD_UNIDAD = a.CD_UNIDAD 	INNER JOIN dbo.GLB_CARGOS_INSTITUCIONALES c ON c.CD_CARGO_INST = a.CD_CARGO_INST WHERE a.CD_EMPLEADO=" + cd_empleado;
                SqlCommand _cmd = new SqlCommand(strquery, _conn);
                SqlDataReader _reader = _cmd.ExecuteReader();
                while (_reader.Read())
                {
                    datos_usuario _c = new datos_usuario();
                    _c.nombre_usuario = _reader.GetString(0);
                    _c.apellido_usuario = _reader.GetString(1);
                    _c.unidad = _reader.GetString(2);
                    _c.cargo = _reader.GetString(3);

                    Lista_c.Add(_c);
                }
            }
            return Lista_c;
        }

        public static void insertar_usuario(string usuario, string clave, int cd_empleado, string nombre, string apellido, string foto, string genero, int id_rol, int estado, int cambio)
        {
            DateTime fecha = DateTime.Today;
            using (SqlConnection _conn = conexion.conectarBD())
            {
                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "INSERT INTO dbo.CONF_USUARIO (usuario, clave, CD_EMPLEADO, nombre, apellido, foto, genero, id_rol, estado, cambio, fecha_crea) VALUES ('" + usuario + "', '" + clave + "', " + cd_empleado + ", '" + nombre + "', '" + apellido + "', '" + foto + "', '" + genero + "', " + id_rol + ", " + estado + ", " + cambio + ", '" + fecha.ToString("yyyy-MM-dd") + "')";
                cmd.Connection = _conn;
                cmd.ExecuteNonQuery();
            }
        }

        public static bool validar_usuario(string usuario)
        {
            string strquery = @"SELECT * FROM dbo.conf_usuario WHERE usuario=@Usuario";
            using (SqlConnection con = conexion.conectarBD())
            {
                SqlCommand cmd = new SqlCommand(strquery, con);
                cmd.Parameters.AddWithValue("@Usuario", usuario);
                int count = Convert.ToInt32(cmd.ExecuteScalar());
                if (count == 0)
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }
        }

        public static void actualizar_usuario(int id_usuario, string usuario, string clave, int cd_empleado, string nombre, string apellido, string foto, string genero, int id_rol, int estado, int cambio)
        {
            DateTime fecha = DateTime.Today;
            using (SqlConnection _conn = conexion.conectarBD())
            {
                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "UPDATE dbo.CONF_USUARIO SET  clave = '" + clave + "' , CD_EMPLEADO = " + cd_empleado + ", nombre = '" + nombre + "', apellido = '" + apellido + "', foto = '" + foto + "', genero = '" + genero + "', id_rol  = " + id_rol + ", estado = " + estado + ", cambio = " + cambio + ", FE_ACTU = '" + fecha.ToString("yyyy-MM-dd") + "' WHERE id_usuario=" + id_usuario;
                cmd.Connection = _conn;
                cmd.ExecuteNonQuery();
            }
        }

        public static List<datos_act_usuario> datos_act_usuario(int id_usr)
        {
            string strquery = "";
            List<datos_act_usuario> Lista_c = new List<datos_act_usuario>();
            using (SqlConnection _conn = conexion.conectarBD())
            {
                SqlCommand Com = new SqlCommand();
                SqlDataAdapter Adp = new SqlDataAdapter();
                DataTable Dt = new DataTable();

                Com.Connection = _conn;

                strquery = "select usuario, CD_EMPLEADO, foto, genero, id_rol, estado from dbo.CONF_USUARIO WHERE id_usuario=" + id_usr;
                SqlCommand _cmd = new SqlCommand(strquery, _conn);
                SqlDataReader _reader = _cmd.ExecuteReader();
                while (_reader.Read())
                {
                    datos_act_usuario _c = new datos_act_usuario();
                    _c.usuario = _reader.GetString(0);
                    _c.cd_empleado = _reader.GetInt32(1);
                    _c.foto = _reader.GetString(2);
                    _c.genero = _reader.GetInt32(3);
                    _c.rol = _reader.GetInt32(4);
                    _c.estado = _reader.GetInt32(5);

                    Lista_c.Add(_c);
                }
            }
            return Lista_c;
        }

        public static List<datos_rol> datos_rol(int cd_rol)
        {
            string strquery = "";
            List<datos_rol> Lista_c = new List<datos_rol>();
            using (SqlConnection _conn = conexion.conectarBD())
            {
                SqlCommand Com = new SqlCommand();
                SqlDataAdapter Adp = new SqlDataAdapter();
                DataTable Dt = new DataTable();

                Com.Connection = _conn;

                strquery = "  SELECT rol FROM dbo.CONF_ROL WHERE id_rol=" + cd_rol; 
                SqlCommand _cmd = new SqlCommand(strquery, _conn);
                SqlDataReader _reader = _cmd.ExecuteReader();
                while (_reader.Read())
                {
                    datos_rol _c = new datos_rol();
                    _c.nombre_rol = _reader.GetString(0);

                    Lista_c.Add(_c);
                }
            }
            return Lista_c;
        }
    }
}