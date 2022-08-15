using TERP.Libs;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.IO;

namespace TERP.Forms
{
    public partial class frmUser : System.Web.UI.Page
    {
        bool encrypt = false;
        TERPSession tERPSession;
        string prefix = "User";

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
            HttpContext.Current.Session["localization"] = Localization.LoadLocalizationMessage("TERP", prefix, tERPSession.Language_code);
            Localization.SetLocalizationMessage(true, this, prefix);

            dsGroupModule.SelectCommand = "SELECT * FROM vTERP_group_module WHERE language_code='" + tERPSession.Language_code + "' ORDER BY sort";
            ddGroupModule.DataBind();
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
                dsGroupModule.SelectCommand = "SELECT * FROM vTERP_group_module WHERE language_code='" + tERPSession.Language_code + "' ORDER BY sort";
                ddGroupModule.DataBind();
                ddGroupModule.SelectedIndex = 0;

                ddDepartment.DataBind();
                dsModule.SelectCommand = "SELECT DISTINCT id,REPLACE(location,'Forms/','') + ' - ' + message_content as menu_desc FROM vTERP_menu " +
                    "WHERE (parent_id!=0 AND enable=1) AND language_code='" + tERPSession.Language_code + "' AND group_id='" + ddGroupModule.SelectedValue + "' ORDER BY menu_desc";
                grModule.DataBind();

                if (ddDepartment.Items.Count > 0)
                {
                    ddDepartment.SelectedIndex = 0;
                    updateUserGrid();
                }

                SetLanguageToDropDownList();
            }

            //limit normal user if they has been assigned to view
            if (tERPSession.Sys_level_id == TERPSession.SYS_LEVEL_1)
            {
                btUserAdd.Enabled = false;
                btUserDel.Enabled = false;
                btUserUpdate.Enabled = false;
                //btUpdateAccessRight.Enabled = false;
            }

            if (Tools.getPostBackControlName(this) == "grUser")
            {
                dsUser.SelectCommand = createQuery();
                lblTotal.Text = DbHelper.getRowCount(dsUser);
            }
            else if (Tools.getPostBackControlName(this) == "chkAll")
            {
                CheckBox chkAll = (CheckBox)grUserRight.HeaderRow.FindControl("chkAll");

                if (!chkAll.Checked)
                {
                    string sql = "SELECT user_name,user_id,user_cid,user_full_name,user_email,department_name FROM vTERP_users WHERE department_name='" + ddDepartmentRight.SelectedItem.Text.Trim() + "' ORDER BY user_id";
                    dsUserRight.SelectCommand = sql;
                    //dsUserRight.DataBind();
                    //grUserRight.EditIndex = -1;
                    //grUserRight.DataBind();

                    //checkAllUser(false);

                    updateUserGrid();
                    updateUserRightGrid();
                }
            }

            LoadLocalizationMessage();
        }

        private void LoadLocalizationMessage()
        {
            HttpContext.Current.Session["localization"] = Localization.LoadLocalizationMessage("TERP", prefix, tERPSession.Language_code);
            Localization.SetLocalizationMessage(true, this, prefix);
        }

        private void clearFields()
        {
            txtUserName.Text = "";
            txtUserFullName.Text = "";
            txtUserID.Text = "";
            txtUserCID.Text = "";
            txtPassword.Text = "";
            txtPasswordConfirm.Text = "";
            imgUserImage.ImageUrl = "";
        }

        private bool validateInput()
        {
            string user_name = txtUserName.Text.Trim();
            string user_full_name = txtUserFullName.Text.Trim();
            string user_id = txtUserID.Text.Trim();
            string pass = txtPassword.Text.Trim();
            string pass_confirm = txtPasswordConfirm.Text.Trim();

            if (user_name == "")
            {
                (new Mess(this)).ShowMessage("Please input User Name", Mess.TYPE_ERROR);
                return false;
            }
            if (user_full_name == "")
            {
                (new Mess(this)).ShowMessage("Please input User Full Name", Mess.TYPE_ERROR);
                return false;
            }
            if (user_id == "")
            {
                (new Mess(this)).ShowMessage("User ID can not null", Mess.TYPE_ERROR);
                return false;
            }
            if (user_id.Length < 6)
            {
                (new Mess(this)).ShowMessage("User id must be 6 characters", Mess.TYPE_ERROR);
                return false;
            }
            if (pass.Length < 8)
            {
                (new Mess(this)).ShowMessage("Password must be at least 8 characters", Mess.TYPE_ERROR);
                return false;
            }
            if ((pass == "" && pass_confirm != "") || (pass != "" && pass_confirm == "") || (pass != pass_confirm))
            {
                (new Mess(this)).ShowMessage("Password does not match", Mess.TYPE_ERROR);
                return false;
            }

            return true;
        }

        protected void btUserAdd_Click(object sender, EventArgs e)
        {
            string department_id = ddDepartment.SelectedItem.Value.Trim();
            string user_right = ddUserLevel.SelectedItem.Value;
            string user_mode = ddUserMode.SelectedItem.Text.Trim();
            string user_name = txtUserName.Text.Trim();
            string user_full_name = txtUserFullName.Text.Trim();
            string user_email = txtEmail.Text.Trim();
            string user_id = txtUserID.Text.Trim();
            string user_cid = txtUserCID.Text.Trim();
            string pass = txtPassword.Text.Trim();
            string pass_confirm = txtPasswordConfirm.Text.Trim();

            //Validate input  
            if (!validateInput())
            {
                return;
            }

            //Check exists
            string sql = "SELECT user_id FROM TERP_users WHERE user_id='" + user_id + "' OR user_name='" + user_name + "' ";
            if (user_cid != "")
            {
                sql = sql + "' OR user_cid='" + user_cid + "'";
            }

            DataRow dr = DbHelper.getDataRow(sql, dsTemp.ConnectionString);

            if (dr != null)
            {
                (new Mess(this)).ShowMessage(" User ID has been existed", Mess.TYPE_ERROR);
            }
            else
            {
                try
                {
                    //Insert into DB
                    dsTemp.InsertCommand = "INSERT INTO TERP_users (user_id,user_name,user_cid,user_full_name,password,user_email,department_id,sys_level_id,status,password_create_time,use_expire,expire_perious,image,image_icon) VALUES ('" +
                        user_id + "','" + user_name + "','" + user_cid + "',N'" + user_full_name + "','" +
                        (encrypt ? (new Cipher()).Encrypt(pass) : pass) + "','" + user_email + "','" + department_id + "','" + user_right + "','" + user_mode + "','" +
                        DateTime.Now.ToString() + "','0','0',null,null)";
                    dsTemp.Insert();

                    saveUserSignatureImage(user_id);

                    (new Mess(this)).ShowMessage("Add new user successfully", Mess.TYPE_SUCCESS);

                    //Clear field
                    //clearFields();

                    //Update grid
                    updateUserGrid();
                }
                catch (Exception ex)
                {
                    (new Mess(this)).ShowMessage("Add new user failed. Connection failed.", Mess.TYPE_ERROR);
                }
            }
        }

        protected void btUserUpdate_Click(object sender, EventArgs e)
        {
            string department_id = ddDepartment.SelectedItem.Value.Trim();
            string user_right = ddUserLevel.SelectedItem.Value;
            string user_mode = ddUserMode.SelectedItem.Text.Trim();
            string user_name = txtUserName.Text.Trim();
            string user_full_name = txtUserFullName.Text.Trim();
            string user_email = txtEmail.Text.Trim();
            string user_id = txtUserID.Text.Trim();
            string user_cid = txtUserCID.Text.Trim();
            string pass = txtPassword.Text.Trim();
            string pass_confirm = txtPasswordConfirm.Text.Trim();

            //Validate input  
            if (!validateInput())
            {
                return;
            }

            //Check exists
            DataTable dt = DbHelper.getDataTable("SELECT user_id FROM TERP_users WHERE user_id='" + user_id + "' ", dsTemp.ConnectionString);

            if (dt.Rows.Count > 1)
            {
                (new Mess(this)).ShowMessage("User Name, User ID or User CID conflicts with other account", Mess.TYPE_ERROR);
            }
            else
            {
                try
                {
                    //Insert into DB
                    dsTemp.UpdateCommand = "UPDATE TERP_users SET user_name='" + user_name + "',user_cid='" + user_cid +
                        "',user_full_name=N'" + user_full_name + "',user_email='" + user_email + "',password='" + (encrypt ? (new Cipher()).Encrypt(pass) : pass) +
                        "',department_id='" + department_id + "',sys_level_id='" + user_right + "',status='" + user_mode + "' " +
                        "WHERE user_id='" + user_id + "'";
                    dsTemp.Update();

                    saveUserSignatureImage(user_id);

                    (new Mess(this)).ShowMessage("Updated user successfully", Mess.TYPE_SUCCESS);

                    //Clear field
                    //clearFields();

                    //Update grid
                    updateUserGrid();
                }
                catch
                {
                    (new Mess(this)).ShowMessage("Update user failed. Connection failed.", Mess.TYPE_ERROR);
                }
            }
        }

        protected void btUserDel_Click(object sender, EventArgs e)
        {
            string user_name = txtUserName.Text.Trim();
            string user_id = txtUserID.Text.Trim();
            string user_cid = txtUserCID.Text.Trim();

            try
            {
                dsTemp.DeleteCommand = "DELETE FROM TERP_users WHERE user_id='" + user_id + "' ";
                dsTemp.Delete();

                (new Mess(this)).ShowMessage("Deleted user successfully", Mess.TYPE_SUCCESS);

                //Clear field
                clearFields();              

                //Update grid
                updateUserGrid();
            }
            catch
            {
                (new Mess(this)).ShowMessage("Delete user failed. Connection failed.", Mess.TYPE_ERROR);
            }
        }

        protected void dsTemp_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.CommandTimeout = 0;
        }

        private string createQuery()
        {
            string sql = "SELECT user_name,user_id,user_cid,user_full_name,department_name,user_email,role,status ";
            sql += "FROM vTERP_Users WHERE ";

            switch (tERPSession.Sys_level_id)
            {
                case TERPSession.SYS_LEVEL_1:
                    sql += "1!=1 ";
                    break;
                case TERPSession.SYS_LEVEL_2:
                case TERPSession.SYS_LEVEL_3:
                case TERPSession.SYS_LEVEL_4:
                case TERPSession.SYS_LEVEL_5:
                    if (ddDepartment.SelectedItem.Text.Trim().Equals(tERPSession.Department_name))
                    {
                        sql += "department_name='" + tERPSession.Department_name + "' ";
                    }
                    else
                    {
                        sql += "1!=1 ";
                    }
                    break;
                case TERPSession.SYS_LEVEL_6:
                    if (ddDepartment.SelectedItem.Text.Trim() != "")
                    {
                        sql += "department_name = '" + ddDepartment.SelectedItem.Text.Trim() + "' ";
                    }
                    else
                    {
                        sql = sql.Replace("WHERE", "");
                    }
                    break;
            }
            sql += "ORDER BY user_id";

            return sql;
        }

        private void updateUserGrid()
        {
            dsUser.SelectCommand = createQuery();
            grUser.DataBind();
            grUser.SelectedIndex = -1;
            lblTotal.Text = DbHelper.getRowCount(dsUser);
        }

        protected void ddDepartment_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (Tools.getPostBackControlName(this).IndexOf("btUserAdd") < 0 && Tools.getPostBackControlName(this).IndexOf("btUserUpdate") < 0)
            {
                updateUserGrid();
            }
            if (Tools.getPostBackControlName(this) != null && Tools.getPostBackControlName(this).IndexOf("bt") < 0)
            {
                clearFields();
            }
        }

        protected void grUser_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (grUser.SelectedIndex >= 0)
            {
                GridViewRow grvRow = grUser.SelectedRow;
                txtUserName.Text = grvRow.Cells[1].Text.Trim().Replace("&nbsp;", "");
                txtUserID.Text = grvRow.Cells[2].Text.Trim();
                txtUserCID.Text = grvRow.Cells[3].Text.Trim().Replace("&nbsp;", "");
                txtUserFullName.Text = grvRow.Cells[4].Text.Trim().Replace("&nbsp;", "");
                txtEmail.Text = grvRow.Cells[6].Text.Trim().Replace("&nbsp;", "");
                //unit
                for (int i = 0; i < ddDepartment.Items.Count; i++)
                {
                    if (ddDepartment.Items[i].Text.Trim().Equals(grvRow.Cells[5].Text.Trim()))
                    {
                        ddDepartment.SelectedIndex = i;
                        break;
                    }
                }
                //level
                for (int i = 0; i < ddUserLevel.Items.Count; i++)
                {
                    if (ddUserLevel.Items[i].Text.Trim().Equals(grvRow.Cells[7].Text.Trim()))
                    {
                        ddUserLevel.SelectedIndex = i;
                        break;
                    }
                }
                //enable

                Label lblstatus = ((Label)grvRow.Cells[7].FindControl("lblStatus"));
                for (int i = 0; i < ddUserMode.Items.Count; i++)
                {
                    if (ddUserMode.Items[i].Text.Trim().Equals(lblstatus.Text))
                    {
                        ddUserMode.SelectedIndex = i;
                        break;
                    }
                }
                loadUserSignatureImage(txtUserID.Text);
            }
        }

        protected void ddRowPerPage_SelectedIndexChanged(object sender, EventArgs e)
        {
            grUser.PageSize = int.Parse(ddRowPerPage.SelectedItem.Text.Trim());
            updateUserGrid();
        }



        /// <summary>
        /// Tab 2
        /// </summary>

        private void updateUserRightGrid()
        {
            string sql = "SELECT user_name,user_id,user_cid,user_full_name,user_email,department_name ";
            sql += "FROM vTERP_users WHERE ";

            switch (tERPSession.Sys_level_id)
            {
                case TERPSession.SYS_LEVEL_1:
                    sql += "1!=1 ";
                    break;
                case TERPSession.SYS_LEVEL_2:
                case TERPSession.SYS_LEVEL_3:
                case TERPSession.SYS_LEVEL_4:
                case TERPSession.SYS_LEVEL_5:
                    if (ddDepartmentRight.SelectedItem.Text.Trim().Equals(tERPSession.Department_name))
                    {
                        sql += "department_name='" + tERPSession.Department_name + "' ";
                    }
                    else
                    {
                        sql += "1!=1 ";
                    }
                    break;
                case TERPSession.SYS_LEVEL_6:
                    sql += "department_name = '" + ddDepartmentRight.SelectedItem.Text.Trim() + "' ";
                    break;
            }
            sql += "AND status='Active' ORDER BY user_id";

            dsUserRight.SelectCommand = sql;
            grUserRight.DataBind();
            grUserRight.SelectedIndex = -1;
            lblTotal.Text = DbHelper.getRowCount(dsUser);

            //reset selected menu/module
            checkAllModule(false);
            //for (int i = 0; i < grModule.Rows.Count; i++)
            //{
            //    ((CheckBox)grModule.Rows[i].FindControl("chkEnable")).Checked = false;
            //}

            //UpdatePanel1.Update();
        }

        protected void ddDepartmentRight_SelectedIndexChanged(object sender, EventArgs e)
        {
            updateUserRightGrid();
        }

        private void checkAllUser(bool check)
        {
            grUserRight.EditIndex = -1;
            for (int i = 0; i < grUserRight.Rows.Count; i++)
            {
                ((CheckBox)grUserRight.Rows[i].FindControl("chkSelect")).Checked = check;
            }

            ((CheckBox)grUserRight.HeaderRow.FindControl("chkAll")).Checked = check;
        }

        private void checkAllModule(bool check)
        {
            for (int i = 0; i < grModule.Rows.Count; i++)
            {
                ((CheckBox)grModule.Rows[i].FindControl("chkEnable")).Checked = check;
            }
        }

        protected void chkAll_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chk = (CheckBox)sender;

            string sql = "SELECT user_name,user_id,user_cid,user_full_name,user_email,department_name FROM vTERP_users " +
                "WHERE department_name='" + ddDepartmentRight.SelectedItem.Text.Trim() + "' AND status='Active' ORDER BY user_id";
            dsUserRight.SelectCommand = sql;
            grUserRight.DataBind();
            lblTotal.Text = DbHelper.getRowCount(dsUser);

            checkAllUser(chk.Checked);
            checkAllModule(false);
        }

        protected void chkSelect_CheckedChanged(object sender, EventArgs e)
        {
            int check_count = 0;

            for (int i=0; i<grUserRight.Rows.Count; i++)
            {
                if (((CheckBox)grUserRight.Rows[i].FindControl("chkSelect")).Checked)
                {
                    check_count++;
                }
            }
//            ((CheckBox)sender)
            if (check_count == 1)
            {
                Label lblID;
                int selected_row = ((GridViewRow)((CheckBox)sender).Parent.Parent).RowIndex;
                string selected_user_id = grUserRight.Rows[selected_row].Cells[2].Text.Trim();

                //reset selected menu/module
                for (int i = 0; i < grModule.Rows.Count; i++)
                {
                    ((CheckBox)grModule.Rows[i].FindControl("chkEnable")).Checked = false;
                }

                //get user module for bellow list
                DataTable dt = DbHelper.getDataTable("SELECT module_id FROM TERP_user_permission WHERE user_id='" + selected_user_id + "'", dsTemp.ConnectionString);

                if (dt != null)
                {
                    string ids = ",";
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        ids += dt.Rows[i].ItemArray[0].ToString().Trim() + ",";
                    }

                    for (int i = 0; i < grModule.Rows.Count; i++)
                    {
                        lblID = ((Label)grModule.Rows[i].FindControl("lblID"));
                        if (ids.IndexOf("," + lblID.Text.Trim() + ",") >= 0)
                        {
                            ((CheckBox)grModule.Rows[i].FindControl("chkEnable")).Checked = true;
                        }
                    }

                    for (int i = 0; i < grModule.Rows.Count; i++)
                    {
                        if (!((CheckBox)grModule.Rows[i].FindControl("chkEnable")).Checked)
                        {
                            ((CheckBox)grModule.HeaderRow.FindControl("chkEnableAll")).Checked = false;
                            return;
                        }
                    }

                    ((CheckBox)grModule.HeaderRow.FindControl("chkEnableAll")).Checked = true;
                }

                if (grUserRight.Rows.Count == 1) {
                    ((CheckBox)grUserRight.HeaderRow.FindControl("chkAll")).Checked = true;
                }
            } else
            {
                if (check_count == grUserRight.Rows.Count)
                    ((CheckBox)grUserRight.HeaderRow.FindControl("chkAll")).Checked = true;

                if (check_count == 0)
                    ((CheckBox)grUserRight.HeaderRow.FindControl("chkAll")).Checked = false;

                checkAllModule(false);
            }
        }

        protected void grUserRight_SelectedIndexChanged(object sender, EventArgs e)
        {
            Label lblID;

            string sql = "SELECT user_name,user_id,user_cid,user_full_name,user_email,department_name FROM vTERP_users WHERE department_name='" + ddDepartmentRight.SelectedItem.Text.Trim() + "' ORDER BY user_id";
            dsUserRight.SelectCommand = sql;
            grUserRight.DataBind();

            string selected_user_id = grUserRight.SelectedRow.Cells[2].Text.Trim();

            //reset selected menu/module
            for (int i = 0; i < grModule.Rows.Count; i++)
            {
                ((CheckBox)grModule.Rows[i].FindControl("chkEnable")).Checked = false;
            }

            //get user module for bellow list
            DataTable dt = DbHelper.getDataTable("SELECT module_id FROM TERP_user_permission WHERE user_id='" + selected_user_id + "'", dsTemp.ConnectionString);

            if (dt != null)
            {
                string ids = ",";
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    ids += dt.Rows[i].ItemArray[0].ToString().Trim() + ",";
                }

                for (int i = 0; i < grModule.Rows.Count; i++)
                {
                    lblID = ((Label)grModule.Rows[i].FindControl("lblID"));
                    if (ids.IndexOf("," + lblID.Text.Trim() + ",") >= 0)
                    {
                        ((CheckBox)grModule.Rows[i].FindControl("chkEnable")).Checked = true;
                    }
                }

                for (int i = 0; i < grModule.Rows.Count; i++)
                {
                    if (!((CheckBox)grModule.Rows[i].FindControl("chkEnable")).Checked)
                    {
                        ((CheckBox)grModule.HeaderRow.FindControl("chkEnableAll")).Checked = false;
                        return;
                    }
                }

                ((CheckBox)grModule.HeaderRow.FindControl("chkEnableAll")).Checked = true;
            }
        }

        protected void User_btUpdateUserAccessRight_Click(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();
            DataRow dr;
            //string sql = "SELECT user_name,user_id,user_cid,user_full_name,user_email,department_name FROM vTERP_Users WHERE department_name='" + ddDepartmentRight.SelectedItem.Text.Trim() + "' ORDER BY user_id";
            //dsUserRight.SelectCommand = sql;
            //grUserRight.DataBind();

            string ids = "";
            string[] ids_ = new string[0];

            for (int i=0; i<grUserRight.Rows.Count; i++)
            {
                if (((CheckBox)grUserRight.Rows[i].FindControl("chkSelect")).Checked)
                {
                    ids += grUserRight.Rows[i].Cells[2].Text.Trim() + ",";
                }
            }

            if (ids.Length>0)
            {
                ids_ = ids.Split(',');
                ids = "'" + ids.Replace(",", "','") + "'";
            }

            if (ids.Length==0)
            {
                string param = "errUpdateAccessright";
                string script = "window.onload = function() { showMessageUserForm('" + param + "'); };";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showMessageUserForm();", script, true);
            } else
            {
                dt.Columns.Add("user_id");
                dt.Columns.Add("module_id");

                string id;
                for (int i = 0; i < grModule.Rows.Count; i++)
                {
                    if (((CheckBox)grModule.Rows[i].FindControl("chkEnable")).Checked)
                    {
                        id = ((Label)grModule.Rows[i].FindControl("lblID")).Text.Trim();
                        for (int j=0; j<ids_.Length; j++)
                        {
                            dr = dt.NewRow();
                            dr[0] = ids_[j];
                            dr[1] = id;
                            dt.Rows.Add(dr);
                        }
                    }
                }

                try
                {
                    //Delete all previous access right
                    dsTemp.DeleteCommand = "DELETE FROM TERP_user_permission WHERE user_id IN (" + ids + ")";
                    dsTemp.Delete();

                    //insert new access right
                    DbHelper.insertBulkIntoDatabaseWithConnectionString(dsTemp.ConnectionString, dt, "TERP_user_permission", "user_id,module_id");

                    //reload menu
                    (this.Master as TERP).LoadMenu();

                    //(new Mess(this)).ShowMessageBar("Access right has been updated", Mess.TYPE_OK);
                    string param = "updAccessRight";
                    string script = "window.onload = function() { showMessageUserForm('" + param + "'); };";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "showMessageUserForm();", script, true);
                }
                catch (Exception ex)
                {
                    //(new Mess(this)).ShowMessageBar("Access right update failed.", Mess.TYPE_NG);
                    string param = "errdAccessRight";
                    string script = "window.onload = function() { showMessageUserForm('" + param + "'); };";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "showMessageUserForm();", script, true);
                }

            }

            //if (grUserRight.SelectedIndex < 0)
            //{
            //    //(new Mess(this)).ShowMessageBar("Please select one user to update access right.", Mess.TYPE_NG);
            //    //return;
            //    string param = "errUpdateAccessright";
            //    string script = "window.onload = function() { showMessageUserForm('" + param + "'); };";
            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "showMessageUserForm();", script, true);
            //    return;
            //}

            //string selected_user_id = grUserRight.Rows[grUserRight.SelectedIndex].Cells[2].Text.Trim();

            //dt.Columns.Add("user_id");
            //dt.Columns.Add("module_id");

            //for (int i = 0; i < grModule.Rows.Count; i++)
            //{
            //    if (((CheckBox)grModule.Rows[i].FindControl("chkEnable")).Checked)
            //    {
            //        dr = dt.NewRow();
            //        dr[0] = selected_user_id;
            //        dr[1] = ((Label)grModule.Rows[i].FindControl("lblID")).Text.Trim();
            //        dt.Rows.Add(dr);
            //    }
            //}

            //try
            //{
            //    //Delete all previous access right
            //    dsTemp.DeleteCommand = "DELETE FROM TERP_user_permission WHERE user_id='" + selected_user_id + "'";
            //    dsTemp.Delete();

            //    //insert new access right
            //    DbHelper.insertBulkIntoDatabaseWithConnectionString(dsTemp.ConnectionString, dt, "TERP_user_permission", "user_id,module_id");

            //    //reload menu
            //    (this.Master as TERP).LoadMenu();

            //    //(new Mess(this)).ShowMessageBar("Access right has been updated", Mess.TYPE_OK);
            //    string param = "updAccessRight";
            //    string script = "window.onload = function() { showMessageUserForm('" + param + "'); };";
            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "showMessageUserForm();", script, true);
            //}
            //catch (Exception ex)
            //{
            //    //(new Mess(this)).ShowMessageBar("Access right update failed.", Mess.TYPE_NG);
            //    string param = "errdAccessRight";
            //    string script = "window.onload = function() { showMessageUserForm('" + param + "'); };";
            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "showMessageUserForm();", script, true);
            //}
        }

        protected void grUser_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int index = e.Row.RowIndex;

                Label lable = (Label)e.Row.FindControl("lblStatus");

                if (lable.Text.Trim() == "Active")
                {
                    lable.CssClass = "bagde-custom_success";
                }
                else
                {
                    lable.CssClass = "bagde-custom_danger";
                }
            }
        }

        protected void chkEnableAll_CheckedChanged(object sender, EventArgs e)
        {
            bool status = ((CheckBox)grModule.HeaderRow.FindControl("chkEnableAll")).Checked;

            for (int i=0; i< grModule.Rows.Count; i++)
            {
                ((CheckBox)grModule.Rows[i].FindControl("chkEnable")).Checked = status;
            }
        }

        protected void chkEnable_CheckedChanged(object sender, EventArgs e)
        {
            for (int i = 0; i < grModule.Rows.Count; i++)
            {
                if (!((CheckBox)grModule.Rows[i].FindControl("chkEnable")).Checked)
                {
                    ((CheckBox)grModule.HeaderRow.FindControl("chkEnableAll")).Checked = false;
                    return;
                }
            }

            ((CheckBox)grModule.HeaderRow.FindControl("chkEnableAll")).Checked = true;
        }

        protected void ddGroupModule_SelectedIndexChanged(object sender, EventArgs e)
        {
            dsModule.SelectCommand = "SELECT DISTINCT id,REPLACE(location,'Forms/','') + ' - ' + message_content as menu_desc FROM vTERP_menu " +
                "WHERE (parent_id!=0 AND enable=1) AND language_code='" + tERPSession.Language_code + "' AND group_id='" + ddGroupModule.SelectedValue + "' ORDER BY menu_desc";
            grModule.DataBind();

            int check_count = 0;
            int check_row = 0;

            for (int i = 0; i < grUserRight.Rows.Count; i++)
            {
                if (((CheckBox)grUserRight.Rows[i].FindControl("chkSelect")).Checked)
                {
                    check_count++;
                    check_row = i;
                }
            }

            if (check_count == 1)
            {
                CheckBox chk = ((CheckBox)grUserRight.Rows[check_row].FindControl("chkSelect"));
                ((CheckBox)grUserRight.HeaderRow.FindControl("chkAll")).Checked = false;
                chkSelect_CheckedChanged(chk, e);
            }
            else
            {
                checkAllModule(false);
            }
        }

        protected void saveUserSignatureImage(string user_id)
        {
            byte[] bytes;

            if (fuSignature.HasFile)
            {
                using (BinaryReader br = new BinaryReader(fuSignature.PostedFile.InputStream))
                {
                    bytes = br.ReadBytes(fuSignature.PostedFile.ContentLength);
                }
                using (SqlConnection conn = new SqlConnection(dsTemp.ConnectionString))
                {
                    string sql = "UPDATE TERP_users SET signature=@Data WHERE user_id='" + user_id + "'";
                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@Data", bytes);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();
                    }
                }

                loadUserSignatureImage(user_id);
            }
        }

        protected void loadUserSignatureImage(string user_id)
        {
            string sql = "SELECT signature FROM TERP_users WHERE user_id='" + user_id + "'";
            SqlConnection conn = new SqlConnection(dsTemp.ConnectionString);
            conn.Open();
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.CommandType = CommandType.Text;
            object data = cmd.ExecuteScalar();
            conn.Close();
            cmd.Dispose();
            if (data != null && data.ToString().Length > 0)
            {
                imgUserImage.ImageUrl = "data:image/png;base64," + Convert.ToBase64String((byte[])data);
            }
            else
            {
                imgUserImage.ImageUrl = "";
            }

        }
    }
}