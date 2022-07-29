using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace TERP.Libs
{
    public class Localization
    {
        public static List<string> LoadLocalizationMessage(string module_prefix, string form_prefix, string language_code)
        {
            List<string> list = new List<string>();

            string sql = "SELECT message_id,message_content FROM vTERP_message_localization WHERE module_prefix='" + module_prefix + "' AND message_id LIKE '%" + form_prefix + "_%' AND language_code='" + language_code + "'";
            DataTable dt = DbHelper.getDataTable(sql, Tools.getConnectionString("TERP"));

            if (dt != null)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    list.Add(dt.Rows[i].ItemArray[0].ToString() + "|" + dt.Rows[i].ItemArray[1].ToString());
                }
            }

            return list;
        }

        //Use to get current localization string in session. User for toast message 
        public static string GetLocalizationMessage(string message_id)
        {
            try
            {
                List<string> messages = (List<string>)HttpContext.Current.Session["localization"];

                for (int i = 0; i < messages.Count; i++)
                {
                    if (messages.ElementAt(i).IndexOf(message_id.Trim() + "|") >= 0)
                    {
                        int index = messages.ElementAt(i).IndexOf('|');

                        return messages.ElementAt(i).Substring(index + 1).Trim();
                    }
                }
            }
            catch { }

            return "";
        }

        public static void SetLocalizationMessage(bool root, Control control, string form_prefix)
        {
            Control curent_control = (root) ? ((Page)control).Master.FindControl("TERPContentPlaceHolder") : control;
            TERPSession tERPSession = (TERPSession)HttpContext.Current.Session["tERPSession"];

            foreach (Control ctl in curent_control.Controls)
            {
                if (ctl.HasControls())
                {
                    SetLocalizationMessage(false, ctl, form_prefix);
                } else
                {
                    try
                    {
                        if (ctl is Label && ctl.ID!=null && ctl.ID.IndexOf(form_prefix)>=0)
                        {
                            ((Label)ctl).Text = GetLocalizationMessage(ctl.ID);
                        }
                        if (ctl is Button && ctl.ID.IndexOf(form_prefix) >= 0)
                        {
                            ((Button)ctl).Text = GetLocalizationMessage(ctl.ID);
                        }
                        if (ctl is LinkButton && ctl.ID.IndexOf(form_prefix) >= 0)
                        {
                            HtmlGenericControl html = new HtmlGenericControl();
                            html.InnerHtml = tERPSession.Link_button_css + "&nbsp;" + GetLocalizationMessage(ctl.ID);
                            ((LinkButton)ctl).Controls.Add(html);
                        }
                    }
                    catch { }
                }
            }
        }

    }
}