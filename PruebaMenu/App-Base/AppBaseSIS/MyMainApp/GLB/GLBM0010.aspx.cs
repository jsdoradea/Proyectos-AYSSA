using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SIS.Framework;
using SIS.Framework.Common;
using SIS.Data;
using System.Data;



namespace ClsFormas
{
    public partial class GLBM0010 : FormaSISWeb, IAcciones
    {
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
            string claseForma = "GLBM0010"; //this.GetType().Name;
            //claseForma = claseForma.Substring(0, claseForma.IndexOf("_"));
            opcionesSistema.DetalleOpcion(claseForma, "", 1);
            lblTitulo.Text = opcionesSistema.NombreForma;
            this.Title = opcionesSistema.DescripcionOpcionSistema;
            _TituloPagina = opcionesSistema.DescripcionOpcionSistema;
        }

        public void Consultar()
        {
            try
            {
                CUnidadesTEG objUnidades = new CUnidadesTEG(_DataSistema.ConexionBaseDato);
                dvUnidades = new DataView(objUnidades.Detalle(0, "", 0).GLB_UNIDADES_TEG);

                dvUnidades.AllowDelete = false;
                dvUnidades.AllowEdit = false;
                dvUnidades.AllowNew = false;

                grdDetalleData.DataSource = dvUnidades;
                grdDetalleData.KeyFieldName = "CD_UNIDAD";
                grdDetalleData.DataBind();
            }
            catch (Exception ex)
            {
                DespliegaMensaje(ex.Message);
            }
        }

        public void Limpiar()
        {
            tabOpciones.ActiveTabIndex = 1;
            CD_UNIDAD.ReadOnly = true;
            CD_UNIDAD.Text = "";
            DS_UNIDAD.Text = "";

            DS_UNIDAD.IsValid = true;

            EstableceStatus(this.lblStatus, "");
        }

        public void Adicionar()
        {
            DS_UNIDAD.Validate();
            if (DS_UNIDAD.IsValid)
            {
                CUnidadesTEG objUnidades = new CUnidadesTEG(_DataSistema.ConexionBaseDato);
                DataQuery objResultado = new DataQuery();

                try
                {
                    objResultado = objUnidades.Actualizacion(0, DS_UNIDAD.Text, _DataSistema.Cusuario, TipoActualizacion.Adicionar);

                    if (objResultado.CodigoError == 0)
                    {
                        Consultar();
                        EstableceStatus(this.lblStatus, objResultado.FilasAfectadas.ToString() + " Filas afectadas.");
                        grdDetalleData.Selection.SelectRowByKey(objResultado.CodigoAuxiliar);
                    }
                    else
                    {
                        DespliegaMensaje(objResultado.MensajeError.Replace("'", ""));
                    }
                }
                catch (Exception ex)
                {
                    DespliegaMensaje(ex.Message);
                }
            }
        }

        public void Modificar()
        {
            DS_UNIDAD.Validate();
            if (DS_UNIDAD.IsValid)
            {
                CUnidadesTEG objUnidades = new CUnidadesTEG(_DataSistema.ConexionBaseDato);
                DataQuery objResultado = new DataQuery();

                try
                {
                    objResultado = objUnidades.Actualizacion(Int32.Parse(CD_UNIDAD.Text), DS_UNIDAD.Text, _DataSistema.Cusuario, TipoActualizacion.Actualizar);

                    if (objResultado.CodigoError == 0)
                    {
                        Consultar();
                        EstableceStatus(this.lblStatus, objResultado.FilasAfectadas.ToString() + " Filas afectadas.");
                        grdDetalleData.Selection.SelectRowByKey(objResultado.CodigoAuxiliar);
                    }
                    else
                    {
                        DespliegaMensaje(objResultado.MensajeError.Replace("'", ""));
                    }
                }
                catch (Exception ex)
                {
                    DespliegaMensaje(ex.Message);
                }
            }
        }

        public void Eliminar()
        {
            if (lblCtrl.Text == "S")
            {
                CUnidadesTEG objUnidades = new CUnidadesTEG(_DataSistema.ConexionBaseDato);
                DataQuery objResultado = new DataQuery();

                try
                {
                    objResultado = objUnidades.Actualizacion(Int32.Parse(CD_UNIDAD.Text), DS_UNIDAD.Text, _DataSistema.Cusuario, TipoActualizacion.Eliminar);

                    if (objResultado.CodigoError == 0)
                    {
                        Consultar();
                        Limpiar();
                        EstableceStatus(this.lblStatus, objResultado.FilasAfectadas.ToString() + " Filas afectadas.");
                        tabOpciones.ActiveTabIndex = 0;
                    }
                    else
                    {
                        DespliegaMensaje(objResultado.MensajeError.Replace("'", ""));
                    }
                }
                catch (Exception ex)
                {
                    DespliegaMensaje(ex.Message);
                }
            }
        }

        public void Imprimir()
        {

        }

        protected void grdDetalleData_DataBinding1(object sender, EventArgs e)
        {
            if (dvUnidades == null)
            {
                _DataSistema = (ClsSistema)Session["MyDataSistema"];

                CUnidadesTEG objUnidades = new CUnidadesTEG(_DataSistema.ConexionBaseDato);
                dvUnidades = new DataView(objUnidades.Detalle(0, "", 0).GLB_UNIDADES_TEG);
            }
            grdDetalleData.DataSource = dvUnidades;
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