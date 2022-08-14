using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TERP.Forms.PMS
{
    public partial class frmEvalueteContentMaintenance : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void frmEvaluateContentMaintenance_btnCreateNew_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "#EvaluateForm", "showEvaluate_Form();", true);
        }

        protected void frmEvaluateContentMaintenance_btnUploadNew_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "#EvaluateImport", "showEvaluate_Import();", true);
        }

        protected void frmEvaluateContentMaintenance_btnGoBack_Click(object sender, EventArgs e)
        {

        }

        protected void btnEditEvaluate_Click(object sender, ImageClickEventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "#EvaluateForm", "showEvaluate_Form();", true);
        }

        protected void grEvaluateContent_RowDataBound(object sender, GridViewRowEventArgs e)
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

        protected void btnDeleteEvaluate_Click(object sender, ImageClickEventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "#EvaluateModalDelete", "showEvaluateDeleteModal();", true);
        }

        protected void btnChangeStatus_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "#EvaluateModalUpdate", "showEvaluateUpdateModal();", true);
        }
    }
}