<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class SEPP0001
    Inherits ClsFormas.MyTemplateForm

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        If disposing AndAlso components IsNot Nothing Then
            components.Dispose()
        End If
        MyBase.Dispose(disposing)
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.Label1 = New System.Windows.Forms.Label
        Me.DS_NOMBRE = New System.Windows.Forms.TextBox
        Me.DS_APELLIDO = New System.Windows.Forms.TextBox
        Me.Label2 = New System.Windows.Forms.Label
        Me.cmdEliminar = New System.Windows.Forms.Button
        Me.cmdModificar = New System.Windows.Forms.Button
        Me.cmdGuardar = New System.Windows.Forms.Button
        Me.cmdLimpiar = New System.Windows.Forms.Button
        Me.grdPersonas = New System.Windows.Forms.DataGridView
        Me.CDPERSONADataGridViewTextBoxColumn = New System.Windows.Forms.DataGridViewTextBoxColumn
        Me.DSNOMBREDataGridViewTextBoxColumn = New System.Windows.Forms.DataGridViewTextBoxColumn
        Me.DSAPELLIDODataGridViewTextBoxColumn = New System.Windows.Forms.DataGridViewTextBoxColumn
        Me.USUACREADataGridViewTextBoxColumn = New System.Windows.Forms.DataGridViewTextBoxColumn
        Me.FECHCREADataGridViewTextBoxColumn = New System.Windows.Forms.DataGridViewTextBoxColumn
        Me.USUAACTUDataGridViewTextBoxColumn = New System.Windows.Forms.DataGridViewTextBoxColumn
        Me.FECHACTUDataGridViewTextBoxColumn = New System.Windows.Forms.DataGridViewTextBoxColumn
        Me.DSPersonas = New ClsDataSets.GLB_GLOBALES
        CType(Me.grdPersonas, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.DSPersonas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(12, 151)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(47, 13)
        Me.Label1.TabIndex = 1
        Me.Label1.Text = "Nombre:"
        '
        'DS_NOMBRE
        '
        Me.DS_NOMBRE.Location = New System.Drawing.Point(85, 148)
        Me.DS_NOMBRE.Name = "DS_NOMBRE"
        Me.DS_NOMBRE.Size = New System.Drawing.Size(265, 20)
        Me.DS_NOMBRE.TabIndex = 2
        '
        'DS_APELLIDO
        '
        Me.DS_APELLIDO.Location = New System.Drawing.Point(85, 174)
        Me.DS_APELLIDO.Name = "DS_APELLIDO"
        Me.DS_APELLIDO.Size = New System.Drawing.Size(265, 20)
        Me.DS_APELLIDO.TabIndex = 4
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(12, 177)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(47, 13)
        Me.Label2.TabIndex = 3
        Me.Label2.Text = "Apellido:"
        '
        'cmdEliminar
        '
        Me.cmdEliminar.Location = New System.Drawing.Point(648, 203)
        Me.cmdEliminar.Name = "cmdEliminar"
        Me.cmdEliminar.Size = New System.Drawing.Size(75, 21)
        Me.cmdEliminar.TabIndex = 5
        Me.cmdEliminar.Text = "Eliminar"
        Me.cmdEliminar.UseVisualStyleBackColor = True
        '
        'cmdModificar
        '
        Me.cmdModificar.Location = New System.Drawing.Point(567, 203)
        Me.cmdModificar.Name = "cmdModificar"
        Me.cmdModificar.Size = New System.Drawing.Size(75, 21)
        Me.cmdModificar.TabIndex = 6
        Me.cmdModificar.Text = "Modificar"
        Me.cmdModificar.UseVisualStyleBackColor = True
        '
        'cmdGuardar
        '
        Me.cmdGuardar.Location = New System.Drawing.Point(486, 203)
        Me.cmdGuardar.Name = "cmdGuardar"
        Me.cmdGuardar.Size = New System.Drawing.Size(75, 21)
        Me.cmdGuardar.TabIndex = 7
        Me.cmdGuardar.Text = "Guardar"
        Me.cmdGuardar.UseVisualStyleBackColor = True
        '
        'cmdLimpiar
        '
        Me.cmdLimpiar.Location = New System.Drawing.Point(405, 203)
        Me.cmdLimpiar.Name = "cmdLimpiar"
        Me.cmdLimpiar.Size = New System.Drawing.Size(75, 21)
        Me.cmdLimpiar.TabIndex = 8
        Me.cmdLimpiar.Text = "Limpiar"
        Me.cmdLimpiar.UseVisualStyleBackColor = True
        '
        'grdPersonas
        '
        Me.grdPersonas.AllowUserToAddRows = False
        Me.grdPersonas.AllowUserToDeleteRows = False
        Me.grdPersonas.AutoGenerateColumns = False
        Me.grdPersonas.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.grdPersonas.Columns.AddRange(New System.Windows.Forms.DataGridViewColumn() {Me.CDPERSONADataGridViewTextBoxColumn, Me.DSNOMBREDataGridViewTextBoxColumn, Me.DSAPELLIDODataGridViewTextBoxColumn, Me.USUACREADataGridViewTextBoxColumn, Me.FECHCREADataGridViewTextBoxColumn, Me.USUAACTUDataGridViewTextBoxColumn, Me.FECHACTUDataGridViewTextBoxColumn})
        Me.grdPersonas.DataMember = "GLB_PERSONAS"
        Me.grdPersonas.DataSource = Me.DSPersonas
        Me.grdPersonas.Location = New System.Drawing.Point(12, 12)
        Me.grdPersonas.Name = "grdPersonas"
        Me.grdPersonas.ReadOnly = True
        Me.grdPersonas.Size = New System.Drawing.Size(711, 121)
        Me.grdPersonas.TabIndex = 0
        '
        'CDPERSONADataGridViewTextBoxColumn
        '
        Me.CDPERSONADataGridViewTextBoxColumn.DataPropertyName = "CD_PERSONA"
        Me.CDPERSONADataGridViewTextBoxColumn.HeaderText = "CD_PERSONA"
        Me.CDPERSONADataGridViewTextBoxColumn.Name = "CDPERSONADataGridViewTextBoxColumn"
        Me.CDPERSONADataGridViewTextBoxColumn.ReadOnly = True
        '
        'DSNOMBREDataGridViewTextBoxColumn
        '
        Me.DSNOMBREDataGridViewTextBoxColumn.DataPropertyName = "DS_NOMBRE"
        Me.DSNOMBREDataGridViewTextBoxColumn.HeaderText = "DS_NOMBRE"
        Me.DSNOMBREDataGridViewTextBoxColumn.Name = "DSNOMBREDataGridViewTextBoxColumn"
        Me.DSNOMBREDataGridViewTextBoxColumn.ReadOnly = True
        '
        'DSAPELLIDODataGridViewTextBoxColumn
        '
        Me.DSAPELLIDODataGridViewTextBoxColumn.DataPropertyName = "DS_APELLIDO"
        Me.DSAPELLIDODataGridViewTextBoxColumn.HeaderText = "DS_APELLIDO"
        Me.DSAPELLIDODataGridViewTextBoxColumn.Name = "DSAPELLIDODataGridViewTextBoxColumn"
        Me.DSAPELLIDODataGridViewTextBoxColumn.ReadOnly = True
        '
        'USUACREADataGridViewTextBoxColumn
        '
        Me.USUACREADataGridViewTextBoxColumn.DataPropertyName = "USUA_CREA"
        Me.USUACREADataGridViewTextBoxColumn.HeaderText = "USUA_CREA"
        Me.USUACREADataGridViewTextBoxColumn.Name = "USUACREADataGridViewTextBoxColumn"
        Me.USUACREADataGridViewTextBoxColumn.ReadOnly = True
        '
        'FECHCREADataGridViewTextBoxColumn
        '
        Me.FECHCREADataGridViewTextBoxColumn.DataPropertyName = "FECH_CREA"
        Me.FECHCREADataGridViewTextBoxColumn.HeaderText = "FECH_CREA"
        Me.FECHCREADataGridViewTextBoxColumn.Name = "FECHCREADataGridViewTextBoxColumn"
        Me.FECHCREADataGridViewTextBoxColumn.ReadOnly = True
        '
        'USUAACTUDataGridViewTextBoxColumn
        '
        Me.USUAACTUDataGridViewTextBoxColumn.DataPropertyName = "USUA_ACTU"
        Me.USUAACTUDataGridViewTextBoxColumn.HeaderText = "USUA_ACTU"
        Me.USUAACTUDataGridViewTextBoxColumn.Name = "USUAACTUDataGridViewTextBoxColumn"
        Me.USUAACTUDataGridViewTextBoxColumn.ReadOnly = True
        '
        'FECHACTUDataGridViewTextBoxColumn
        '
        Me.FECHACTUDataGridViewTextBoxColumn.DataPropertyName = "FECH_ACTU"
        Me.FECHACTUDataGridViewTextBoxColumn.HeaderText = "FECH_ACTU"
        Me.FECHACTUDataGridViewTextBoxColumn.Name = "FECHACTUDataGridViewTextBoxColumn"
        Me.FECHACTUDataGridViewTextBoxColumn.ReadOnly = True
        '
        'DSPersonas
        '
        Me.DSPersonas.DataSetName = "GLB_GLOBALES"
        Me.DSPersonas.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema
        '
        'SEPP0001
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.ClientSize = New System.Drawing.Size(735, 349)
        Me.Controls.Add(Me.cmdLimpiar)
        Me.Controls.Add(Me.cmdGuardar)
        Me.Controls.Add(Me.cmdModificar)
        Me.Controls.Add(Me.cmdEliminar)
        Me.Controls.Add(Me.DS_APELLIDO)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.DS_NOMBRE)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.grdPersonas)
        Me.Name = "SEPP0001"
        CType(Me.grdPersonas, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.DSPersonas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents DSPersonas As ClsDataSets.GLB_GLOBALES
    Friend WithEvents grdPersonas As System.Windows.Forms.DataGridView
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents DS_NOMBRE As System.Windows.Forms.TextBox
    Friend WithEvents DS_APELLIDO As System.Windows.Forms.TextBox
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents cmdEliminar As System.Windows.Forms.Button
    Friend WithEvents cmdModificar As System.Windows.Forms.Button
    Friend WithEvents cmdGuardar As System.Windows.Forms.Button
    Friend WithEvents cmdLimpiar As System.Windows.Forms.Button
    Friend WithEvents CDPERSONADataGridViewTextBoxColumn As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents DSNOMBREDataGridViewTextBoxColumn As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents DSAPELLIDODataGridViewTextBoxColumn As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents USUACREADataGridViewTextBoxColumn As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents FECHCREADataGridViewTextBoxColumn As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents USUAACTUDataGridViewTextBoxColumn As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents FECHACTUDataGridViewTextBoxColumn As System.Windows.Forms.DataGridViewTextBoxColumn

End Class
