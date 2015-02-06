using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using SIS.Framework;
using SIS.Framework.Common;
using SIS.Data;
using ClsDataSets;

namespace ClsFormas
{
    public partial class GLBM0011 : FormaSISWeb, IAcciones
    {
        private DataView dvEmpleados;
        private DataView dvTitulos;
        private DataView dvCargos;
        private DataView dvUnidades;

        protected void Page_Load(object sender, EventArgs e)
        {
            _DataSistema = (ClsSistema)Session["MyDataSistema"];
            CargaForma();
            if (!IsPostBack)
            {
                Consultar();
            }
        }

        protected void CargaForma()
        {
            COpcionesSistemas opcionesSistema = new COpcionesSistemas(_DataSistema.ConexionBaseDato);
            string claseForma = "GLBM0011"; //this.GetType().Name;
            //claseForma = claseForma.Substring(0, claseForma.IndexOf("_"));
            opcionesSistema.DetalleOpcion(claseForma, "", 1);
            lblTitulo.Text = opcionesSistema.NombreForma;
            this.Title = opcionesSistema.DescripcionOpcionSistema;
            _TituloPagina = opcionesSistema.DescripcionOpcionSistema;
        }

        public void Adicionar()
        {

        }

        public void Modificar()
        {

        }

        public void Eliminar()
        {

        }

        public void Imprimir()
        {

        }

        public void Consultar()
        {
            try
            {
                
                CEmpleadosTEG objEmpleados = new CEmpleadosTEG(_DataSistema.ConexionBaseDato);
                dvEmpleados = new DataView(objEmpleados.Detalle(0, 0, 0, 0, 0).GLB_EMPLEADOS_TEG);

                dvEmpleados.AllowDelete = false;
                dvEmpleados.AllowEdit = false;
                dvEmpleados.AllowNew = false;

                grdDetalleData.DataSource = dvEmpleados;
                grdDetalleData.KeyFieldName = "CD_EMPLEADO";
                grdDetalleData.DataBind();

                CTitulosAcademicos objTitulos = new CTitulosAcademicos(_DataSistema.ConexionBaseDato);
                dvTitulos = new DataView(objTitulos.Detalle(0, "", 0).GLB_TITULOS_ACADEMICOS);

                dvTitulos.AllowDelete = false;
                dvTitulos.AllowEdit = false;
                dvTitulos.AllowNew = false;

                CD_TITULO.DataSource = dvTitulos;
                CD_TITULO.KeyFieldName = "CD_TITULO";
                CD_TITULO.DataBind();

                CCargosInstitucionales objCargos = new CCargosInstitucionales(_DataSistema.ConexionBaseDato);
                dvCargos = new DataView(objCargos.Detalle(0, "", 0).GLB_CARGOS_INSTITUCIONALES);

                dvCargos.AllowDelete = false;
                dvCargos.AllowEdit = false;
                dvCargos.AllowNew = false;
                CD_CARGO.DataSource = dvCargos;
                CD_CARGO.KeyFieldName = "CD_CARGO_INST";
                CD_CARGO.DataBind();

                CUnidadesTEG objUnidades = new CUnidadesTEG(_DataSistema.ConexionBaseDato);
                dvUnidades = new DataView(objUnidades.Detalle(0, "", 0).GLB_UNIDADES_TEG);

                dvUnidades.AllowDelete = false;
                dvUnidades.AllowEdit = false;
                dvUnidades.AllowNew = false;
                CD_UNIDAD.DataSource = dvUnidades;
                CD_UNIDAD.KeyFieldName = "CD_UNIDAD";
                CD_UNIDAD.DataBind();

            }
            catch (Exception ex)
            {
                DespliegaMensaje(ex.Message);
            }
        }

        public void Limpiar()
        {

        }

        protected void grdDetalleData_DataBinding(object sender, EventArgs e)
        {
            if (dvEmpleados == null)
            {
                _DataSistema = (ClsSistema)Session["MyDataSistema"];
                CEmpleadosTEG objEmpleados = new CEmpleadosTEG(_DataSistema.ConexionBaseDato);
                dvEmpleados = new DataView(objEmpleados.Detalle(0, 0, 0, 0, 0).GLB_EMPLEADOS_TEG);
            }
            grdDetalleData.DataSource = dvEmpleados;
                
        }

        protected void CD_TITULO_DataBinding(object sender, EventArgs e)
        {
            if (dvTitulos == null)
            {
                _DataSistema = (ClsSistema)Session["MyDataSistema"];
                CTitulosAcademicos objTitulos = new CTitulosAcademicos(_DataSistema.ConexionBaseDato);
                dvTitulos = new DataView(objTitulos.Detalle(0, "", 0).GLB_TITULOS_ACADEMICOS);
            }
            CD_TITULO.DataSource = dvTitulos;
        }

        protected void CD_UNIDAD_DataBinding(object sender, EventArgs e)
        {
            if (dvUnidades == null)
            {
                _DataSistema = (ClsSistema)Session["MyDataSistema"];
                CUnidadesTEG objUnidades = new CUnidadesTEG(_DataSistema.ConexionBaseDato);
                dvUnidades = new DataView(objUnidades.Detalle(0, "", 0).GLB_UNIDADES_TEG);
            }
            CD_UNIDAD.DataSource = dvUnidades;
        }

        protected void CD_CARGO_DataBinding(object sender, EventArgs e)
        {
            if (dvCargos == null)
            {
                _DataSistema = (ClsSistema)Session["MyDataSistema"];
                CCargosInstitucionales objCargos = new CCargosInstitucionales(_DataSistema.ConexionBaseDato);
                dvCargos = new DataView(objCargos.Detalle(0, "", 0).GLB_CARGOS_INSTITUCIONALES);
            }
            CD_CARGO.DataSource = dvCargos;
        }

        protected void mnuPrincipal_ItemClick(object source, DevExpress.Web.MenuItemEventArgs e)
        {
            switch (mnuPrincipal.SelectedItem.Name)
            {
                case "icRefresh":
                    Consultar();
                    break;
                case "icLimpiar":
                    Limpiar();
                    break;
                case "icAdicionar":
                    Adicionar();
                    break;
                case "icModificar":
                    Modificar();
                    break;
                case "icEliminar":
                    Eliminar();
                    break;
                case "icExportarXls":
                    this.gridExport.WriteXlsxToResponse();
                    break;
                case "icExportarDoc":
                    this.gridExport.WriteRtfToResponse();
                    break;
                case "icExportarPDF":
                    this.gridExport.WritePdfToResponse();
                    break;

            }
        }

    }
}