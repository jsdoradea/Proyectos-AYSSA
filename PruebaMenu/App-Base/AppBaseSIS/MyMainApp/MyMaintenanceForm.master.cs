using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SIS.Framework;
using SIS.Framework.Common;
using SIS.Data;
using ClsDataSets;


namespace ClsFormas
{
    public partial class MyMaintenanceForm : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

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

        }

        public void Limpiar()
        {

        }
    }
}