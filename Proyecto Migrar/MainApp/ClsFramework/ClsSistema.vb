Namespace SIS.Framework.Common

    Public Interface IAcciones

        Sub Consultar()
        Sub Adicionar()
        Sub Modificar()
        Sub Eliminar()
        Sub Imprimir()

    End Interface

    Public Class ClsSistema
        Private _Cusuario As String
        Private _NombreUsuario As String
        Private _ObjInfoData As DataQuery
        Private _ConexionBaseDato As String
        Private _NombreAplicacion As String
        Private _NombreAplicacionImpresion As String
        Private _CodigoOpcionSistema As String
        Private _NombreOpcionSistema As String
        Private _DescripcionOpcionSistema As String
        Private _RefrescaCamposenCarga As String
        Private _CodigoEmpresa As String
        Private _CodigoAnio As String
        Private _CodigoMes As String
        Private _NecesitaCodigoEmpresa As String
        Private _NecesitaPeriodoContable As String
        Private _ValidaPeriodoContable As String
        Private _ValidaPeriodoLogistico As String
        Private _CodigoEmpresaDefecto As String
        Private _EstadoUsuario As Object
        Private _TipoAutenticacionSistema As TipoAutenticacion
        Private _CodigoInstancia As String
        Private _NombreInstancia As String
        Private _CodigoBodegaRecepcion As String

        Private _ServidorDeReportes As String

        Private _ExcluirDocs As String

        Public Property CodigoBodegaRecepcion() As String
            Get
                Return _CodigoBodegaRecepcion
            End Get
            Set(ByVal value As String)
                _CodigoBodegaRecepcion = value
            End Set
        End Property

        Public Property NombreAplicacionImpresion() As String
            Get
                Return _NombreAplicacionImpresion
            End Get
            Set(ByVal value As String)
                _NombreAplicacionImpresion = value
            End Set
        End Property

        Public Property CodigoInstancia() As String
            Get
                Return _CodigoInstancia
            End Get
            Set(ByVal value As String)
                _CodigoInstancia = value
            End Set
        End Property

        Public Property NombreInstancia() As String
            Get
                Return _NombreInstancia
            End Get
            Set(ByVal value As String)
                _NombreInstancia = value
            End Set
        End Property

        Public Property TipoAutenticacionSistema() As TipoAutenticacion
            Get
                Return _TipoAutenticacionSistema
            End Get
            Set(ByVal value As TipoAutenticacion)
                _TipoAutenticacionSistema = value
            End Set
        End Property

        Public Property ValidaPeriodoContable() As String
            Get
                Return _ValidaPeriodoContable
            End Get
            Set(ByVal value As String)
                _ValidaPeriodoContable = value
            End Set
        End Property

        Public Property ValidaPeriodoLogistico() As String
            Get
                Return _ValidaPeriodoLogistico
            End Get
            Set(ByVal value As String)
                _ValidaPeriodoLogistico = value
            End Set
        End Property

        Public Property EstadoUsuario() As String
            Get
                Return _EstadoUsuario
            End Get
            Set(ByVal value As String)
                _EstadoUsuario = value
            End Set
        End Property

        Public Property CodigoEmpresaDefecto() As String
            Get
                Return _CodigoEmpresaDefecto
            End Get
            Set(ByVal value As String)
                _CodigoEmpresaDefecto = value
            End Set
        End Property

        Public Property DescripcionOpcionSistema() As String
            Get
                Return _DescripcionOpcionSistema
            End Get
            Set(ByVal value As String)
                _DescripcionOpcionSistema = value
            End Set
        End Property
        Public Property NecesitaCodigoEmpresa() As String
            Get
                Return _NecesitaCodigoEmpresa
            End Get
            Set(ByVal value As String)
                _NecesitaCodigoEmpresa = value
            End Set
        End Property

        Public Property NecesitaPeriodoContable() As String
            Get
                Return _NecesitaPeriodoContable
            End Get
            Set(ByVal value As String)
                _NecesitaPeriodoContable = value
            End Set
        End Property

        Public Property CodigoEmpresa() As String
            Get
                Return _CodigoEmpresa
            End Get
            Set(ByVal value As String)
                _CodigoEmpresa = value
            End Set
        End Property

        Public Property CodigoAnio() As String
            Get
                Return _CodigoAnio
            End Get
            Set(ByVal value As String)
                _CodigoAnio = value
            End Set
        End Property

        Public Property CodigoMes() As String
            Get
                Return _CodigoMes
            End Get
            Set(ByVal value As String)
                _CodigoMes = value
            End Set
        End Property

        Public Property RefrescaCamposenCarga() As String
            Get
                Return _RefrescaCamposenCarga
            End Get
            Set(ByVal value As String)
                _RefrescaCamposenCarga = value
            End Set
        End Property

        Public Property CodigoOpcionSistema() As String
            Get
                Return _CodigoOpcionSistema
            End Get
            Set(ByVal value As String)
                _CodigoOpcionSistema = value
            End Set
        End Property
        Public Property NombreOpcionSistema() As String
            Get
                Return _NombreOpcionSistema

            End Get
            Set(ByVal value As String)
                _NombreOpcionSistema = value
            End Set
        End Property
        Public Property NombreAplicacion() As String
            Get
                Return _NombreAplicacion
            End Get
            Set(ByVal value As String)
                _NombreAplicacion = value
            End Set
        End Property
        Public Property ConexionBaseDato() As String
            Get
                Return _ConexionBaseDato
            End Get
            Set(ByVal value As String)
                _ConexionBaseDato = value
            End Set
        End Property
        Public Property Cusuario() As String
            Get
                Return _Cusuario
            End Get
            Set(ByVal value As String)
                _Cusuario = value
            End Set
        End Property
        Public Property NombreUsuario() As String
            Get
                Return _NombreUsuario

            End Get
            Set(ByVal value As String)
                _NombreUsuario = value
            End Set
        End Property

        Public Property ServidorDeReportes() As String
            Get
                Return _ServidorDeReportes
            End Get
            Set(ByVal value As String)
                _ServidorDeReportes = value
            End Set
        End Property

        Public Property ExcluirDocs() As String
            Get
                Return _ExcluirDocs
            End Get
            Set(ByVal value As String)
                _ExcluirDocs = value
            End Set
        End Property

        Public ReadOnly Property ObjInfoData() As DataQuery
            Get
                Return _ObjInfoData
            End Get
        End Property

        Sub New()
            _ObjInfoData = New DataQuery
        End Sub

    End Class

    Public Class DataQuery
        Public CodigoError As Decimal
        Public MensajeError As String
        Public ObjData As New DataSet
        Public Resultado As Boolean
        Public CodigoAuxiliar As Object
        Public FilasAfectadas As Integer

        Sub New()
            CodigoError = 0
            FilasAfectadas = 0
            MensajeError = ""
            CodigoAuxiliar = ""
            Resultado = False
        End Sub

    End Class

    Public Enum TipoUsuario
        Consulta = 1
        Normal = 2
        Supervisor = 3
        SuperUsuario = 4
        Administrador = 5
    End Enum

    Public Enum TipoActualizacion
        Adicionar = 1
        Actualizar = 2
        Eliminar = 3
        No_Definida = 4
    End Enum

    Public Enum TipoEstadoUsuario
        Pendiente = 0
        Activo = 1
        Suspendido = 2
    End Enum

    Public Enum TipoAutenticacion
        TablaSistema = 1
        ActiveDirectory = 2
        SQLServer = 3
    End Enum
End Namespace
