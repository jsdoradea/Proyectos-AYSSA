Imports ClsFramework.SIS.Framework.Common
'Imports ClsFormas
'Imports ClsDataApp.SIS.Data

Public Class MainWindow

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        Dim frmPersonas As New ClsFormas.SEPP0001(My.Application.MyDataSistema)
        frmPersonas.Show()
    End Sub

    Private Sub CreaDatos()

    End Sub
End Class
