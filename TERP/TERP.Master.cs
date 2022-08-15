using TERP.Libs;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TERP
{
    public partial class TERP : System.Web.UI.MasterPage
    {
        TERPSession tERPSession;
        public delegate void LanguageSelected(object sender, String SelectedValue);
        public event LanguageSelected OnLanguageSelected;

        protected void Page_Load(object sender, EventArgs e)
        {
            tERPSession = (TERPSession)HttpContext.Current.Session["TERPSession"];

            if (!IsPostBack)
            {
                try
                {
                    LoadMenu();
                } catch
                {

                }
            }

            //try
            //{
            //    ddLanguage.DataBind();
            //    for (int i = 0; i < ddLanguage.Items.Count; i++)
            //    {
            //        if (ddLanguage.Items[i].Text.Trim() == tERPSession.Language_code)
            //        {
            //            ddLanguage.SelectedIndex = i;
            //            break;
            //        }
            //    }
            //}
            //catch { }
        }

        public void LoadMenu()
        {
            StringBuilder sbMenu = new StringBuilder();

            DataTable dt = DbHelper.getDataTable(
                "SELECT id,message_content,location,link,parent_id,sort,protected,enable,icon FROM vTERP_Menu WHERE (user_id='" + tERPSession.User_id + "' OR parent_id=0) AND language_code='" + tERPSession.Language_code + "' AND enable=1", 
                dsTemp.ConnectionString);

            //Next release will check user permission on each menu to show or not

            if (dt!=null)
            {
                DataRow[] dtMenu = dt.Select("parent_id=0", "sort ASC");

                if (dtMenu!=null)
                {
                    for (int i = 0; i < dtMenu.Length; i++)
                    {
                        string id = dtMenu[i].ItemArray[0].ToString().Trim();
                        DataRow[] dtSubMenu = dt.Select("parent_id='" + id + "'", "sort ASC");
                        
                        if (dtSubMenu.Length > 0)
                        {
                            sbMenu.AppendLine("<li class='nav-item'>");
                            sbMenu.AppendLine("<a href='" + dtMenu[i].ItemArray[3].ToString().Trim() + "' class='nav-link'>");
                            sbMenu.AppendLine("<i class='" + dtMenu[i].ItemArray[8].ToString() + "'></i>");
                            sbMenu.AppendLine("<p>" + dtMenu[i].ItemArray[1].ToString().Trim());
                            sbMenu.AppendLine("<i class='fas fa-angle-left right'></i>");
                            sbMenu.AppendLine("</p>\n</a>");

                            //Sub menu - don't support three layers menu tree
                            if (dtSubMenu != null)
                            {
                                sbMenu.AppendLine("<ul class='nav nav-treeview'>");

                                for (int j = 0; j < dtSubMenu.Length; j++)
                                {
                                    sbMenu.AppendLine("<li class='nav-item'>");
                                    sbMenu.AppendLine("<a href='/TERP/" + dtSubMenu[j].ItemArray[2].ToString().Trim() + "/" +
                                        dtSubMenu[j].ItemArray[3].ToString().Trim() + "' class='nav-link'>");
                                    sbMenu.AppendLine("<i class='" + dtSubMenu[j].ItemArray[8].ToString() + "'></i>");
                                    sbMenu.AppendLine("<p>" + dtSubMenu[j].ItemArray[1].ToString().Trim() + "</p>");
                                    sbMenu.AppendLine("</a>\n</li>");
                                }

                                sbMenu.AppendLine("</ul>");
                            }

                            sbMenu.AppendLine("</li>");
                        }
                    }
                }
            }

            mnuLiteral.Text = sbMenu.ToString() + "<p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p>";
            lblUserName.Text = tERPSession.User_full_name;
            if (tERPSession.Logo!=null)
            {
                imgAvatar.ImageUrl = Tools.IMG_HEADER + Convert.ToBase64String(tERPSession.Logo);
            } else
            {
                imgAvatar.ImageUrl = "/TERP/Theme/dist/img/user2-160x160.jpg";
            }
        }

        protected void dsTemp_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.CommandTimeout = 0;
        }

        protected void ddLanguage_SelectedIndexChanged(object sender, EventArgs e)
        {
            tERPSession = (TERPSession)HttpContext.Current.Session["TERPSession"];
            tERPSession.Language_code = ddLanguage.SelectedItem.Text.Trim();
            HttpContext.Current.Session["TERPSession"] = tERPSession;

            LoadMenu();

            try
            {
                OnLanguageSelected(sender, ((DropDownList)sender).SelectedValue);
            }
            catch { }
        }
    }
}