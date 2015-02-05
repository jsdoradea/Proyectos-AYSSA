using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TEGNotes.views.convocatoria
{
    public partial class convocatoria : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.iframe.Attributes.Add("src", "../convocatoria/convocatoria_frame.aspx");
        }
    }
}