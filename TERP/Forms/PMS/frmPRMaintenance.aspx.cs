using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TERP.Libs;

namespace TERP.Forms.PMS
{
    public partial class frmPRMaintenance : System.Web.UI.Page
    {
        TERPSession tERPSession;
        string prefix = "PRMaintenance";

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

                ddStatus.DataBind();
                if (ddStatus.Items.Count > 0) ddStatus.SelectedIndex = 0;

                ddSupplier.DataBind();
                if (ddSupplier.Items.Count > 0) ddSupplier.SelectedIndex = 0;

                if (ddSupplier.SelectedIndex >= 0 && ddStatus.SelectedIndex >= 0)
                    btSearch_Click(sender, e);

                ddSuppilerModal.DataBind();
                if (ddSuppilerModal.Items.Count > 0) ddSuppilerModal.SelectedIndex = 0;

                ddSiteModal.DataBind();
                if (ddSiteModal.Items.Count > 0) ddSiteModal.SelectedIndex = 0;

                ddAprovalCodeModal.DataBind();
                if (ddAprovalCodeModal.Items.Count > 0) ddAprovalCodeModal.SelectedIndex = 0;

                SetLanguageToDropDownList();

                //filter by condition when default page link click
                if (Session != null)
                {
                    int dr_Value = Convert.ToInt16(Session["dropdown_Value"]);
                    int status_Id = Convert.ToInt16(Session["status_Id"]);

                    ddStatus.SelectedValue = status_Id.ToString();
                    getAllPRStatusID(status_Id, dr_Value);
                }
            }

            LoadLocalizationMessage();

            //if (Tools.getPostBackControlName(this) == "ddSuppilerModal" || Tools.getPostBackControlName(this) == "txtShipToModal" ||
            //    Tools.getPostBackControlName(this) == "txtDeptModal" || Tools.getPostBackControlName(this) == "txtEndUserModal" ||
            //    Tools.getPostBackControlName(this) == "ddSiteModal")
            //{
            //    //updateModalGridFilter();
            //}
            //
            if (Tools.getPostBackControlName(this) == "grPRMaint")
            {
                dsPRMaintBrowse.SelectCommand = buildQuery();
                try
                {
                    grPRMaint.DataBind();
                    lblTotal.Text = DbHelper.getRowCount(dsPRMaintBrowse);
                }
                catch (Exception ex)
                {
                    if (ex.Message.IndexOf("converting date") >= 0 || ex.Message.IndexOf("datetime data type") >= 0)
                    {
                        (new Mess(this)).ShowMessage("Invalid Datetime inputed.", Mess.TYPE_ERROR);
                    }
                }
            }

            if (HttpContext.Current.Session["menu_type"] != null)
            {
                if (HttpContext.Current.Session["menu_type"].ToString() == "edit")
                {
                    PRMaintenance_lbModalTitle.Text = Localization.GetLocalizationMessage("PRMaintenance_lbModalTitle_Edit");// "Edit PR";
                    PRMaintenance_btSave.Text = Localization.GetLocalizationMessage("PRMaintenance_btUpdate");// "Update";
                }
                else
                {
                    PRMaintenance_lbModalTitle.Text = Localization.GetLocalizationMessage("PRMaintenance_lbModalTitle_Create");// "Create RFP";
                    PRMaintenance_btSave.Text = Localization.GetLocalizationMessage("PRMaintenance_btSave"); // "Save";
                }
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

        protected void btCreate_Click(object sender, EventArgs e)
        {
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "#prMaintModal", "showPRMaintModal();", true);
            PRMaintenance_lbModalTitle.Text = Localization.GetLocalizationMessage("PRMaintenance_lbModalTitle_Create");// "Create RFP";
            PRMaintenance_btSave.Text = Localization.GetLocalizationMessage("PRMaintenance_btSave"); // "Save";

            HttpContext.Current.Session["menu_type"] = "create";

            ddSuppilerModal.DataBind();
            if (ddSuppilerModal.Items.Count > 0) ddSuppilerModal.SelectedIndex = 0;

            txtShipToModal.Text = "";
            txtEndUserModal.Text = "";
            txtRequestByModal.Text = "";

            ddSiteModal.DataBind();
            if (ddSiteModal.Items.Count > 0) ddSiteModal.SelectedIndex = 0;

            ddAprovalCodeModal.DataBind();
            if (ddSiteModal.Items.Count > 0) ddSiteModal.SelectedIndex = 0;

            dsPRMaintDetailModal.DeleteCommand = "DELETE FROM PMS_master_pr_temp WHERE create_by='" + tERPSession.User_id + "'";
            dsPRMaintDetailModal.Delete();

            //Delete all locked pr_no 
            dsPRMaintDetailModal.DeleteCommand = "DELETE FROM PMS_pr_no_locking WHERE pr_no LIKE 'TR%' AND locked_by='" + tERPSession.User_id + "'";
            dsPRMaintDetailModal.Delete();

            //Lock new pr_no
            string pr_no = "TR000001";
            DataRow dr = DbHelper.getDataRow("SELECT DISTINCT TOP (1) pr_no FROM vPMS_pr_no_max_created ORDER BY pr_no DESC", dsPRMaintDetailModal.ConnectionString);
            if (dr != null)
            {
                string index = dr[0].ToString().Replace("TR", "");
                pr_no = "TR" + fillPRNo(int.Parse(index) + 1);
            }
            dsPRMaintDetailModal.InsertCommand = "INSERT INTO PMS_pr_no_locking (pr_no,locked_by) VALUES ('" + pr_no + "','" + tERPSession.User_id + "')";
            dsPRMaintDetailModal.Insert();

            lblCurrentPR.Text = pr_no;

            divAddEdit.Visible = true;
            divMain.Visible = false;
            PRMaintenance_btCreate.Visible = false;
        }

        private string fillPRNo(int pr_no)
        {
            string s_pr_no = pr_no.ToString();
            int pr_no_len = s_pr_no.Length;

            for (int i = 0; i < 6 - pr_no_len; i++)
            {
                s_pr_no = "0" + s_pr_no;
            }

            return s_pr_no;
        }

        private string buildQuery()
        {
            string pr_no = txtPRNo.Text.Trim();
            string status_id = ddStatus.SelectedItem.Value.Trim();
            string supplier = ddSupplier.SelectedItem.Value.Trim();
            string request_by = txtRequestBy.Text.Trim();
            string due_date_from = txtDueDateFrom.Text.Trim();
            string due_date_to = txtDueDateTo.Text.Trim();

            string sql = "SELECT DISTINCT pr_no,request_by,supplier,purchaser_email,due_date,status FROM vPMS_master_pr_browse WHERE ";

            if (status_id == "0")
            {
                sql = sql + "status_id<5 ";
            }
            else
            {
                sql = sql + "status_id='" + status_id + "' ";
            }

            if (pr_no != "")
            {
                sql = sql + "AND pr_no='" + pr_no + "' ";
            }

            if (request_by != "")
            {
                sql = sql + "AND request_by LIKE '%" + request_by + "%' ";
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

        protected void btSearch_Click(object sender, EventArgs e)
        {
            //WHERE status_id < 5";
            dsPRMaintBrowse.SelectCommand = buildQuery();
            try
            {
                grPRMaint.DataBind();
                lblTotal.Text = DbHelper.getRowCount(dsPRMaintBrowse);
            }
            catch (Exception ex)
            {
                if (ex.Message.IndexOf("converting date") >= 0 || ex.Message.IndexOf("datetime data type") >= 0)
                {
                    (new Mess(this)).ShowMessage("Invalid Datetime inputed.", Mess.TYPE_ERROR);
                }
            }
        }

        protected void btClear_Click(object sender, EventArgs e)
        {
            txtPRNo.Text = "";
            ddSupplier.SelectedIndex = 0;
            ddStatus.SelectedIndex = 0;
            txtRequestBy.Text = "";
            txtDueDateFrom.Text = "";
            txtDueDateTo.Text = "";

            //Clear Session
            Session["dropdown_Value"] = null;
            Session["status_Id"] = null;
        }

        protected void btEdit_Click(object sender, ImageClickEventArgs e)
        {
            GridViewRow row = ((GridViewRow)(((ImageButton)sender).Parent.Parent));
            string pr_no = row.Cells[0].Text.Trim();

            lblCurrentPR.Text = pr_no;
            PRMaintenance_lbModalTitle.Text = Localization.GetLocalizationMessage("PRMaintenance_lbModalTitle_Edit");// "Edit PR";
            PRMaintenance_btSave.Text = Localization.GetLocalizationMessage("PRMaintenance_btUpdate");// "Update";

            HttpContext.Current.Session["menu_type"] = "edit";

            dsPRMaintDetailModal.DeleteCommand = "DELETE FROM PMS_master_pr_temp WHERE create_by='" + tERPSession.User_id + "'";
            dsPRMaintDetailModal.Delete();

            //Delete all locked pr_no 
            dsPRMaintDetailModal.DeleteCommand = "DELETE FROM PMS_pr_no_locking WHERE pr_no='" + pr_no + "' AND locked_by='" + tERPSession.User_id + "'";
            dsPRMaintDetailModal.Delete();

            //Check pr_no locked or not
            DataRow dr = DbHelper.getDataRow("SELECT pr_no,user_full_name FROM vPMS_pr_no_locking WHERE pr_no='" + pr_no + "'", dsPRMaintBrowse.ConnectionString);

            if (dr != null)
            {
                (new Mess(this)).ShowMessage("This PR has been locking by " + dr[1].ToString(), Mess.TYPE_ERROR);
            }
            else
            {
                divAddEdit.Visible = true;
                divMain.Visible = false;

                //Lock new pr_no
                dsPRMaintDetailModal.InsertCommand = "INSERT INTO PMS_pr_no_locking (pr_no,locked_by) VALUES ('" + pr_no + "','" + tERPSession.User_id + "')";
                dsPRMaintDetailModal.Insert();

                updateModalGridFilter(pr_no);
            }

            PRMaintenance_btCreate.Visible = false;
        }

        protected void btPrint_Click(object sender, ImageClickEventArgs e)
        {
            GridViewRow row = ((GridViewRow)(((ImageButton)sender).Parent.Parent));
            string pr_no = row.Cells[0].Text.Trim();
            HttpContext.Current.Session["pr_no"] = pr_no;

            Response.Redirect("/terp/Forms/PMS/frmPrintPreview.aspx");
        }

        protected void btClose_Click(object sender, ImageClickEventArgs e)
        {
            GridViewRow row = ((GridViewRow)(((ImageButton)sender).Parent.Parent));
            string pr_no = row.Cells[0].Text.Trim();
            string sql = "UPDATE PMS_master_pr SET status_id='" + Config.I_STATUS_CLOSE + "' WHERE pr_no='" + pr_no + "'";

            dsPRMaintBrowse.UpdateCommand = sql;
            dsPRMaintBrowse.Update();

            btSearch_Click(sender, e);
        }

        protected void grPRMaint_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (e.Row.Cells[5].Text.Trim() == Config.S_STATUS_NEW)
                {
                    e.Row.FindControl("btClose").Visible = true;
                }
                else
                {
                    e.Row.FindControl("btClose").Visible = false;
                }
            }
        }

        /* MODAL */
        private void updateModalGridFilter(string pr_no)
        {
            dsPRMaintDetailModal.DeleteCommand = "DELETE FROM PMS_master_pr_temp WHERE create_by='" + tERPSession.User_id + "'";
            dsPRMaintDetailModal.Delete();

            string fields = "pr_no,supplier,supplier_name,ship_to,request_by,site_name,request_date,approval_code,send_email,status_id,line,item_number," +
                "description,um,prod_line,type,required_qty,ordered_qty,unit_cost,disc,need_date,due_date,purchaser_email,upload_time,upload_by,create_time";
            string sql = "INSERT INTO PMS_master_pr_temp (" + fields + ",create_by) SELECT " + fields + ",'" + tERPSession.User_id + "' FROM PMS_master_pr WHERE pr_no='" + pr_no + "'";

            dsPRMaintDetailModal.InsertCommand = sql;
            dsPRMaintDetailModal.Insert();

            DataRow dr = DbHelper.getDataRow("SELECT supplier_name,site_name,request_by,ship_to,approval_code,purchaser_email,send_email FROM PMS_master_pr_temp WHERE pr_no='" + pr_no + "' AND create_by='" + tERPSession.User_id + "'", dsPRMaintBrowse.ConnectionString);
            if (dr != null)
            {
                try
                {
                    string tmp = dr[0].ToString().Trim();
                    for (int i = 0; i < ddSuppilerModal.Items.Count; i++)
                    {
                        if (ddSuppilerModal.Items[i].Value.Trim() == tmp)
                        {
                            ddSuppilerModal.SelectedIndex = i;
                            ddSuppilerModal.SelectedValue = tmp;
                            break;
                        }
                    }

                    tmp = dr[1].ToString().Trim();
                    for (int i = 0; i < ddSiteModal.Items.Count; i++)
                    {
                        if (ddSiteModal.Items[i].Value.Trim() == tmp)
                        {
                            ddSiteModal.SelectedIndex = i;
                            ddSiteModal.SelectedValue = tmp;
                            HttpContext.Current.Session["SITE"] = tmp;
                            break;
                        }
                    }

                    tmp = dr[4].ToString().Trim();
                    for (int i = 0; i < ddAprovalCodeModal.Items.Count; i++)
                    {
                        if (ddAprovalCodeModal.Items[i].Value.Trim() == tmp)
                        {
                            ddAprovalCodeModal.SelectedIndex = i;
                            ddAprovalCodeModal.SelectedValue = tmp;
                            break;
                        }
                    }

                    tmp = dr[6].ToString().Trim();
                    if (tmp == "Y")
                    {
                        ddApprovalNoti.SelectedIndex = 0;
                    }
                    else if (tmp == "N")
                    {
                        ddApprovalNoti.SelectedIndex = 1;
                    }
                    else
                    {
                        ddApprovalNoti.SelectedIndex = 0;
                    }

                    txtRequestByModal.Text = dr[2].ToString().Trim();
                    txtShipToModal.Text = dr[3].ToString().Trim();
                    txtEndUserModal.Text = dr[5].ToString().Trim();
                }
                catch { }
            }

            dsPRMaintDetailModal.SelectCommand = "SELECT id,line,item_number,need_date,due_date,required_qty,ordered_qty,unit_cost,disc,um FROM PMS_master_pr_temp WHERE pr_no='" + pr_no + "' AND create_by='" + tERPSession.User_id + "'";
            grPRMaintModal.DataBind();

            //ScriptManager.RegisterStartupScript(this, this.GetType(), "#prMaintModal", "showPRMaintModal();", true);
        }

        protected void ddSuppilerModal_SelectedIndexChanged(object sender, EventArgs e)
        {
            string supplier = ddSupplier.SelectedItem.Text.Trim();
            //string sql = "SELECT site_name FROM vPMS_site"

            //updateModalGridFilter();
        }


        protected void grPRMaintModal_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.Cells[0].Visible = false;
            }

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string id = e.Row.Cells[0].Text.Trim();
                e.Row.Cells[0].Visible = false;
                ((Label)e.Row.FindControl("lblItemModal")).Visible = false;

                DropDownList ddItem = (DropDownList)e.Row.FindControl("ddItemModal");
                if (ddItem != null)
                {
                    string site_name;
                    if (HttpContext.Current.Session["SITE"] != null)
                    {
                        site_name = HttpContext.Current.Session["SITE"].ToString(); //(ddSiteModal.SelectedIndex >= 0) ? ddSiteModal.SelectedItem.Text.Trim() : "";
                    }
                    else
                    {
                        site_name = (ddSiteModal.SelectedIndex >= 0) ? ddSiteModal.SelectedItem.Text.Trim() : "";
                    }
                    SqlDataSource dsItem = new SqlDataSource();
                    dsItem.ConnectionString = dsPRMaintBrowse.ConnectionString;
                    dsItem.SelectCommand = "SELECT DISTINCT item_number,description FROM vPMS_master_item WHERE site_name='" + site_name + "'";
                    ddItem.DataSource = dsItem;
                    ddItem.DataTextField = "description";
                    ddItem.DataValueField = "item_number";
                    ddItem.DataBind();

                    if (ddItem.Items.Count > 0)
                    {
                        try
                        {
                            ddItem.SelectedValue = ((Label)e.Row.FindControl("lblItemModal")).Text.Trim();
                        }
                        catch { }
                    }
                }
            }
        }

        protected void PRMaintenance_btDelete_Click(object sender, EventArgs e)
        {
            string pr_no = lblCurrentPR.Text.Trim();
            GridViewRow row = (GridViewRow)((Button)sender).Parent.Parent;
            string id = row.Cells[0].Text.Trim();

            dsPRMaintDetailModal.DeleteCommand = "DELETE FROM PMS_master_pr_temp WHERE id='" + id + "'";
            dsPRMaintDetailModal.Delete();

            dsPRMaintDetailModal.UpdateCommand = "UPDATE T SET T.line = TT.ROW_ID FROM PMS_master_pr_temp AS T " +
                "INNER JOIN(SELECT ROW_NUMBER() OVER (ORDER BY id) AS ROW_ID, id FROM PMS_master_pr_temp) AS TT " +
                "ON T.id = TT.id AND T.pr_no = '" + pr_no + "' AND create_by='" + tERPSession.User_id + "'";
            dsPRMaintDetailModal.Update();

            dsPRMaintDetailModal.SelectCommand = "SELECT id,line,item_number,need_date,due_date,required_qty,ordered_qty,unit_cost,disc,um FROM PMS_master_pr_temp WHERE pr_no='" + pr_no + "' AND create_by='" + tERPSession.User_id + "'";
            grPRMaintModal.DataBind();

            //PRMaintenance_lbModalTitle.Text = Localization.GetLocalizationMessage("PRMaintenance_lbModalTitle_Edit");// "Edit PR";
        }

        protected void PRMaintenance_btModalAdd_Click(object sender, EventArgs e)
        {
            string pr_no = lblCurrentPR.Text.Trim();
            string site = (ddSiteModal.Items.Count > 0) ? ddSiteModal.SelectedItem.Text.Trim() : "";
            //string item_number = ddItemModal.SelectedItem.Value.Trim();

            DataRow dr = DbHelper.getDataRow("SELECT site,item_number,description,um,prod_line,type FROM PMS_master_item WHERE site='" + site + "' AND status='Active'", dsPRMaintDetailModal.ConnectionString);

            if (dr == null)
            {
                (new Mess(this)).ShowMessage("This site does not contain Item", Mess.TYPE_ERROR);
            }
            else
            {
                string sql = "INSERT INTO PMS_master_pr_temp (pr_no,item_number,create_by) VALUES ('" + pr_no + "','_','" + tERPSession.User_id + "')";
                dsPRMaintDetailModal.InsertCommand = sql;
                dsPRMaintDetailModal.Insert();

                sql = "SELECT id FROM PMS_master_pr_temp WHERE pr_no='" + pr_no + "' AND create_by='" + tERPSession.User_id + "' AND item_number='_'";
                DataRow dr2 = DbHelper.getDataRow(sql, dsPRMaintDetailModal.ConnectionString);
                string id = dr2[0].ToString();

                sql = "UPDATE PMS_master_pr_temp SET request_by='" + tERPSession.User_id + "',site_name=N'" + dr[0].ToString() + "',request_date='" + DateTime.Now.ToString("MM/dd/yyyy") +
                    "',item_number='" + dr[1].ToString() + "',description=N'" + dr[2].ToString() + "',um='" + dr[3].ToString() + "',prod_line=N'" + dr[4].ToString() +
                    "',type=N'" + dr[5].ToString() + "',create_time='" + DateTime.Now.ToString() + "',create_by='" + tERPSession.User_id + "' ";
                sql += "WHERE id='" + id + "'";
                dsPRMaintDetailModal.UpdateCommand = sql;
                dsPRMaintDetailModal.Update();

                dsPRMaintDetailModal.UpdateCommand = "UPDATE T SET T.line = TT.ROW_ID FROM PMS_master_pr_temp AS T " +
                    "INNER JOIN (SELECT ROW_NUMBER() OVER (ORDER BY id) AS ROW_ID, id FROM PMS_master_pr_temp WHERE pr_no = '" + pr_no + "' AND create_by='" + tERPSession.User_id + "') AS TT " +
                    "ON T.id = TT.id AND T.pr_no = '" + pr_no + "' AND create_by='" + tERPSession.User_id + "'";
                dsPRMaintDetailModal.Update();

                dsPRMaintDetailModal.SelectCommand = "SELECT id,line,item_number,need_date,due_date,required_qty,ordered_qty,unit_cost,disc,um FROM PMS_master_pr_temp WHERE pr_no='" + pr_no + "' AND create_by='" + tERPSession.User_id + "'";
                grPRMaintModal.DataBind();
            }
        }

        protected void PRMaintenance_btSave_Click(object sender, EventArgs e)
        {
            string err = "1";

            try
            {
                string pr_no = lblCurrentPR.Text.Trim();

                err = "2";

                dsPRMaintBrowse.DeleteCommand = "DELETE FROM PMS_master_pr WHERE pr_no='" + pr_no + "'";
                dsPRMaintBrowse.Delete();

                err = "3";

                dsPRMaintBrowse.InsertCommand = "INSERT INTO PMS_master_pr (pr_no,supplier,supplier_name,ship_to,request_by,site_name,request_date,approval_code," +
                    "send_email,status_id,line,item_number,description,um,prod_line,type,required_qty,ordered_qty,unit_cost,disc,need_date,due_date,purchaser_email," +
                    "upload_time,upload_by,last_edit_time,last_edit_by,create_time,create_by) SELECT pr_no,'" + ddSuppilerModal.SelectedItem.Text.Trim() + "','" +
                    ddSuppilerModal.SelectedItem.Value.Trim() + "','" + txtShipToModal.Text.Trim() + "','" + txtRequestByModal.Text.Trim() + "',site_name,request_date,'" +
                    ddAprovalCodeModal.SelectedItem.Text.Trim() + "','" + ((ddApprovalNoti.SelectedItem.Text.Trim() == "Yes") ? "N" : "") +
                    "',status_id,line,item_number,description,um,prod_line,type,required_qty,ordered_qty,unit_cost,disc,need_date,due_date,'" +
                    txtEndUserModal.Text.Trim() + "',upload_time,upload_by,'" + DateTime.Now.ToString() + "','" + tERPSession.User_id + "',create_time,create_by FROM PMS_master_pr_temp WHERE pr_no='" + pr_no + "'";
                dsPRMaintBrowse.Insert();

                err = "4";

                //Remove locking pr
                dsPRMaintBrowse.DeleteCommand = "DELETE FROM PMS_pr_no_locking WHERE pr_no='" + pr_no + "' AND locked_by='" + tERPSession.User_id + "'";
                dsPRMaintBrowse.Delete();

                dsPRMaintBrowse.DeleteCommand = "DELETE FROM PMS_master_pr_temp WHERE pr_no='" + pr_no + "'";// AND create_by='" + tERPSession.User_id + "'";
                dsPRMaintBrowse.Delete();

                err = "5";

                if (ddApprovalNoti.SelectedItem.Text.Trim() == "Yes")
                {
                    string email_to = "";
                    string body = "";
                    DataRow dr = DbHelper.getDataRow("SELECT DISTINCT approver_id,user_full_name,user_email,alt_approver_id,alt_user_full_name,alt_user_email FROM vPMS_pr_approval_approver WHERE pr_no='" + pr_no + "' AND order_='1'", dsPRMaintBrowse.ConnectionString);
                    if (dr != null)
                    {
                        email_to = (tERPSession.User_id == dr[0].ToString().Trim()) ? dr[2].ToString().Trim() : dr[5].ToString().Trim();
                        body = "Dear " + ((tERPSession.User_id == dr[0].ToString().Trim()) ? dr[1].ToString().Trim() : dr[4].ToString().Trim()) + "<br/><br/>\n";
                        body += "You have a Purchase Requisition <a href='http://192.168.1.142/terp/Forms/PMS/frmPRApproval.aspx?pr_no=" + pr_no + "'>[" + pr_no + "]</a> need approved." + "<br/><br/>\n";

                        dsPRMaintBrowse.InsertCommand = "INSERT INTO TERP_email_notification (noti_content,user_id,noti_date,viewed) VALUES ('" +
                            WebUtility.HtmlEncode(body) + "','" + ((tERPSession.User_id == dr[0].ToString().Trim()) ? dr[0].ToString().Trim() : dr[3].ToString().Trim()) + "','" + DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss") + "','0')";
                        dsPRMaintBrowse.Insert();
                    }

                    if (email_to != "")
                    {
                        body += "TERP notification system.";
                        (new Email(email_to, "Notification", body, null, true)).send();
                    }
                }

            }
            catch (Exception ex)
            {
                (new Mess(this)).ShowMessage(err + " - " + ex.Message, Mess.TYPE_ERROR);
            }

            divAddEdit.Visible = false;
            divMain.Visible = true;
            btSearch_Click(sender, e);
            PRMaintenance_btCreate.Visible = true;
        }

        protected void PRMaintenance_btCancel_Click(object sender, EventArgs e)
        {
            //Remove locking pr
            string pr_no = lblCurrentPR.Text.Trim();
            dsPRMaintBrowse.DeleteCommand = "DELETE FROM PMS_pr_no_locking WHERE pr_no='" + pr_no + "' AND locked_by='" + tERPSession.User_id + "'";
            dsPRMaintBrowse.Delete();

            dsPRMaintBrowse.DeleteCommand = "DELETE FROM PMS_master_pr_temp WHERE pr_no='" + pr_no + "' AND create_by='" + tERPSession.User_id + "'";
            dsPRMaintBrowse.Delete();

            divAddEdit.Visible = false;
            divMain.Visible = true;
            btSearch_Click(sender, e);

            PRMaintenance_btCreate.Visible = true;
        }

        protected void POApprovalMaint_ddItem_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddItem = (DropDownList)sender;
            GridViewRow row = (GridViewRow)ddItem.Parent.Parent;
            string id = row.Cells[0].Text.Trim();

            DataRow dr = DbHelper.getDataRow("SELECT line,need_date,due_date,ordered_qty,um FROM PMS_master_pr_temp " +
                "WHERE id='" + id + "' AND item_number='" + ddItem.SelectedItem.Text.Trim() + "'", dsItemModal.ConnectionString);
            if (dr != null)
            {
                ((Label)row.FindControl("lblLine")).Text = dr[0].ToString().Replace("&nbsp;", "").Trim();
                ((TextBox)row.FindControl("txtNeedDate")).Text = dr[1].ToString().Replace("&nbsp;", "").Trim();
                ((TextBox)row.FindControl("txtDueDate")).Text = dr[2].ToString().Replace("&nbsp;", "").Trim();
                ((TextBox)row.FindControl("PRMaintenance_txtOrder")).Text = dr[3].ToString().Replace("&nbsp;", "").Trim();
                ((TextBox)row.FindControl("PRMaintenance_txtUm")).Text = dr[4].ToString().Replace("&nbsp;", "").Trim();
            }
        }

        protected void ddItemModal_SelectedIndexChanged(object sender, EventArgs e)
        {
            string pr_no = lblCurrentPR.Text.Trim();
            string item_number = ((DropDownList)sender).SelectedItem.Value.Trim();
            GridViewRow row = (GridViewRow)((DropDownList)sender).Parent.Parent;
            string id = row.Cells[0].Text.Trim();

            DataRow dr = DbHelper.getDataRow("SELECT site_name,item_number,description,um,prod_line,type FROM vPMS_master_item WHERE item_number='" + item_number + "'", dsPRMaintDetailModal.ConnectionString);

            string sql = "UPDATE PMS_master_pr_temp SET site_name=N'" + dr[0].ToString() + "',item_number='" + dr[1].ToString() + "',description=N'" + dr[2].ToString() +
                "',um='" + dr[3].ToString() + "',prod_line=N'" + dr[4].ToString() + "',type=N'" + dr[5].ToString() + "'";
            sql += "WHERE id='" + id + "'";
            dsPRMaintDetailModal.UpdateCommand = sql;
            dsPRMaintDetailModal.Update();

            dsPRMaintDetailModal.SelectCommand = "SELECT id,line,item_number,need_date,due_date,required_qty,ordered_qty,unit_cost,disc,um FROM PMS_master_pr_temp WHERE pr_no='" + pr_no + "' AND create_by='" + tERPSession.User_id + "'";
            grPRMaintModal.DataBind();
        }

        protected void txtNeedDate_TextChanged(object sender, EventArgs e)
        {
            string pr_no = lblCurrentPR.Text.Trim();
            string need_date = ((TextBox)sender).Text.Trim();
            GridViewRow row = (GridViewRow)((TextBox)sender).Parent.Parent;
            string id = row.Cells[0].Text.Trim();

            if (DatetimeTool.VerifyDate2(need_date))// (ordered_qty, Tools.TYPE_DOUBLE))
            {
                string sql = "UPDATE PMS_master_pr_temp SET need_date='" + need_date + "' WHERE id='" + id + "'";
                dsPRMaintDetailModal.UpdateCommand = sql;
                dsPRMaintDetailModal.Update();

                dsPRMaintDetailModal.SelectCommand = "SELECT id,line,item_number,need_date,due_date,required_qty,ordered_qty,unit_cost,disc,um FROM PMS_master_pr_temp WHERE pr_no='" + pr_no + "' AND create_by='" + tERPSession.User_id + "'";
                grPRMaintModal.DataBind();
            }
            else
            {
                (new Mess(this)).ShowMessage("Invalid Need Date format", Mess.TYPE_ERROR);
            }
        }

        protected void txtDueDate_TextChanged(object sender, EventArgs e)
        {
            string pr_no = lblCurrentPR.Text.Trim();
            string due_date = ((TextBox)sender).Text.Trim();
            GridViewRow row = (GridViewRow)((TextBox)sender).Parent.Parent;
            string id = row.Cells[0].Text.Trim();

            if (DatetimeTool.VerifyDate2(due_date))// (ordered_qty, Tools.TYPE_DOUBLE))
            {
                string sql = "UPDATE PMS_master_pr_temp SET due_date='" + due_date + "' WHERE id='" + id + "'";
                dsPRMaintDetailModal.UpdateCommand = sql;
                dsPRMaintDetailModal.Update();

                dsPRMaintDetailModal.SelectCommand = "SELECT id,line,item_number,need_date,due_date,required_qty,ordered_qty,unit_cost,disc,um FROM PMS_master_pr_temp WHERE pr_no='" + pr_no + "' AND create_by='" + tERPSession.User_id + "'";
                grPRMaintModal.DataBind();
            }
            else
            {
                (new Mess(this)).ShowMessage("Invalid Need Date format", Mess.TYPE_ERROR);
            }
        }

        protected void txtOrder_TextChanged(object sender, EventArgs e)
        {
            string pr_no = lblCurrentPR.Text.Trim();
            string ordered_qty = ((TextBox)sender).Text.Trim();
            GridViewRow row = (GridViewRow)((TextBox)sender).Parent.Parent;
            string id = row.Cells[0].Text.Trim();

            if (Tools.VerifyNumber(ordered_qty, Tools.TYPE_DOUBLE))
            {
                string sql = "UPDATE PMS_master_pr_temp SET ordered_qty='" + ordered_qty + "' WHERE id='" + id + "'";
                dsPRMaintDetailModal.UpdateCommand = sql;
                dsPRMaintDetailModal.Update();

                dsPRMaintDetailModal.SelectCommand = "SELECT id,line,item_number,need_date,due_date,required_qty,ordered_qty,unit_cost,disc,um FROM PMS_master_pr_temp WHERE pr_no='" + pr_no + "' AND create_by='" + tERPSession.User_id + "'";
                grPRMaintModal.DataBind();
            }
            else
            {
                (new Mess(this)).ShowMessage("Invalid Ordered Qty format", Mess.TYPE_ERROR);
            }
        }

        protected void txtRequiredQty_TextChanged(object sender, EventArgs e)
        {
            string pr_no = lblCurrentPR.Text.Trim();
            string required_qty = ((TextBox)sender).Text.Trim();
            GridViewRow row = (GridViewRow)((TextBox)sender).Parent.Parent;
            string id = row.Cells[0].Text.Trim();

            if (Tools.VerifyNumber(required_qty, Tools.TYPE_DOUBLE))
            {
                string sql = "UPDATE PMS_master_pr_temp SET required_qty='" + required_qty + "' WHERE id='" + id + "'";
                dsPRMaintDetailModal.UpdateCommand = sql;
                dsPRMaintDetailModal.Update();

                dsPRMaintDetailModal.SelectCommand = "SELECT id,line,item_number,need_date,due_date,required_qty,ordered_qty,unit_cost,disc,um FROM PMS_master_pr_temp WHERE pr_no='" + pr_no + "' AND create_by='" + tERPSession.User_id + "'";
                grPRMaintModal.DataBind();
            }
            else
            {
                (new Mess(this)).ShowMessage("Invalid Required Qty format", Mess.TYPE_ERROR);
            }
        }

        protected void txtUnitCost_TextChanged(object sender, EventArgs e)
        {
            string pr_no = lblCurrentPR.Text.Trim();
            string unit_cost = ((TextBox)sender).Text.Trim();
            GridViewRow row = (GridViewRow)((TextBox)sender).Parent.Parent;
            string id = row.Cells[0].Text.Trim();

            if (Tools.VerifyNumber(unit_cost, Tools.TYPE_DOUBLE))
            {
                string sql = "UPDATE PMS_master_pr_temp SET unit_cost='" + unit_cost + "' WHERE id='" + id + "'";
                dsPRMaintDetailModal.UpdateCommand = sql;
                dsPRMaintDetailModal.Update();

                dsPRMaintDetailModal.SelectCommand = "SELECT id,line,item_number,need_date,due_date,required_qty,ordered_qty,unit_cost,disc,um FROM PMS_master_pr_temp WHERE pr_no='" + pr_no + "' AND create_by='" + tERPSession.User_id + "'";
                grPRMaintModal.DataBind();
            }
            else
            {
                (new Mess(this)).ShowMessage("Invalid Unit Cost format", Mess.TYPE_ERROR);
            }
        }

        protected void txtDiscount_TextChanged(object sender, EventArgs e)
        {
            string pr_no = lblCurrentPR.Text.Trim();
            string disc = ((TextBox)sender).Text.Trim();
            GridViewRow row = (GridViewRow)((TextBox)sender).Parent.Parent;
            string id = row.Cells[0].Text.Trim();

            if (Tools.VerifyNumber(disc, Tools.TYPE_DOUBLE))
            {
                string sql = "UPDATE PMS_master_pr_temp SET disc='" + disc + "' WHERE id='" + id + "'";
                dsPRMaintDetailModal.UpdateCommand = sql;
                dsPRMaintDetailModal.Update();

                dsPRMaintDetailModal.SelectCommand = "SELECT id,line,item_number,need_date,due_date,required_qty,ordered_qty,unit_cost,disc,um FROM PMS_master_pr_temp WHERE pr_no='" + pr_no + "' AND create_by='" + tERPSession.User_id + "'";
                grPRMaintModal.DataBind();
            }
            else
            {
                (new Mess(this)).ShowMessage("Invalid Discount format", Mess.TYPE_ERROR);
            }
        }

        protected void ddRecordPerPage_SelectedIndexChanged(object sender, EventArgs e)
        {
            grPRMaint.PageSize = int.Parse(ddRecordPerPage.SelectedItem.Text);
            btSearch_Click(sender, e);
        }

        protected void getAllPRStatusID(int status_Id, int dr_Value)
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

            string sql = "SELECT DISTINCT pr_no,request_by,supplier,purchaser_email,due_date,status FROM vPMS_master_pr_browse WHERE status_id = " + status_Id + query_timer;

            dsPRMaintBrowse.SelectCommand = sql;
            grPRMaint.DataBind();
            lblTotal.Text = DbHelper.getRowCount(dsPRMaintBrowse);
        }
    }
}