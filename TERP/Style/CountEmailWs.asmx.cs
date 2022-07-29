using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using TERP.Libs;

namespace TERP
{
    /// <summary>
    /// Summary description for CountEmailWs
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class CountEmailWs : System.Web.Services.WebService
    {
        TERPSession tERPSession;

        [WebMethod(EnableSession = true)]
        public string CountEmail()
        {
            tERPSession = (TERPSession)HttpContext.Current.Session["tERPSession"];
            if (tERPSession == null)
            {
                HttpContext.Current.Response.Redirect("/terp/Login.aspx");
            }
            string currentId = tERPSession.User_id;

            string query = "SELECT COUNT(id) FROM TERP_email_notification WHERE viewed=0 AND user_id='" + currentId + "'";
            string connstring = System.Configuration.ConfigurationManager.ConnectionStrings["TERPConnectionString"].ConnectionString;
            DataRow dr = DbHelper.getDataRow(query, connstring);
            string dstr = (dr==null)? "" : dr[0].ToString();
            return dstr;
        }
    }
}
