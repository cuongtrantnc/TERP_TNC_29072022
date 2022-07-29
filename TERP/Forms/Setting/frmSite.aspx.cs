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
    public partial class frmSite : System.Web.UI.Page
    {
        TERPSession tERPSession;
        string prefix = "Site";

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
                HttpContext.Current.Session["localization"] = Localization.LoadLocalizationMessage("TERP", prefix, tERPSession.Language_code);
                SetLanguageToDropDownList();
            }

            LoadLocalizationMessage();

            if (!IsPostBack)
            {
                grSite.DataBind();
                lblTotal.Text = DbHelper.getRowCount(dsSite);

                grDepartment.DataBind();
                lblTotalDepartment.Text = DbHelper.getRowCount(dsDept);
            }

            //if (Tools.getPostBackControlName(this)== "ddDeptSite")
            //{
            //    grDepartment.DataBind();
            //}
           
        }

        private void LoadLocalizationMessage()
        {
            HttpContext.Current.Session["localization"] = Localization.LoadLocalizationMessage("TERP", prefix, tERPSession.Language_code);
            Localization.SetLocalizationMessage(true, this, prefix);
        }

        protected void Site_btSiteAdd_Click(object sender, EventArgs e)
        {
            string site_name = txtSiteName.Text.Trim();
            string desc = txtDescription.Text.Trim();
            string accessible = ddAccessible.SelectedItem.Text.Trim();

            if (site_name == "")
            {
                (new Mess(this)).ShowMessage("Site Code can not be null", Mess.TYPE_ERROR);
            }
            else
            {
                //check unit exist
                string sql = "SELECT name FROM TERP_site WHERE name='" + site_name + "'";
                DataRow dr = DbHelper.getDataRow(sql, dsTemp.ConnectionString);

                if (dr != null)
                {
                    (new Mess(this)).ShowMessage("This Site Code has been exist", Mess.TYPE_WARNING);
                }
                else
                {
                    dsTemp.InsertCommand = "INSERT INTO TERP_site (name,description,status) VALUES ('" + site_name + "',N'" + desc + "','" + accessible + "')";
                    dsTemp.Insert();

                    (new Mess(this)).ShowMessage("Site has been added successfully", Mess.TYPE_SUCCESS);

                    //Reset form
                    txtSiteName.Text = "";
                    txtDescription.Text = "";
                    grSite.DataBind();
                    lblTotal.Text = DbHelper.getRowCount(dsSite);
                    ddDeptSite.DataBind();
                }
            }
        }

        protected void Site_btSiteUpdate_Click(object sender, EventArgs e)
        {
            string site_name = txtSiteName.Text.Trim();
            string site_name_backup = txtSiteNameBackUp.Text.Trim();
            string desc = txtDescription.Text.Trim();
            string accessible = ddAccessible.SelectedItem.Text.Trim();

            if (site_name == "")
            {
                (new Mess(this)).ShowMessage("Site Name can not be null", Mess.TYPE_WARNING);
            }
            else if (site_name!= site_name_backup)
            {
                (new Mess(this)).ShowMessage("Site Name can not be changed", Mess.TYPE_WARNING);
            }
            else
            {
                //check unit exist
                string sql = "SELECT name FROM TERP_site WHERE name='" + site_name + "'";
                DataRow dr = DbHelper.getDataRow(sql, dsTemp.ConnectionString);

                if (dr == null)
                {
                    (new Mess(this)).ShowMessage("This Site Code has been exist", Mess.TYPE_WARNING);
                }
                else
                {
                    dsTemp.UpdateCommand = "UPDATE TERP_site SET description=N'" + desc + "',status='" + accessible + "' " +
                        "WHERE name='" + site_name + "'";
                    dsTemp.Update();

                    (new Mess(this)).ShowMessage("Site has been updated successfully", Mess.TYPE_SUCCESS);

                    // Reset Form 
                    grSite.DataBind();
                    lblTotal.Text = DbHelper.getRowCount(dsSite);
                    txtSiteName.Text = "";
                    txtDescription.Text = "";
                }
            }
        }

        protected void Site_btSiteDel_Click(object sender, EventArgs e)
        {
            string site_name = txtSiteName.Text.Trim();
            if (site_name == "")
            {
                (new Mess(this)).ShowMessage("Site Name can not be null", Mess.TYPE_WARNING);
            }
            else
            {
                dsTemp.DeleteCommand = "DELETE FROM TERP_site WHERE name='" + site_name + "'";
                dsTemp.Delete();

                (new Mess(this)).ShowMessage("Site has been deleted successfully", Mess.TYPE_SUCCESS);

                // Reset Form 
                grSite.DataBind();
                lblTotal.Text = DbHelper.getRowCount(dsSite);
                txtSiteName.Text = "";
                txtDescription.Text = "";
            }
        }

        protected void grSite_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (grSite.SelectedIndex >= 0)
            {
                txtSiteName.Text = grSite.SelectedRow.Cells[1].Text.Trim();
                txtSiteNameBackUp.Text = grSite.SelectedRow.Cells[1].Text.Trim();
                txtDescription.Text = grSite.SelectedRow.Cells[2].Text.Replace("&nbsp;", "").Trim();
                ddAccessible.SelectedValue = grSite.SelectedRow.Cells[3].Text.Trim();
            }
        }

        protected void ddRowPerPage_SelectedIndexChanged(object sender, EventArgs e)
        {
            grSite.PageSize = int.Parse(ddRowPerPage.SelectedItem.Text.Trim());
            grSite.DataBind();
        }

        protected void dsTemp_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.CommandTimeout = 0;
        }


        /*DEPARTMENT TAB*/


        protected void Site_btDeptAdd_Click(object sender, EventArgs e)
        {
            string site_id = ddDeptSite.SelectedItem.Value.Trim();
            string dept_code = txtDeptCode.Text.Trim();
            string desc = txtDeptDesc.Text.Trim();
            string accessible = ddDeptStatus.SelectedItem.Text.Trim();

            if (dept_code == "")
            {
                (new Mess(this)).ShowMessage("Department Code can not be null", Mess.TYPE_ERROR);
            }
            else
            {
                //check unit exist
                string sql = "SELECT name FROM TERP_department WHERE name='" + dept_code + "'";
                DataRow dr = DbHelper.getDataRow(sql, dsTemp.ConnectionString);

                if (dr != null)
                {
                    (new Mess(this)).ShowMessage("This Department has been exist", Mess.TYPE_WARNING);
                }
                else
                {
                    dsTemp.InsertCommand = "INSERT INTO TERP_department (site_id,name,description,status) VALUES ('" + site_id + "','" + dept_code + "',N'" + desc + "','" + accessible + "')";
                    dsTemp.Insert();

                    (new Mess(this)).ShowMessage("Department has been added successfully", Mess.TYPE_SUCCESS);

                    //Reset form
                    //txtSiteName.Text = "";
                    //txtDescription.Text = "";
                    grDepartment.DataBind();
                    lblTotalDepartment.Text = DbHelper.getRowCount(dsDept);
                }
            }
        }

        protected void Site_btDeptUpdate_Click(object sender, EventArgs e)
        {
            string dept_code = txtDeptCode.Text.Trim();
            string dept_code_backup = txtDeptCodeBackup.Text.Trim();
            string desc = txtDeptDesc.Text.Trim();
            string accessible = ddDeptStatus.SelectedItem.Text.Trim();
            string site_id = ddDeptSite.SelectedItem.Value.Trim();

            if (dept_code == "")
            {
                (new Mess(this)).ShowMessage("Department Code can not be null", Mess.TYPE_WARNING);
            }
            else if (dept_code != dept_code_backup)
            {
                (new Mess(this)).ShowMessage("Department Code can not be changed", Mess.TYPE_WARNING);
            }
            else
            {
                //check unit exist
                string sql = "SELECT name FROM TERP_department WHERE name='" + dept_code + "'";
                DataRow dr = DbHelper.getDataRow(sql, dsTemp.ConnectionString);

                if (dr == null)
                {
                    (new Mess(this)).ShowMessage("This Department Code has been exist", Mess.TYPE_WARNING);
                }
                else
                {
                    dsTemp.UpdateCommand = "UPDATE TERP_department SET description=N'" + desc + "',status='" + accessible + "',site_id='" + site_id + "' " +
                        "WHERE name='" + dept_code + "'";
                    dsTemp.Update();

                    (new Mess(this)).ShowMessage("Department has been updated successfully", Mess.TYPE_SUCCESS);

                    // Reset Form 
                    grDepartment.DataBind();
                    lblTotalDepartment.Text = DbHelper.getRowCount(dsDept);
                    //txtSiteName.Text = "";
                    //txtDescription.Text = "";
                }
            }
        }

        protected void Site_btDeptDelete_Click(object sender, EventArgs e)
        {
            string dept_code = txtDeptCode.Text.Trim();
            if (dept_code == "")
            {
                (new Mess(this)).ShowMessage("Department Code can not be null", Mess.TYPE_WARNING);
            }
            else
            {
                dsTemp.DeleteCommand = "DELETE FROM TERP_department WHERE name='" + dept_code + "'";
                dsTemp.Delete();

                (new Mess(this)).ShowMessage("Site has been deleted successfully", Mess.TYPE_SUCCESS);

                // Reset Form 
                grDepartment.DataBind();
                lblTotalDepartment.Text = DbHelper.getRowCount(dsDept);
                //txtSiteName.Text = "";
                //txtDescription.Text = "";
            }
        }

        protected void grDepartment_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (grDepartment.SelectedIndex >= 0)
            {
                txtDeptCode.Text = grDepartment.SelectedRow.Cells[1].Text.Trim();
                txtDeptCodeBackup.Text = grDepartment.SelectedRow.Cells[1].Text.Trim();
                txtDeptDesc.Text = grDepartment.SelectedRow.Cells[2].Text.Replace("&nbsp;", "").Trim();
                ddDeptStatus.SelectedValue = grDepartment.SelectedRow.Cells[4].Text.Trim();

                DataRow dr = DbHelper.getDataRow("SELECT site_id FROM TERP_site WHERE name='" + grDepartment.SelectedRow.Cells[3].Text.Trim() + "'", dsTemp.ConnectionString);
                if (dr!=null)
                {
                    ddDeptSite.SelectedValue = dr[0].ToString().Trim();
                }
            }
        }

        protected void ddDeptRowPerPage_SelectedIndexChanged(object sender, EventArgs e)
        {
            grDepartment.PageSize = int.Parse(ddDeptRowPerPage.SelectedItem.Text.Trim());
            grDepartment.DataBind();
        }

        protected void grSite_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
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

        protected void grDepartment_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
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
    }
}