using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace TERP.Forms.PMS
{
    public partial class frmSupplierMaintenance : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        //Action show form create new supplier
        protected void frmSupplierMaintenance_btnCreateNew_Click(object sender, EventArgs e)
        {


            ScriptManager.RegisterStartupScript(this, this.GetType(), "#SupplierForm", "showSupplier_Form();", true);
        }

        //Action show form upload excel template
        protected void frmSupplierMaintenance_btnUploadNew_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "#SupplierImport", "showSupplier_Import();", true);
        }

        protected void frmSupplierMaintenance_btnGoBack_Click(object sender, EventArgs e)
        {

        }

        //Action show form edit supplier
        protected void btnEditSupplier_Click(object sender, ImageClickEventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "#SupplierForm", "showSupplier_Form();", true);
        }

        protected void grSupplierMaintenance_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label label = (Label)e.Row.FindControl("lblStatus");

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

        //Action show block action ( delete , pending, inactive)
        protected void ckAll_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chk = (CheckBox)sender;
            ScriptManager.RegisterStartupScript(this, this.GetType(), ".paging_display", "showActionSuppl_View();", true);
        }

        //Action when check all 
        protected void ckCheck_CheckedChanged(object sender, EventArgs e)
        {

        }

        //Action change Status pending
        protected void frmSupplierMaintenance_btnPending_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "#SupplierModalUpdate", "showSupplierUpdateModal();", true);
        }

        protected void frmSupplierMaintenance_btnRemove_Click(object sender, ImageClickEventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "#SupplierModalDelete", "showSupplierDeleteModal();", true);
        }
    }
}