using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TERP.Libs;
using System.Text;
using System.Data;
using System.Globalization;
using System.Web.UI.HtmlControls;

namespace TERP.Forms.Setting
{
    public partial class frmEmailNotification : System.Web.UI.Page
    {
        TERPSession tERPSession;
        string prefix = "EmailNotification";
        static string mailOption = "";
        static string year = DateTime.Now.Year.ToString();
        static string mailStatus = "0";
        static string mailStatusLabel = "Unseen";
        public string Clients
        {
            get { return tERPSession.User_id; }
        }

        protected void Page_init(object sender, EventArgs e)
        {
            var master = (TERP)Page.Master;
            master.OnLanguageSelected += LanguageSelected;
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
            }
            dsYear.SelectParameters["userID"].DefaultValue = tERPSession.User_id;
            dsYear.DataBind();

            LoadLocalizationMessage();

            lblDisplayYear.Text = year;
            lblDisplayStatus.Text = mailStatusLabel;

            LoadEmail();
        }

        private void LoadLocalizationMessage()
        {
            if (HttpContext.Current.Session["localization"] == null)
            {
                HttpContext.Current.Session["localization"] = Localization.LoadLocalizationMessage("TERP", prefix, tERPSession.Language_code);
            }

            Localization.SetLocalizationMessage(true, this, prefix);
        }

        protected void dsTemp_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.CommandTimeout = 0;
        }

        protected void ddStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            mailStatus = ddStatus.SelectedValue.Trim();
            mailStatusLabel = mailStatus == "0" ? "Unseen" : "Seen";
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }

        protected void ddYear_SelectedIndexChanged(object sender, EventArgs e)
        {
            year = ddYear.SelectedItem.Text.Trim();
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }

        protected void btnRequest_Click(object sender, EventArgs e)
        {
            mailOption = "request";

            lbContent.Text = "";
            lbTimeOfMail.Text = "";

            Page.Response.Redirect(Page.Request.Url.ToString(), true);

        }

        protected void btnTask_Click(object sender, EventArgs e)
        {
            mailOption = "task";

            lbContent.Text = "";
            lbTimeOfMail.Text = "";

            Page.Response.Redirect(Page.Request.Url.ToString(), true);

        }

        public void LoadEmail()
        {

            string queryStr = "";
            if (mailOption == "request")
            {
                queryStr = "SELECT id,noti_content,user_id,viewed,noti_date FROM TERP_email_notification WHERE user_id='" + tERPSession.User_id + "' and type = 0 and Year(noti_date) ='" + year + "' and viewed = '" + mailStatus + "' order by noti_date DESC";
            }
            else if (mailOption == "task")
            {
                queryStr = "SELECT id,noti_content,user_id,viewed,noti_date FROM TERP_email_notification WHERE user_id='" + tERPSession.User_id + "' and type = 1 and Year(noti_date) ='" + year + "' and viewed = '" + mailStatus + "' order by noti_date DESC";
            }

            DataTable dt = DbHelper.getDataTable(queryStr, dsTemp.ConnectionString);

            if (dt != null)
            {
                DataRow[] dtMenu = dt.Select();

                if (dtMenu != null)
                {

                    for (int i = 0; i < dtMenu.Length; i++)
                    {

                        HtmlGenericControl div = new HtmlGenericControl("div");
                        div.ID = "mail" + dtMenu[i].ItemArray[0].ToString().Trim();
                        div.Attributes.Add("class", "mail");

                        HtmlGenericControl span = new HtmlGenericControl("span");
                        string getStringDateTime = dtMenu[i].ItemArray[4].ToString();
                        DateTime timeOfEachEmail = DateTime.Parse(getStringDateTime);

                        if(timeOfEachEmail.Year != DateTime.Now.Year)
                        {
                            span.InnerHtml = timeOfEachEmail.Day.ToString("00") + "-" + timeOfEachEmail.Month.ToString("00") + "-" + timeOfEachEmail.Year.ToString("0000");
                        }else
                        {
                            span.InnerHtml = timeOfEachEmail.Day.ToString("00") + "-" + timeOfEachEmail.Month.ToString("00");
                        }
                        

                        string title = "";
                        Button button = new Button();

                        string data = dtMenu[i].ItemArray[1].ToString().Trim();
                        int firstIndex = data.IndexOf('[');
                        int secondIndex = data.IndexOf(']');
                        int titleLength = (secondIndex - firstIndex) - 1;
                        if (firstIndex.ToString() == "-1" && secondIndex.ToString() == "-1" && titleLength.ToString() == "-1")
                        {
                            bool checkapproved = WebUtility.HtmlDecode(dtMenu[i].ItemArray[1].ToString().Trim()).Contains("been approved");
                            bool checkpo = WebUtility.HtmlDecode(dtMenu[i].ItemArray[1].ToString().Trim()).Contains("Your Purchase Order");
                            if (checkapproved)
                            {
                                if (checkpo)
                                {
                                    title = "Your PO has been approved";
                                }
                                else
                                {
                                    title = "Your PR has been approved";
                                }
                            }
                            else
                            {
                                if (checkpo)
                                {
                                    title = "Your PO has been rejected";
                                }
                                else
                                {
                                    title = "Your PR has been rejected";
                                }
                            }
                        }
                        else
                        {

                            bool checkpo = WebUtility.HtmlDecode(dtMenu[i].ItemArray[1].ToString().Trim()).Contains("You have a Purchase Order");
                            if (checkpo)
                            {
                                title = "PO " + WebUtility.HtmlDecode(data.Substring(firstIndex + 1, titleLength)) + " need to be approved";
                            }
                            else
                            {
                                title = "PR " + WebUtility.HtmlDecode(data.Substring(firstIndex + 1, titleLength)) + " need to be approved";
                            }

                        }

                        button.Text = title;
                        button.ID = dtMenu[i].ItemArray[0].ToString().Trim();
                        button.Click += Submit;
                        //if (dtMenu[i].ItemArray[3].ToString().Trim() == "1")
                        //{
                        //    button.Attributes.Add("class", "viewed");
                        //    span.Attributes.Add("class", "viewed");
                        //}

                        div.Controls.Add(button);
                        div.Controls.Add(span);

                        pnRender.Controls.Add(div);
                    }

                }
            }
        }

        protected void Submit(object sender, EventArgs e)
        {
            string id = (sender as Button).ID;

            Page.ClientScript.RegisterStartupScript(this.GetType(), "HandleMailItem", "HandleMailItem('" + id + "')", true);

            string query = "SELECT noti_content, noti_date from TERP_email_notification where id =" + id;
            string connstring = System.Configuration.ConfigurationManager.ConnectionStrings["TERPConnectionString"].ConnectionString;
            DataRow dr = DbHelper.getDataRow(query, connstring);

            string dstr = dr[0].ToString();

            DateTime maildt = DateTime.Parse(dr[1].ToString());
            lbTimeOfMail.Text = maildt.ToString("dd/MM/yyyy hh:mm tt");
            lbContent.Text = WebUtility.HtmlDecode(dstr);

            dsTemp.UpdateCommand = "UPDATE TERP_email_notification SET viewed=1 WHERE id='" + id + "'";
            dsTemp.Update();

        }

    }
}