using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TERP.Libs;

namespace TERP.Forms.PMS
{
    public partial class frmPOHistory : System.Web.UI.Page
    {
        TERPSession tERPSession;
        string prefix = "POHistory";

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
            }

            if (Tools.getPostBackControlName(this) == "grPOHistory")
            {
                dsPOHistoryBrowse.SelectCommand = getQuery();
                lblTotal.Text = DbHelper.getRowCount(dsPOHistoryBrowse);
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

        private string getQuery()
        {
            string po_no = txtPONo.Text.Trim();
            string supplier = txtSupplier.Text.Trim();
            string status_id = ddStatus.SelectedItem.Value.Trim();
            string from_date = txtDueDateFrom.Text.Trim();
            string to_date = txtDueDateTo.Text.Trim();
            string request_by = txtRequestBy.Text.Trim();

            string sql = "SELECT DISTINCT * FROM vPMS_po_history WHERE #";

            if (po_no != "")
            {
                sql += "AND po_no='" + po_no + "' ";
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

            if (request_by != "")
            {
                sql += "AND request_by LIKE '%" + request_by + "%' ";
            }

            sql = sql.Replace("#AND", "").Replace("WHERE #", "").Trim();

            return sql;
        }

        private void updateGrHistory()
        {
            dsPOHistoryBrowse.SelectCommand = getQuery();
            grPOHistory.DataBind();
            lblTotal.Text = DbHelper.getRowCount(dsPOHistoryBrowse);
        }

        protected void POHistory_btSearch_Click(object sender, EventArgs e)
        {
            updateGrHistory();
        }

        protected void ddRecordPerPage_SelectedIndexChanged(object sender, EventArgs e)
        {
            grPOHistory.PageSize = int.Parse(ddRecordPerPage.SelectedItem.Text);
            //dsPOHistoryBrowse.SelectCommand = getQuery();
            POHistory_btSearch_Click(sender, e);
        }

        protected void dsStatus_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.CommandTimeout = 0;
        }
    }
}