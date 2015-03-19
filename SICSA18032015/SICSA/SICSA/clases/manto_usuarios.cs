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
        public string correo { get; set; }
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

        public static void insertar_usuario(string usuario, string clave, int cd_empleado, string nombre, string apellido, string correo, string foto, string genero, int id_rol, int estado, int cambio)
        {
            DateTime fecha = DateTime.Today;
            using (SqlConnection _conn = conexion.conectarBD())
            {
                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "INSERT INTO dbo.CONF_USUARIO (usuario, clave, CD_EMPLEADO, nombre, apellido, correo, foto, genero, id_rol, estado, cambio, fecha_crea) VALUES ('" + usuario + "', '" + clave + "', " + cd_empleado + ", '" + nombre + "', '" + apellido + "', '" + correo + " ', '" + foto + "', '" + genero + "', " + id_rol + ", " + estado + ", " + cambio + ", '" + fecha.ToString("yyyy-MM-dd") + "')";
                cmd.Connection = _conn;
                cmd.ExecuteNonQuery();

                //Agregar Usuario a tabla Lisandro
                //Obtener estado
                string est = "";
                if (estado == 1)
                {
                    est = "A";
                }
                else
                {
                    est = "C";
                }

                //Obtener Codigo perfil.
                string strquery = "";
                string nom_rol = "";
                strquery = "  SELECT rol FROM CONF_ROL WHERE id_rol=" + id_rol;
                SqlCommand _cmd3 = new SqlCommand(strquery, _conn);
                SqlDataReader _reader = _cmd3.ExecuteReader();
                while (_reader.Read())
                {
                    nom_rol = _reader.GetString(0);
                }

                string nom_user = "";
                nom_user = nombre + ' ' + apellido;

                _reader.Dispose();
                _reader.Close();

                SqlCommand cmd2 = new SqlCommand();
                cmd2.CommandType = System.Data.CommandType.Text;
                cmd2.CommandText = "INSERT INTO dbo.GLB_USUARIOS (CD_CODIGO_USUARIO, DS_NOMBRE_USUARIO, CD_CLAVE_USUARIO, CD_CODIGO_PERFIL, CD_DIRE_EMAIL, CD_ESTADO_USUARIO, USUA_CREA, FECH_CREA) VALUES ('" + usuario + "', '" + nom_user + "', '" + clave + "', '" + nom_rol + "', '" + correo + "', '" + est + "', '1', '" + fecha.ToString("yyyy-MM-dd") + "')";
                cmd2.Connection = _conn;
                cmd2.ExecuteNonQuery();
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

        public static void actualizar_usuario(int id_usuario, string usuario, string clave, int cd_empleado, string nombre, string apellido, string correo, string foto, string genero, int id_rol, int estado, int cambio)
        {
            DateTime fecha = DateTime.Today;
            using (SqlConnection _conn = conexion.conectarBD())
            {
                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "UPDATE dbo.CONF_USUARIO SET  clave = '" + clave + "' , CD_EMPLEADO = " + cd_empleado + ", nombre = '" + nombre + "', apellido = '" + apellido + "', correo = '" + correo + "', foto = '" + foto + "', genero = '" + genero + "', id_rol  = " + id_rol + ", estado = " + estado + ", cambio = " + cambio + ", FE_ACTU = '" + fecha.ToString("yyyy-MM-dd") + "' WHERE id_usuario=" + id_usuario;
                cmd.Connection = _conn;
                cmd.ExecuteNonQuery();

                //Agregar Usuario a tabla Lisandro
                //Obtener estado
                string est = "";
                if (estado == 1)
                {
                    est = "A";
                }
                else
                {
                    est = "C";
                }

                //Obtener Codigo perfil.
                string strquery = "";
                string nom_rol = "";
                strquery = "  SELECT rol FROM CONF_ROL WHERE id_rol=" + id_rol;
                SqlCommand _cmd3 = new SqlCommand(strquery, _conn);
                SqlDataReader _reader = _cmd3.ExecuteReader();
                while (_reader.Read())
                {
                    nom_rol = _reader.GetString(0);
                }

                string nom_user = "";
                nom_user = nombre + ' ' + apellido;

                _reader.Dispose();
                _reader.Close();

                SqlCommand cmd2 = new SqlCommand();
                cmd2.CommandType = System.Data.CommandType.Text;
                cmd2.CommandText = "  UPDATE dbo.GLB_USUARIOS SET CD_CODIGO_USUARIO='" + usuario + "', DS_NOMBRE_USUARIO = '" + nom_user + "', CD_CLAVE_USUARIO='" + clave + "', CD_CODIGO_PERFIL='" + nom_rol + "', CD_DIRE_EMAIL='" + correo + "', CD_ESTADO_USUARIO='" + est + "', USUA_ACTU='1', FECH_ACTU='" + fecha.ToString("yyyy-MM-dd") + "' WHERE CD_CODIGO_USUARIO='" + usuario + "'";
                cmd2.Connection = _conn;
                cmd2.ExecuteNonQuery();
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

                strquery = "select usuario, CD_EMPLEADO, foto, genero, id_rol, estado, correo from dbo.CONF_USUARIO WHERE id_usuario=" + id_usr;
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
                    _c.correo = _reader.IsDBNull(6) ? String.Empty : _reader.GetString(6);

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

        public static void actualizar_contraseña (int id_usuario, string clave)
        {
            DateTime fecha = DateTime.Today;
            using (SqlConnection _conn = conexion.conectarBD())
            {
                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "UPDATE dbo.CONF_USUARIO SET  clave = '" + clave + "' , cambio = 0  WHERE id_usuario=" + id_usuario;
                cmd.Connection = _conn;
                cmd.ExecuteNonQuery();

                //Agregar Usuario a tabla Lisandro
                //Obtener usuario.
                string strquery = "";
                string user = "";
                strquery = "SELECT usuario FROM dbo.CONF_USUARIO WHERE id_usuario=" + id_usuario;
                SqlCommand _cmd3 = new SqlCommand(strquery, _conn);
                SqlDataReader _reader = _cmd3.ExecuteReader();
                while (_reader.Read())
                {
                    user = _reader.GetString(0);
                }

                _reader.Dispose();
                _reader.Close();

                SqlCommand cmd2 = new SqlCommand();
                cmd2.CommandType = System.Data.CommandType.Text;
                cmd2.CommandText = "  UPDATE dbo.GLB_USUARIOS SET CD_CLAVE_USUARIO='" + clave + "' WHERE CD_CODIGO_USUARIO='" + user + "'";
                cmd2.Connection = _conn;
                cmd2.ExecuteNonQuery();
            }
        }

        public static bool validar_pass(int id_usr, string pass)
        {
            string strquery = "";
            string clave = "";
            using (SqlConnection con = conexion.conectarBD())
            {
                SqlCommand cmd = new SqlCommand(strquery, con);
                strquery = "SELECT clave FROM dbo.CONF_USUARIO WHERE id_usuario=" + id_usr;
                SqlCommand _cmd3 = new SqlCommand(strquery, con);
                SqlDataReader _reader = _cmd3.ExecuteReader();
                while (_reader.Read())
                {
                    clave = _reader.GetString(0);
                }
            }

            if (pass == clave)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public static List<datos_usuario> nom_usuario(int id_usuario)
        {
            string strquery = "";
            List<datos_usuario> Lista_c = new List<datos_usuario>();
            using (SqlConnection _conn = conexion.conectarBD())
            {
                SqlCommand Com = new SqlCommand();
                SqlDataAdapter Adp = new SqlDataAdapter();
                DataTable Dt = new DataTable();

                Com.Connection = _conn;

                strquery = "select nombre, apellido FROM dbo.CONF_USUARIO WHERE id_usuario = " + id_usuario; 
                SqlCommand _cmd = new SqlCommand(strquery, _conn);
                SqlDataReader _reader = _cmd.ExecuteReader();
                while (_reader.Read())
                {
                    datos_usuario _c = new datos_usuario();
                    _c.nombre_usuario = _reader.GetString(0);
                    _c.apellido_usuario = _reader.GetString(1);

                    Lista_c.Add(_c);
                }
            }
            return Lista_c;
        }

        public static bool cambio_clave(int id_usr)
        {
            string strquery = "";
            int cambio = 0;
            using (SqlConnection con = conexion.conectarBD())
            {
                SqlCommand cmd = new SqlCommand(strquery, con);
                strquery = "select cambio FROM dbo.CONF_USUARIO WHERE id_usuario = " + id_usr;
                SqlCommand _cmd3 = new SqlCommand(strquery, con);
                SqlDataReader _reader = _cmd3.ExecuteReader();
                while (_reader.Read())
                {
                    cambio = _reader.GetInt32(0);
                }
            }

            if (cambio == 1)
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