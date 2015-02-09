using System;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using SIS.Framework.Common;


namespace SIS.Data
{
    public class COpcionesSistemas:CTemplate
    {
        private string _ConexionData;
        private string _NombreForma;
        private string _DescripcionOpcionSistema;

        public COpcionesSistemas(string ConexionData)
        {
            _ConexionData = ConexionData;
        }

        public string NombreForma
        {
            get
            {
                return _NombreForma;
            }
            set
            {
                _NombreForma = value;
            }
        }

        public string DescripcionOpcionSistema
        {
            get
            {
                return _DescripcionOpcionSistema;
            }
            set
            {
                _DescripcionOpcionSistema = value;
            }
        }

        public void DetalleOpcion(string CodigoOpcion, string DescripcionOpcion, int OpcionConsulta)
        {
            try
            {
                ObjConnection = new SqlConnection(_ConexionData);
                ObjCommand = new SqlCommand("PRAL_DATA_GLB_OPCIONES_SISTEMA", ObjConnection);
                //ObjParam = new SqlParameter;
                ObjCommand.CommandType = CommandType.StoredProcedure;

                ObjCommand.Parameters.AddWithValue("@CD_CODI_OPCI_SIST", CodigoOpcion);
                ObjCommand.Parameters.AddWithValue("@DS_CODI_OPCI_SIST", DescripcionOpcion);
                ObjCommand.Parameters.AddWithValue("@OPCI_CONS", OpcionConsulta);

                ObjConnection.Open();

                SqlDataReader objReader = ObjCommand.ExecuteReader();

                while (objReader.Read())
                {
                    _NombreForma = objReader.GetString(objReader.GetOrdinal("DS_NOMBRE_FORMA"));
                    _DescripcionOpcionSistema = objReader.GetString( objReader.GetOrdinal("DS_CODI_OPCI_SIST"));
                }

                ObjConnection.Close();

                if (ObjConnection.State != ConnectionState.Closed)
                {
                    ObjConnection.Close();
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public DataSet DetalleOpciones(string CodigoUsuario, string CodigoSistema, int OpcionConsulta)
        {
            DataSet objDataset = new DataSet();
            try
            {
                ObjConnection = new SqlConnection(_ConexionData);
                ObjAdapter = new SqlDataAdapter("PRAL_DATA_GLB_OPCIONES_USUARIO", ObjConnection);
                ObjAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;
 
                ObjAdapter.SelectCommand.Parameters.AddWithValue("@CD_CODIGO_USUARIO", CodigoUsuario);
                ObjAdapter.SelectCommand.Parameters.AddWithValue("@CD_CODI_SIST", CodigoSistema);
                ObjAdapter.SelectCommand.Parameters.AddWithValue("@OPCI_CONS", OpcionConsulta);
 
                ObjAdapter.Fill(objDataset);
 
                ObjConnection.Close();
 
                if( ObjConnection.State != ConnectionState.Closed ){
                    ObjConnection.Close();
                }
            }
            catch (Exception ex)
            {
                System.ApplicationException appEx = new System.ApplicationException(ex.Message);
                throw appEx;
            }
            return objDataset;
        }

        public ClsDataSets.DS_GLB_SIS Detalle(string CodigoForma, string DescripcionForma, int OpcionConsulta)
        {
            ClsDataSets.DS_GLB_SIS objDataSet = new ClsDataSets.DS_GLB_SIS();

            try
            {

                ObjConnection = new SqlConnection(_ConexionData);
                ObjAdapter = new SqlDataAdapter("PRAL_DATA_GLB_OPCIONES_SISTEMA", ObjConnection);
                ObjParam = new SqlParameter();
                ObjAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

                ObjAdapter.SelectCommand.Parameters.AddWithValue("@CD_CODI_OPCI_SIST", CodigoForma);
                ObjAdapter.SelectCommand.Parameters.AddWithValue("@DS_CODI_OPCI_SIST", DescripcionForma);
                ObjAdapter.SelectCommand.Parameters.AddWithValue("@OPCI_CONS", OpcionConsulta);


                ObjAdapter.Fill(objDataSet, "GLB_OPCIONES_SISTEMA");

                ObjConnection.Close();

                if (ObjConnection.State != ConnectionState.Closed)
                {
                    ObjConnection.Close();
                }

            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }

            return objDataSet;
        }

        public DataQuery Actualizacion(string Codigo, string Descripcion, string NombreForma, string RutaForma, string LoginUsuario, TipoActualizacion OpcionActualizacion)
        {

            DataQuery objResultado = new DataQuery();

            try
            {

                string StrCommand = "";

                switch (OpcionActualizacion)
                {
                    case TipoActualizacion.Adicionar:
                        StrCommand = "PRAL_INSE_GLB_OPCIONES_SISTEMA";
                        break;
                    case TipoActualizacion.Actualizar:
                        StrCommand = "PRAL_ACTU_GLB_OPCIONES_SISTEMA";
                        break;
                    case TipoActualizacion.Eliminar:
                        StrCommand = "PRAL_ELIM_GLB_OPCIONES_SISTEMA";
                        break;
                    case TipoActualizacion.No_Definida:
                        objResultado.CodigoError = -1;
                        objResultado.MensajeError = "Opcion de Actualizacion No Definida. Objeto COpcionesSistemas. Metodo Actualizacion";
                        //return objResultado;
                        break;
                }



                ObjConnection = new SqlConnection(_ConexionData);
                
                ObjCommand = new SqlCommand(StrCommand, ObjConnection);
                ObjParam = new SqlParameter();
                ObjCommand.CommandType = CommandType.StoredProcedure;

                ObjCommand.Parameters.AddWithValue("@CD_CODI_OPCI_SIST", Codigo);
                ObjCommand.Parameters.AddWithValue("@DS_CODI_OPCI_SIST", Descripcion);
                ObjCommand.Parameters.AddWithValue("@DS_NOMBRE_FORMA", NombreForma);
                ObjCommand.Parameters.AddWithValue("@DS_RUTA_FORMA", RutaForma);
                
                ObjCommand.Parameters.AddWithValue("@LOGIN_USUARIO", LoginUsuario);

                ObjParam = ObjCommand.Parameters.Add("@FILAS_AFECTADAS", SqlDbType.Int, 0);
                ObjParam.Direction = ParameterDirection.Output;

                ObjParam = ObjCommand.Parameters.Add("@NumeroError", SqlDbType.Decimal);
                ObjParam.Precision = 38;
                ObjParam.Scale = 0;
                ObjParam.Direction = ParameterDirection.Output;

                ObjParam = ObjCommand.Parameters.Add("@MensajeError", SqlDbType.NVarChar, 4000);
                ObjParam.Direction = ParameterDirection.Output;

                ObjConnection.Open();
                ObjCommand.ExecuteNonQuery();

                objResultado.CodigoAuxiliar = (object) ObjCommand.Parameters["@CD_CODI_OPCI_SIST"].Value;
                objResultado.FilasAfectadas = (int) ObjCommand.Parameters["@FILAS_AFECTADAS"].Value;
                objResultado.CodigoError = (decimal) ObjCommand.Parameters["@NumeroError"].Value;
                objResultado.MensajeError = (string) ObjCommand.Parameters["@MensajeError"].Value;

                ObjConnection.Close();

                if (ObjConnection.State != ConnectionState.Closed)
                {
                    ObjConnection.Close();
                }


            }
            catch (Exception ex)
            {
                objResultado.CodigoError = -1;
                objResultado.MensajeError = ex.Message;
            }

            return objResultado;

        }
    }
}