using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TERP.Libs;

namespace TERP.Forms.Setting
{
    public partial class frmLocalization : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            TERPSession tERPSession = (TERPSession)HttpContext.Current.Session["tERPSession"];

            if (tERPSession == null)
            {
                Response.Redirect("/terp/Login.aspx");
            }

            if (Tools.getPostBackControlName(this)=="grLocalization")
            {
                updateDataSource();
            }

            if (!IsCallback) //IsCallBack
            {

                string sql = "SELECT language_code,language_name FROM TERP_language";
                DataTable dt = DbHelper.getDataTable(sql, dsLocalization.ConnectionString);
                
                if (dt!=null)
                {
                    pnLiteral.Controls.Add(new LiteralControl("<div class='row row-cols-1 row-cols-sm-2 row-cols-md-3'>\n"));

                    for (int i=0; i<dt.Rows.Count; i++)
                    {
                        pnLiteral.Controls.Add(new LiteralControl("<div class='col'>\n" + dt.Rows[i].ItemArray[1].ToString().Trim() + "\n"));

                        //lt = "<input type='text' ID='TERPContentPlaceHolder_txt_" + dt.Rows[i].ItemArray[0].ToString().Trim().Replace("-","_") + "' class='form-control'>\n";
                        TextBox tb = new TextBox();
                        tb.ID = "txt_" + dt.Rows[i].ItemArray[0].ToString().Trim().Replace("-", "_");
                        tb.CssClass = "form-control";
                        pnLiteral.Controls.Add(tb);

                        pnLiteral.Controls.Add(new LiteralControl("</div>\n"));

                    }
                    pnLiteral.Controls.Add(new LiteralControl("</div>\n"));
                }
            }

            if (!IsPostBack)
            {
                ddModule.DataBind();
                if (ddModule.Items.Count > 0)
                {
                    ddModule.SelectedIndex = 0;
                    ddModule_SelectedIndexChanged(sender, e);
                }
            }
        }

        private void updateDataSource()
        {
            string sql = "SELECT * FROM vTERP_message_localization WHERE module_id='" + ddModule.SelectedItem.Value + "' AND message_id LIKE '" + ddPrefix.SelectedItem.Text.Trim() + "_%' ORDER BY message_id";
            dsLocalization.SelectCommand = sql;
            lblTotal.Text = DbHelper.getRowCount(dsLocalization);
        }

        protected void btQuery_Click(object sender, EventArgs e)
        {
            updateDataSource();
            grLocalization.DataBind();
        }

        protected void dsTemp_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.CommandTimeout = 0;
        }

        protected void ddRecordPerPage_SelectedIndexChanged(object sender, EventArgs e)
        {
            grLocalization.PageSize = int.Parse(ddRecordPerPage.SelectedItem.Text.Trim());
        }

        protected void grLocalization_RowEditing(object sender, GridViewEditEventArgs e)
        {
            grLocalization.EditIndex = e.NewEditIndex;
            HttpContext.Current.Session["message_id"] = ((Label)grLocalization.Rows[e.NewEditIndex].FindControl("lblMessageID")).Text.Trim();
        }

        protected void grLocalization_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string message_id = HttpContext.Current.Session["message_id"].ToString();
            string new_message_id = ((TextBox)grLocalization.Rows[grLocalization.EditIndex].FindControl("txtMessageID")).Text.Trim();
            string message_content = ((TextBox)grLocalization.Rows[grLocalization.EditIndex].FindControl("txtMessageContent")).Text.Trim();
            string id = grLocalization.Rows[grLocalization.EditIndex].Cells[1].Text.Trim();
            string sql;

            if (new_message_id=="")
            {
                (new Mess(this)).show("Message ID can't blank");
                dsLocalization.UpdateCommand = "UPDATE TERP_message_localization SET message_content='' WHERE id=-1";
                dsLocalization.Update();
            } else
            {
                if (new_message_id!=message_id)
                {
                    sql = "UPDATE TERP_message_localization SET message_id='" + new_message_id + "' WHERE message_id='" + message_id + "'";
                    dsLocalization.UpdateCommand = sql;
                    dsLocalization.Update();
                }

                sql = "UPDATE TERP_message_localization SET message_content=N'" + message_content + "' WHERE id='" + id + "'";
                dsLocalization.UpdateCommand = sql;
                dsLocalization.Update();
            }

            updateDataSource();
            grLocalization.DataBind();
            HttpContext.Current.Session["message_id"] = null;
        }

        protected void grLocalization_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string id = grLocalization.Rows[e.RowIndex].Cells[1].Text.Trim();

            dsLocalization.DeleteCommand = "DELETE FROM TERP_message_localization WHERE message_id='-1'";
            if (id!="")
            {
                dsLocalization.DeleteCommand = "DELETE FROM TERP_message_localization WHERE id='" + id + "'";
            }
            dsLocalization.Delete();

            updateDataSource();
            grLocalization.DataBind();
            HttpContext.Current.Session["message_id"] = null;
        }

        protected void btCopy_Click(object sender, EventArgs e)
        {

        }

        protected void btAdd_Click(object sender, EventArgs e)
        {
            string message_id = txtMessageID.Text.Trim();

            if (message_id=="")
            {
                (new Mess(this)).ShowMessage("Please input MessageID.",Mess.TYPE_ERROR);
                (new Mess(this)).ShowMessage(Localization.GetLocalizationMessage("msgMessageIDMissing"), Mess.TYPE_ERROR);
            } else
            {
                //Check Message ID exist
                DataRow dr = DbHelper.getDataRow("SELECT id FORM TERP_message_localization WHERE module_id='" + ddModule.SelectedItem.Value.Trim() + 
                    "' AND message_id='" + message_id + "'",dsModule.ConnectionString);

                if (dr!=null)
                {
                    (new Mess(this)).show("Message ID has been exists.");
                } else
                {
                    if (((TextBox)pnLiteral.FindControl("txt_vi_VN")).Text.Trim()=="")
                    {
                        (new Mess(this)).show("Vietnamses can be blank");
                        return;
                    }
                    if (((TextBox)pnLiteral.FindControl("txt_en_US")).Text.Trim() == "")
                    {
                        (new Mess(this)).show("English can be blank");
                        return;
                    }

                    DataTable dt = new DataTable();
                    dt.Columns.Add("module_id", typeof(string));
                    dt.Columns.Add("message_id", typeof(string));
                    dt.Columns.Add("message_content", typeof(string));
                    dt.Columns.Add("language_code", typeof(string));
                    dt.Columns.Add("note", typeof(string));

                    string sql = "SELECT language_code,language_name FROM TERP_language";
                    DataTable dtLanguage = DbHelper.getDataTable(sql, dsLocalization.ConnectionString);
                    string language_code;
                    TextBox txtContent;

                    for (int i=0; i<dtLanguage.Rows.Count; i++)
                    {
                        language_code = dtLanguage.Rows[i].ItemArray[0].ToString();
                        txtContent = ((TextBox)pnLiteral.FindControl("txt_" + language_code.Replace("-", "_")));

                        if (txtContent!=null && txtContent.Text.Trim()!="")
                        {
                            DataRow row = dt.NewRow();
                            row["module_id"] = ddModule.SelectedItem.Value.Trim();
                            row["message_id"] = txtMessageID.Text.Trim();
                            row["message_content"] = txtContent.Text.Trim();
                            row["language_code"] = language_code;
                            row["note"] = "";
                            dt.Rows.Add(row);
                        }
                    }

                    DbHelper.insertBulkIntoDatabaseWithConnectionString(dsModule.ConnectionString, dt, "TERP_message_localization", "module_id,message_id,message_content,language_code,note");
                    updateDataSource();
                    grLocalization.DataBind();

                    txtMessageID.Text = "";
                    for (int i = 0; i < dtLanguage.Rows.Count; i++)
                    {
                        language_code = dtLanguage.Rows[i].ItemArray[0].ToString();
                        txtContent = ((TextBox)pnLiteral.FindControl("txt_" + language_code.Replace("-", "_")));
                        txtContent.Text = "";
                    }
                }
            }
        }

        protected void ddModule_SelectedIndexChanged(object sender, EventArgs e)
        {
            dsPrefix.SelectCommand = "SELECT prefix_name FROM vPMS_prefix WHERE module_id='" + ddModule.SelectedItem.Value + "'";
            ddPrefix.DataBind();
        }
    }
}