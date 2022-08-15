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
    public partial class frmSupplierEvaluationReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string rptFile = "/terp/Report/SupplierEvaluation.rpt";
            string ImageURL = "D:\\HUUNHAT\\ThinkNextco\\PMS\\TERP_180122\\TERP\\Images\\logo-ThinkNextco.png";
            ReportDocument crystalReport;

            crystalReport = new ReportDocument();
            //crystalReport.SetParameterValue("ImageURL", "//terp//Images//logo-ThinkNext.png");
            crystalReport.Load(Server.MapPath(rptFile));


            CrystalReportViewer.ReportSource = crystalReport;
        }
    }
}