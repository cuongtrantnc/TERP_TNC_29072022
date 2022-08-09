using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TERP.Forms.PMS
{
    public partial class frmCriteriaSupplierPerformanceMaint : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void frmCriteriaSupplierPerformanceMaint_btnCreateNew_Click(object sender, EventArgs e)
        {


            ScriptManager.RegisterStartupScript(this, this.GetType(), "#CriteriaMaintForm", "showCriteriaSupplier_Form();", true);
        }

        protected void frmCriteriaSupplierPerformanceMaint_btnUploadNew_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "#CriteriaMaintImport", "showCriteriaSupplier_Import();", true);
        }

        protected void frmCriteriaSupplierPerformanceMaint_btnGoBack_Click(object sender, EventArgs e)
        {

        }

        protected void btnEditCriteriaMaint_Click(object sender, ImageClickEventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "#CriteriaMaintForm", "showCriteriaSupplier_Form();", true);
        }

        protected void grCriteriaSupplierPerformanceMaint_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if(e.Row.RowType == DataControlRowType.DataRow)
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

        protected void btnDeleteCriteriaMaint_Click(object sender, ImageClickEventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "#CriteriaModalDelete", "showCriteriaDeleteModal();", true);
        }

        protected void btnChangeStatus_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "#CriteriaModalUpdate", "showCriteriaUpdateModal();", true);
        }
    }
}