using TERP.Libs;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TERP.Forms
{
    public partial class frmUnitLine : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            TERPSession tERPSession = (TERPSession)HttpContext.Current.Session["tERPSession"];

            if (tERPSession == null)
            {
                (new Mess(this)).show("Please login");
                Response.Redirect("/terp/Login.aspx");
            }

            if (!IsPostBack)
            {
                grUnitDept.DataBind();

                ddUnitLine.DataBind();
                if (ddUnitLine.Items.Count>0)
                {
                    ddUnitLine.SelectedIndex = 0;
                    dsLine.SelectCommand = "SELECT name,enable FROM TERP_line WHERE unit_dept_id='" + ddUnitLine.SelectedItem.Value.Trim() + "' ORDER BY name";
                    grLine.DataBind();
                }
            } 
        }

        protected void btUnitAdd_Click(object sender, EventArgs e)
        {
            string unit_dept = txtUnitName.Text.Trim();
            string desc = txtDescription.Text.Trim();
            string dept = (ddType.SelectedItem.Value == "0") ? "1" : "0";
            string accessible = ddAccessible.SelectedItem.Value;

            if (unit_dept=="")
            {
                (new Mess(this)).ShowMessage("Name can not be blank", Mess.TYPE_ERROR);
            } else
            {
                //check unit exist
                string sql = "SELECT name FROM TERP_unit_dept WHERE name='" + unit_dept + "'";
                DataRow dr = DbHelper.getDataRow(sql,dsTemp.ConnectionString);

                if (dr!=null)
                {
                    (new Mess(this)).ShowMessage("This Department/Unit has been exists.", Mess.TYPE_ERROR);
                    return;
                } else
                {
                    dsTemp.InsertCommand = "INSERT INTO TERP_unit_dept (name,description,is_unit,enable) VALUES ('" + unit_dept + "','" + desc + "','" + dept + "','" + accessible +"')";
                    dsTemp.Insert();

                    //(new Mess(this)).ShowMessageBar("Department/Unit has been added successfully",Mess.TYPE_OK);
                    string param = "adddepartmentSuccess";
                    string script = "window.onload = function() { showMessage_UnitWorkline('" + param + "'); };";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "showMessage_UnitWorkline();", script, true);
                    
                    //Reset form
                    txtUnitName.Text = "";
                    txtDescription.Text = "";
                    grUnitDept.DataBind();
                    return;
                }
            }
        }

        protected void btUnitUpdate_Click(object sender, EventArgs e)
        {
            string unit_dept = txtUnitName.Text.Trim();
            string desc = txtDescription.Text.Trim();
            string dept = (ddType.SelectedItem.Value=="0") ? "1": "0";
            string accessible = ddAccessible.SelectedItem.Value;

            if (unit_dept == "")
            {
                (new Mess(this)).ShowMessage("Name can not be blank", Mess.TYPE_ERROR);
                //(new Mess(this)).show("Department/Unit can not be blank");
            }
            else
            {
                //check unit exist
                string sql = "SELECT name FROM TERP_unit_dept WHERE name='" + unit_dept + "'";
                DataRow dr = DbHelper.getDataRow(sql, dsTemp.ConnectionString);

                if (dr == null)
                {
                    //(new Mess(this)).ShowMessageBar("This Department/Unit has not been exist", Mess.TYPE_NG);
                    //(new Mess(this)).show("This Department/Unit has been exists.");
                    string param = "errDepartmentexist";
                    string script = "window.onload = function() { showMessage_UnitWorkline('" + param + "'); };";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "showMessage_UnitWorkline();", script, true);
                    return;
                }
                else
                {
                    dsTemp.UpdateCommand = "UPDATE unit_dept SET description='" + desc + "',is_unit='" + dept + "',enable='" + accessible + "' " +
                        "WHERE name='" + unit_dept + "'";
                    dsTemp.Update();

                    //(new Mess(this)).ShowMessageBar("Department/Unit has been updated successfully", Mess.TYPE_OK);
                    string param = "updDepartmentSuccess";
                    string script = "window.onload = function() { showMessage_UnitWorkline('" + param + "'); };";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "showMessage_UnitWorkline();", script, true);

                    // Reset Form 
                    grUnitDept.DataBind();
                    txtUnitName.Text = "";
                    txtDescription.Text = "";
                }
            }
        }

        protected void btUnitDel_Click(object sender, EventArgs e)
        {
            string unit_dept = txtUnitName.Text.Trim();
            if (unit_dept == "")
            {
                (new Mess(this)).ShowMessage("Name can not be blank", Mess.TYPE_ERROR);
                //(new Mess(this)).show("Department/Unit can not be blank");
            }
            else
            {
                dsTemp.DeleteCommand = "DELETE FROM TERP_unit_dept WHERE name='" + unit_dept + "'";
                dsTemp.Delete();

                //(new Mess(this)).ShowMessageBar("Department/Unit has been deleted successfully", Mess.TYPE_OK);
                string param = "delDepartmentSuccess";
                string script = "window.onload = function() { showMessage_UnitWorkline('" + param + "'); };";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showMessage_UnitWorkline();", script, true);

                // Reset Form 
                grUnitDept.DataBind();
                txtUnitName.Text = "";
                txtDescription.Text = "";
            }
        }

        protected void grUnitDept_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //CheckBox chk;
            if (e.Row.RowType==DataControlRowType.DataRow)
            {
                e.Row.Cells[3].Text = (e.Row.Cells[3].Text.Trim() == "1") ? "Work Center" : "Department";


                Label lable = (Label)e.Row.FindControl("lblStatus");

                if (lable.Text.Trim() == "1")
                {
                    lable.Text = "Active";
                    lable.CssClass = "bagde-custom_success";
                }
                else
                {
                    lable.Text = "Inactive";
                    lable.CssClass = "bagde-custom_danger";
                }
                //chk = (CheckBox)e.Row.FindControl("chkEnable");
                //chk.Checked = (e.Row.Cells[4].Text.Trim() == "0") ? false : true;
                //e.Row.Cells[4].Visible = false;
            }

            //if (e.Row.RowType==DataControlRowType.Header)
            //{
            //    e.Row.Cells[4].Visible = false;
            //}
        }

        protected void grUnitDept_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (grUnitDept.SelectedIndex>=0)
            {
                txtUnitName.Text = grUnitDept.SelectedRow.Cells[1].Text.Trim();
                txtDescription.Text = grUnitDept.SelectedRow.Cells[2].Text.Replace("&nbsp;","").Trim();
                ddType.SelectedValue = grUnitDept.SelectedRow.Cells[3].Text.Trim().Equals("Work Center") ? "0" : "1";
                //ddAccessible.SelectedValue = grUnitDept.SelectedRow.Cells[4].Text.Trim();

                GridViewRow grvRow = grUnitDept.SelectedRow;
                Label lblstatus = ((Label)grvRow.Cells[4].FindControl("lblStatus"));
                for (int i = 0; i < ddAccessible.Items.Count; i++)
                {
                    if (ddAccessible.Items[i].Text.Trim().Equals(lblstatus.Text))
                    {
                        ddAccessible.SelectedIndex = i;
                        break;
                    }
                }
                
            }
        }

        protected void ddUnitRowPerPage_SelectedIndexChanged(object sender, EventArgs e)
        {
            grUnitDept.PageSize = int.Parse(ddUnitRowPerPage.SelectedItem.Text.Trim());
            grUnitDept.DataBind();
        }

        protected void ddUnitLine_SelectedIndexChanged(object sender, EventArgs e)
        {
            dsLine.SelectCommand = "SELECT name,enable FROM TERP_line WHERE unit_dept_name='" + ddUnitLine.SelectedItem.Text.Trim() + "' ORDER BY name";
            grLine.DataBind();
        }

        protected void btWorklineAdd_Click(object sender, EventArgs e)
        {
            string unit_dept = ddUnitLine.SelectedItem.Text.Trim();
            string line = txtWorkLine.Text.Trim();
            string accessible = ddLineAccessible.SelectedItem.Value;

            //check unit exist
            string sql = "SELECT name FROM TERP_line WHERE name='" + line + "' AND unit_dept_name='" + unit_dept + "'";
            DataRow dr = DbHelper.getDataRow(sql, dsTemp.ConnectionString);

            if (dr != null)
            {
                //(new Mess(this)).ShowMessageBar("This ProLine has been exist", Mess.TYPE_NG);
                //(new Mess(this)).show("This Department/Unit has been exists.");
                string param = "errProLineexist";
                string script = "window.onload = function() { showMessage_UnitWorkline('" + param + "'); };";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showMessage_UnitWorkline();", script, true);
                return;
            }
            else
            {
                dsTemp.InsertCommand = "INSERT INTO TERP_line (unit_dept_name,name,enable) VALUES ('" + unit_dept + "','" + line + "','" + accessible + "')";
                dsTemp.Insert();

                //(new Mess(this)).ShowMessageBar("Production line has been added successfully.", Mess.TYPE_OK);
                string param = "addProLinesuccess";
                string script = "window.onload = function() { showMessage_UnitWorkline('" + param + "'); };";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showMessage_UnitWorkline();", script, true);

                dsLine.SelectCommand = "SELECT name,enable FROM TERP_line WHERE unit_dept_name='" + ddUnitLine.SelectedItem.Text.Trim() + "' ORDER BY name";
                grLine.DataBind();
                txtWorkLine.Text = "";
            }

        }

        protected void btWorklineUpdate_Click(object sender, EventArgs e)
        {
            string unit_dept = ddUnitLine.SelectedItem.Text.Trim();
            string line = txtWorkLine.Text.Trim();
            string accessible = ddLineAccessible.SelectedItem.Value;

            if (grLine.SelectedIndex<0)
            {
                //(new Mess(this)).ShowMessageBar("Please select one line to update", Mess.TYPE_NG);
                string param = "errProLine";
                string script = "window.onload = function() { showMessage_UnitWorkline('" + param + "'); };";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showMessage_UnitWorkline();", script, true);
                return;
            }

            string old_line = grLine.Rows[grLine.SelectedIndex].Cells[1].Text.Trim();

            //check line exist
            string sql = "SELECT name FROM TERP_line WHERE name='" + line + "' AND unit_dept_name='" + unit_dept + "' AND enable='" + accessible + "'";
            DataRow dr = DbHelper.getDataRow(sql, dsTemp.ConnectionString);

            if (dr!=null /*&& line!=grLine.SelectedRow.Cells[1].Text.Trim()*/)
            {
                //(new Mess(this)).ShowMessageBar("This production line has been exist. Can't update to exist production line.", Mess.TYPE_NG);
                //(new Mess(this)).show("This Department/Unit has been exists.");
                string param = "updProLineExist";
                string script = "window.onload = function() { showMessage_UnitWorkline('" + param + "'); };";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showMessage_UnitWorkline();", script, true);
                return;
            }
            else
            {
                dsTemp.UpdateCommand = "UPDATE TERP_line SET name='" + line + "',enable='" + accessible + "' WHERE name='" + old_line + "' AND unit_dept_name='" + unit_dept + "'";
                dsTemp.Update();

                //(new Mess(this)).ShowMessageBar("Production line has been updated successfully.", Mess.TYPE_OK);
                string param = "updProLineSuccess";
                string script = "window.onload = function() { showMessage_UnitWorkline('" + param + "'); };";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showMessage_UnitWorkline();", script, true);

                dsLine.SelectCommand = "SELECT name,enable FROM line WHERE unit_dept_name='" + ddUnitLine.SelectedItem.Text.Trim() + "' ORDER BY name";
                grLine.DataBind();
                txtWorkLine.Text = "";
                grLine.SelectedIndex = -1;
                return;
            }
        }

        protected void btWorklineDelete_Click(object sender, EventArgs e)
        {
            string unit_dept = ddUnitLine.SelectedItem.Text.Trim();
            string line = txtWorkLine.Text.Trim();

            //check unit exist
            string sql = "SELECT name FROM TERP_line WHERE name='" + line + "' AND unit_dept_name='" + unit_dept + "'";
            DataRow dr = DbHelper.getDataRow(sql, dsTemp.ConnectionString);

            if (dr == null)
            {
                //(new Mess(this)).ShowMessageBar("Please select the production line.", Mess.TYPE_NG);
                //(new Mess(this)).show("Department/Unit can not be blank");
                string param = "errProLineSelect";
                string script = "window.onload = function() { showMessage_UnitWorkline('" + param + "'); };";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showMessage_UnitWorkline();", script, true);
                return;
            }
            else
            {
                dsTemp.DeleteCommand = "DELETE FROM TERP_line WHERE name='" + line + "' AND unit_dept_name='" + unit_dept + "'";
                dsTemp.Delete();

                //(new Mess(this)).ShowMessageBar("Production line has been deleted successfully", Mess.TYPE_OK);
                string param = "delProLineSuccess";
                string script = "window.onload = function() { showMessage_UnitWorkline('" + param + "'); };";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showMessage_UnitWorkline();", script, true);

                dsLine.SelectCommand = "SELECT name,enable FROM line WHERE unit_dept_name='" + ddUnitLine.SelectedItem.Text.Trim() + "' ORDER BY name";
                grLine.DataBind();
                txtWorkLine.Text = "";
            }
        }

        protected void grLine_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (grLine.SelectedIndex >= 0)
            {
                txtWorkLine.Text = grLine.SelectedRow.Cells[1].Text.Trim();
                //ddLineAccessible.SelectedValue = ((CheckBox)grLine.SelectedRow.FindControl("chkEnable")).Checked ? "1" : "0";

                GridViewRow grvRow = grLine.SelectedRow;
                Label lbbStatus = ((Label)grvRow.Cells[2].FindControl("lblStatus"));
                for(int i =0; i <= ddLineAccessible.Items.Count; i++)
                {
                    if (ddLineAccessible.Items[i].Text.Trim().Equals(lbbStatus.Text))
                    {
                        ddLineAccessible.SelectedIndex = i;
                        break;
                    }
                }
            }
        }

        protected void grLine_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //CheckBox chk;
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //chk = (CheckBox)e.Row.FindControl("chkEnable");
                //chk.Checked = (e.Row.Cells[2].Text.Trim() == "0") ? false : true;

                Label lable = (Label)e.Row.FindControl("lblStatus");

                if (lable.Text.Trim() == "1")
                {
                    lable.Text = "Active";
                    lable.CssClass = "bagde-custom_success";
                }
                else
                {
                    lable.Text = "Inactive";
                    lable.CssClass = "bagde-custom_danger";
                }
            }

            //if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.Header)
            //    e.Row.Cells[2].Visible = false;
        }

        protected void ddLineRowPerPage_SelectedIndexChanged(object sender, EventArgs e)
        {
            grLine.PageSize = int.Parse(ddLineRowPerPage.SelectedItem.Text.Trim());
            dsLine.SelectCommand = "SELECT name,enable FROM TERP_line WHERE unit_dept_name='" + ddUnitLine.SelectedItem.Text.Trim() + "' ORDER BY name";
            grLine.DataBind();
        }

        protected void dsTemp_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.CommandTimeout = 0;
        }

        protected void dsUnitDept_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.CommandTimeout = 0;
        }

        protected void dsUnitDeptLine_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.CommandTimeout = 0;
        }

        protected void dsRowPerPage_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.CommandTimeout = 0;
        }

        protected void dsLine_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.CommandTimeout = 0;
        }

        protected void dsLineRowPerPage_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.CommandTimeout = 0;
        }
    }
}