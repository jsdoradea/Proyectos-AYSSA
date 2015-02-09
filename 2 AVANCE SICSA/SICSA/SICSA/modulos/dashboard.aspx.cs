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
        
    }
}