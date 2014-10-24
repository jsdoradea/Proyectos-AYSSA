Imports ClsFramework.SIS.Framework.Common.ClsSistema
Imports System.Reflection


Public Class MyTemplateForm
    Protected _DataSistema As ClsFramework.SIS.Framework.Common.ClsSistema
    Protected _ConexionBaseDato As String

    Public Sub New()

        ' This call is required by the Windows Form Designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.
        _DataSistema = New ClsFramework.SIS.Framework.Common.ClsSistema
    End Sub

    Public Sub New(ByVal DataSistema As ClsFramework.SIS.Framework.Common.ClsSistema)
        InitializeComponent()

        _DataSistema = DataSistema
        _ConexionBaseDato = DataSistema.ConexionBaseDato

        Me.Text = _DataSistema.NombreOpcionSistema

    End Sub


    Public Overridable Sub Limpiar()

    End Sub

    Protected Sub DespliegaMensaje(ByVal mensaje As String)
        System.Windows.Forms.MessageBox.Show(mensaje, _DataSistema.NombreAplicacion, MessageBoxButtons.OK)

    End Sub
End Class