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
    public partial class frmPOImport : System.Web.UI.Page
    {
        TERPSession tERPSession;
        int row_added = 0;
        string prefix = "POImport";

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
            tERPSession.Link_button_css = "<i class=\"fa fa-upload mr-2\"></i>";
            HttpContext.Current.Session["tERPSession"] = tERPSession;

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

        private string ValidateField(string fields)
        {
            string mess = "";
            string[] tmp = fields.Split(',');

            if (tmp.Length!=22)
            {
                return "The number of field is not correct.";
            }

            if (tmp[0].Trim()=="")
            {
                return "PO No can not be empty.";
            }

            if (tmp[0].Trim().Length>8)
            {
                return "PO No is too long.";
            }

            if (tmp[1].Trim().Length > 8)
            {
                return "Supplier is too long.";
            }

            if (tmp[2].Trim().Length > 28)
            {
                return "Supplier Name is too long.";
            }

            if (tmp[3].Trim().Length > 8)
            {
                return "Ship To is too long.";
            }

            if (tmp[4].Trim() != "")
            {
                int ash = tmp[4].IndexOf("@");
                int point = tmp[4].IndexOf(".",ash);

                if (ash<0)
                {
                    return "Invalid Request By email.";
                }

                if (point<0)
                {
                    return "Invalid Request By email.";
                }
            }

            if (tmp[5].Trim() != "")
            {
                int ash = tmp[5].IndexOf("@");
                int point = tmp[5].IndexOf(".", ash);

                if (ash < 0)
                {
                    return "Invalid Purchaser email.";
                }

                if (point < 0)
                {
                    return "Invalid Purchaser email.";
                }
            }

            if (tmp[6].Trim().Length > 8)
            {
                return "Site is too long.";
            }

            //Request Date
            if (!DatetimeTool.VerifyDate3(tmp[7].Trim()))
            {
                return "Request Date is invalid.";
            }

            if (tmp[8].Trim().Length > 8)
            {
                return "Approval Code is too long.";
            }

            if (tmp[9].Trim().Length > 1)
            {
                return "Email Field is too long.";
            }

            //Status
            //if (tmp[9].Trim().Length > 8)
            //{
            //    //return "Ship To is too long.";
            //}

            try
            {
                int.Parse(tmp[11].Trim());
            } catch
            {
                return "Invalid line.";
            }

            if (tmp[12].Trim().Length > 18)
            {
                return "Item Number is too long.";
            }

            if (tmp[13].Trim().Length > 48)
            {
                return "Item Description is too long.";
            }

            if (tmp[14].Trim().Length > 2)
            {
                return "UM is too long.";
            }

            if (tmp[15].Trim().Length > 4)
            {
                return "Product Line is too long.";
            }

            if (tmp[16].Trim().Length > 8)
            {
                return "Type is too long.";
            }

            //Required QTY
            if (!Tools.checkDOUBLE(tmp[17]))
            {
                return "Required Qty is invalid.";
            }

            if (!Tools.checkDOUBLE(tmp[18]))
            {
                return "Unit Cost is invalid.";
            }

            if (!Tools.checkDOUBLE(tmp[19]))
            {
                return "Discount is invalid.";
            }

            //Need Date
            if (!DatetimeTool.VerifyDate3(tmp[20].Trim()))
            {
                return "Need Date is invalid.";
            }

            //Due Date
            if (!DatetimeTool.VerifyDate3(tmp[21].Trim()))
            {
                return "Due Date is invalid.";
            }

            return mess;
        }

        protected void POImport_btQuery_Click(object sender, EventArgs e)
        {
            string field = "po_no,supplier,supplier_name,ship_to,request_by,purchaser_email,site_name,request_date,approval_code,send_email,status_id,line," +
                "item_number,item_desc,um,prod_line,type,required_qty,unit_cost,disc,need_date,due_date,upload_time,upload_by";
            if (fileUpload.HasFile)
            {
                if (fileUpload.FileName.Substring(fileUpload.FileName.Length - 4).ToLower().IndexOf("csv") < 0)
                {
                    (new Mess(this)).ShowMessage("Upload failed, please re-check format file.", Mess.TYPE_ERROR);
                    return;
                }

                //string file = string.Format("{0}{1}", Request.PhysicalApplicationPath, Guid.NewGuid().ToString().Replace("-", string.Empty));
                //fileUpload.SaveAs(file);
                //DataSet dataSet = (new ExcelHelper()).ExcelToDS(file, "PO_Import_Template");
                //return;

                List<string> content = (new FileHelper(fileUpload)).readFile();
                if (content != null)
                {
                    try
                    {
                        DataTable dt = new DataTable();
                        dt.Columns.Add("po_no");
                        dt.Columns.Add("supplier");
                        dt.Columns.Add("supplier_name");
                        dt.Columns.Add("ship_to");
                        dt.Columns.Add("request_by");
                        dt.Columns.Add("purchaser_email");
                        dt.Columns.Add("site_name");
                        dt.Columns.Add("request_date");
                        dt.Columns.Add("approval_code");
                        dt.Columns.Add("send_email");
                        dt.Columns.Add("status_id");
                        dt.Columns.Add("line");
                        dt.Columns.Add("item_number");
                        dt.Columns.Add("item_desc");
                        dt.Columns.Add("um");
                        dt.Columns.Add("prod_line");
                        dt.Columns.Add("type");
                        dt.Columns.Add("required_qty");
                        dt.Columns.Add("unit_cost");
                        dt.Columns.Add("disc");
                        dt.Columns.Add("need_date");
                        dt.Columns.Add("due_date");
                        dt.Columns.Add("upload_time");
                        dt.Columns.Add("upload_by");

                        DataRow dr;
                        string[] fields;
                        string tmp;
                        string mess;

                        //Ignore first line - title
                        for (int i = 1; i < content.Count; i++)
                        {
                            dr = dt.NewRow();

                            tmp = Tools.FindTextBetween(content[i], ",\"", "\",", ",");

                            mess = ValidateField(tmp);
                            if (mess!="")
                            {
                                (new Mess(this)).ShowMessage("Error: " + mess + " at line: " + (i+1), Mess.TYPE_ERROR);
                                return;
                            }

                            fields = tmp.Split(',');

                            dr["po_no"] = fields[0].ToString().Trim();
                            dr["supplier"] = fields[1].ToString().Trim();
                            dr["supplier_name"] = fields[2].ToString().Trim();
                            dr["ship_to"] = fields[3].ToString().Trim();
                            dr["request_by"] = fields[4].ToString().Trim();
                            dr["purchaser_email"] = fields[5].ToString().Trim();
                            dr["site_name"] = fields[6].ToString().Trim();
                            dr["request_date"] = fields[7].ToString().Trim();
                            dr["approval_code"] = fields[8].ToString().Trim();
                            dr["send_email"] = fields[9].ToString().Trim();
                            switch (fields[10].ToString().Trim().ToUpper())
                            {
                                case "APPROVE":
                                    dr["status_id"] = 3;
                                    break;
                                case "DENY":
                                    dr["status_id"] = 4;
                                    break;
                                default:
                                    dr["status_id"] = 1;
                                    break;
                            }
                            dr["line"] = fields[11].ToString().Trim();
                            dr["item_number"] = fields[12].ToString().Trim();
                            dr["item_desc"] = fields[13].ToString().Trim();
                            dr["um"] = fields[14].ToString().Trim();
                            dr["prod_line"] = fields[15].ToString().Trim();
                            dr["type"] = fields[16].ToString().Trim();
                            dr["required_qty"] = fields[17].ToString().Trim();
                            dr["unit_cost"] = fields[18].ToString().Trim();
                            dr["disc"] = fields[19].ToString().Trim();
                            dr["need_date"] = fields[20].ToString().Trim();
                            dr["due_date"] = fields[21].ToString().Trim();
                            dr["upload_time"] = DateTime.Now.ToString("MM/dd/yyyy");
                            dr["upload_by"] = tERPSession.User_id;

                            dt.Rows.Add(dr);
                        }

                        //empty temp table
                        dsTemp.DeleteCommand = "DELETE FROM PMS_master_po_temp WHERE upload_by='" + tERPSession.User_id + "'";
                        dsTemp.Delete();

                        //insert into temp table to calculate
                        DbHelper.insertBulkIntoDatabaseWithConnectionString(dsTemp.ConnectionString, dt, "PMS_master_po_temp", field);

                        //Check Approval Code active
                        dt = DbHelper.getDataTable("SELECT approval_code FROM PMS_master_po_temp INNER JOIN PMS_po_approval ON " +
                            "PMS_master_po_temp.approval_code=PMS_po_approval.approval_code AND PMS_po_approval.status='Inactive' WHERE PMS_master_po_temp.upload_by='" + tERPSession.User_id + "'", dsTemp.ConnectionString);
                        if (dt != null)
                        {
                            (new Mess(this)).ShowMessage("Approval code: '" + dt.Rows[0].ItemArray[0].ToString() + "' is Inactive", Mess.TYPE_ERROR);
                            return;
                        }

                        //Check valid email
                        dt = DbHelper.getDataTable("SELECT request_by FROM PMS_master_po_temp WHERE upload_by='" + tERPSession.User_id + "' AND RTRIM(LTRIM(request_by))=''", dsTemp.ConnectionString);
                        if (dt == null)
                        {
                            (new Mess(this)).ShowMessage("Request by can not be empty", Mess.TYPE_ERROR);
                            return;
                        }

                        dt = DbHelper.getDataTable("SELECT request_by FROM PMS_master_po_temp WHERE NOT EXISTS (SELECT DISTINCT user_email FROM TERP_users) AND upload_by='" + tERPSession.User_id + "'", dsTemp.ConnectionString);
                        if (dt != null && dt.Rows.Count > 0)
                        {
                            (new Mess(this)).ShowMessage("There is no user that has email as '" + dt.Rows[0].ItemArray[0].ToString().Trim() + "' in Request By field", Mess.TYPE_ERROR);
                            return;
                        }

                        //Send Email
                        dt = DbHelper.getDataTable("SELECT DISTINCT po_no,user_full_name,user_email,user_id FROM vPMS_po_approver_importing WHERE upload_by='" + tERPSession.User_id + "'", dsTemp.ConnectionString);
                        if (dt != null && dt.Rows.Count > 0)
                        {
                            foreach (DataRow row in dt.Rows)
                            {
                                string body = "Dear " + row.ItemArray[1].ToString().Trim() + "<br/><br/>\n";
                                body += "You have a Purchase Order <a href='http://192.168.1.142/terp/Forms/PMS/frmPOApproval.aspx?po_no=" + row.ItemArray[0].ToString().Trim() + "'>[" + row.ItemArray[0].ToString().Trim() + "]</a> need approved." + "<br/><br/>\n";
                                body += "TERP notification system.";
                                (new Email(row.ItemArray[2].ToString().Trim(), "Notification", body, null, true)).send();

                                //dr = DbHelper.getDataRow("SELECT a.user_full_name,a.user_email,a.user_id FROM TERP_users a LEFT JOIN PMS_master_po b ON a.user_email=b.request_by WHERE b.po_no='" + po_no + "'", dsPOApproval.ConnectionString);
                                dsTemp.InsertCommand = "INSERT INTO TERP_email_notification (noti_content,user_id,noti_date,viewed) VALUES ('" +
                                    WebUtility.HtmlEncode(body) + "','" + row.ItemArray[3].ToString().Trim() + "','" + DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss") + "','0')";
                                dsTemp.Insert();
                            }
                        }

                        row_added = 0;
                        //Get number of row will be added
                        dt = DbHelper.getDataTable("SELECT * FROM vPMS_master_po_new_upload", dsTemp.ConnectionString);
                        if (dt != null) row_added = dt.Rows.Count;

                        if (row_added>0)
                        {
                            //add new row from temp table
                            dsTemp.InsertCommand = "INSERT INTO PMS_master_po (" + field + ") SELECT " + field + " FROM vPMS_master_po_new_upload";
                            dsTemp.Insert();
                        }

                        //get new record from temp table
                        //dt = DbHelper.getDataTable("SELECT a.po_no,a.line,a.item_number FROM PMS_master_po a WHERE EXISTS (SELECT b.po_no, b.line, b.item_number FROM PMS_master_po_temp b WHERE upload_by='" + tERPSession.User_id + "' and a.po_no = b.po_no AND a.line = b.line AND a.item_number = b.item_number)", dsTemp.ConnectionString);
                        //if (dt != null && dt.Rows.Count > 0)
                        //{
                        //    row_added = dt.Rows.Count;
                        //}

                        //Remove moved rows
                        dsTemp.DeleteCommand = "DELETE FROM PMS_master_po_temp WHERE po_no IN (SELECT DISTINCT po_no FROM PMS_master_po WHERE upload_by='" + tERPSession.User_id + "')";
                        dsTemp.Delete();

                        //dt = DbHelper.getDataTable("SELECT DISTINCT item_number FROM vPMS_master_item_duplicate_upload", dsTemp.ConnectionString);
                        //string dupplicate = "";
                        //if (dt != null)
                        //{
                        //    for (int i = 0; i < dt.Rows.Count; i++)
                        //    {
                        //        dupplicate += dt.Rows[i].ItemArray[0].ToString().Trim() + " Items Number existed. <br>";
                        //    }
                        //}

                        //string script2 = "'Log List','[" + row_added + "] records has been added & updated','" + dupplicate + "','Đóng'";
                        //ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal(" + script2 + ");", true);

                        (new Mess(this)).ShowMessage("[" + row_added + "] records has been added & updated " + (row_added==0? "because of data existed" : ""), (row_added == 0 ? Mess.TYPE_WARNING : Mess.TYPE_SUCCESS));
                    }
                    catch (Exception ex)
                    {
                        if (ex.Message.IndexOf("type datetime") > 0)
                        {
                            (new Mess(this)).ShowMessage("Date format incorrect. Make sure date value is MM/dd/yyyy format", Mess.TYPE_ERROR);
                        }
                        else
                        {
                            //(new Mess(this)).ShowMessage("Upload failed, please check network or data type in upload file. Error: " + ex.Message, Mess.TYPE_ERROR);
                            (new Mess(this)).ShowMessage("Error: " + ex.Message, Mess.TYPE_ERROR);
                        }
                    }
                }
            }
            else
            {
                (new Mess(this)).ShowMessage("Please select file", Mess.TYPE_INFO);
            }
        }

        protected void dsTemp_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.CommandTimeout = 0;
        }
    }
}