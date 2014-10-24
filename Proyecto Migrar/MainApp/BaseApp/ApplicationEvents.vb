Imports ClsFramework.SIS.Framework
Imports ClsFramework.SIS.Framework.Common
Imports System.Configuration

Namespace My

    Partial Friend Class MyApplication

        Public MyDataSistema As ClsFramework.SIS.Framework.Common.ClsSistema

        Private Sub MyApplication_Startup(ByVal sender As Object, ByVal e As Microsoft.VisualBasic.ApplicationServices.StartupEventArgs) Handles Me.Startup
            MyDataSistema = New ClsFramework.SIS.Framework.Common.ClsSistema()

            'MyDataSistema.ServidorDeReportes = System.Configuration.ConfigurationManager.AppSettings.Item("ServidorReportes").ToString

            'Dim ObjEncryptacion As New CEncriptacion()

            'Dim MyBytes() As Byte

            'MyBytes = CEncriptacion.FromBase64(CType(System.Configuration.ConfigurationManager.AppSettings.Item("ConexionTemporal"), String))

            MyDataSistema.ConexionBaseDato = System.Configuration.ConfigurationManager.AppSettings.Item("conexion").ToString


            MyDataSistema.NombreAplicacion = Me.Info.Title
            MyDataSistema.NombreAplicacionImpresion = Me.Info.Title

            MyDataSistema.Cusuario = "Admin" 'Esta linea debe reemplazarse con el usuario captado en un Login

        End Sub

        Protected Overrides Sub Finalize()
            MyBase.Finalize()
        End Sub
    End Class
End Namespace
