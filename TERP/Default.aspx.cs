using TERP.Libs;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;

namespace TERP
{
    public partial class Default : System.Web.UI.Page
    {

        public static string timestr = " And create_time IS NOT NULL";
        protected void Page_Load(object sender, EventArgs e)
        {
            TERPSession TERPSession = (TERPSession)HttpContext.Current.Session["TERPSession"];

            if (TERPSession == null)
            {
                //(new Mess(this)).show("Please login");
                Response.Redirect("/TERP/Login.aspx");
            }

            if (!IsPostBack)
            {
                
            }

        }

        public void Selection_Change(Object sender, EventArgs e)
        {
            if (Default_DrOption.Items[Default_DrOption.SelectedIndex].Value == "0")
            {
                timestr = " And create_time IS NOT NULL";
            }
            else if (Default_DrOption.Items[Default_DrOption.SelectedIndex].Value == "1")
            {
                timestr = " And create_time BETWEEN DATEADD(day, -7, CAST(GETDATE() As date)) and GETDATE()";
            }
            else if (Default_DrOption.Items[Default_DrOption.SelectedIndex].Value == "2")
            {
                timestr = " AND MONTH(create_time) = MONTH(GETDATE()) And YEAR(create_time) = YEAR(GETDATE())";
            }
            else if (Default_DrOption.Items[Default_DrOption.SelectedIndex].Value == "3")
            {
                timestr = " AND DatePart(q,CAST((create_time) As DateTime)) = DatePart(q,CAST((GETDATE()) As DateTime)) ";
            }
            else if (Default_DrOption.Items[Default_DrOption.SelectedIndex].Value == "4")
            {
                timestr = " AND YEAR(create_time) = YEAR(GETDATE())";
            }

            Session["dropdown_Value"] = Default_DrOption.SelectedValue.ToString();
        }

        [WebMethod]
        public static string CountPRApproved()
        {
            string query = "SELECT COUNT(*) from vPMS_pr_completed where status_id = 3" + timestr;
            string connstring = System.Configuration.ConfigurationManager.ConnectionStrings["TERPConnectionString"].ConnectionString;
            DataRow dr = DbHelper.getDataRow(query, connstring);

            if (dr!=null)
            {
                return dr[0].ToString();
            } else
            {
                return "0";
            }
        }

        [WebMethod]
        public static string CountPRRejected()
        {
            string query = "SELECT COUNT(*) from vPMS_pr_completed where status_id = 4" + timestr;
            string connstring = System.Configuration.ConfigurationManager.ConnectionStrings["TERPConnectionString"].ConnectionString;
            DataRow dr = DbHelper.getDataRow(query, connstring);

            if (dr != null)
            {
                return dr[0].ToString();
            }
            else
            {
                return "0";
            }
        }

        [WebMethod]
        public static string CountPRUnApproved()
        {
            string query = "select count(*) from(SELECT DISTINCT pr_no, request_by, supplier, purchaser_email, due_date, status FROM vPMS_master_pr_browse WHERE status_id = 1" + timestr + ")a";
            string connstring = System.Configuration.ConfigurationManager.ConnectionStrings["TERPConnectionString"].ConnectionString;
            DataRow dr = DbHelper.getDataRow(query, connstring);

            if (dr != null)
            {
                return dr[0].ToString();
            }
            else
            {
                return "0";
            }
        }

        [WebMethod]
        public static string CountPROnProcess()
        {
            string query = "select count(*) from(SELECT DISTINCT pr_no, request_by, supplier, purchaser_email, due_date, status FROM vPMS_master_pr_browse WHERE status_id = 2" + timestr + ")a";
            string connstring = System.Configuration.ConfigurationManager.ConnectionStrings["TERPConnectionString"].ConnectionString;
            DataRow dr = DbHelper.getDataRow(query, connstring);

            if (dr != null)
            {
                return dr[0].ToString();
            }
            else
            {
                return "0";
            }
        }

        //End PR

        [WebMethod]
        public static string CountPOApproved()
        {
            string query = "SELECT COUNT(*) from vPMS_po_completed where status_id = 3" + timestr;
            string connstring = System.Configuration.ConfigurationManager.ConnectionStrings["TERPConnectionString"].ConnectionString;
            DataRow dr = DbHelper.getDataRow(query, connstring);

            if (dr != null)
            {
                return dr[0].ToString();
            }
            else
            {
                return "0";
            }
        }

        [WebMethod]
        public static string CountPORejected()
        {
            string query = "SELECT COUNT(*) from vPMS_po_completed where status_id = 4" + timestr;
            string connstring = System.Configuration.ConfigurationManager.ConnectionStrings["TERPConnectionString"].ConnectionString;
            DataRow dr = DbHelper.getDataRow(query, connstring);

            if (dr != null)
            {
                return dr[0].ToString();
            }
            else
            {
                return "0";
            }
        }

        [WebMethod]
        public static string CountPOUnApproved()
        {
            string query = "select count(*) from (SELECT DISTINCT * FROM vPMS_master_po_browse WHERE status_id = 1" + timestr + ")a";
            string connstring = System.Configuration.ConfigurationManager.ConnectionStrings["TERPConnectionString"].ConnectionString;
            DataRow dr = DbHelper.getDataRow(query, connstring);

            if (dr != null)
            {
                return dr[0].ToString();
            }
            else
            {
                return "0";
            }
        }

        [WebMethod]
        public static string CountPOOnProcess()
        {
            string query = "select count(*) from (SELECT DISTINCT * FROM vPMS_master_po_browse WHERE status_id = 2" + timestr + ")a";
            string connstring = System.Configuration.ConfigurationManager.ConnectionStrings["TERPConnectionString"].ConnectionString;
            DataRow dr = DbHelper.getDataRow(query, connstring);

            if (dr != null)
            {
                return dr[0].ToString();
            }
            else
            {
                return "0";
            }
        }

        //End PO

        [WebMethod]
        public static string CountTotalUnapproved()
        {
            int total = Int32.Parse(CountPOUnApproved()) + Int32.Parse(CountPOOnProcess());

            return total.ToString();
        }

        public static string CountTotalUnapprovedAfter3Days()
        {
            string query = "select count(*) from (SELECT DISTINCT * FROM vPMS_master_po_browse WHERE DATEDIFF(DAY,vPMS_master_po_browse.create_time, GETDATE()) = 3 AND (status_id = 1 OR status_id = 2)" + timestr + ")a";
            string connstring = System.Configuration.ConfigurationManager.ConnectionStrings["TERPConnectionString"].ConnectionString;
            DataRow dr = DbHelper.getDataRow(query, connstring);

            if (dr != null)
            {
                return dr[0].ToString();
            }
            else
            {
                return "0";
            }
        }

        public static string CountTotalUnapprovedAfter7Days()
        {
            string query = "select count(*) from (SELECT DISTINCT * FROM vPMS_master_po_browse WHERE DATEDIFF(DAY,vPMS_master_po_browse.create_time, GETDATE()) = 7 AND (status_id = 1 OR status_id = 2)" + timestr + ")a";
            string connstring = System.Configuration.ConfigurationManager.ConnectionStrings["TERPConnectionString"].ConnectionString;
            DataRow dr = DbHelper.getDataRow(query, connstring);

            if (dr != null)
            {
                return dr[0].ToString();
            }
            else
            {
                return "0";
            }
        }

        [WebMethod]
        public static string PieChartData()
        {
            string dstr = CountPOApproved() + "," + CountTotalUnapprovedAfter3Days() + "," + CountTotalUnapprovedAfter7Days();

            return dstr;
        }

        public static string CountTotalPOOfThisMonth()
        {
            string query = "select count(*) from (SELECT DISTINCT(po_no) from vPMS_master_po_browse where MONTH(vPMS_master_po_browse.create_time) = MONTH(GETDATE()) And YEAR(vPMS_master_po_browse.create_time) = YEAR(GETDATE()))a";
            string connstring = System.Configuration.ConfigurationManager.ConnectionStrings["TERPConnectionString"].ConnectionString;
            DataRow dr = DbHelper.getDataRow(query, connstring);

            if (dr != null)
            {
                return dr[0].ToString();
            }
            else
            {
                return "0";
            }
        }

        public static string CountTotalPOOfLastMonth()
        {
            string query = "select COUNT(*) from (SELECT DISTINCT(po_no) from vPMS_master_po_browse WHERE DATEPART(m, vPMS_master_po_browse.create_time) = DATEPART(m, DATEADD(m, -1, getdate())) AND DATEPART(yyyy, vPMS_master_po_browse.create_time) = DATEPART(yyyy, DATEADD(m, -1, getdate())))a";
            string connstring = System.Configuration.ConfigurationManager.ConnectionStrings["TERPConnectionString"].ConnectionString;
            DataRow dr = DbHelper.getDataRow(query, connstring);

            if (dr != null)
            {
                return dr[0].ToString();
            }
            else
            {
                return "0";
            }
        }

        public static string CountTotalPOOfLast2Month()
        {
            string query = "select COUNT(*) from (SELECT DISTINCT(po_no) from vPMS_master_po_browse WHERE DATEPART(m, vPMS_master_po_browse.create_time) = DATEPART(m, DATEADD(m, -2, getdate())) AND DATEPART(yyyy, vPMS_master_po_browse.create_time) = DATEPART(yyyy, DATEADD(m, -2, getdate())))a";
            string connstring = System.Configuration.ConfigurationManager.ConnectionStrings["TERPConnectionString"].ConnectionString;
            DataRow dr = DbHelper.getDataRow(query, connstring);

            if (dr != null)
            {
                return dr[0].ToString();
            }
            else
            {
                return "0";
            }
        }

        [WebMethod]
        public static string LineChartData()
        {
            string dstr = CountTotalPOOfThisMonth() + "," + CountTotalPOOfLastMonth() + "," + CountTotalPOOfLast2Month();

            return dstr;
        }

        protected void Default_linkPRApproved_Click(object sender, EventArgs e)
        {
            Session["status_Id"] = 3;
            Response.Redirect("/TERP/Forms/PMS/frmPRCompleted.aspx");
        }

        protected void Default_linkPRRejected_Click(object sender, EventArgs e)
        {
            Session["status_Id"] = 4;
            Response.Redirect("/TERP/Forms/PMS/frmPRCompleted.aspx");
        }

        protected void Default_linkPOApproved_Click(object sender, EventArgs e)
        {
            Session["status_Id"] = 3;
            Response.Redirect("/TERP/Forms/PMS/frmPOCompleted.aspx");
        }

        protected void Default_linkPORejected_Click(object sender, EventArgs e)
        {
            Session["status_Id"] = 4;
            Response.Redirect("/TERP/Forms/PMS/frmPOCompleted.aspx");
        }

        protected void Default_linkPRUnapproved_Click(object sender, EventArgs e)
        {
            Session["status_Id"] = 1;
            Response.Redirect("/TERP/Forms/PMS/frmPRMaintenance.aspx");
        }

        protected void Default_linkPROnProcess_Click(object sender, EventArgs e)
        {
            Session["status_Id"] = 2;
            Response.Redirect("/TERP/Forms/PMS/frmPRMaintenance.aspx");
        }

        protected void Default_linkPOUnapproved_Click(object sender, EventArgs e)
        {
            Session["status_Id"] = 1;
            Response.Redirect("/TERP/Forms/PMS/frmPOBrowse.aspx");
        }

        protected void Default_linkPOOnProcess_Click(object sender, EventArgs e)
        {
            Session["status_Id"] = 2;
            Response.Redirect("/TERP/Forms/PMS/frmPOBrowse.aspx");
        }
    }
}