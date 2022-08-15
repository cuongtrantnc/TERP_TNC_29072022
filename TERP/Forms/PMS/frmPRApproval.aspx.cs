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
    public partial class frmPRApproval : System.Web.UI.Page
    {
        TERPSession tERPSession;
        string prefix = "PRApproval";

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
                if (Request.QueryString["pr_no"] != null && Request.QueryString["pr_no"] != "")
                {
                    HttpContext.Current.Session["pr_no"] = Request.QueryString["pr_no"];
                }
                Response.Redirect("/terp/Login.aspx");
            }

            if (!IsPostBack)
            {
                HttpContext.Current.Session["localization"] = Localization.LoadLocalizationMessage("PMS", prefix, tERPSession.Language_code);
                SetLanguageToDropDownList();
            }

            if (Tools.getPostBackControlName(this) == "grPRApproval")
            {
                dsPRApproval.SelectCommand = buildQuery();
                lblTotal.Text = DbHelper.getRowCount(dsPRApproval);
            }

            LoadLocalizationMessage();

            string parameter = Request.QueryString["pr_no"];
            string url = Request.Url.ToString();
            if (parameter!=null && parameter != "")
            {
                url = url.Split('?')[0].Trim();
                HttpContext.Current.Session["pr_no"] = parameter;
                Response.Redirect(url);
            }

            if (HttpContext.Current.Session["pr_no"]!=null)
            {
                string pr_no = HttpContext.Current.Session["pr_no"].ToString();
                txtPurchase.Text = pr_no;
                PRApproval_btQuery_Click(sender, e);
                HttpContext.Current.Session["pr_no"] = null;
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
            string pr_no = txtPurchase.Text.Trim();
            string from_date = txtFromDate.Text.Trim();
            string to_date = txtToDate.Text.Trim();

            string sql = "SELECT DISTINCT pr_no,SUM(amount) amount,create_date,due_date,next_approver,status,order_ FROM vPMS_pr_approval_browse WHERE #";

            if (pr_no != "")
            {
                sql = sql + "AND pr_no='" + pr_no + "' ";
            }

            if (from_date == "") from_date = to_date;
            if (to_date == "") to_date = from_date;

            if (from_date != "")
            {
                sql = sql + "AND due_date BETWEEN '" + from_date + "' AND '" + to_date + "' ";
            }

            return sql.Replace("#AND", "").Replace("WHERE #", "") + " GROUP BY pr_no, create_date,due_date,next_approver,status,order_";

        }

        protected void PRApproval_btQuery_Click(object sender, EventArgs e)
        {
            dsPRApproval.SelectCommand = buildQuery();
            try
            {
                grPRApproval.DataBind();
                lblTotal.Text = DbHelper.getRowCount(dsPRApproval);
            }
            catch (Exception ex)
            {
                if (ex.Message.IndexOf("converting date") >= 0 || ex.Message.IndexOf("datetime data type") >= 0)
                {
                    (new Mess(this)).ShowMessage("Invalid Datetime inputed.", Mess.TYPE_ERROR);
                }
            }
        }

        //Action: User Click on Colum [History] of gridView_PRApprovalDetail
        protected void btLast10PRHistory_Click(object sender, ImageClickEventArgs e)
        {
            GridViewRow row = (GridViewRow)((ImageButton)sender).Parent.Parent;

            string item_number = row.Cells[2].Text.Trim();
            string desc = row.Cells[3].Text.Trim().Replace("&nbsp;", "");

            txtItemPart.Text = item_number + " - " + desc;

            dsHistoryItemView.SelectCommand = "SELECT TOP (10) pr_no,supplier,supplier_name,unit_cost,create_date FROM vPMS_pr_approval_item_history " +
                "WHERE item_number='" + item_number + "' ORDER BY create_date DESC";
            grHistoryItemView.DataBind();

            if (grHistoryItemView.Rows.Count > 0)
            {
                divNoDataAvailable.Visible = false;
            }
            ScriptManager.RegisterStartupScript(this, this.GetType(), "#prApproval_HistoryItemView", "showHistoryItemView();", true);
        }

        protected void btDetailItemView_Click(object sender, ImageClickEventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "#showApproval_Detailview", "showApproval_Detailview();", true);

            GridViewRow row = (GridViewRow)((ImageButton)sender).Parent.Parent;
            string pr_no = row.Cells[0].Text.Trim();
            txtPrNoView.Text = pr_no;
            txtCreatedDateView.Text = row.Cells[2].Text.Trim().Replace("&nbsp;", "");
            txtDueDateView.Text = row.Cells[3].Text.Trim().Replace("&nbsp;", "");

            DataRow dr = DbHelper.getDataRow("SELECT DISTINCT supplier,approval_code FROM PMS_master_pr WHERE pr_no='" + pr_no + "'", dsTemp.ConnectionString);
            txtSupplierView.Text = (dr != null) ? dr[0].ToString().Trim().Replace("&nbsp;", "") : "";
            string approval_code = (dr != null) ? dr[1].ToString().Trim().Replace("&nbsp;", "") : "";

            txtApprovalCodeView.Text = approval_code;

            dr = DbHelper.getDataRow("SELECT a.approver_id,a.alt_approver_id FROM vPMS_pr_approver a " +
                "WHERE a.order_ = CASE WHEN ISNULL((SELECT max(b.order_) FROM PMS_pr_approval_log b WHERE a.approval_code = b.approval_code), 0) = 0 THEN 1 ELSE(SELECT max(b.order_) " +
                "FROM PMS_pr_approval_log b WHERE a.approval_code = b.approval_code) + 1 END AND a.approval_code = '" + approval_code + "'", dsTemp.ConnectionString);
            if (dr != null)
            {
                txtApproverIDView.Text = dr[0].ToString().Trim();
                txtAltApproverIDView.Text = dr[1].ToString().Trim();
            }
            txtOrderView.Text = row.Cells[8].Text.Trim();

            dsPRApprovalDetail.SelectCommand = "SELECT pr_no,line,item_number,description,unit_cost,disc,required_qty,total FROM vPMS_pr_approval_detail " +
                "WHERE pr_no='" + pr_no + "'  ORDER BY line";
            grPRApprovalDetail.DataBind();
            lblTotal.Text = DbHelper.getRowCount(dsPRApproval);

            divDetailview.Visible = true;
            divCondition.Visible = false;
        }

        protected void btHistoryLogged_Click(object sender, ImageClickEventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "#prApproval_LogedModal", "showLogedlModal();", true);
            string pr_no = ((GridViewRow)(((ImageButton)sender).Parent.Parent)).Cells[0].Text.Trim();
            txtPrNo.Text = pr_no;
            dsApprovalLoged.SelectCommand = "SELECT ROW_NUMBER() OVER (ORDER BY order_) AS row_number, pr_no,approver_name,alt_approver_name,action_by,status,approval_time " +
                "FROM vPMS_pr_approval_log WHERE pr_no='" + pr_no + "' ORDER BY order_";
            grApprovalLoged.DataBind();
        }

        private bool validateApprover(string pr_no, int order_)
        {
            string sql = "SELECT DISTINCT approver_id,alt_approver_id FROM vPMS_pr_approval_approver WHERE pr_no='" + pr_no + "' AND order_='" + (order_ + 1) + "'";

            DataRow dr = DbHelper.getDataRow(sql, dsTemp.ConnectionString);

            if (dr!=null)
            {
                return (tERPSession.User_id == dr[0].ToString().Trim() || tERPSession.User_id == dr[1].ToString().Trim());
            }

            return false;
            //return (txtApproverIDView.Text.Trim() == tERPSession.User_id || txtAltApproverIDView.Text.Trim() == tERPSession.User_id);
        }

        private string getNextApprover(string pr_no, int order_)
        {
            string approver_name = "";

            string sql = "SELECT DISTINCT approver_id,alt_approver_id FROM vPMS_pr_approval_approver WHERE pr_no='" + pr_no + "' AND order_='" + (order_ + 1) + "'";

            return approver_name;
        }

        protected void PRApproval_btApproval_Click(object sender, EventArgs e)
        {
            //string param = "addUserSuccess";
            //string script = "window.onload = function() { showMessageUserForm('" + param + "'); };";
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "showMessageUserForm();", script, true);
            string pr_no = txtPrNoView.Text.Trim();
            int order_ = int.Parse(txtOrderView.Text);

            //Validate approval code
            string sql = "SELECT status FROM PMS_approval WHERE approval_code='" + txtApprovalCodeView.Text + "'";
            DataRow dr = DbHelper.getDataRow(sql, dsPRApproval.ConnectionString);
            if (dr!=null && dr[0].ToString().Trim()=="Inactive")
            {
                (new Mess(this)).ShowMessage("Approval Code has been Inactive.", Mess.TYPE_ERROR);
                return;
            }

            if (validateApprover(pr_no, order_))
            {
                int status = Config.I_STATUS_NEW;
                int max_order = 0;

                //DataRow dr = DbHelper.getDataRow("SELECT status_id FROM PMS_master_pr WHERE pr_no='" + pr_no + "'", dsPRApproval.ConnectionString);
                //if (dr!=null)
                //{
                //    status = int.Parse(dr[0].ToString());
                //}

                dr = DbHelper.getDataRow("SELECT max(order_) FROM PMS_approval_detail WHERE approval_code='" + txtApprovalCodeView.Text + "'", dsPRApproval.ConnectionString);
                if (dr != null && dr[0].ToString().Trim() != "")
                {
                    max_order = int.Parse(dr[0].ToString());
                }
                else if (dr[0].ToString().Trim() == "")
                {
                    (new Mess(this)).ShowMessage("Approval Code not found", Mess.TYPE_ERROR);
                    return;
                }

                /*FIX HISTORY LOG - BEGIN*/
                if (order_==1)
                {
                    dsPRApproval.InsertCommand = "INSERT INTO PMS_pr_approval_log_detail (pr_no,approval_code,status_id,approval_by_id,approval_time) VALUES ('" + pr_no + "','" +
                        txtApprovalCodeView.Text + "','1','','01/01/1900')";
                    dsPRApproval.Insert();
                }
                /*FIX HISTORY LOG - END*/

                order_ += 1;
                dsPRApproval.InsertCommand = "INSERT INTO PMS_pr_approval_log (pr_no,approval_code,order_,reason,approval_by_id,approval_time) VALUES ('" + pr_no + "','" +
                    txtApprovalCodeView.Text + "','" + order_ + "',N'" + txtReason.Text.Trim() + "','" + tERPSession.User_id + "','" + DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss") + "')";
                dsPRApproval.Insert();

                if (order_ < max_order)
                {
                    status = Config.I_STATUS_ON_PROCESS;
                }
                else
                {
                    status = Config.I_STATUS_APPROVE;
                }

                /*FIX HISTORY LOG - BEGIN*/
                dsPRApproval.InsertCommand = "INSERT INTO PMS_pr_approval_log_detail (pr_no,approval_code,status_id,approval_by_id,approval_time) VALUES ('" + pr_no + "','" +
                    txtApprovalCodeView.Text + "','" + status + "','" + tERPSession.User_id + "','" + DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss") + "')";
                dsPRApproval.Insert();
                /*FIX HISTORY LOG - END*/

                dsPRApproval.UpdateCommand = "UPDATE PMS_master_pr SET status_id='" + status + "' WHERE pr_no='" + pr_no + "'";
                dsPRApproval.Update();
                grPRApproval.DataBind();
                lblTotal.Text = DbHelper.getRowCount(dsPRApproval);

                string email_to = "";
                string body = "";
                //Send email to Request_by
                if (status == Config.I_STATUS_ON_PROCESS)
                {
                    dr = DbHelper.getDataRow("SELECT DISTINCT approver_id,user_full_name,user_email,alt_approver_id,alt_user_full_name,alt_user_email FROM vPMS_pr_approval_approver WHERE pr_no='" + pr_no + "' AND order_='" + (order_+1) + "'", dsPRApproval.ConnectionString);
                    if (dr != null)
                    {
                        email_to = (tERPSession.User_id == dr[0].ToString().Trim()) ? dr[2].ToString().Trim() : dr[5].ToString().Trim();
                        body = "Dear " + ((tERPSession.User_id == dr[0].ToString().Trim()) ? dr[1].ToString().Trim() : dr[4].ToString().Trim()) + "<br/><br/>\n";
                        body += "You have a Purchase Requisition <a href='http://192.168.1.142/terp/Forms/PMS/frmPRApproval.aspx?pr_no=" + pr_no + "'>[" + pr_no + "]</a> need approved." + "<br/><br/>\n";

                        dsTemp.InsertCommand = "INSERT INTO TERP_email_notification (noti_content,user_id,noti_date,viewed) VALUES ('" +
                            WebUtility.HtmlEncode(body) + "','" + ((tERPSession.User_id == dr[0].ToString().Trim()) ? dr[0].ToString().Trim() : dr[3].ToString().Trim()) + "','" + DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss") + "','1')";
                        dsTemp.Insert();
                    }
                }
                else
                {
                    dr = DbHelper.getDataRow("SELECT a.user_full_name,a.user_email,a.user_id,b.purchaser_email FROM TERP_users a LEFT JOIN PMS_master_pr b ON a.user_email=b.request_by WHERE b.pr_no='" + pr_no + "'", dsPRApproval.ConnectionString);
                    if (dr != null)
                    {
                        email_to = dr[1].ToString().Trim() + ";" + dr[3].ToString().Trim();
                        body = "Dear " + dr[0].ToString().Trim() + " and Purchaser<br/><br/>\n";
                        body += "Your Purchase Requisition has been approved." + "<br/>\n";
                        body += "You can access Web portal via <a href='http://192.168.1.142/terp/'>Link</a>" + "<br/><br/>\n";

                        dsTemp.InsertCommand = "INSERT INTO TERP_email_notification (noti_content,user_id,noti_date,viewed) VALUES ('" +
                            WebUtility.HtmlEncode(body) + "','" + dr[2].ToString().Trim() + "','" + DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss") + "','0')";
                        dsTemp.Insert();
                    }
                }

                if (email_to != "")
                {
                    body += "TERP notification system.";
                    (new Email(email_to, "Notification", body, null, true)).send();
                }

                divDetailview.Visible = false;
                divCondition.Visible = true;

                PRApproval_btQuery_Click(sender, e);
                (new Mess(this)).ShowMessage(txtPrNoView.Text.Trim() + " has been approved successfully", Mess.TYPE_SUCCESS);
            }
            else
            {
                (new Mess(this)).ShowMessage("You dont have permission to Approve this PR", Mess.TYPE_ERROR);
            }
        }

        protected void PRApproval_btReject_Click(object sender, EventArgs e)
        {
            string pr_no = txtPrNoView.Text.Trim();
            int order_ = int.Parse(txtOrderView.Text);

            //Validate approval code
            string sql = "SELECT status FROM PMS_approval WHERE approval_code='" + txtApprovalCodeView.Text + "'";
            DataRow dr = DbHelper.getDataRow(sql, dsPRApproval.ConnectionString);
            if (dr != null && dr[0].ToString().Trim() == "Inactive")
            {
                (new Mess(this)).ShowMessage("Approval Code has been Inactive.", Mess.TYPE_ERROR);
                return;
            }

            if (validateApprover(pr_no, order_))
            {
                dsPRApproval.InsertCommand = "INSERT INTO PMS_pr_approval_log (pr_no,approval_code,order_,reason,approval_by_id,approval_time) VALUES ('" + pr_no + "','" +
                    txtApprovalCodeView.Text + "','" + (order_ + 1) + "',N'" + txtReason.Text.Trim() + "','" + tERPSession.User_id + "','" + DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss") + "')";
                dsPRApproval.Insert();

                dsPRApproval.UpdateCommand = "UPDATE PMS_master_pr SET status_id='" + Config.I_STATUS_REJECT + "' WHERE pr_no='" + txtPrNoView.Text.Trim() + "'";
                dsPRApproval.Update();
                grPRApproval.DataBind();
                lblTotal.Text = DbHelper.getRowCount(dsPRApproval);

                //Send email to Request_by
                dr = DbHelper.getDataRow("SELECT a.user_full_name,a.user_email,a.user_id FROM TERP_users a LEFT JOIN PMS_master_pr b ON a.user_email=b.request_by WHERE b.pr_no='" + pr_no + "'", dsPRApproval.ConnectionString);
                if (dr != null)
                {
                    string email_to = dr[1].ToString().Trim();
                    string body = "Dear " + dr[0].ToString().Trim() + "<br/><br/>\n";
                    body += "Your Purchase Requisition has been rejected." + "<br/>\n";
                    body += "You can access Web portal via <a href='http://192.168.1.142/terp/'>Link</a>" + "<br/><br/>\n";
                    body += "TERP notification system.";
                    (new Email(email_to, "Notification", body, null, true)).send();

                    dsTemp.InsertCommand = "INSERT INTO TERP_email_notification (noti_content,user_id,noti_date,viewed) VALUES ('" +
                        WebUtility.HtmlEncode(body) + "','" + dr[2].ToString().Trim() + "','" + DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss") + "','0')";
                    dsTemp.Insert();
                }
                else
                {
                    dr = DbHelper.getDataRow("SELECT DISTINCT request_by,user_full_name,user_id FROM PMS_master_pr b INNER JOIN TERP_users a ON a.user_email=b.request_by WHERE b.po_no='" + pr_no + "'", dsPRApproval.ConnectionString);

                    if (dr != null)
                    {
                        string email_to = dr[0].ToString().Trim();
                        string body = "Dear " + dr[1].ToString().Trim() + "<br/><br/>\n";

                        body += "Your Purchase Requisition has been rejected." + "<br/>\n";
                        body += "You can access Web portal via <a href='http://192.168.1.142/terp/'>Link</a>" + "<br/><br/>\n";
                        body += "TERP notification system.";
                        (new Email(email_to, "Notification", body, null, true)).send();

                        dsTemp.InsertCommand = "INSERT INTO TERP_email_notification (noti_content,user_id,noti_date,viewed) VALUES ('" +
                            WebUtility.HtmlEncode(body) + "','" + dr[2].ToString().Trim() + "','" + DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss") + "','0')";
                        dsTemp.Insert();
                    }
                }

                //DataRow dr = DbHelper.getDataRow("SELECT a.user_full_name,a.user_email,a.user_id FROM TERP_users a LEFT JOIN PMS_master_pr b ON a.user_id=b.request_by WHERE b.pr_no='" + pr_no + "'", dsPRApproval.ConnectionString);
                //if (dr != null)
                //{
                //    string email_to = dr[1].ToString().Trim();
                //    string body = "Dear Mr./Ms. " + dr[1].ToString().Trim() + "<br/><br/>\n";
                //    body += "Your Purchase Requisition has been rejected." + "<br/>\n";
                //    body += "You can access Web portal via <a href='http://192.168.1.142/terp/'>Link</a>" + "<br/><br/>\n";
                //    body += "TERP notification system.";
                //    (new Email(email_to, "Notification", body, null, true)).send();

                //    dsTemp.InsertCommand = "INSERT INTO TERP_email_notification (noti_content,user_id,noti_date,viewed) VALUES ('" +
                //        WebUtility.HtmlEncode(body) + "','" + dr[2].ToString().Trim() + "','" + DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss") + "','0')";
                //    dsTemp.Insert();
                //}

                divDetailview.Visible = false;
                divCondition.Visible = true;

                (new Mess(this)).ShowMessage(txtPrNoView.Text.Trim() + " has been rejected successfully", Mess.TYPE_SUCCESS);
            }
            else
            {
                (new Mess(this)).ShowMessage("You dont have permission to Reject this PR", Mess.TYPE_ERROR);
            }
        }

        protected void PRApproval_btBack_Click(object sender, EventArgs e)
        {
            divDetailview.Visible = false;
            divCondition.Visible = true;
        }

        protected void grPRApproval_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header || e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[8].Visible = false;
            }
        }

        protected void ddRecordPerPage_SelectedIndexChanged(object sender, EventArgs e)
        {
            dsPRApproval.SelectCommand = buildQuery();
            grPRApproval.PageSize = int.Parse(ddRecordPerPage.SelectedItem.Text.Trim());
            //PRApproval_btQuery_Click(sender, e);
        }
    }
}