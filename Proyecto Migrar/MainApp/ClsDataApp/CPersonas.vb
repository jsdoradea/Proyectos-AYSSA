Imports System.IO
Imports System.Data
Imports System.Data.SqlClient
Imports ClsFramework.SIS.Framework.Common
Imports ClsDataSets

Namespace SIS.Data
    Public Class CPersonas
        Inherits CTemplate

        Private _ConexionData As String

        Sub New(ByVal ConexionData As String)
            _ConexionData = ConexionData
        End Sub

        Public Function Actualizacion(ByVal CodigoPersona As Integer, _
                                      ByVal Nombre As String, _
                                      ByVal Apellido As String, _
                                      ByVal LoginUsuario As String, _
                                      ByVal OpcionActualizacion As TipoActualizacion) As DataQuery
            Dim ObjResultado As DataQuery = New DataQuery

            Try

                Dim StrCommand As String = ""

                Select Case OpcionActualizacion
                    Case TipoActualizacion.Adicionar
                        StrCommand = "PRAL_INSE_GLB_PERSONAS"
                    Case TipoActualizacion.Actualizar
                        StrCommand = "PRAL_ACTU_GLB_PERSONAS"
                    Case TipoActualizacion.Eliminar
                        StrCommand = "PRAL_ELIM_GLB_PERSONAS"
                    Case TipoActualizacion.No_Definida
                        ObjResultado.CodigoError = -1
                        ObjResultado.MensajeError = "Opcion de Actualizacion No Definida. Objeto CDocumentos. Metodo Actualizacion"
                        Return ObjResultado
                End Select

                ObjConnection = New SqlConnection(_ConexionData)
                Objcommand = New SqlCommand(StrCommand, ObjConnection)
                ObjParam = New SqlParameter
                Objcommand.CommandType = CommandType.StoredProcedure

                Objcommand.Parameters.AddWithValue("@DS_NOMBRE", Nombre)
                Objcommand.Parameters.AddWithValue("@DS_APELLIDO", Apellido)

                If OpcionActualizacion = TipoActualizacion.Adicionar Then
                    ObjParam = Objcommand.Parameters.Add("@CD_PERSONA", SqlDbType.Decimal)
                    ObjParam.Direction = ParameterDirection.Output
                Else
                    Objcommand.Parameters.AddWithValue("@CD_PERSONA", CodigoPersona)
                End If


                Objcommand.Parameters.AddWithValue("@LOGIN_USUARIO", LoginUsuario)

                ObjParam = Objcommand.Parameters.Add("@FILAS_AFECTADAS", SqlDbType.Int, 0)
                ObjParam.Direction = ParameterDirection.Output

                ObjParam = Objcommand.Parameters.Add("@NumeroError", SqlDbType.Decimal)
                ObjParam.Precision = 38
                ObjParam.Scale = 0
                ObjParam.Direction = ParameterDirection.Output

                ObjParam = Objcommand.Parameters.Add("@MensajeError", SqlDbType.NVarChar, 4000)
                ObjParam.Direction = ParameterDirection.Output

                ObjConnection.Open()
                Objcommand.ExecuteNonQuery()

                ObjResultado.CodigoAuxiliar = Objcommand.Parameters("@CD_PERSONA").Value
                ObjResultado.FilasAfectadas = Objcommand.Parameters("@FILAS_AFECTADAS").Value
                ObjResultado.CodigoError = Objcommand.Parameters("@NumeroError").Value
                ObjResultado.MensajeError = Objcommand.Parameters("@MensajeError").Value

                ObjConnection.Close()

                If ObjConnection.State <> ConnectionState.Closed Then
                    ObjConnection.Close()
                End If


            Catch ex As Exception
                ObjResultado.CodigoError = -1
                ObjResultado.MensajeError = ex.Message
            End Try


            Return ObjResultado
        End Function

        Public Function Detalle(ByVal CodigoPersona As Integer, _
                                      ByVal Nombre As String, _
                                      ByVal Apellido As String, _
                                      ByVal OpcionConsulta As Integer) As ClsDataSets.GLB_GLOBALES

            Dim objdataset As New ClsDataSets.GLB_GLOBALES
            Try

                ObjConnection = New SqlConnection(_ConexionData)
                ObjAdapter = New SqlDataAdapter("PRAL_DATA_GLB_PERSONAS", ObjConnection)
                ObjParam = New SqlParameter
                ObjAdapter.SelectCommand.CommandType = CommandType.StoredProcedure

                ObjAdapter.SelectCommand.Parameters.AddWithValue("@CD_PERSONA", CodigoPersona)
                ObjAdapter.SelectCommand.Parameters.AddWithValue("@DS_NOMBRE", Nombre)
                ObjAdapter.SelectCommand.Parameters.AddWithValue("@DS_APELLIDO", Apellido)
                ObjAdapter.SelectCommand.Parameters.AddWithValue("@OPCI_CONS", OpcionConsulta)

                ObjAdapter.Fill(objdataset, "GLB_PERSONAS")

                ObjConnection.Close()

                If ObjConnection.State <> ConnectionState.Closed Then
                    ObjConnection.Close()
                End If

            Catch ex As Exception
                Throw New Exception(ex.Message)
            End Try

            Return objdataset
        End Function


    End Class
End Namespace


