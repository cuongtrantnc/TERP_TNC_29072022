using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.Linq;
using System.Web;

namespace TERP.Libs
{
    public class ExcelHelper
    {

        public DataSet ExcelToDS(string Path, string sheetname)
        {
            //string xlsConn = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Path + ";Extended Properties=Excel 8.0;";

            string xlsConn = string.Format("Provider=Microsoft.Jet.OLEDB.4.0;Data Source ={0}; Extended Properties = 'Excel 8.0;HRD=YES;IMEX=1'", Path);
            //string xlsxConn = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + Path + ";Extended Properties='Excel 12.0 Xml;HDR=YES'";
            using (OleDbConnection conn = new OleDbConnection(xlsConn))
            {
                conn.Open();
                string strExcel = "select * from " + sheetname + "";
                OleDbDataAdapter oledbda = new OleDbDataAdapter(strExcel, xlsConn);
                DataSet ds = new DataSet();
                oledbda.Fill(ds, sheetname);
                conn.Close();
                return ds;
            }
        }
    }
}