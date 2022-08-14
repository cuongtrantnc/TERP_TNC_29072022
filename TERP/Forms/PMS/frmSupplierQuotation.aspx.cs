using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TERP.Forms.PMS
{
    public partial class frmSupplierQuotation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void frmSupplierQuotation_btnGoBack_Click(object sender, EventArgs e)
        {

        }

        protected void frmSupplierQuotation_btnCreateNew_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "#SupplierForm", "showSupplier_Form();", true);
        }

        protected void frmSupplierQuotation_btnUploadNew_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "#SupplierImport", "showSupplier_Import();", true);
        }

        protected void grSupplQuotation_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                LinkButton label = (LinkButton)e.Row.FindControl("btnChangeStatus");

                if (label.Text.Trim() == "Active")
                {
                    label.CssClass = "bagde-custom_success";
                }
                else
                {
                    label.CssClass = "bagde-custom_danger";
                }
            }
        }

        protected void btnChangeStatus_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "#SupplierModalUpdate", "showSupplierUpdateModal();", true);
        }

        protected void btnEditEvaluate_Click(object sender, ImageClickEventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "#SupplierForm", "showSupplier_Form();", true);
        }
    }
}