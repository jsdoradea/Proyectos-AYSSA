Imports ClsDataApp.SIS.Data
Imports ClsFramework.SIS.Framework.Common


Public Class TEMPP0001
    Implements IAcciones

    Protected _ConexionBaseDato As String

    Private dvPersonas As DataView

    Public Sub New()
        ' This call is required by the Windows Form Designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.

    End Sub

    Public Sub New(ByVal DataSistema As ClsFramework.SIS.Framework.Common.ClsSistema)
        InitializeComponent()

        _ConexionBaseDato = DataSistema.ConexionBaseDato

        Consultar()
    End Sub

    Public Sub Adicionar() Implements ClsFramework.SIS.Framework.Common.IAcciones.Adicionar

    End Sub

    Public Sub Consultar() Implements ClsFramework.SIS.Framework.Common.IAcciones.Consultar
        Dim objPersonas As New CPersonas(_ConexionBaseDato)
        DSPersonas = objPersonas.Detalle(0, "", "", 0)

        Dim dvManager As DataViewManager
        dvManager = New DataViewManager(DSPersonas)

        dvPersonas = dvManager.CreateDataView(DSPersonas.Tables("GLB_PERSONAS"))
        dvPersonas.AllowNew = False
        dvPersonas.AllowEdit = False
        dvPersonas.AllowDelete = False


        grdPersonas.DataSource = DSPersonas

    End Sub

    Public Sub Eliminar() Implements ClsFramework.SIS.Framework.Common.IAcciones.Eliminar

    End Sub

    Public Sub Imprimir() Implements ClsFramework.SIS.Framework.Common.IAcciones.Imprimir

    End Sub

    Public Sub Modificar() Implements ClsFramework.SIS.Framework.Common.IAcciones.Modificar

    End Sub
End Class
