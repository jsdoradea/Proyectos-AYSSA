Imports ClsDataApp.SIS.Data
Imports ClsFramework.SIS.Framework.Common
Imports System.Windows.Forms

Public Class SEPP0001
    Implements IAcciones

    Private dvPersonas As DataView
    Dim iPersona As Integer

    Public Sub New()

        ' This call is required by the Windows Form Designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.

    End Sub

    Public Sub New(ByVal DataSistema As ClsFramework.SIS.Framework.Common.ClsSistema)
        MyBase.New(DataSistema)
        InitializeComponent()
        Consultar()
    End Sub

    Public Sub Adicionar() Implements ClsFramework.SIS.Framework.Common.IAcciones.Adicionar
        Dim objPersonas As New CPersonas(_ConexionBaseDato)
        Dim objResultado As New DataQuery

        Try
            objResultado = objPersonas.Actualizacion(0, DS_NOMBRE.Text, DS_APELLIDO.Text, _DataSistema.Cusuario, TipoActualizacion.Adicionar)

            If objResultado.CodigoError = 0 Then
                Consultar()
            Else
                DespliegaMensaje(objResultado.MensajeError)

            End If
        Catch ex As Exception
            System.Windows.Forms.MessageBox.Show(ex.Message, _DataSistema.NombreAplicacion, Windows.Forms.MessageBoxButtons.OK, Windows.Forms.MessageBoxIcon.Error)
        End Try
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
        Dim objPersonas As New CPersonas(_ConexionBaseDato)
        Dim objResultado As New DataQuery

        Try
            objResultado = objPersonas.Actualizacion(iPersona, DS_NOMBRE.Text, DS_APELLIDO.Text, _DataSistema.Cusuario, TipoActualizacion.Eliminar)

            If objResultado.CodigoError = 0 Then
                Consultar()
            Else
                DespliegaMensaje(objResultado.MensajeError)
            End If
        Catch ex As Exception
            System.Windows.Forms.MessageBox.Show(ex.Message, _DataSistema.NombreAplicacion, Windows.Forms.MessageBoxButtons.OK, Windows.Forms.MessageBoxIcon.Error)
        End Try
    End Sub

    Public Sub Imprimir() Implements ClsFramework.SIS.Framework.Common.IAcciones.Imprimir

    End Sub

    Public Sub Modificar() Implements ClsFramework.SIS.Framework.Common.IAcciones.Modificar
        Dim objPersonas As New CPersonas(_ConexionBaseDato)
        Dim objResultado As New DataQuery

        Try
            objResultado = objPersonas.Actualizacion(iPersona, DS_NOMBRE.Text, DS_APELLIDO.Text, _DataSistema.Cusuario, TipoActualizacion.Actualizar)

            If objResultado.CodigoError = 0 Then
                Consultar()
            Else
                DespliegaMensaje(objResultado.MensajeError)
            End If
        Catch ex As Exception
            System.Windows.Forms.MessageBox.Show(ex.Message, _DataSistema.NombreAplicacion, Windows.Forms.MessageBoxButtons.OK, Windows.Forms.MessageBoxIcon.Error)
        End Try
    End Sub

    Public Overrides Sub Limpiar()
        MyBase.Limpiar()
        DS_NOMBRE.Text = ""
        DS_APELLIDO.Text = ""
    End Sub

    Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdModificar.Click
        Modificar()
    End Sub

    Private Sub cmdLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdLimpiar.Click
        Limpiar()
    End Sub

    Private Sub cmdGuardar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdGuardar.Click
        Adicionar()
    End Sub

    Private Sub grdPersonas_RowEnter(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles grdPersonas.RowEnter
        iPersona = grdPersonas.Rows(e.RowIndex).Cells(0).Value
        DS_NOMBRE.Text = grdPersonas.Rows(e.RowIndex).Cells(1).Value
        DS_APELLIDO.Text = grdPersonas.Rows(e.RowIndex).Cells(2).Value
    End Sub

    Private Sub cmdEliminar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdEliminar.Click
        Eliminar()
    End Sub
End Class
