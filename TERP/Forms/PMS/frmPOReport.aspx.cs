using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;

namespace TERP.Forms.PMS
{
    public partial class frmPOReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string rptFile = "/terp/Report/POReport.rpt";
            ReportDocument crystalReport;

            crystalReport = new ReportDocument();
            crystalReport.Load(Server.MapPath(rptFile));


            CrystalReportViewer.ReportSource = crystalReport;
        }

        protected void POReport_btQuery_Click(object sender, EventArgs e)
        {

        }
    }
}