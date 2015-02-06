using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Reflection;
using SIS.Framework;
using SIS.Framework.Common;
using SIS.Data;
using ClsDataSets;

namespace ClsFormas
{
    public partial class GLBM0099 : FormaSISWeb, IAcciones
    {
        private DataView dvOpciones;

        public GLBM0099()
        {
            
        }


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
            string claseForma = "GLBM0099";
            //string claseForma = this.GetType().Name;
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
                COpcionesSistemas objOpciones = new COpcionesSistemas(_DataSistema.ConexionBaseDato);
                dvOpciones = new DataView(objOpciones.Detalle("", "", 0).GLB_OPCIONES_SISTEMA);
                
                dvOpciones.AllowDelete = false;
                dvOpciones.AllowEdit = false;
                dvOpciones.AllowNew = false;


                grdDetalleData.DataSource = dvOpciones;
                grdDetalleData.KeyFieldName = "CD_CODI_OPCI_SIST";
                grdDetalleData.DataBind();
                
                
                //grdDetalleData.DataBind();
            }
            catch (Exception ex)
            {
                DespliegaMensaje(ex.Message);
            }
        }



        public void Adicionar()
        {
            CD_CODI_OPCI_SIST.Validate();
            DS_NOMBRE_FORMA.Validate();

            if (CD_CODI_OPCI_SIST.IsValid && DS_NOMBRE_FORMA.IsValid)
            {
                COpcionesSistemas objOpcionesSistemas = new COpcionesSistemas(_DataSistema.ConexionBaseDato);
                DataQuery objResultado = new DataQuery();

                try
                {
                    objResultado = objOpcionesSistemas.Actualizacion(CD_CODI_OPCI_SIST.Text, DS_CODI_OPCI_SIST.Text, DS_NOMBRE_FORMA.Text, DS_RUTA_FORMA.Text, _DataSistema.Cusuario, TipoActualizacion.Adicionar);

                    if (objResultado.CodigoError == 0)
                    {
                        Consultar();
                        EstableceStatus(this.lblStatus, objResultado.FilasAfectadas.ToString() + " Filas afectadas.");
                        //lblStatus.Text = objResultado.FilasAfectadas.ToString() + " Filas afectadas.";
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
            CD_CODI_OPCI_SIST.Validate();
            DS_CODI_OPCI_SIST.Validate();

            if (CD_CODI_OPCI_SIST.IsValid && DS_CODI_OPCI_SIST.IsValid)
            {
                COpcionesSistemas objOpcionesSistemas = new COpcionesSistemas(_DataSistema.ConexionBaseDato);
                DataQuery objResultado = new DataQuery();

                try
                {
                    objResultado = objOpcionesSistemas.Actualizacion(CD_CODI_OPCI_SIST.Text, DS_CODI_OPCI_SIST.Text, DS_NOMBRE_FORMA.Text, DS_RUTA_FORMA.Text, _DataSistema.Cusuario, TipoActualizacion.Actualizar);

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

                COpcionesSistemas objOpcionesSistemas = new COpcionesSistemas(_DataSistema.ConexionBaseDato);
                DataQuery objResultado = new DataQuery();

                try
                {
                    objResultado = objOpcionesSistemas.Actualizacion(CD_CODI_OPCI_SIST.Text, "", "", "", _DataSistema.Cusuario, TipoActualizacion.Eliminar);

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

        public void Limpiar()
        {
            tabOpciones.ActiveTabIndex = 1;
            CD_CODI_OPCI_SIST.ReadOnly = false;
            CD_CODI_OPCI_SIST.Text = "";
            DS_CODI_OPCI_SIST.Text = "";
            DS_NOMBRE_FORMA.Text = "";
            DS_RUTA_FORMA.Text = "";

            CD_CODI_OPCI_SIST.IsValid = true;
            DS_NOMBRE_FORMA.IsValid = true;

            EstableceStatus(this.lblStatus, "");
        }

        protected void grdDetalleData_DataBinding(object sender, EventArgs e)
        {
            if (dvOpciones == null)
            {
                _DataSistema = (ClsSistema)Session["MyDataSistema"];
                COpcionesSistemas objOpciones = new COpcionesSistemas(_DataSistema.ConexionBaseDato);
                dvOpciones = new DataView(objOpciones.Detalle("", "", 0).GLB_OPCIONES_SISTEMA);
            }
            grdDetalleData.DataSource = dvOpciones;
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

        protected void cmdRegresar_Click(object sender, EventArgs e)
        {

        }
    }
}