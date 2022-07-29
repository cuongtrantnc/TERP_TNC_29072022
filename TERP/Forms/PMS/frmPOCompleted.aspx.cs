using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TERP.Libs;

namespace TERP.Forms.PMS
{
    public partial class frmPOCompleted : System.Web.UI.Page
    {
        TERPSession tERPSession;
        string prefix = "POCompleted";

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

            if (!IsPostBack)
            {
                HttpContext.Current.Session["localization"] = Localization.LoadLocalizationMessage("PMS", prefix, tERPSession.Language_code);
                SetLanguageToDropDownList();

                //filter by condition when default page link click
                if (Session != null)
                {
                    int dr_Value = Convert.ToInt16(Session["dropdown_Value"]);
                    int status_Id = Convert.ToInt16(Session["status_Id"]);

                    ddStatus.SelectedValue = status_Id.ToString();
                    getAllStatusID(status_Id, dr_Value);
                }
            }

            if (Tools.getPostBackControlName(this) == "grPOCompleted")
            {
                dsPOCompletedBrowse.SelectCommand = buildQuery();
                lblTotal.Text = DbHelper.getRowCount(dsPOCompletedBrowse);
            }

            LoadLocalizationMessage();

            DataRow dr = DbHelper.getDataRow("SELECT Approved,Rejected FROM vPMS_po_completed_overview", dsStatus.ConnectionString);
            if (dr != null)
            {
                lblApprovalPOValue.Text = dr[0].ToString().Trim();
                lblRejectedPOValue.Text = dr[1].ToString().Trim();
                lblTotalPOValue.Text = (int.Parse(dr[0].ToString().Trim()) + int.Parse(dr[1].ToString().Trim())).ToString();
            }
            else
            {
                lblApprovalPOValue.Text = "0";
                lblRejectedPOValue.Text = "0";
                lblTotalPOValue.Text = "0";
            }

        }

        private void LoadLocalizationMessage()
        {
            if (HttpContext.Current.Session["localization"] == null)
            {
                HttpContext.Current.Session["localization"] = Localization.LoadLocalizationMessage("PMS", prefix, tERPSession.Language_code);
            }

            Localization.SetLocalizationMessage(true, this, prefix);
        }

        private string buildQuery()
        {
            string po_no = txtPONo.Text.Trim();
            string item_number = txtItemNo.Text.Trim();
            string status_id = ddStatus.SelectedItem.Value.Trim();
            string from_date = txtDateForm.Text.Trim();
            string to_date = txtDateTo.Text.Trim();
            string supplier = txtSupplier.Text.Trim();

            string sql = "SELECT * FROM vPMS_po_completed WHERE #";

            if (po_no != "")
            {
                sql += "AND po_no='" + po_no + "' ";
            }

            if (item_number != "")
            {
                sql += "AND item_number='" + item_number + "' ";
            }

            if (status_id != "0")
            {
                sql += "AND status_id='" + status_id + "' ";
            }

            if (from_date == "") from_date = to_date;
            if (to_date == "") to_date = from_date;

            if (from_date != "")
            {
                sql += "AND due_date BETWEEN '" + from_date + "' AND '" + to_date + "' ";
            }

            if (supplier != "")
            {
                sql += "AND supplier LIKE '%" + supplier + "%' ";
            }

            sql = sql.Replace("#AND", "").Replace("WHERE #", "").Trim();

            return sql;
        }

        protected void POCompleted_btSearch_Click(object sender, EventArgs e)
        {
            dsPOCompletedBrowse.SelectCommand = buildQuery();
            grPOCompleted.DataBind();
            lblTotal.Text = DbHelper.getRowCount(dsPOCompletedBrowse);

        }
        protected void ddRecordPerPage_SelectedIndexChanged(object sender, EventArgs e)
        {
            grPOCompleted.PageSize = int.Parse(ddRecordPerPage.SelectedItem.Value);
            POCompleted_btSearch_Click(sender, e);
        }

        protected void dsRowPerPage_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.CommandTimeout = 0;
        }

        protected void POCompleted_Clear_Click(object sender, EventArgs e)
        {
            txtPONo.Text = "";
            txtItemNo.Text = "";
            ddStatus.SelectedIndex = 0;
            txtDateForm.Text = "";
            txtDateTo.Text = "";
            txtSupplier.Text = "";

            //Clear Session
            Session["dropdown_Value"] = null;
            Session["status_Id"] = null;
        }

        protected void getAllStatusID(int status_Id, int dr_Value)
        {
            string timer = " And create_time IS NOT NULL";
            switch (dr_Value)
            {
                case 1:
                    timer = "And create_time BETWEEN DATEADD(day, -7, CAST(GETDATE() As date)) and GETDATE()";
                    break;
                case 2:
                    timer = "AND MONTH(create_time) = MONTH(GETDATE()) And YEAR(create_time) = YEAR(GETDATE())";
                    break;
                case 3:
                    timer = "AND DatePart(q,CAST((create_time) As DateTime)) = DatePart(q,CAST((GETDATE()) As DateTime))";
                    break;
                case 4:
                    timer = "AND YEAR(create_time) = YEAR(GETDATE())";
                    break;
                default:
                    break;
            }

            string query_timer = timer;

            string sql = "SELECT po_no,line,supplier,supplier_name,item_number,description,required_qty,due_date,status_id,status FROM vPMS_po_completed WHERE status_id =" + status_Id + query_timer;
            dsPOCompletedBrowse.SelectCommand = sql;
            grPOCompleted.DataBind();
            lblTotal.Text = DbHelper.getRowCount(dsPOCompletedBrowse);
        }
    }
}