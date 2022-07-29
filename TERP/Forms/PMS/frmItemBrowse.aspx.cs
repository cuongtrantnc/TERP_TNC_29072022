using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TERP.Libs;

namespace TERP.Forms.PMS
{
    public partial class frmItemBrowse : System.Web.UI.Page
    {
        TERPSession tERPSession;
        string prefix = "ItemBrowse";

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

            if (!IsPostBack) {
                HttpContext.Current.Session["localization"] = Localization.LoadLocalizationMessage("PMS", prefix, tERPSession.Language_code);
                SetLanguageToDropDownList();
            }
            if (Tools.getPostBackControlName(this) == "grItemBrowse")
            {
                dsItemBrowse.SelectCommand = buildQuery();
            }
            LoadLocalizationMessage();

            dsItemBrowse.DataBind();
            lblTotal.Text = DbHelper.getRowCount(dsItemBrowse);
        }

        private void LoadLocalizationMessage()
        {
            HttpContext.Current.Session["localization"] = Localization.LoadLocalizationMessage("PMS", prefix, tERPSession.Language_code);
            Localization.SetLocalizationMessage(true, this, prefix);
        }

        protected void Edit_Click(object sender, ImageClickEventArgs e)
        {
            GridViewRow r = (GridViewRow)(((ImageButton)sender).Parent).Parent;
            Label lblStatus = (Label)r.FindControl("lblStatus");

            txtItemNumber.Text = r.Cells[2].Text;
            txtItemDescription.Text = r.Cells[3].Text.Replace("&nbsp;","");
            txtProductline.Text = r.Cells[5].Text.Replace("&nbsp;", "");
            txtItemType.Text = r.Cells[6].Text.Replace("&nbsp;", "");
            txtSite.Text = r.Cells[1].Text;
            if (lblStatus.Text.Trim() == "Active")
            {
                ddModalStatus.SelectedIndex = 0;
            }
            else
            {
                ddModalStatus.SelectedIndex = 1;
            }

            ScriptManager.RegisterStartupScript(this, this.GetType(), "#editFormModal", "itemBrowse_showEditItem();", true);
        }

        protected void Delete_Click(object sender, ImageClickEventArgs e)
        {
            GridViewRow r = (GridViewRow)(((ImageButton)sender).Parent).Parent;
            HttpContext.Current.Session["txtItemNumber"] = r.Cells[2].Text;
            ItemBrowse_lblIemDelete.Text = r.Cells[2].Text;

            ScriptManager.RegisterStartupScript(this, this.GetType(), "#comfirmDeleteModal", "itemBrowse_ComfirmDelete();", true);
        }

        protected void dsRowPerPage_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.CommandTimeout = 0;
        }

        protected void ItemBrowse_btCancel_Click(object sender, EventArgs e)
        {

        }

        protected void ItemBrowse_btSave_Click(object sender, EventArgs e)
        {
            string item_number = txtItemNumber.Text.Trim();
            string site = txtSite.Text.Trim();
            string desc = txtItemDescription.Text.Trim();
            string prod_line = txtProductline.Text.Trim();
            string item_type = txtItemType.Text.Trim();
            string status = ddModalStatus.SelectedItem.Value.Trim();

            if (site=="")
            {
                (new Mess(this)).ShowMessage("Site should be inputed", Mess.TYPE_ERROR);
                return;
            }

            string sql = "UPDATE PMS_master_item SET site='" + site + "', description='" + desc + "', prod_line='" + prod_line + "', type='" + item_type + "', status='" +
                status + "', last_edit_time='" + DateTime.Now.ToString("MM/dd/yyyy") + "', last_edit_by='" + tERPSession.User_id + "' WHERE item_number='" + item_number + "'";

            try
            {
                dsItemBrowse.UpdateCommand = sql;
                dsItemBrowse.Update();
                (new Mess(this)).ShowMessage("Item has been updated successfully", Mess.TYPE_SUCCESS);
            }
            catch (Exception ex)
            {
                (new Mess(this)).ShowMessage("Error occus: " + ex.Message, Mess.TYPE_ERROR);
            }
        }

        protected void ItemBrowse_btCancelConfirm_Click(object sender, EventArgs e)
        {
            HttpContext.Current.Session["txtItemNumber"] = null;
        }

        protected void ItemBrowse_btConfirm_Click(object sender, EventArgs e)
        {
            string item_number = (string)HttpContext.Current.Session["txtItemNumber"];

            dsItemBrowse.DeleteCommand = "DELETE FROM PMS_master_item WHERE item_number='" + item_number + "'";
            dsItemBrowse.Delete();
            lblTotal.Text = DbHelper.getRowCount(dsItemBrowse);
            HttpContext.Current.Session["txtItemNumber"] = null;
        }

        protected void ddRecordPerPage_SelectedIndexChanged(object sender, EventArgs e)
        {
            grItemBrowse.PageSize = int.Parse(ddRecordPerPage.SelectedItem.Text.Trim());
        }

        protected void grItemBrowse_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label label = (Label)e.Row.FindControl("lblStatus");

                if (label.Text.Trim() == "Active")
                {
                    label.CssClass = "bagde-custom_success";
                }
                else
                {
                    label.CssClass = "bagde-custom_danger";
                }
            }
        }

        protected void ItemBrowse_filterBtnSreach_Click(object sender, EventArgs e)
        {
            dsItemBrowse.SelectCommand = buildQuery();
            try
            {
                grItemBrowse.DataBind();
            }
            catch (Exception ex)
            {

            }
        }

        protected void ItemBrowse_filterBtnClear_Click(object sender, EventArgs e)
        {
            ItemBrowse_txtFilterSite.Text = "";
            ItemBrowse_txtFilterItemNumber.Text = "";
            ItemBrowse_txtFilterProductLine.Text = "";
            ItemBrowse_txtFilterType.Text = "";
            ddStatus.SelectedIndex = 0;
            dsItemBrowse.SelectCommand = buildQuery();
        }

        private string buildQuery()
        {
            string itemsite = ItemBrowse_txtFilterSite.Text.Trim();
            string itemNumber = ItemBrowse_txtFilterItemNumber.Text.Trim();
            string productLine = ItemBrowse_txtFilterProductLine.Text.Trim();
            string type = ItemBrowse_txtFilterType.Text.Trim();
            string status = ddStatus.SelectedItem.Value.Trim();
            string sql = "SELECT site, item_number, description, um, prod_line, type, status FROM PMS_master_item where  #";

            if (status == "")
            {
                sql = sql + "AND status IN ('Active','inactive') ";
            }
            else
            {
                sql = sql + "AND status = '" + status + "' ";
            }
            if (itemsite != "")
            {
                sql = sql + "AND site like  '%" + itemsite + "%' ";
            }
            if (itemNumber != "")
            {
                sql = sql + "AND item_number like '%" + itemNumber + "%' ";
            }
            if (productLine != "")
            {
                sql = sql + "AND prod_line like '%" + productLine + "%' ";
            }
            if (type != "")
            {
                sql = sql + "AND type like '%" + type + "%' ";
            }
            return sql.Replace("#AND", "").Replace("WHERE #", "");


        }
    }
}