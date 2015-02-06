using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SICSA.clases
{
    public class datos_acuerdo
    {
        public string ds_acuerdo_comp { get; set; }
        public string ds_acuerdo_corto { get; set; }
        public int tipo_acuerdo { get; set; }
        public DateTime fecha_inicio { get; set; }
        public int periodo { get; set; }
        public int responsable { get; set; }
    }
}