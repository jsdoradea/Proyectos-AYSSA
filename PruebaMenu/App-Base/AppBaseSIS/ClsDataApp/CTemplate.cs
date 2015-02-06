using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SIS.Data
{
    public class CTemplate : IDisposable
    {
        protected SqlConnection ObjConnection;
        protected SqlDataAdapter ObjAdapter;
        protected SqlParameter ObjParam;
        protected SqlCommand ObjCommand;
        protected SqlDataReader ObjReader;

        public void Dispose()
        {
            if (ObjConnection.State != ConnectionState.Closed)
            {
                ObjConnection.Close();
            }

            ObjConnection = null;
            ObjAdapter = null;
            ObjParam = null;
            ObjCommand = null;
            ObjReader = null;
        }

    }
}