using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using DevExpress;
using DevExpress.Export;
using DevExpress.Web;
using DevExpress.XtraPrinting;

namespace SICSA.modulos
{
    public partial class dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ASPxPageInformes.ActiveTabIndex = 0;
                TextDesde.Text = DateTime.Today.ToString("yyyy-MM-dd");
                TextHasta.Text = DateTime.Today.ToString("yyyy-MM-dd");
                TextDesde1.Text = DateTime.Today.ToString("yyyy-MM-dd");
                TextHasta1.Text = DateTime.Today.ToString("yyyy-MM-dd");
                TextBox1.Text = DateTime.Today.ToString("yyyy-MM-dd");
                TextBox2.Text = DateTime.Today.ToString("yyyy-MM-dd");
                ASPxComboBoxPeriodo.SelectedIndex = 0;
            }
        }

        protected void ASPxButtonExpXls_Click(object sender, EventArgs e)
        {
            gridExporter.WriteXlsxToResponse(new XlsxExportOptionsEx { ExportType = ExportType.WYSIWYG });
        }

        protected void ASPxButtonVerInforme_Click(object sender, EventArgs e)
        {
            ASPxGridView1.DataBind();
        }

        protected void ASPxButtonVerInforme1_Click(object sender, EventArgs e)
        {
            ASPxGridView2.DataBind();
        }

        protected void ASPxButtonExpExcel1_Click(object sender, EventArgs e)
        {
            gridExporter1.WriteXlsxToResponse(new XlsxExportOptionsEx { ExportType = ExportType.WYSIWYG });
        }

        protected void btnSeleccionar_Click(object sender, EventArgs e)
        {
            TomaDatosSeleccionados();
        }

        private void TomaDatosSeleccionados()
        {
            Int32 inicio = ASPxGridView2.VisibleStartIndex;
            Int32 fin = ASPxGridView2.VisibleStartIndex + ASPxGridView2.SettingsPager.PageSize;
            fin = (fin > ASPxGridView2.VisibleRowCount ? ASPxGridView2.VisibleRowCount : fin);
            int? cd_emp = 0;
            for (int i = inicio; i < fin; i++)
            {
                if (ASPxGridView2.Selection.IsRowSelected(i))
                {
                    List<object> resultado = new List<object>();
                    cd_emp = (int?)ASPxGridView2.GetRowValues(i, "CD_RESPONSABLE");
                }
            }
            //Cargar info de componentes.
            ASPxLabelCDEmp.Text = cd_emp.ToString();
            ASPxGridView3.DataBind();
            ASPxGridView3.Visible = true;
        }

        protected void ASPxButton2_Click(object sender, EventArgs e)
        {
            ASPxPivotGridExporter1.ExportXlsxToResponse("Estado_Acuerdos.xlsx");
        }

        protected void ASPxButton1_Click(object sender, EventArgs e)
        {
            ASPxPivotGrid1.DataBind();
            ASPxPivotGrid1.CollapseAllRows();
        }

        protected void ASPxButton3_Click(object sender, EventArgs e)
        {
            ASPxPivotGrid2.DataBind();
        }

        protected void ASPxButton4_Click(object sender, EventArgs e)
        {
            //ASPxPivotGridExporter2.ExportXlsxToResponse("Control_Tareas.xlsx");
            //ASPxGridViewExporter1.ExportXlsxToResponse("Seguimiento.xlsx");
            ASPxGridViewExporter1.WriteXlsxToResponse(new XlsxExportOptionsEx { ExportType = ExportType.WYSIWYG });
        }
        
    }
}