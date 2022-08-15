using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TERP.Libs
{
    public class Mess
    {
        Page page;

        public static string TYPE_ERROR = "error";
        public static string TYPE_INFO = "info";
        public static string TYPE_WARNING = "warning";
        public static string TYPE_SUCCESS = "success";

        public Mess(Control orgPage)
        {
            this.page = (Page)orgPage;
        }

        public void show(string msg)
        {
            string script = "alert(\"" + msg + "\");";
            ScriptManager.RegisterStartupScript(page, GetType(), "ServerControlScript", script, true);
        }

        public void ShowMessage(string msg, string type)
        {
            //page.ClientScript.RegisterStartupScript(page.GetType(), "showMessage", "showMessage('" + type + "','" + msg + "');", true);
            ScriptManager.RegisterStartupScript(page, GetType(), "showMessage", "showMessage('" + type + "','" + msg + "');", true);
        }
    }
}


