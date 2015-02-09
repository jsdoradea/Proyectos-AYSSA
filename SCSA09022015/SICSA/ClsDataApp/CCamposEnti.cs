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
    public class CCamposEnti:CTemplate
    {
        private string _ConexionData;


        public CCamposEnti(string ConexionData)
        {
            _ConexionData = ConexionData;
        }

        public ClsDataSets.GLB_DICCIONARIO_CARGA Detalle(decimal CodigoEntidad, decimal CodigoCampoEnti, 
                int OpcionConsulta)
        {
            ClsDataSets.GLB_DICCIONARIO_CARGA objDataSet = new ClsDataSets.GLB_DICCIONARIO_CARGA();

            try
            {

                ObjConnection = new SqlConnection(_ConexionData);
                ObjAdapter = new SqlDataAdapter("PRAL_DATA_GLB_CAMPOS_ENTI", ObjConnection);
                ObjParam = new SqlParameter();
                ObjAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

                ObjAdapter.SelectCommand.Parameters.AddWithValue("@CD_ENTIDAD",  CodigoEntidad);
                ObjAdapter.SelectCommand.Parameters.AddWithValue("@CD_CAMPOS_ENTI", CodigoCampoEnti);
                ObjAdapter.SelectCommand.Parameters.AddWithValue("@OPCI_CONS", OpcionConsulta);


                ObjAdapter.Fill(objDataSet, "GLB_CAMPOS_ENTI");

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

        public DataQuery Actualizacion(decimal CodigoCampoEnti, decimal CodigoEntidad, string NombreCampo,
            string EtiquetaCampo, string DescripcionCampo, int CodigoTipoDato, int LongitudCampo,
            int DecimalCampo, string EsPrimary, string EsForeign, decimal CodigoEntidadForeign,
            string EsIdentity, string PermiteNulos,
            string LoginUsuario, TipoActualizacion OpcionActualizacion)
        {

            DataQuery objResultado = new DataQuery();

            try
            {

                string StrCommand = "";

                switch (OpcionActualizacion)
                {
                    case TipoActualizacion.Adicionar:
                        StrCommand = "PRAL_INSE_GLB_CAMPOS_ENTI";
                        break;
                    case TipoActualizacion.Actualizar:
                        StrCommand = "PRAL_ACTU_GLB_CAMPOS_ENTI";
                        break;
                    case TipoActualizacion.Eliminar:
                        StrCommand = "PRAL_ELIM_GLB_CAMPOS_ENTI";
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
                    ObjParam = ObjCommand.Parameters.Add("@CD_CAMPOS_ENTI", SqlDbType.Int, 0);
                    ObjParam.Direction = ParameterDirection.Output;
                }
                else
                {
                    ObjCommand.Parameters.AddWithValue("@CD_CAMPOS_ENTI",  CodigoCampoEnti);
                }
                ObjCommand.Parameters.AddWithValue("@CD_ENTIDAD",  CodigoEntidad);
                ObjCommand.Parameters.AddWithValue("@DS_NOMBRE_CAMPO",  NombreCampo);
                ObjCommand.Parameters.AddWithValue("@DS_ETIQ_CAMPO",  EtiquetaCampo);
                ObjCommand.Parameters.AddWithValue("@DS_DES_CAMPO",  DescripcionCampo);

                ObjCommand.Parameters.AddWithValue("@CD_TIPO_DATO",  CodigoTipoDato);
                ObjCommand.Parameters.AddWithValue("@NM_LONG_CAMPO",  LongitudCampo);
                ObjCommand.Parameters.AddWithValue("@NM_DECI_CAMPO",  DecimalCampo);
                ObjCommand.Parameters.AddWithValue("@CD_PRI_KEY",  EsPrimary);

                ObjCommand.Parameters.AddWithValue("@CD_FOR_KEY",  EsForeign);
                ObjCommand.Parameters.AddWithValue("@CD_ENTIDAD_FOR",  CodigoEntidadForeign);
                ObjCommand.Parameters.AddWithValue("@CD_CAMPO_IDENTITY",  EsIdentity);
                ObjCommand.Parameters.AddWithValue("@CD_CAMPO_PERM_NULL",  PermiteNulos);
                
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

                objResultado.CodigoAuxiliar = (object)ObjCommand.Parameters["CD_CAMPOS_ENTI"].Value;
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