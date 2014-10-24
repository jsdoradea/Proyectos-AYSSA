Imports System.Data
Imports System.Data.SqlClient
Namespace SIS.Data
    Public Class CTemplate
        Implements IDisposable

        Protected ObjConnection As SqlConnection
        Protected ObjAdapter As SqlDataAdapter
        Protected ObjParam As SqlParameter
        Protected Objcommand As SqlCommand
        Protected ObjReader As SqlDataReader
        ' Protected StrConnection As String = ConfigurationSettings.AppSettings.Item("StrSistConn")

        Public Sub Dispose() Implements System.IDisposable.Dispose

            Try
                If ObjConnection.State <> ConnectionState.Closed Then
                    ObjConnection.Close()
                End If

            Catch ex As Exception

            End Try

            ObjConnection = Nothing
            ObjAdapter = Nothing
            ObjParam = Nothing
            Objcommand = Nothing
            ObjReader = Nothing

        End Sub
    End Class
End Namespace
