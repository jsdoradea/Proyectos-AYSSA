using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de datos_correspondencia
/// </summary>
public class datos_correspondencia
{
    public int estado { get; set; }
    public DateTime fec_registro { get; set; }
    public DateTime fec_solicitud { get; set; }
    public int origen { get; set; }
    public int solicitante { get; set; }
    public int unidad { get; set; }
    public int tipo_correspondencia { get; set; }
    public string punto { get; set; }
    public string justificacion { get; set; }
}