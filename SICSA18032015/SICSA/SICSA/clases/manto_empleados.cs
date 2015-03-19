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
    public class datos_empleados
    {
        public string nombre_emp { get; set; }
        public string apellido_emp { get; set; }
        public int cargo_emp { get; set; }
        public bool estado_emp { get; set; }
    }

    public class manto_empleados
    {
        public static List<datos_empleados> datos_emp(int cd_empleado)
        {
            string strquery = "";
            List<datos_empleados> Lista_emp = new List<datos_empleados>();
            using (SqlConnection _conn = conexion.conectarBD())
            {
                SqlCommand Com = new SqlCommand();
                SqlDataAdapter Adp = new SqlDataAdapter();
                DataTable Dt = new DataTable();

                Com.Connection = _conn;

                strquery = "SELECT DS_NOMBRE_EMPLEADO, DS_APELLIDO_EMPLEADO, CD_ESTADO, CD_CARGO_INST FROM dbo.GLB_EMPLEADOS WHERE CD_EMPLEADO=" + cd_empleado;
                SqlCommand _cmd = new SqlCommand(strquery, _conn);
                SqlDataReader _reader = _cmd.ExecuteReader();
                while (_reader.Read())
                {
                    datos_empleados _emp = new datos_empleados();
                    _emp.nombre_emp = _reader.GetString(0);
                    _emp.apellido_emp = _reader.GetString(1);
                    _emp.estado_emp = _reader.GetBoolean(2);
                    _emp.cargo_emp = _reader.GetInt32(3);

                    Lista_emp.Add(_emp);
                }
            }
            return Lista_emp;
        }

        public static void mto_emp(string accion, string nombre, string apellido, bool estado, int cargo, int usuario, DateTime fecha, int cd_emp)
        {
            using (System.Data.SqlClient.SqlConnection con = conexion.conectarBD())
            {
                SqlCommand Com = new SqlCommand();
                SqlDataAdapter Adp = new SqlDataAdapter();
                DataTable Dt = new DataTable();

                Com.Connection = con;
                Com.CommandType = CommandType.StoredProcedure;
                //nombre de procedimiento
                Com.CommandText = "PRAL_ACTUALIZAR_EMPLEADOS";
                //parametros
                Com.Parameters.Add(new SqlParameter("@ACCION", SqlDbType.VarChar));
                Com.Parameters["@ACCION"].Value = accion;

                Com.Parameters.Add(new SqlParameter("@NOMBRE", SqlDbType.VarChar));
                Com.Parameters["@NOMBRE"].Value = nombre;

                Com.Parameters.Add(new SqlParameter("@APELLIDO", SqlDbType.VarChar));
                Com.Parameters["@APELLIDO"].Value = apellido;

                Com.Parameters.Add(new SqlParameter("@ESTADO", SqlDbType.Bit));
                Com.Parameters["@ESTADO"].Value = estado;

                Com.Parameters.Add(new SqlParameter("@USUARIO", SqlDbType.Int));
                Com.Parameters["@USUARIO"].Value = usuario;

                Com.Parameters.Add(new SqlParameter("@CARGO", SqlDbType.Int));
                Com.Parameters["@CARGO"].Value = cargo;

                Com.Parameters.Add(new SqlParameter("@FECHA", SqlDbType.DateTime));
                Com.Parameters["@FECHA"].Value = fecha;

                Com.Parameters.Add(new SqlParameter("@CD_EMP", SqlDbType.Int));
                Com.Parameters["@CD_EMP"].Value = cd_emp;

                Adp.SelectCommand = Com;
                Adp.Fill(Dt);
            }
        }
    }
}