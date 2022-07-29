using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TERP.Forms.PMS
{
    public partial class frmSupplierEvaluation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void frmSupplierEvaluation_btnCreateNew_Click(object sender, EventArgs e)
        {


            ScriptManager.RegisterStartupScript(this, this.GetType(), "#SupplierEvaluationForm", "showSupplierEvaluation_Form();", true);
        }

        protected void frmSupplierEvaluation_btnGoBack_Click(object sender, EventArgs e)
        {

        }

        protected void btnEditSupplierEvaluation_Click(object sender, ImageClickEventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "#SupplierEvaluationForm", "showSupplierEvaluation_Form();", true);
        }
    }
}