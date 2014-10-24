<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class TEMPP0001
    Inherits System.Windows.Forms.Form

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.grdPersonas = New System.Windows.Forms.DataGridView
        Me.DSPersonas = New ClsDataSets.GLB_GLOBALES
        Me.CDPERSONADataGridViewTextBoxColumn = New System.Windows.Forms.DataGridViewTextBoxColumn
        Me.DSNOMBREDataGridViewTextBoxColumn = New System.Windows.Forms.DataGridViewTextBoxColumn
        Me.DSAPELLIDODataGridViewTextBoxColumn = New System.Windows.Forms.DataGridViewTextBoxColumn
        Me.USUACREADataGridViewTextBoxColumn = New System.Windows.Forms.DataGridViewTextBoxColumn
        Me.FECHCREADataGridViewTextBoxColumn = New System.Windows.Forms.DataGridViewTextBoxColumn
        Me.USUAACTUDataGridViewTextBoxColumn = New System.Windows.Forms.DataGridViewTextBoxColumn
        Me.FECHACTUDataGridViewTextBoxColumn = New System.Windows.Forms.DataGridViewTextBoxColumn
        CType(Me.grdPersonas, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.DSPersonas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'grdPersonas
        '
        Me.grdPersonas.AutoGenerateColumns = False
        Me.grdPersonas.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.grdPersonas.Columns.AddRange(New System.Windows.Forms.DataGridViewColumn() {Me.CDPERSONADataGridViewTextBoxColumn, Me.DSNOMBREDataGridViewTextBoxColumn, Me.DSAPELLIDODataGridViewTextBoxColumn, Me.USUACREADataGridViewTextBoxColumn, Me.FECHCREADataGridViewTextBoxColumn, Me.USUAACTUDataGridViewTextBoxColumn, Me.FECHACTUDataGridViewTextBoxColumn})
        Me.grdPersonas.DataMember = "GLB_PERSONAS"
        Me.grdPersonas.DataSource = Me.DSPersonas
        Me.grdPersonas.Location = New System.Drawing.Point(12, 12)
        Me.grdPersonas.Name = "grdPersonas"
        Me.grdPersonas.Size = New System.Drawing.Size(679, 107)
        Me.grdPersonas.TabIndex = 0
        '
        'DSPersonas
        '
        Me.DSPersonas.DataSetName = "GLB_GLOBALES"
        Me.DSPersonas.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema
        '
        'CDPERSONADataGridViewTextBoxColumn
        '
        Me.CDPERSONADataGridViewTextBoxColumn.DataPropertyName = "CD_PERSONA"
        Me.CDPERSONADataGridViewTextBoxColumn.HeaderText = "CD_PERSONA"
        Me.CDPERSONADataGridViewTextBoxColumn.Name = "CDPERSONADataGridViewTextBoxColumn"
        '
        'DSNOMBREDataGridViewTextBoxColumn
        '
        Me.DSNOMBREDataGridViewTextBoxColumn.DataPropertyName = "DS_NOMBRE"
        Me.DSNOMBREDataGridViewTextBoxColumn.HeaderText = "DS_NOMBRE"
        Me.DSNOMBREDataGridViewTextBoxColumn.Name = "DSNOMBREDataGridViewTextBoxColumn"
        '
        'DSAPELLIDODataGridViewTextBoxColumn
        '
        Me.DSAPELLIDODataGridViewTextBoxColumn.DataPropertyName = "DS_APELLIDO"
        Me.DSAPELLIDODataGridViewTextBoxColumn.HeaderText = "DS_APELLIDO"
        Me.DSAPELLIDODataGridViewTextBoxColumn.Name = "DSAPELLIDODataGridViewTextBoxColumn"
        '
        'USUACREADataGridViewTextBoxColumn
        '
        Me.USUACREADataGridViewTextBoxColumn.DataPropertyName = "USUA_CREA"
        Me.USUACREADataGridViewTextBoxColumn.HeaderText = "USUA_CREA"
        Me.USUACREADataGridViewTextBoxColumn.Name = "USUACREADataGridViewTextBoxColumn"
        '
        'FECHCREADataGridViewTextBoxColumn
        '
        Me.FECHCREADataGridViewTextBoxColumn.DataPropertyName = "FECH_CREA"
        Me.FECHCREADataGridViewTextBoxColumn.HeaderText = "FECH_CREA"
        Me.FECHCREADataGridViewTextBoxColumn.Name = "FECHCREADataGridViewTextBoxColumn"
        '
        'USUAACTUDataGridViewTextBoxColumn
        '
        Me.USUAACTUDataGridViewTextBoxColumn.DataPropertyName = "USUA_ACTU"
        Me.USUAACTUDataGridViewTextBoxColumn.HeaderText = "USUA_ACTU"
        Me.USUAACTUDataGridViewTextBoxColumn.Name = "USUAACTUDataGridViewTextBoxColumn"
        '
        'FECHACTUDataGridViewTextBoxColumn
        '
        Me.FECHACTUDataGridViewTextBoxColumn.DataPropertyName = "FECH_ACTU"
        Me.FECHACTUDataGridViewTextBoxColumn.HeaderText = "FECH_ACTU"
        Me.FECHACTUDataGridViewTextBoxColumn.Name = "FECHACTUDataGridViewTextBoxColumn"
        '
        'SEPP0001
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(703, 309)
        Me.Controls.Add(Me.grdPersonas)
        Me.Name = "SEPP0001"
        Me.Text = "Form1"
        CType(Me.grdPersonas, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.DSPersonas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents DSPersonas As ClsDataSets.GLB_GLOBALES
    Friend WithEvents grdPersonas As System.Windows.Forms.DataGridView
    Friend WithEvents CDPERSONADataGridViewTextBoxColumn As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents DSNOMBREDataGridViewTextBoxColumn As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents DSAPELLIDODataGridViewTextBoxColumn As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents USUACREADataGridViewTextBoxColumn As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents FECHCREADataGridViewTextBoxColumn As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents USUAACTUDataGridViewTextBoxColumn As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents FECHACTUDataGridViewTextBoxColumn As System.Windows.Forms.DataGridViewTextBoxColumn

End Class
