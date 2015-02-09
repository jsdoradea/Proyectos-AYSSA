using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SICSA.clases
{
    public class datos_convocatoria
    {
        public string ds_ref { get; set; }
        public int cd_sesion { get; set; }
        public int cd_estado { get; set; }
        public DateTime fe_prop { get; set; }
        public TimeSpan hora_prop { get; set; }
        public int cd_lugar { get; set; }
    }
}