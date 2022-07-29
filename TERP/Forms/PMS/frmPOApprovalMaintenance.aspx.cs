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
    public partial class frmPOApprovalMaintenance : System.Web.UI.Page
    {
        TERPSession tERPSession;
        string prefix = "POApprovalMaintenance";

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

            LoadLocalizationMessage();

            if (!IsPostBack)
            {
                string approval_code = txtApprovalCode.Text.Trim();
                if (approval_code == "")
                {
                    dsPOApprovalModal.SelectCommand = "SELECT TOP (0) approver_id, alt_approver_id, order_,id FROM [PMS_po_approval_detail_temp]";
                }
                else
                {
                    dsPOApprovalModal.SelectCommand = "SELECT approver_id, alt_approver_id, order_,id FROM [PMS_po_approval_detail_temp] " +
                        "WHERE approval_code='" + approval_code + "' AND modifying_by='" + tERPSession.User_id + "' ORDER BY order_";
                }
                grPOApprovalModal.DataBind();
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

        protected void POApprovalMaintenance_btnCreate_Click(object sender, EventArgs e)
        {
            POApprovalMaintenance_lblModaltitle.Text = Localization.GetLocalizationMessage("POApprovalMaintenance_lblModaltitle_Create");// "Create Approval";
            POApprovalMaintenance_btnCancel_Click(sender, e);

            txtApprovalCode.Text = "";
            txtApprovalCode.ReadOnly = false;
            txtDescription.Text = "";
            ddStatus.SelectedIndex = 0;

            grPOApprovalModal.DataSource = null;
            grPOApprovalModal.DataBind();

            ScriptManager.RegisterStartupScript(this, this.GetType(), "#POapprovalModal", "showPOApprovalModal();", true);
        }

        protected void btEdit_Click(object sender, ImageClickEventArgs e)
        {
            POApprovalMaintenance_lblModaltitle.Text = Localization.GetLocalizationMessage("POApprovalMaintenance_lblModaltitle_Edit");// "Edit Approval";
            GridViewRow row = (GridViewRow)((ImageButton)sender).Parent.Parent;

            txtApprovalCode.Text = row.Cells[0].Text.Trim();
            txtApprovalCode.ReadOnly = true;
            txtDescription.Text = row.Cells[1].Text.Trim();
            ddStatus.SelectedValue = row.Cells[2].Text.Trim();

            txtApprovalCode_TextChanged(sender, e);

            ScriptManager.RegisterStartupScript(this, this.GetType(), "#POapprovalModal", "showPOApprovalModal();", true);
        }

        private void updateGridApprovalModal()
        {
            string approval_code = txtApprovalCode.Text.Trim();

            dsPOApprovalModal.SelectCommand = "SELECT approver_id, alt_approver_id, order_,id FROM [PMS_po_approval_detail_temp] " +
                "WHERE approval_code='" + approval_code + "' AND modifying_by='" + tERPSession.User_id + "' ORDER BY order_";
            grPOApprovalModal.DataBind();
        }

        protected void txtApprovalCode_TextChanged(object sender, EventArgs e)
        {
            string approval_code = txtApprovalCode.Text.Trim();

            try
            {
                DataRow dr = DbHelper.getDataRow("SELECT status,description FROM PMS_po_approval WHERE approval_code='" + approval_code + "'", dsTemp.ConnectionString);
                if (dr != null)
                {
                    txtApprovalCode.ReadOnly = true;
                    txtDescription.Text = dr[1].ToString().Trim();
                    ddStatus.SelectedValue = dr[0].ToString().Trim();
                }

                dsPOApprovalModal.DeleteCommand = "DELETE FROM PMS_po_approval_detail_temp WHERE modifying_by='" + tERPSession.User_id + "'";
                dsPOApprovalModal.Delete();

                dsPOApprovalModal.InsertCommand = "INSERT INTO PMS_po_approval_detail_temp " +
                    "SELECT approval_code,approver_id,alt_approver_id,order_,'" + tERPSession.User_id + "' FROM PMS_po_approval_detail WHERE approval_code='" + approval_code + "'";
                dsPOApprovalModal.Insert();

                updateGridApprovalModal();

                //Localization.SetLocalizationMessage(true, grApprovalModal, prefix);
            }
            catch (Exception ex)
            {
                (new Mess(this)).ShowMessage("Network error occuss!", Mess.TYPE_WARNING);
            }
        }

        protected void grPOApprovalModal_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            string approver_id;
            string alt_approver_id;
            string order;
            //string id;
            DropDownList ddTemp;

            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.Cells[0].Visible = false;
                e.Row.Cells[2].Visible = false;
                e.Row.Cells[4].Visible = false;
                e.Row.Cells[7].Visible = false;
            }

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                approver_id = e.Row.Cells[0].Text.Trim();
                alt_approver_id = e.Row.Cells[2].Text.Trim();
                order = e.Row.Cells[4].Text.Trim();
                //id = e.Row.Cells[6].Text.Trim();

                e.Row.Cells[0].Visible = false;
                e.Row.Cells[2].Visible = false;
                e.Row.Cells[4].Visible = false;
                e.Row.Cells[7].Visible = false;

                ddTemp = (DropDownList)e.Row.FindControl("ddApprover");
                try
                {
                    ddTemp.SelectedValue = approver_id;
                }
                catch
                {
                    ddTemp.SelectedIndex = (ddTemp.Items.Count > 0) ? 0 : -1;
                }
                ddTemp = (DropDownList)e.Row.FindControl("ddAltApprover");
                try
                {
                    ddTemp.SelectedValue = alt_approver_id;
                }
                catch
                {
                    ddTemp.SelectedIndex = (ddTemp.Items.Count > 0) ? 0 : -1;
                }
                try
                {
                    ((TextBox)e.Row.FindControl("txtOrder")).Text = order;
                }
                catch { }
            }
        }

        protected void ddApprover_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                DropDownList drop = (DropDownList)sender;
                string order = ((TextBox)((GridViewRow)(drop.Parent.Parent)).FindControl("txtOrder")).Text.Trim();

                if (order != "")
                {
                    dsPOApprovalModal.UpdateCommand = "UPDATE PMS_po_approval_detail_temp SET approver_id='" + drop.SelectedItem.Value.Trim() + "' WHERE modifying_by='" + tERPSession.User_id + "' AND order_='" + order + "'";
                    dsPOApprovalModal.Update();

                    updateGridApprovalModal();
                }
                else
                {
                    (new Mess(this)).ShowMessage("Order has not been set", Mess.TYPE_ERROR);
                }
            }
            catch { }
        }

        protected void ddAltApprover_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                DropDownList drop = (DropDownList)sender;
                string order = ((TextBox)((GridViewRow)(drop.Parent.Parent)).FindControl("txtOrder")).Text.Trim();

                if (order != "")
                {
                    dsPOApprovalModal.UpdateCommand = "UPDATE PMS_po_approval_detail_temp SET alt_approver_id='" + drop.SelectedItem.Value.Trim() + "' WHERE modifying_by='" + tERPSession.User_id + "' AND order_='" + order + "'";
                    dsPOApprovalModal.Update();

                    updateGridApprovalModal();
                }
                else
                {
                    (new Mess(this)).ShowMessage("Order has not been set", Mess.TYPE_ERROR);
                }
            }
            catch { }
        }

        protected void POApprovalMaintenance_btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                string order = ((TextBox)((GridViewRow)((Button)sender).Parent.Parent).FindControl("txtOrder")).Text.Trim();

                if (order != "")
                {
                    dsPOApprovalModal.DeleteCommand = "DELETE FROM PMS_po_approval_detail_temp WHERE modifying_by='" + tERPSession.User_id + "' AND order_='" + order + "'";
                    dsPOApprovalModal.Delete();

                    updateGridApprovalModal();
                }
                else
                {
                    (new Mess(this)).ShowMessage("Order has not been set", Mess.TYPE_ERROR);
                }
            }
            catch { }
        }

        protected void POApprovalMaintenance_btnMoDalAdd_Click(object sender, EventArgs e)
        {
            string approval_code = txtApprovalCode.Text.Trim();

            if (approval_code != "")
            {
                string order_ = "0";
                DataRow dr = DbHelper.getDataRow("SELECT max(order_) FROM PMS_po_approval_detail_temp WHERE approval_code='" + approval_code + "'", dsPOApprovalModal.ConnectionString);

                if (dr != null)
                {
                    order_ = dr[0].ToString().Trim();
                }

                int order = 0;

                try
                {
                    order = int.Parse(order_);
                }
                catch { }

                order++;

                dsPOApprovalModal.InsertCommand = "INSERT INTO PMS_po_approval_detail_temp (approval_code,approver_id,alt_approver_id,order_,modifying_by) VALUES ('" +
                    approval_code + "','" + tERPSession.User_id + "','" + tERPSession.User_id + "','" + order + "','" + tERPSession.User_id + "')";
                dsPOApprovalModal.Insert();

                updateGridApprovalModal();
            }
            else
            {
                (new Mess(this)).ShowMessage("Please input Approval Code first.", Mess.TYPE_WARNING);
            }
        }

        protected void POApprovalMaintenance_btnCancel_Click(object sender, EventArgs e)
        {
            dsPOApprovalModal.DeleteCommand = "DELETE FROM PMS_po_approval_detail_temp WHERE modifying_by='" + tERPSession.User_id + "'";
            dsPOApprovalModal.Delete();
        }

        protected void POApprovalMaintenance_btnSave_Click(object sender, EventArgs e)
        {
            DataRow dr;
            string approval_code = txtApprovalCode.Text.Trim();
            bool add_new = false;

            if (approval_code != "")
            {
                //Check if approval code exist in case add
                if (!txtApprovalCode.ReadOnly)
                {
                    dr = DbHelper.getDataRow("SELECT DISTINCT approval_code FROM PMS_po_approval WHERE approval_code='" + approval_code + "'", dsPOApprovalModal.ConnectionString);
                    if (dr == null)
                    {
                        dsTemp.InsertCommand = "INSERT INTO PMS_po_approval (approval_code,status,description) VALUES ('" + approval_code + "','" + ddStatus.SelectedItem.Text.Trim() + "',N'" + txtDescription.Text.Trim() + "')";
                        dsTemp.Insert();
                        add_new = true;
                    }
                    else
                    {
                        dsTemp.UpdateCommand = "UPDATE PMS_po_approval SET status='" + ddStatus.SelectedItem.Text.Trim() + "', description=N'" + txtDescription.Text.Trim() + "' WHERE approval_code='" + approval_code + "'";
                        dsTemp.Update();
                    }
                }
                else
                {
                    dsTemp.UpdateCommand = "UPDATE PMS_po_approval SET status='" + ddStatus.SelectedItem.Text.Trim() + "', description=N'" + txtDescription.Text.Trim() + "' WHERE approval_code='" + approval_code + "'";
                    dsTemp.Update();
                }

                GridViewRow row;

                for (int i = 0; i < grPOApprovalModal.Rows.Count; i++)
                {
                    row = grPOApprovalModal.Rows[i];
                    try
                    {
                        string order_ = ((TextBox)row.FindControl("txtOrder")).Text.Trim();
                        string approver_id = ((DropDownList)row.FindControl("ddApprover")).SelectedItem.Value.Trim();
                        string alt_approver_id = ((DropDownList)row.FindControl("ddAltApprover")).SelectedItem.Value.Trim();
                        string id = row.Cells[7].Text.Trim();

                        dsTemp.UpdateCommand = "UPDATE PMS_po_approval_detail_temp SET approver_id='" + approver_id + "', alt_approver_id='" +
                            alt_approver_id + "', order_='" + order_ + "' WHERE id='" + id + "'";
                        dsTemp.Update();
                    }
                    catch { }
                }


                //Remove all approval detail
                dsTemp.DeleteCommand = "DELETE FROM PMS_po_approval_detail WHERE approval_code='" + approval_code + "'";
                dsTemp.Delete();

                //Add again approval detail from temp table
                dsTemp.InsertCommand = "INSERT INTO PMS_po_approval_detail SELECT approval_code,approver_id,alt_approver_id,order_ FROM PMS_po_approval_detail_temp " +
                    "WHERE approval_code='" + approval_code + "' AND modifying_by='" + tERPSession.User_id + "'";
                dsTemp.Insert();

                //Delete approval detail of temp table
                dsTemp.DeleteCommand = "DELETE FROM PMS_po_approval_detail_temp WHERE approval_code='" + approval_code + "' AND modifying_by='" + tERPSession.User_id + "'";
                dsTemp.Delete();

                POApprovalMaintenance_btnCancel_Click(sender, e);

                grPOApprovalMaintenance.DataBind();

                if (add_new)
                {
                    (new Mess(this)).ShowMessage("Approval has been created successfully", Mess.TYPE_SUCCESS);
                }
                else
                {
                    (new Mess(this)).ShowMessage("Approval has been updated successfully", Mess.TYPE_SUCCESS);
                }
            }
            else
            {
                (new Mess(this)).ShowMessage("Approval Code has not been set", Mess.TYPE_ERROR);
            }
            ScriptManager.RegisterStartupScript(this, this.GetType(), "#poApprovalModal", "closeModal('#POapprovalModal');", true);
        }

        protected void grPOApprovalMaintenance_RowDataBound(object sender, GridViewRowEventArgs e)
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

        protected void POApprovalMaintenance_btnSreach_Click(object sender, EventArgs e)
        {
            string po_code = POApprovalMaintenance_filterTxtPOCode.Text.Trim();
            string status = POApprovalMaintenance_filterDlStatus.SelectedItem.Value.Trim();

            string sql = "SELECT  approval_code ,description ,status FROM [TERP].[dbo].[PMS_po_approval] where ";
            if (status == "")
            {
                sql = sql + "status IN ('Active','Inactive')";
            }
            else
            {
                sql = sql + " status = '" + POApprovalMaintenance_filterDlStatus.SelectedItem.Value.Trim() + "'";
            }
            if (po_code != "")
            {

            }
            sql = sql + " order by status , approval_code asc ";
            dsPOApprovalMaintenanceBrowse.SelectCommand = sql;
        }

        protected void POApprovalMaintenance_btnClear_Click(object sender, EventArgs e)
        {
            POApprovalMaintenance_filterTxtPOCode.Text = "";
            POApprovalMaintenance_filterDlStatus.SelectedIndex = 0;
            dsPOApprovalMaintenanceBrowse.SelectCommand = "SELECT  [approval_code],[status],[description] FROM [TERP].[dbo].[PMS_po_approval]   ";
        }

        protected void dsRowPerPage_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.CommandTimeout = 0;
        }

        protected void ddRecordPerPage_SelectedIndexChanged(object sender, EventArgs e)
        {
            grPOApprovalMaintenance.PageSize = int.Parse(ddRecordPerPage.SelectedItem.Text.Trim());
        }
    }
}