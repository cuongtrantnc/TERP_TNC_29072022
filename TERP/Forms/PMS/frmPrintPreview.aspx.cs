using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TERP.Libs;

namespace TERP.Forms.PMS
{
    public partial class frmPrintPreview : System.Web.UI.Page
    {
        TERPSession tERPSession;
        string prefix = "PrintPreview";

        protected void Page_init(object sender, EventArgs e)
        {
            var master = (TERP)Page.Master;
            master.OnLanguageSelected += LanguageSelected;
        }

        private void SetLanguageToDropDownList()
        {
            DropDownList ddLanguage = (DropDownList)this.Page.Master.FindControl("ddLanguage");
            ddLanguage.DataBind();
            for (int i = 0; i < ddLanguage.Items.Count; i++)
            {
                if (ddLanguage.Items[i].Text.Trim() == tERPSession.Language_code)
                {
                    ddLanguage.SelectedIndex = i;
                    break;
                }
            }
        }

        private void LanguageSelected(object sender, string selectedValue)
        {
            HttpContext.Current.Session["localization"] = Localization.LoadLocalizationMessage("PMS", prefix, tERPSession.Language_code);
            Localization.SetLocalizationMessage(true, this, prefix);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            tERPSession = (TERPSession)HttpContext.Current.Session["tERPSession"];

            if (tERPSession == null)
            {
                Response.Redirect("/terp/Login.aspx");
            }

            string rptFile = "/terp/Report/rpPRDemo.rpt";
            ReportDocument crystalReport;
            string query = "SELECT * FROM PMS_master_pr WHERE pr_no='" + HttpContext.Current.Session["pr_no"] + "'";
            string view = "PMS_master_pr";

            crystalReport = new ReportDocument();
            crystalReport.Load(Server.MapPath(rptFile));
            crystalReport = reportLogIn(crystalReport);

            SqlDataAdapter dataAdapter = new SqlDataAdapter(query, dsTemp.ConnectionString);
            DataSet ds = new DataSet();
            dataAdapter.Fill(ds, view);

            crystalReport.SetDataSource(ds.Tables[0]);
            crViewer.ReportSource = crystalReport;
            crViewer.RefreshReport();
        }

        public static ReportDocument reportLogIn(ReportDocument crystalReport)
        {
            if (crystalReport == null) return null;

            Configuration rootWebConfig = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration(null);
            string SERVER_NAME = ConfigurationManager.AppSettings["ServerName"];//["ServerName"].Value.ToString();
            string DATABASE_NAME = ConfigurationManager.AppSettings["DataBaseName"];//["DataBaseName"].Value.ToString();
            string DatabaseUser = ConfigurationManager.AppSettings["DatabaseUser"];//["DatabaseUser"].Value.ToString();
            string DatabasePassword = ConfigurationManager.AppSettings["DatabasePassword"];//["DatabasePassword"].Value.ToString();

            ConnectionInfo crConnectionInfo = new ConnectionInfo();
            crConnectionInfo.ServerName = SERVER_NAME;
            crConnectionInfo.DatabaseName = DATABASE_NAME;
            crConnectionInfo.UserID = DatabaseUser;
            crConnectionInfo.Password = DatabasePassword;

            Tables tables = crystalReport.Database.Tables;
            foreach (CrystalDecisions.CrystalReports.Engine.Table table in tables)
            {
                TableLogOnInfo tableLogOnInfo = table.LogOnInfo;
                tableLogOnInfo.ConnectionInfo = crConnectionInfo;
                table.ApplyLogOnInfo(tableLogOnInfo);
            }

            return crystalReport;
        }

    }
}