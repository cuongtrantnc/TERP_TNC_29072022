using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TERP.Libs;

namespace TERP.Forms.Setting
{
    public partial class frmProfile : System.Web.UI.Page
    {
        TERPSession tERPSession;
        string prefix = "Profile";

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
                HttpContext.Current.Session["localization"] = Localization.LoadLocalizationMessage("PMS", prefix, tERPSession.Language_code);
                SetLanguageToDropDownList();
            }

            if (!IsPostBack)
            {
                lblUserID.Text = tERPSession.User_id;
                txtCardID.Text = tERPSession.User_cid;
                txtUserName.Text = tERPSession.User_name;
                txtUserFullName.Text = tERPSession.User_full_name;
                txtEmail.Text = tERPSession.User_email;

                string sql = "SELECT image FROM TERP_users WHERE user_id='" + tERPSession.User_id + "'";
                DataRow dr = DbHelper.getDataRow(sql, dsTemp.ConnectionString);

                if (dr!=null && dr[0].ToString()!="")
                {
                    imgUserImage.ImageUrl = Tools.IMG_HEADER + Convert.ToBase64String((byte[])dr[0]);  //Convert.ToBase64String  - Encoding.Default.GetString
                } else
                {
                    imgUserImage.ImageUrl = "";
                }

            }

            LoadLocalizationMessage();
        }

        private void LoadLocalizationMessage()
        {
            HttpContext.Current.Session["localization"] = Localization.LoadLocalizationMessage("TERP", prefix, tERPSession.Language_code);
            Localization.SetLocalizationMessage(true, this, prefix);
        }

        protected void Profile_btSave_Click(object sender, EventArgs e)
        {
            string user_id = lblUserID.Text.Trim();
            string user_name = txtUserName.Text.Trim();
            string user_full_name = txtUserFullName.Text.Trim();
            string card_id = txtCardID.Text.Trim();
            string user_email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();
            string r_password = txtConfirmPassword.Text.Trim();

            if (user_name=="")
            {
                (new Mess(this)).ShowMessage("User name can't not be empty", Mess.TYPE_ERROR);
                return;
            }

            if (user_full_name == "")
            {
                (new Mess(this)).ShowMessage("User full name can't not be empty", Mess.TYPE_ERROR);
                return;
            }

            if (password!=r_password)
            {
                (new Mess(this)).ShowMessage("Password is not match", Mess.TYPE_ERROR);
                return;
            }

            //byte[] image_org = File.ReadAllBytes(Server.MapPath(imgUserImage.ImageUrl));

            dsTemp.UpdateCommand = "UPDATE TERP_users SET user_name='" + user_name + "', user_full_name=N'" + user_full_name + "', user_cid='" + card_id + "'," +
                "password='" + password + "', user_email='" + user_email + "' WHERE user_id='" + user_id + "'";
            dsTemp.Update();

            byte[] image256;
            byte[] image48 = tERPSession.Logo;
            if (imgUserImage.ImageUrl.IndexOf(Tools.IMG_HEADER) != 0)
            {
                image256 = Tools.CreateThumbnailByteArray(Server.MapPath(imgUserImage.ImageUrl), 256, 256);
                image48 = Tools.CreateThumbnailByteArray(Server.MapPath(imgUserImage.ImageUrl), 48, 48);
                Tools.SaveImageToDB(user_id, image256, image48);

                tERPSession.Logo = image48;
            }

            tERPSession.User_name = user_name;
            tERPSession.User_full_name = user_full_name;
            tERPSession.User_cid = card_id;
            tERPSession.User_email = user_email;

            HttpContext.Current.Session["tERPSession"] = tERPSession;

            //Update Site
            if (image48!=null)
            {
                ((Image)this.Master.FindControl("imgAvatar")).ImageUrl = Tools.IMG_HEADER + Convert.ToBase64String(tERPSession.Logo);
            }
            ((Label)this.Master.FindControl("lblUserName")).Text = user_full_name;
        }

        protected void dsTemp_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            e.Command.CommandTimeout = 0;
        }

        protected void Profile_btUpload_Click(object sender, EventArgs e)
        {
            if (fileUpload.HasFile)
            {
                try
                {
                    string filename = fileUpload.FileName;
                    string filepath = Server.MapPath("/TERP/Images/Temp/");

                    fileUpload.SaveAs(filepath + filename);

                    imgUserImage.ImageUrl = "/TERP/Images/Temp/" + filename;
                } catch (Exception ex)
                {
                    (new Mess(this)).ShowMessage("Invalid Image", Mess.TYPE_ERROR);
                    //txtCardID.Text = ex.Message;
                }
            }
        }
    }
}