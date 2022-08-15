using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TERP.Libs;

namespace TERP.Forms.PMS
{
    public partial class frmPOBrowse : System.Web.UI.Page
    {
        TERPSession tERPSession;
        string prefix = "POBrowse";

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
                    getAllPOStatusID(status_Id, dr_Value);
                }
            }

            if (Tools.getPostBackControlName(this) == "grPOBrowse")
            {
                dsPOBrowse.SelectCommand = buildQuery();
                lblTotal.Text = DbHelper.getRowCount(dsPOBrowse);
            }

            LoadLocalizationMessage();
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
            string supplier = txtSupplier.Text.Trim();
            string due_date_from = txtFrom.Text.Trim();
            string due_date_to = txtTo.Text.Trim();

            string sql = "SELECT DISTINCT * FROM vPMS_master_po_browse WHERE ";

            if (status_id == "0")
            {
                sql = sql + "status_id IN (1,2) ";
            }
            else
            {
                sql = sql + "status_id='" + status_id + "' ";
            }

            if (po_no != "")
            {
                sql = sql + "AND po_no='" + po_no + "' ";
            }

            if (item_number != "")
            {
                sql = sql + "AND item_number = '" + item_number + "' ";
            }

            if (supplier != "")
            {
                sql = sql + "AND supplier='" + supplier + "' ";
            }

            if (due_date_from == "") due_date_from = due_date_to;
            if (due_date_to == "") due_date_to = due_date_from;

            if (due_date_from != "")
            {
                sql = sql + "AND due_date BETWEEN '" + due_date_from + "' AND '" + due_date_to + "'";
            }

            return sql;
        }

        protected void POBrowse_btSearch_Click(object sender, EventArgs e)
        {
            //WHERE status_id < 5";
            dsPOBrowse.SelectCommand = buildQuery();
            try
            {
                grPOBrowse.DataBind();
                lblTotal.Text = DbHelper.getRowCount(dsPOBrowse);
            }
            catch (Exception ex)
            {
                if (ex.Message.IndexOf("converting date") >= 0)
                {
                    (new Mess(this)).ShowMessage("Invalid Datetime inputed.", Mess.TYPE_ERROR);
                }
            }
        }

        protected void ddRecordPerPage_SelectedIndexChanged(object sender, EventArgs e)
        {
            grPOBrowse.PageSize = int.Parse(ddRecordPerPage.SelectedItem.Text.Trim());
            POBrowse_btSearch_Click(sender, e);
        }

        protected void dsPOBrowse_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.CommandTimeout = 0;
        }

        protected void POBrowse_btClear_Click(object sender, EventArgs e)
        {
            txtPONo.Text = "";
            txtItemNo.Text = "";
            txtSupplier.Text = "";
            txtFrom.Text = "";
            txtTo.Text = "";
            ddStatus.SelectedIndex = 0;

            //Clear Session
            Session["dropdown_Value"] = null;
            Session["status_Id"] = null;
        }

        protected void getAllPOStatusID(int status_Id, int dr_Value)
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

            string sql = "SELECT * FROM vPMS_master_po_browse WHERE status_id = " + status_Id + query_timer;
            dsPOBrowse.SelectCommand = sql;
            grPOBrowse.DataBind();
            lblTotal.Text = DbHelper.getRowCount(dsPOBrowse);
        }
    }
}