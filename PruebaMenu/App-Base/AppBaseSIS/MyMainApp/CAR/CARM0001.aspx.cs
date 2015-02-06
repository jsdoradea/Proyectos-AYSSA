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
    public partial class CARM0001 : FormaSISWeb, IAcciones
    {
        private DataView dvEntidades;
        private DataView dvCamposEntidades;

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
            string claseForma = "CARM0001"; //this.GetType().Name;
            //claseForma = claseForma.Substring(0, claseForma.IndexOf("_"));
            opcionesSistema.DetalleOpcion(claseForma, "", 1);
            lblTitulo.Text = opcionesSistema.NombreForma;
            this.Title = opcionesSistema.DescripcionOpcionSistema;
            _TituloPagina = opcionesSistema.DescripcionOpcionSistema;
        }

        public void Adicionar()
        {
            EstableceStatus(this.lblStatus, "");
            DS_NOM_ENTIDAD.Validate();
            CD_ESTADO.Validate();
            if (DS_NOM_ENTIDAD.IsValid && CD_ESTADO.IsValid)
            {
                CEntidades objEntidades = new CEntidades(_DataSistema.ConexionBaseDato);
                DataQuery objResultado = new DataQuery();

                try
                {
                    objResultado = objEntidades.Actualizacion(0, DS_NOM_ENTIDAD.Text,
                        DS_DES_ENTIDAD_COR.Text, DS_DES_ENTIDAD_LAR.Text, (string)CD_ESTADO.Value,
                        _DataSistema.Cusuario, TipoActualizacion.Adicionar);

                    if (objResultado.CodigoError == 0)
                    {
                        CD_ENTIDAD.Text = objResultado.CodigoAuxiliar.ToString();
                        Consultar();
                        EstableceStatus(this.lblStatus, objResultado.FilasAfectadas.ToString() + " Filas afectadas.");
                        grdDetalleData.Selection.SelectRowByKey(objResultado.CodigoAuxiliar);
                    }
                    else
                    {
                        DespliegaMensaje(objResultado.MensajeError);
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
            EstableceStatus(this.lblStatus, "");
            DS_NOM_ENTIDAD.Validate();
            CD_ESTADO.Validate();
            if (DS_NOM_ENTIDAD.IsValid && CD_ESTADO.IsValid)
            {
                CEntidades objEntidades = new CEntidades(_DataSistema.ConexionBaseDato);
                DataQuery objResultado = new DataQuery();

                try
                {
                    objResultado = objEntidades.Actualizacion(decimal.Parse(CD_ENTIDAD.Text), DS_NOM_ENTIDAD.Text,
                        DS_DES_ENTIDAD_COR.Text, DS_DES_ENTIDAD_LAR.Text, (string)CD_ESTADO.Value,
                        _DataSistema.Cusuario, TipoActualizacion.Actualizar);

                    if (objResultado.CodigoError == 0)
                    {
                        Consultar();
                        EstableceStatus(this.lblStatus, objResultado.FilasAfectadas.ToString() + " Filas afectadas.");
                        grdDetalleData.Selection.SelectRowByKey(objResultado.CodigoAuxiliar);
                    }
                    else
                    {
                        DespliegaMensaje(objResultado.MensajeError);
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
            if (lblControl.Text == "S")
            {
                EstableceStatus(this.lblStatus, "");
                CEntidades objEntidades = new CEntidades(_DataSistema.ConexionBaseDato);
                DataQuery objResultado = new DataQuery();

                try
                {
                    objResultado = objEntidades.Actualizacion(decimal.Parse(CD_ENTIDAD.Text), "",
                        "", "", "", _DataSistema.Cusuario, TipoActualizacion.Eliminar);

                    if (objResultado.CodigoError == 0)
                    {
                        Consultar();
                        Limpiar();
                        EstableceStatus(this.lblStatus, objResultado.FilasAfectadas.ToString() + " Filas afectadas.");
                        tabOpciones.ActiveTabIndex = 0;
                    }
                    else
                    {
                        DespliegaMensaje(objResultado.MensajeError);
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

        public void Consultar()
        {
            try
            {
                CEntidades objEntidades = new CEntidades(_DataSistema.ConexionBaseDato);
                dvEntidades = new DataView(objEntidades.Detalle(0, "", "", 0).GLB_ENTIDADES);

                dvEntidades.AllowDelete = false;
                dvEntidades.AllowEdit = false;
                dvEntidades.AllowNew = false;

                grdDetalleData.DataSource = dvEntidades;
                grdDetalleData.KeyFieldName = "CD_ENTIDAD";
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
            CD_ENTIDAD.ReadOnly = true;
            CD_ENTIDAD.Text = "";
            DS_NOM_ENTIDAD.Text = "";
            DS_DES_ENTIDAD_COR.Text = "";
            DS_DES_ENTIDAD_LAR.Text = "";
            CD_ESTADO.Value = "";

            DS_NOM_ENTIDAD.IsValid = true;
            CD_ESTADO.IsValid = true;

            CargaDetalleEntidad(0);

            EstableceStatus(this.lblStatus, "");
        }

        protected void grdDetalleData_DataBinding(object sender, EventArgs e)
        {
            if (dvEntidades == null)
            {
                _DataSistema = (ClsSistema)Session["MyDataSistema"];

                CEntidades objEntidades = new CEntidades(_DataSistema.ConexionBaseDato);
                dvEntidades = new DataView(objEntidades.Detalle(0, "", "", 0).GLB_ENTIDADES);
            }
            grdDetalleData.DataSource = dvEntidades;
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

        private void CargaDetalleEntidad(decimal CodigoEntidad)
        {
            try
            {
                CCamposEnti objCamposEnti = new CCamposEnti(_DataSistema.ConexionBaseDato);
                dvCamposEntidades = new DataView(objCamposEnti.Detalle(CodigoEntidad, 0, 1).GLB_CAMPOS_ENTI);

                dvCamposEntidades.AllowDelete = false;
                dvCamposEntidades.AllowEdit = false;
                dvCamposEntidades.AllowNew = false;

                grdDetalleEntidad.DataSource = dvCamposEntidades;
                grdDetalleEntidad.KeyFieldName = "CD_CAMPOS_ENTI";
                grdDetalleEntidad.DataBind();
            }
            catch (Exception ex)
            {
                DespliegaMensaje(ex.Message);
            }
        }

        protected void grdDetalleData_SelectionChanged(object sender, EventArgs e)
        {
            List<object> valores = grdDetalleData.GetSelectedFieldValues(new string[] { "CD_ENTIDAD" });

            string CdEntidad = valores[0].ToString();

            if (CdEntidad.Length > 0)
            {
                CargaDetalleEntidad(decimal.Parse(CdEntidad));
            }

        }

        protected void grdDetalleEntidad_DataBinding(object sender, EventArgs e)
        {
            if (dvCamposEntidades == null)
            {
                List<object> valores = grdDetalleData.GetSelectedFieldValues(new string[] { "CD_ENTIDAD" });
                string CdEntidad = valores[0].ToString();

                if (CdEntidad.Length > 0)
                {
                    _DataSistema = (ClsSistema)Session["MyDataSistema"];
                    CCamposEnti objCamposEnti = new CCamposEnti(_DataSistema.ConexionBaseDato);
                    dvCamposEntidades = new DataView(objCamposEnti.Detalle(decimal.Parse(CdEntidad), 0, 1).GLB_CAMPOS_ENTI);
                }
            }
            grdDetalleEntidad.DataSource = dvCamposEntidades;
        }

        protected void ASPxButton1_Click(object sender, EventArgs e)
        {
            List<object> valores = grdDetalleData.GetSelectedFieldValues(new string[] { "CD_ENTIDAD" });

            string CdEntidad = valores[0].ToString();

            if (CdEntidad.Length > 0)
            {
                CargaDetalleEntidad(decimal.Parse(CdEntidad));
            }
        }
    }
}