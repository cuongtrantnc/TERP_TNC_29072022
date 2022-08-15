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
    public partial class frmItemImport : System.Web.UI.Page
    {
        TERPSession tERPSession;
        int row_added = 0;
        string prefix = "ItemImport";

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
        }

        private void LoadLocalizationMessage()
        {
            if (HttpContext.Current.Session["localization"] == null)
            {
                HttpContext.Current.Session["localization"] = Localization.LoadLocalizationMessage("PMS", prefix, tERPSession.Language_code);
            }

            Localization.SetLocalizationMessage(true, this, prefix);
        }

        protected void ItemImport_btUpload_Click(object sender, EventArgs e)
        {
            if (fileUpload.HasFile)
            {
                if (fileUpload.FileName.Substring(fileUpload.FileName.Length-4).ToLower().IndexOf("csv")<0)
                {
                    (new Mess(this)).ShowMessage("Upload failed, please re-check format file.", Mess.TYPE_ERROR);
                    return;
                }

                List<string> content = (new FileHelper(fileUpload)).readFile();
                if (content != null)
                {
                    try
                    {
                        DataTable dt = new DataTable();
                        dt.Columns.Add("site");
                        dt.Columns.Add("item_number");
                        dt.Columns.Add("description");
                        dt.Columns.Add("um");
                        dt.Columns.Add("prod_line");
                        dt.Columns.Add("type");
                        dt.Columns.Add("status");
                        dt.Columns.Add("upload_time");
                        dt.Columns.Add("upload_by");

                        DataRow dr;
                        string[] fields;

                        //Ignore first line - title
                        for (int i = 1; i < content.Count; i++)
                        {
                            dr = dt.NewRow();
                            fields = content[i].Split(',');
                            dr["site"] = fields[0].Trim();
                            dr["item_number"] = fields[1].Trim();
                            dr["description"] = fields[2].Trim();
                            dr["um"] = fields[3].Trim();
                            dr["prod_line"] = fields[4].Trim();
                            dr["type"] = fields[5].Trim();
                            dr["status"] = fields[6].Trim();
                            dr["upload_time"] = DateTime.Now.ToString("MM/dd/yyyy");
                            dr["upload_by"] = tERPSession.User_id;

                            dt.Rows.Add(dr);
                        }

                        //empty temp table
                        dsTemp.DeleteCommand = "DELETE FROM PMS_master_item_temp WHERE upload_by='" + tERPSession.User_id + "'";
                        dsTemp.Delete();

                        //insert into temp table to calculate
                        DbHelper.insertBulkIntoDatabaseWithConnectionString(dsTemp.ConnectionString, dt, "PMS_master_item_temp", 
                            "site,item_number,description,um,prod_line,type,status,upload_time,upload_by");

                        dt = DbHelper.getDataTable("SELECT DISTINCT item_number FROM vPMS_master_item_duplicate_upload", dsTemp.ConnectionString);
                        string dupplicate = "";
                        if (dt != null)
                        {
                            for (int i = 0; i < dt.Rows.Count; i++)
                            {
                                dupplicate += dt.Rows[i].ItemArray[0].ToString().Trim() + " Items Number existed. <br/>";
                            }
                        }

                        row_added = 0;
                        //get new record from temp table
                        dt = DbHelper.getDataTable("SELECT DISTINCT item_number FROM vPMS_master_item_new_upload", dsTemp.ConnectionString);
                        if (dt != null && dt.Rows.Count>0)
                        {
                            //add new row from temp table
                            dsTemp.InsertCommand = "INSERT INTO PMS_master_item (site,item_number,description,um,prod_line,type,status,upload_time,upload_by)" +
                                "SELECT site,item_number,description,um,prod_line,type,status,upload_time,upload_by FROM vPMS_master_item_new_upload";
                            dsTemp.Insert();
                            row_added = dt.Rows.Count;
                        }

                        //Remove moved rows
                        dsTemp.DeleteCommand = "DELETE FROM PMS_master_item_temp WHERE item_number IN (SELECT DISTINCT item_number FROM PMS_master_item WHERE upload_by='" + tERPSession.User_id + "')";
                        dsTemp.Delete();

                        string script2 = "'Log List','[" + row_added + "] records has been added & updated','" + dupplicate + "','Đóng'";
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal(" + script2  + ");", true);

                    }
                    catch (Exception ex)
                    {
                        if (ex.Message.IndexOf("type datetime") > 0)
                        {
                            (new Mess(this)).ShowMessage("Date format incorrect. Make sure date value is MM/dd/yyyy format", Mess.TYPE_ERROR);
                        }
                        else
                        {
                            (new Mess(this)).ShowMessage("Upload failed, please check network or data type in upload file",Mess.TYPE_ERROR);
                        }
                    }
                }
            } else
            {
                (new Mess(this)).ShowMessage("Please select file", Mess.TYPE_INFO);
            }
        }

        protected void dsTemp_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.CommandTimeout = 0;
        }

        protected void btShowPopup_Click(object sender, EventArgs e)
        {

        }
    }
}