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
    public class CEntidades:CTemplate
    {
        private string _ConexionData;


        public CEntidades(string ConexionData)
        {
            _ConexionData = ConexionData;
        }

        public ClsDataSets.GLB_DICCIONARIO_CARGA Detalle(decimal CodigoEntidad, string NombreEntidad, string CodigoEstado, int OpcionConsulta)
        {
            ClsDataSets.GLB_DICCIONARIO_CARGA objDataSet = new ClsDataSets.GLB_DICCIONARIO_CARGA();

            try
            {

                ObjConnection = new SqlConnection(_ConexionData);
                ObjAdapter = new SqlDataAdapter("PRAL_DATA_GLB_ENTIDADES", ObjConnection);
                ObjParam = new SqlParameter();
                ObjAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

                ObjAdapter.SelectCommand.Parameters.AddWithValue("@CD_ENTIDAD",  CodigoEntidad);
                ObjAdapter.SelectCommand.Parameters.AddWithValue("@DS_NOM_ENTIDAD",  NombreEntidad);
                ObjAdapter.SelectCommand.Parameters.AddWithValue("@CD_ESTADO",  CodigoEstado);
                ObjAdapter.SelectCommand.Parameters.AddWithValue("@OPCI_CONS", OpcionConsulta);


                ObjAdapter.Fill(objDataSet, "GLB_ENTIDADES");

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

        public DataQuery Actualizacion(decimal CodigoEntidad, string  NombreEntidad, string DescripcionCortaEntidad,
            string DescripcionLargaEntidad, string CodigoEstadoEntidad,
            string LoginUsuario, TipoActualizacion OpcionActualizacion)
        {

            DataQuery objResultado = new DataQuery();

            try
            {

                string StrCommand = "";

                switch (OpcionActualizacion)
                {
                    case TipoActualizacion.Adicionar:
                        StrCommand = "PRAL_INSE_GLB_ENTIDADES";
                        break;
                    case TipoActualizacion.Actualizar:
                        StrCommand = "PRAL_ACTU_GLB_ENTIDADES";
                        break;
                    case TipoActualizacion.Eliminar:
                        StrCommand = "PRAL_ELIM_GLB_ENTIDADES";
                        break;
                    case TipoActualizacion.No_Definida:
                        objResultado.CodigoError = -1;
                        objResultado.MensajeError = "Opcion de Actualizacion No Definida. Objeto CEntidades. Metodo Actualizacion";
                        //return objResultado;
                        break;
                }



                ObjConnection = new SqlConnection(_ConexionData);
                
                ObjCommand = new SqlCommand(StrCommand, ObjConnection);
                ObjParam = new SqlParameter();
                ObjCommand.CommandType = CommandType.StoredProcedure;

                if (OpcionActualizacion == TipoActualizacion.Adicionar)
                {
                    ObjParam = ObjCommand.Parameters.Add("@CD_ENTIDAD", SqlDbType.Int, 0);
                    ObjParam.Direction = ParameterDirection.Output;
                }
                else
                {
                    ObjCommand.Parameters.AddWithValue("@CD_ENTIDAD",  CodigoEntidad);
                }
                ObjCommand.Parameters.AddWithValue("@DS_NOM_ENTIDAD",  NombreEntidad);
                ObjCommand.Parameters.AddWithValue("@DS_DES_ENTIDAD_COR",  DescripcionCortaEntidad);
                ObjCommand.Parameters.AddWithValue("@DS_DES_ENTIDAD_LAR",  DescripcionLargaEntidad);
                ObjCommand.Parameters.AddWithValue("@CD_ESTADO",  CodigoEstadoEntidad);
                
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

                objResultado.CodigoAuxiliar = (object)ObjCommand.Parameters["@CD_ENTIDAD"].Value;
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