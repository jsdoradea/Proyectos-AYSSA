using System.Data;

namespace SIS.Framework.Common
{
    
    public interface IAcciones
    {
        void Consultar();
        void Adicionar();
        void Modificar();
        void Eliminar();
        void Imprimir();
        void Limpiar();
    }

    public class ClsSistema
    {
        private string _Cusuario;
        private string _NombreUsuario;
        private DataQuery _ObjInfoData;
        private string _ConexionBaseDato;
        private string _NombreAplicacion;
        private string _NombreAplicacionImpresion;
        private string _CodigoOpcionSistema;
        private string _NombreOpcionSistema;
        private string _DescripcionOpcionSistema;
        private string _RefrescaCamposenCarga;
        private string _CodigoEmpresa;
        private string _CodigoAnio;
        private string _CodigoMes;
        private string _NecesitaCodigoEmpresa;
        private string _NecesitaPeriodoContable;
        private string _ValidaPeriodoContable;
        private string _CodigoEmpresaDefecto;
        private string _EstadoUsuario;
        //private  _TipoAutenticacionSistema As TipoAutenticacion
        private string _CodigoInstancia;
        private string _NombreInstancia;

        private string _ServidorDeReportes;


        public string NombreAplicacionImpresion{
            get
            {
                return _NombreAplicacionImpresion;
            }
            set
            {
                _NombreAplicacionImpresion = value;
            }

        }

        public string CodigoInstancia
        {
            get
            {
                return _CodigoInstancia;
            }
            set
            {
                _CodigoInstancia = value;
            }
        }

        public string NombreInstancia
        {
            get
            {
                return _NombreInstancia;
            }
            set
            {
                _NombreInstancia = value;
            }
        }

        public string ValidaPeriodoContable
        {
            get
            {
                return _ValidaPeriodoContable;
            }
            set
            {
                _ValidaPeriodoContable = value;
            }
        }

        public string EstadoUsuario
        {
            get
            {
                return _EstadoUsuario;
            }
            set
            {
                _EstadoUsuario = value;
            }
        }

        public string CodigoEmpresaDefecto
        {
            get
            {
                return _CodigoEmpresaDefecto;
            }
            set
            {
                _CodigoEmpresaDefecto = value;
            }
        }

        public string DescripcionOpcionSistema
        {
            get
            {
                return _DescripcionOpcionSistema;
            }
            set
            {
                _DescripcionOpcionSistema = value;
            }
        }
        public string NecesitaCodigoEmpresa
        {
            get
            {
                return _NecesitaCodigoEmpresa;
            }
            set
            {
                _NecesitaCodigoEmpresa = value;
            }
        }

        public string NecesitaPeriodoContable
        {
            get
            {
                return _NecesitaPeriodoContable;
            }
            set
            {
                _NecesitaPeriodoContable = value;
            }
        }

        public string CodigoEmpresa
        {
            get
            {
                return _CodigoEmpresa;
            }
            set
            {
                _CodigoEmpresa = value;
            }
        }

        public string CodigoAnio
        {
            get
            {
                return _CodigoAnio;
            }
            set
            {
                _CodigoAnio = value;
            }
        }

        public string CodigoMes
        {
            get
            {
                return _CodigoMes;
            }
            set
            {
                _CodigoMes = value;
            }
        }

        public string RefrescaCamposenCarga
        {
            get
            {
                return _RefrescaCamposenCarga;
            }
            set
            {
                _RefrescaCamposenCarga = value;
            }
        }

        public string CodigoOpcionSistema
        {
            get
            {
                return _CodigoOpcionSistema;
            }
            set
            {
                _CodigoOpcionSistema = value;
            }
        }
        public string NombreOpcionSistema
        {
            get
            {
                return _NombreOpcionSistema;

            }
            set
            {
                _NombreOpcionSistema = value;
            }
        }
        public string NombreAplicacion
        {
            get
            {
                return _NombreAplicacion;
            }
            set
            {
                _NombreAplicacion = value;
            }
        }
        public string ConexionBaseDato
        {
            get
            {
                return _ConexionBaseDato;
            }
            set
            {
                _ConexionBaseDato = value;
            }
        }
        public string Cusuario
        {
            get
            {
                return _Cusuario;
            }
            set
            {
                _Cusuario = value;
            }
        }
        public string NombreUsuario
        {
            get
            {
                return _NombreUsuario;

            }
            set
            {
                _NombreUsuario = value;
            }
        }

        public string ServidorDeReportes
        {
            get
            {
                return _ServidorDeReportes;
            }
            set
            {
                _ServidorDeReportes = value;
            }
        }

        public DataQuery ObjInfoData {
            get{
                return _ObjInfoData;
            }
        }

        public ClsSistema()
        {
            _ObjInfoData = new DataQuery();
        }
    }

    public class DataQuery
    {
        public decimal CodigoError;
        public string MensajeError;
        public DataSet ObjData;
        public bool Resultado;
        public object CodigoAuxiliar;
        public int FilasAfectadas;

        public DataQuery()
        {
            CodigoError = 0;
            FilasAfectadas = 0;
            MensajeError = "";
            CodigoAuxiliar = "";
            Resultado = false;
        }
    }

    public enum TipoActualizacion
    {
        Adicionar = 1,
        Actualizar = 2,
        Eliminar = 3,
        No_Definida = 4
    }
}