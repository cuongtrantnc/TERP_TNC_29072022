using TERP.Libs;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;

namespace TERP
{
    public partial class Login : System.Web.UI.Page
    {
        //Will be removed in next relaese when encrypt/decrypt supported.
        bool encrypted = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            //Password will be encrypted in next release
            //Email mail  = new Email("","","","",null,true);
        }

        protected void btQR_Click(object sender, ImageClickEventArgs e)
        {

        }

        protected void btLogin_Click(object sender, EventArgs e)
        {
            //get input
            string user = txtCardID.Text.Trim();
            string pass = txtPass.Text.Trim();
            string po_no = (string)HttpContext.Current.Session["po_no"];
            string pr_no = (string)HttpContext.Current.Session["pr_no"];

            //check if user not exist
            if (user=="")
            {
                (new Mess(this)).ShowMessage("Please input User ID/User name/User card ID", Mess.TYPE_ERROR);
                return;
            }

            //search in db
            string query = "SELECT user_id,user_name,user_cid,user_full_name,user_email,password,department_id,image_icon,sys_level_id,status " +
                "FROM TERP_users WHERE user_id='" + user + "' OR user_name='" + user + "' OR user_cid='" + user + "' ";

            if (!encrypted)
            {
                query += "AND password='" + pass + "'";
            } 

            DataRow dr = DbHelper.getDataRow(query, dsTemp.ConnectionString);

            //if exist
            if (dr!=null)
            {
                TERPSession TERPSession = new TERPSession(
                                dr[0].ToString(), 
                                dr[1].ToString(), 
                                dr[2].ToString(),
                                dr[3].ToString(),
                                dr[4].ToString(),
                                dr[6].ToString(),
                                (dr[7].ToString()=="") ? null : (byte[])dr[7],
                                int.Parse(dr[8].ToString()),
                                "vi-VN");
                if (dr[7].ToString()== "Inactive") //User has been disabled
                {
                    (new Mess(this)).ShowMessage("User not found", Mess.TYPE_ERROR);
                } else
                {
                    if (encrypted)
                    {
                        if ((new Cipher()).Decrypt(dr[4].ToString().Trim()).Equals(pass))
                        {
                            HttpContext.Current.Session["TERPSession"] = TERPSession;
                            if (pr_no!=null && pr_no!="")
                            {
                                Response.Redirect("/TERP/Forms/PMS/frmPRApproval.aspx?pr_no=" + pr_no + "");
                            } else if (po_no != null && po_no != "")
                            {
                                Response.Redirect("/TERP/Forms/PMS/frmPOApproval.aspx?po_no=" + po_no + "");
                            }
                            else
                            {
                                Response.Redirect("/TERP/Default.aspx");
                            }
                        }
                        else
                        {
                            (new Mess(this)).ShowMessage("Login failed! Invalid username or Password", Mess.TYPE_ERROR);
                        }
                    }
                    else
                    {
                        if (dr[5].ToString().Trim().Equals(pass))
                        {
                            HttpContext.Current.Session["TERPSession"] = TERPSession;
                            if (pr_no != null && pr_no != "")
                            {
                                Response.Redirect("/TERP/Forms/PMS/frmPRApproval.aspx?pr_no=" + pr_no + "");
                            }
                            else if (po_no != null && po_no != "")
                            {
                                Response.Redirect("/TERP/Forms/PMS/frmPOApproval.aspx?po_no=" + po_no + "");
                            }
                            else
                            {
                                Response.Redirect("/TERP/Default.aspx");
                            }
                        } else
                        {
                            (new Mess(this)).ShowMessage("Login failed! Invalid username or Password", Mess.TYPE_ERROR);
                        }
                    } 
                }
            } else
            {
                (new Mess(this)).ShowMessage("Login failed! Invalid username or Password", Mess.TYPE_ERROR);
            }
        }

        protected void dsTemp_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.CommandTimeout = 0;
        }
    }
}