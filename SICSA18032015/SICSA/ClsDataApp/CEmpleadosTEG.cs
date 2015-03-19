﻿using System;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using SIS.Framework.Common;


namespace SIS.Data
{
    public class CEmpleadosTEG:CTemplate
    {
        private string _ConexionData;


        public CEmpleadosTEG(string ConexionData)
        {
            _ConexionData = ConexionData;
        }

        public ClsDataSets.DS_GLB_SIS Detalle(int CodigoEmpleado,  int CodigoUnidad, int CodigoCargoInstitucional, int CodigoTitulo, int OpcionConsulta)
        {
            ClsDataSets.DS_GLB_SIS objDataSet = new ClsDataSets.DS_GLB_SIS();

            try
            {

                ObjConnection = new SqlConnection(_ConexionData);
                ObjAdapter = new SqlDataAdapter("PRAL_DATA_GLB_EMPLEADOS", ObjConnection);
                ObjParam = new SqlParameter();
                ObjAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

                ObjAdapter.SelectCommand.Parameters.AddWithValue("@CD_EMPLEADO", CodigoEmpleado);
                ObjAdapter.SelectCommand.Parameters.AddWithValue("@CD_UNIDAD", CodigoUnidad);
                ObjAdapter.SelectCommand.Parameters.AddWithValue("@CD_CARGO_INST", CodigoCargoInstitucional);
                ObjAdapter.SelectCommand.Parameters.AddWithValue("@CD_TITULO", CodigoTitulo);
                ObjAdapter.SelectCommand.Parameters.AddWithValue("@OPCI_CONS", OpcionConsulta);


                ObjAdapter.Fill(objDataSet, "GLB_EMPLEADOS_TEG");

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

        public DataQuery Actualizacion(int CodigoEmpleado, string NombreEmpleado, string ApellidoEmpleado, string CodigoEstado, int CodigoUnidad, string CorreoEmpleado, int CodigoCargo, int CodigoTitulo, string LoginUsuario, TipoActualizacion OpcionActualizacion)
        {

            DataQuery objResultado = new DataQuery();

            try
            {

                string StrCommand = "";

                switch (OpcionActualizacion)
                {
                    case TipoActualizacion.Adicionar:
                        StrCommand = "PRAL_INSE_GLB_EMPLEADOS";
                        break;
                    case TipoActualizacion.Actualizar:
                        StrCommand = "PRAL_ACTU_GLB_EMPLEADOS";
                        break;
                    case TipoActualizacion.Eliminar:
                        StrCommand = "PRAL_ELIM_GLB_EMPLEADOS";
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

                if (OpcionActualizacion == TipoActualizacion.Adicionar)
                {
                    ObjParam = ObjCommand.Parameters.Add("@CD_EMPLEADO", SqlDbType.Int, 0);
                    ObjParam.Direction = ParameterDirection.Output;
                }
                else
                {
                    ObjCommand.Parameters.AddWithValue("@CD_EMPLEADO", CodigoEmpleado);
                }
                ObjCommand.Parameters.AddWithValue("@DS_NOMBRE_EMPLEADO",  NombreEmpleado);
                ObjCommand.Parameters.AddWithValue("@DS_APELLIDO_EMPLEADO",  ApellidoEmpleado);
                ObjCommand.Parameters.AddWithValue("@CD_ESTADO",  CodigoEstado);
                ObjCommand.Parameters.AddWithValue("@CD_UNIDAD",  CodigoUnidad);
                ObjCommand.Parameters.AddWithValue("@DS_CORREO",  CorreoEmpleado);
                ObjCommand.Parameters.AddWithValue("@CD_CARGO_INST",  CodigoCargo);
                ObjCommand.Parameters.AddWithValue("@CD_TITULO",  CodigoTitulo);
                
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

                objResultado.CodigoAuxiliar = (object) ObjCommand.Parameters["@CD_UNIDAD"].Value;
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