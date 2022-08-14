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
    public partial class frmSupplierComparison : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //string rptFile = "/terp/Report/SupplierComparison.rpt";
            //ReportDocument crystalReport;

            //crystalReport = new ReportDocument();
            //crystalReport.Load(Server.MapPath(rptFile));


            //CrystalReportViewer1.ReportSource = crystalReport;

        }

        protected void frmSupplierComparison_btnCreateNew_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "#SupplierForm", "showSupplier_Form();", true);
        }

        protected void btnEditSupplier_Click(object sender, ImageClickEventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "#SupplierForm", "showSupplier_Form();", true);
        }

        protected void btnDetailItemView_Click(object sender, ImageClickEventArgs e)
        {
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "#SupplierComparison_ViewReport", "showComparisonReport();", true);

            //string rptFile = "/terp/Report/SupplierComparison.rpt";
            //ReportDocument crystalReport;

            //crystalReport = new ReportDocument();
            //crystalReport.Load(Server.MapPath(rptFile));


            //CrystalReportViewer.ReportSource = crystalReport;

            //ClientScript.RegisterStartupScript(this.GetType(), "Pop", "OpenModal();", true);
            HttpContext.Current.Response.Redirect("frmSupplierComparisonReport.aspx");
        }

    }
}