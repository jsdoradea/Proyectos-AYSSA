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
using DevExpress.Web;

namespace ClsFormas
{
    public partial class MyTemplateForm : System.Web.UI.MasterPage
    {
        private SIS.Framework.Common.ClsSistema _DataSistema; 

        protected void Page_Load(object sender, EventArgs e)
        {
            imgLogo.ImageUrl = "/sysdata/logoUIE.jpg";
            _DataSistema = (ClsSistema)Session["MyDataSistema"];

            CargaMenu();

            if (!IsPostBack)
            {
                treeMenu.DataBind();
                if (treeMenu.SelectedNode != null)
                {
                    TreeViewNode nodoMenu;
                    nodoMenu = treeMenu.SelectedNode;
                    treeMenu.ExpandToNode(nodoMenu);
                }
            }
        }

        private void CargaMenu()
        {
            if (treeMenu.Nodes.Count == 0)
            {
                COpcionesSistemas objDataOpciones = new COpcionesSistemas(_DataSistema.ConexionBaseDato);
                DataSet dsOpciones = new DataSet();
                treeMenu.Nodes.Clear();
                dsOpciones = objDataOpciones.DetalleOpciones(_DataSistema.Cusuario, "", 1);

                try
                {
                    string CodigoSistema;
                    string CodigoMenu;
                    string CodigoOpcion;

                    string CodigoSistemaUlt = "";
                    string CodigoMenuUlt = "";
                    string CodigoOpcionUlt = "";

                    TreeViewNode nodoOpcion = new TreeViewNode();
                    TreeViewNode nodoMenu = new TreeViewNode();
                    TreeViewNode nodoSistema = new TreeViewNode();

                    foreach (DataRow objRow in dsOpciones.Tables[0].Rows)
                    {
                        CodigoSistema = objRow["CD_CODI_SIST"].ToString();
                        CodigoMenu = objRow["CD_CODI_MENU"].ToString();
                        CodigoOpcion = objRow["CD_CODI_OPCI_SIST"].ToString();

                        if (CodigoSistema != CodigoSistemaUlt)
                        {
                            if (nodoSistema.Nodes.Count > 0)
                            {
                                treeMenu.Nodes.Add(nodoSistema);
                                CodigoMenuUlt = "";
                                CodigoOpcionUlt = "";
                            }
                            nodoSistema = new TreeViewNode();
                            nodoSistema.NodeStyle.Paddings.PaddingLeft = 0;
                            nodoSistema.Name = CodigoSistema;
                            nodoSistema.Text = objRow["DS_NOMB_SIST"].ToString();
                            CodigoSistemaUlt = CodigoSistema;
                        }

                        if (CodigoMenu != CodigoMenuUlt)
                        {
                            nodoMenu = new TreeViewNode();
                            nodoMenu.NodeStyle.Paddings.PaddingLeft = 0;
                            nodoMenu.Name = CodigoSistema + CodigoMenu;
                            nodoMenu.Text = objRow["DS_DESC_MENU"].ToString();
                            CodigoMenuUlt = CodigoMenu;
                            nodoSistema.Nodes.Add(nodoMenu);
                        }

                        if (CodigoOpcion != CodigoOpcionUlt)
                        {
                            nodoOpcion = new TreeViewNode();
                            nodoOpcion.NodeStyle.Paddings.PaddingLeft = 0;
                            nodoOpcion.Name = CodigoOpcion;
                            nodoOpcion.Text = objRow["DS_NOMBRE_FORMA"].ToString();
                            nodoOpcion.NavigateUrl = objRow["DS_RUTA_FORMA"].ToString();
                            CodigoOpcionUlt = CodigoOpcion;
                            nodoMenu.Nodes.Add(nodoOpcion);
                        }
                    }
                    if (nodoSistema.Nodes.Count > 0)
                    {
                        treeMenu.Nodes.Add(nodoSistema);
                    }
                }
                catch (Exception ex)
                {
                    System.ApplicationException appEx = new System.ApplicationException(ex.Message);
                    throw appEx;
                }
            }
        }
    }

    public partial class FormaSISWeb : System.Web.UI.Page
    {
        protected SIS.Framework.Common.ClsSistema _DataSistema;
        protected string _ConexionBaseDato;
        protected string _RefrescaCamposEnCarga;
        protected string _TituloPagina;

        protected string _NecesitaPeriodoContable = "N";
        protected string _NecesitaCodigoEmpresa = "N";

        protected bool _CamposEnlazados = false;
        protected string _Ejercicio = "";
        protected string _Periodo = "";

        public FormaSISWeb()
        {
            _DataSistema = new SIS.Framework.Common.ClsSistema();
        }

        public FormaSISWeb(SIS.Framework.Common.ClsSistema DataSistema)
        {
            _DataSistema = DataSistema;
            _ConexionBaseDato = DataSistema.ConexionBaseDato;

            _NecesitaCodigoEmpresa = DataSistema.NecesitaCodigoEmpresa;
            _NecesitaPeriodoContable = DataSistema.NecesitaPeriodoContable;
        }


        public virtual void Limpiar(DevExpress.Web.ASPxTextBox lblStatus)
        {
            LimpiaStatus(lblStatus);
        }

        protected virtual void RefrescaInfo()
        {

        }


        public virtual void Salir()
        {
            this.Dispose();
        }

        protected void EnlazaCampos()
        {
        }

        protected virtual void IniciaEnlaceCampos()
        {

        }

        protected virtual void FinalizaEnlaceCampos()
        {

        }



        private void LimpiaStatus(DevExpress.Web.ASPxTextBox lblStatus)
        {
            try
            {
                lblStatus.Text = "";
            }
            catch (Exception ex)
            {
                lblStatus.Text = ex.Message;
            }
        }

        protected virtual void Page_Init(object sender, EventArgs e)
        {
            if (_RefrescaCamposEnCarga == "S")
            {
                RefrescaInfo();
            }

        }

        protected void DespliegaMensaje(string Mensaje)
        {
            Mensaje = Mensaje.Replace("'", "");
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "MessageBox", "<script language='javascript'>alert('" + Mensaje + "');</script>");
        }

        protected void EstableceStatus(DevExpress.Web.ASPxTextBox lblStatus, string Mensaje)
        {
            lblStatus.Text = Mensaje;
        }

        public virtual void ExportaGrid()
        {

        }

        protected void CargaForma()
        {

        }


    }
}