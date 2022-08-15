
// CODE SỬ DỤNG JQUERY

// KHAI BÁO CÁC PARAMETER ERROR MESSAGE

// Parameter for User Menu
var userpass_null = "Please input User ID / User name / User card ID.";
var notfound = "User Not Found.";
var userExist = "User name is already existed.";
var addUserSuccess = "Add new user successfully.";
var updateUserSuccess = "Update user successfully.";
var deleteUserSuccess = "Delete user successfully.";

var connectionFail = "Connection failed, please try again.";
var userConflict = "User Name, User ID or User CID conflicts with other account.";
var userWorkline = "User's workline is not existed in system.";
var errUpdateAccessright = "Please select one user to update access right.";
var updAccessRight = "Access right has been updated";
var errdAccessRight = "Access right update failed.";

// Parameter for Unit / WorkLine Menu
var errDepartmentexist = "This Department/Unit has been exist.";
var adddepartmentSuccess = "Department/Unit has been added successfully.";
var updDepartmentSuccess = "Department/Unit has been updated successfully.";
var delDepartmentSuccess = "Department/Unit has been deleted successfully.";

var errProLineexist = "This production line has been exist.";
var addProLinesuccess = "Production line has been added successfully.";
var errProLine = "Please select one line to update.";
var updProLineExist = "This production line has been exist. Can't update to exist production line.";
var errProLineSelect = "Please select the production line.";
var updProLineSuccess = "Production line has been updated successfully.";
var delProLineSuccess = "Production line has been deleted successfully.";

// Parameter for Production Paramenter Menu
var errTotalInteger = "Total need production should be integer.";
var errTargetInteger = "Target for day should be integer.";
var updSuccess = "Update successfully.";
var errUpdate = "Update failed.";

// Parameter for Production Paramenter Menu
var errTypeDate = "Date format incorrect. Make sure date value is MM/dd/yyyy format.";
var errTypeFile = "Upload failed, please check network or data type in upload file.";


var passwordMismatch = " Password does not match.";

// FUNCTION SHOW MODAL CHECK USERNAME = NULL
function userNull() {
    $('#lblModalBody').text(userpass_null);
    $('#exampleModal').modal('show');
};

// FUNCTION SHOW MODAL CHECK USER NOT FOUND
function userNotFound() {
    $('#lblModalBody').text(notfound);
    $('#exampleModal').modal('show');
};


// FUNCTION SHOW MODAL CHECK USERNAME or PASSWORD
function showMessagePassword() {
    $('#exampleModal').modal('show');
};


// FUNCTION SHOW MODAL EDIT ITEM MASTER BROWSE
function itemBrowse_showEditItem() {
    $(document).ready(function () {
        $('#editFormModal').modal('show');
    });
};

// FUNCTION SHOW CONFIRM MODAL DELETE ITEM MASTER BROWSE
function itemBrowse_ComfirmDelete() {
    $(document).ready(function () {
        $('#comfirmDeleteModal').modal('show');
    });
};

//FUNCTION SHOW MODAL IN APPROVAL MAINT
function showApprovalModal() {
    $(document).ready(function () {
        $('#approvalModal').modal('show');
    });
};

// FUNCTION SHOW MESSAGE ERROR OF USER FORM - TOASK JQUERY PLUGINS
var param = '';

function showMessageUserForm(param) {

    toastr.options = {
        "closeButton": true,
        "debug": false,
        "newestOnTop": false,
        "progressBar": true,
        "positionClass": "toast-top-right",
        "preventDuplicates": false,
        "onclick": null,
        "showDuration": "300",
        "hideDuration": "1000",
        "timeOut": "9000",
        "extendedTimeOut": "1000",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
    }

    switch (param) {
        case "userExist":
            toastr["error"](userExist);
            break;
        case "addUserSuccess":
            toastr["success"](addUserSuccess);
            break;
        case "connectionFail":
            toastr["error"](connectionFail);
            break;
        case "userConflict":
            toastr["error"](userConflict);
            break;
        case "updateUserSuccess":
            toastr["success"](updateUserSuccess);
            break;
        case "deleteUserSuccess":
            toastr["success"](deleteUserSuccess);
            break;
        case "userWorkline":
            toastr["error"](userWorkline);
            break;
        case "passwordMismatch":
            toastr["error"](passwordMismatch);
            break;
        case "errUpdateAccessright":
            toastr["error"](errUpdateAccessright);
            break;
        case "updAccessRight":
            toastr["success"](updAccessRight);
            break;
        case "errdAccessRight":
            toastr["error"](errdAccessRight);
            break;
            
    }
};

// FUNCTION SHOW MESSAGE ERROR OF UNIT / WORKLINE DEFINITION FORM - TOASK JQUERY PLUGINS

var unitParam = '';
function showMessage_UnitWorkline(unitParam) {

    toastr.options = {
        "closeButton": true,
        "debug": false,
        "newestOnTop": false,
        "progressBar": true,
        "positionClass": "toast-top-right",
        "preventDuplicates": false,
        "onclick": null,
        "showDuration": "300",
        "hideDuration": "1000",
        "timeOut": "9000",
        "extendedTimeOut": "1000",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
    }

    switch (unitParam) {
        case "errDepartmentexist":
            toastr["error"](errDepartmentexist);
            break;
        case "addDepartmentSuccess":
            toastr["success"](addDepartmentSuccess);
            break;
        case "updDepartmentSuccess":
            toastr["success"](updDepartmentSuccess);
            break;
        case "delDepartmentSuccess":
            toastr["success"](delDepartmentSuccess);
            break;
        case "errProLineexist":
            toastr["error"](errProLineexist);
            break;
        case "addProLinesuccess":
            toastr["success"](addProLinesuccess);
            break;
        case "errProLine":
            toastr["error"](errProLine);
            break;
        case "updProLineExist":
            toastr["error"](updProLineExist);
            break;
        case "updProLineSuccess":
            toastr["success"](updProLineSuccess);
            break;
        case "delProLineSuccess":
            toastr["success"](delProLineSuccess);
            break;
        case "errProLineSelect":
            toastr["error"](errProLineSelect);
            break;
            
    }
};

// FUNCTION SHOW MESSAGE ERROR OF PRODUCTION PARAMETER FORM - TOASK JQUERY PLUGINS
var productParam = '';

function showMessage_ProductParameter(productParam) {

    toastr.options = {
        "closeButton": true,
        "debug": false,
        "newestOnTop": false,
        "progressBar": true,
        "positionClass": "toast-top-right",
        "preventDuplicates": false,
        "onclick": null,
        "showDuration": "300",
        "hideDuration": "1000",
        "timeOut": "9000",
        "extendedTimeOut": "1000",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
    }

    switch (productParam) {
        case "errTotalInteger":
            toastr["error"](errTotalInteger);
            break;
        case "errTargetInteger":
            toastr["error"](errTargetInteger);
            break;
        case "updSuccess":
            toastr["success"](updSuccess);
            break;
        case "errUpdate":
            toastr["error"](errUpdate);
            break;

    }
};

// FUNCTION SHOW MESSAGE ERROR OF IMPORT PARAMETER FORM - TOASK JQUERY PLUGINS
var importParam = '';

function showMessage_ImportBrowse(importParam) {

    toastr.options = {
        "closeButton": true,
        "debug": false,
        "newestOnTop": false,
        "progressBar": true,
        "positionClass": "toast-top-right",
        "preventDuplicates": false,
        "onclick": null,
        "showDuration": "300",
        "hideDuration": "1000",
        "timeOut": "9000",
        "extendedTimeOut": "1000",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
    }

    switch (importParam) {
        case "errTypeFile":
            toastr["error"](errTypeFile);
            break;
        case "errTypeDate":
            toastr["error"](errTypeDate);
            break;
        default:
            toastr["success"](importParam);
    }
};

// FUNCTION SHOW MESSAGE ERROR OF IMPORT PARAMETER FORM - TOASK JQUERY PLUGINS
var productionParam = '';
var errNotFound = "Item number not found.";
var itemSuccess = "Item has been successfully updated.";
var errOperation = "Operation not found.";
var errSalesOder = "Sales order not found.";
var errWorkOder = "Work order not found.";
var errQuantity = "Quantity not found.";
var errQuantityInt = "Quantity should be in INTERGER value.";
var errSave = "Save failed. Check connection please.";
//var errOperationvalidate = "Operation not found validate";

function showMessage_Production(productionParam) {

    toastr.options = {
        "closeButton": true,
        "debug": false,
        "newestOnTop": false,
        "progressBar": true,
        "positionClass": "toast-top-right",
        "preventDuplicates": false,
        "onclick": null,
        "showDuration": "300",
        "hideDuration": "1000",
        "timeOut": "9000",
        "extendedTimeOut": "1000",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
    }

    switch (productionParam) {
        case "errNotFound":
            toastr["error"](errNotFound);
            break;
        case "itemSuccess":
            toastr["success"](itemSuccess);
            break;
        case "errOperation":
            toastr["error"](errOperation);
            break;
        //case "errOperationvalidate":
        //    toastr["error"](errOperationvalidate);
        //    break;
        case "errSalesOder":
            toastr["error"](errSalesOder);
            break;
        case "errWorkOder":
            toastr["error"](errWorkOder);
            break;
        case "errQuantity":
            toastr["error"](errQuantity);
            break;
        case "errQuantityInt":
            toastr["error"](errQuantityInt);
            break;
        case "errSave":
            toastr["error"](errSave);
            break;
        
    }
};

//FUNCTION SHOW MODAL LOGED IN PR APPROVAL MENU 
function showLogedlModal() {
    $(document).ready(function () {
        $('#prApproval_LogedModal').modal('show');
    });
};

//FUNCTION SHOW MODAL LOGED IN PR APPROVAL MENU 
function showPOLogedlModal() {
    $(document).ready(function () {
        $('#POApproval_LogedModal').modal('show');
    });
};

//FUNCTION SHOW MODAL HISTORY ITEM IN PR APPROVAL MENU 
function showHistoryItemView() {
    $(document).ready(function () {
        $('#prApproval_HistoryItemView').modal('show');
        showApproval_Detailview();

    });
};

//FUNCTION SHOW MODAL HISTORY ITEM IN PO APPROVAL MENU 
function showPOHistoryItemView() {
    $(document).ready(function () {
        $('#POApproval_HistoryItemView').modal('show');
        showApproval_Detailview();
    });
};


//FUNCTION SHOW BLOCK (PRApproval Item Detail View) IN PR APPROVAL MENU
function showApproval_Detailview() {
    $(document).ready(function () {
        $('#prApproval_Condition').addClass('prApprovalCondition');
        $('#prApproval_Detailview').removeClass('approvalDetailView');
    });
};

//FUNCTION SHOW BLOCK (PRApproval Item Detail View) IN PO APPROVAL MENU
function showPOApproval_Detailview() {
    $(document).ready(function () {
        $('#poApproval_Condition').addClass('poApprovalCondition');
        $('#poApproval_Detailview').removeClass('approvalDetailView');
    });
};

//FUNCTION SHOW MODAL IN PR MAINT
function showPRMaintModal() {
    $(document).ready(function () {
        $('#prMaintModal').modal('show');
    });
};

//FUNCTION SHOW MODAL IN PO APPROVAL MAINT
function showPOApprovalModal() {
    $(document).ready(function () {
        $('#POapprovalModal').modal('show');
    });
};

//Close backdrop modal
function closeBackDropModal() {
    $(".modal-backdrop").remove();
    $('body').removeClass('modal-open');
    $('body').css({ padding: 0, margin: 0 });
};

//close modal
function closeModal(param) {
    $(document).ready(function () {
        $(param).modal('hide');
    });
};

//FUNCTION SHOW BLOCK CREATE NEW Criteria Supplier && EDIT Creteria Supplier
function showCriteriaSupplier_Form() {
    $(document).ready(function () {
        $('#CriteriaMaintFilter').addClass('supplier_filter');
        $('#CriteriaMaintForm').removeClass('supplier_form');

        $('#btnGoBack').removeClass('action_button-hide');
        $('#btnCreateNew').addClass('action_button-hide');

        $('#frmCriteriaSupplierPerformanceMaint_btnUploadNew').removeClass('btn-outline-success');
        $('#frmCriteriaSupplierPerformanceMaint_btnUploadNew').addClass('bg-gradient-success');
    });
};

//FUNCTION SHOW BLOCK IMPORT Criteria Supplier
function showCriteriaSupplier_Import() {
    $(document).ready(function () {
        $('#CriteriaMaintFilter').addClass('supplier_filter');
        $('#CriteriaMaintImport').removeClass('supplier_import');

        $('#btnCreateNew').removeClass('action_button-hide');
        $('#btnUploadNew').addClass('action_button-hide');
        $('#btnGoBack').removeClass('action_button-hide');
    });
};

//FUNCTION SHOW BLOCK CREATE NEW SUPPLIER EVALUATION && EDIT SUPPLIER EVALUATION
function showSupplierEvaluation_Form() {
    $(document).ready(function () {
        $('#SupplierEvaluationFilter').addClass('supplier_filter');
        $('#SupplierEvaluationForm').removeClass('supplier_form');

        $('#btnGoBack').removeClass('action_button-hide');
        $('#btnCreateNew').addClass('action_button-hide');

    });
};

//FUNCTION SHOW BLOCK CREATE NEW SUPPLIER && EDIT SUPPLIER  
function showSupplier_Form() {
    $(document).ready(function () {
        $('#SupplierFilter').addClass('supplier_filter');
        $('#SupplierForm').removeClass('supplier_form');

        $('#btnGoBack').removeClass('action_button-hide');
        $('#btnCreateNew').addClass('action_button-hide');

        //action for Supplier Mainternance
        $('#frmSupplierMaintenance_btnUploadNew').removeClass('btn-outline-success');
        $('#frmSupplierMaintenance_btnUploadNew').addClass('bg-gradient-success');

        //action for Supplier Quotation
        $('#frmSupplierQuotation_btnUploadNew').removeClass('btn-outline-success');
        $('#frmSupplierQuotation_btnUploadNew').addClass('bg-gradient-success');
    });
};

//FUNCTION SHOW BLOCK IMPORT SUPPLIER
function showSupplier_Import() {
    $(document).ready(function () {
        $('#SupplierFilter').addClass('supplier_filter');
        $('#SupplierImport').removeClass('supplier_import');

        $('#btnCreateNew').removeClass('action_button-hide');
        $('#btnUploadNew').addClass('action_button-hide');
        $('#btnGoBack').removeClass('action_button-hide');
    });
};

//FUNCTION SHOW BLOCK ACTION SUPPLIER BROWSE
function showActionSuppl_View() {
    $(document).ready(function () {

        $('#Paging_Left').toggleClass('paging_display');
        $('#Paging_Left').addClass('paging_itemLeft');
    });
}


//FUNCTION SHOW MODAL UPDATE MENU SUPPLIER
function showSupplierUpdateModal() {
    $(document).ready(function () {
        $('#SupplierModalUpdate').modal('show');
    });
};

//FUNCTION SHOW MODAL DELETE MENU SUPPLIER
function showSupplierDeleteModal() {
    $(document).ready(function () {
        $('#SupplierModalDelete').modal('show');
    });
};

//FUNCTION SHOW BLOCK CREATE NEW EVALUATE CONTENT && EDIT EVALUATE CONTENT  
function showEvaluate_Form() {
    $(document).ready(function () {
        $('#EvaluateFilter').addClass('evaluate_filter');
        $('#EvaluateForm').removeClass('evaluate_form');

        $('#btnGoBack').removeClass('action_button-hide');
        $('#btnCreateNew').addClass('action_button-hide');

        //action for Evaluate content
        $('#frmEvaluateContentlMaintenance_btnUploadNew').removeClass('btn-outline-success');
        $('#frmEvaluateContentMaintenance_btnUploadNew').addClass('bg-gradient-success');

        //action for Evaluate content detail
        $('#frmEvaluateContentDetailMaintenance_btnUploadNew').removeClass('btn-outline-success');
        $('#frmEvaluateContentDetailMaintenance_btnUploadNew').addClass('bg-gradient-success');
    });
};

//FUNCTION SHOW BLOCK IMPORT EVALUATE CONTENT
function showEvaluate_Import() {
    $(document).ready(function () {
        $('#EvaluateFilter').addClass('evaluate_filter');
        $('#EvaluateImport').removeClass('evaluate_import');

        $('#btnCreateNew').removeClass('action_button-hide');
        $('#btnUploadNew').addClass('action_button-hide');
        $('#btnGoBack').removeClass('action_button-hide');
    });
};

//FUNCTION SHOW MODAL DELETE MENU EVALUATE and EVALUATE CONTENT DETAIL
function showEvaluateDeleteModal() {
    $(document).ready(function () {
        $('#EvaluateModalDelete').modal('show');
    });
};

//FUNCTION SHOW MODAL UPDATE MENU EVALUATE and EVALUATE CONTENT DETAIL
function showEvaluateUpdateModal() {
    $(document).ready(function () {
        $('#EvaluateModalUpdate').modal('show');
    });
};

//FUNCTION SHOW MODAL SUPPLIER COMPARISON REPORT MENU 
function showComparisonReport() {
    $(document).ready(function () {
        $('#SupplierComparison_ViewReport').modal('show');
    });
};

//FUNCTION SHOW BLOCK CREATE NEW Criteria Supplier && EDIT Creteria Supplier
function showCriteriaSupplier_Form() {
    $(document).ready(function () {
        $('#CriteriaMaintFilter').addClass('supplier_filter');
        $('#CriteriaMaintForm').removeClass('supplier_form');

        $('#btnGoBack').removeClass('action_button-hide');
        $('#btnCreateNew').addClass('action_button-hide');

        $('#frmCriteriaSupplierPerformanceMaint_btnUploadNew').removeClass('btn-outline-success');
        $('#frmCriteriaSupplierPerformanceMaint_btnUploadNew').addClass('bg-gradient-success');
    });
};

//FUNCTION SHOW BLOCK IMPORT Criteria Supplier
function showCriteriaSupplier_Import() {
    $(document).ready(function () {
        $('#CriteriaMaintFilter').addClass('supplier_filter');
        $('#CriteriaMaintImport').removeClass('supplier_import');

        $('#btnCreateNew').removeClass('action_button-hide');
        $('#btnUploadNew').addClass('action_button-hide');
        $('#btnGoBack').removeClass('action_button-hide');
    });
};

//FUNCTION SHOW BLOCK CREATE NEW SUPPLIER EVALUATION && EDIT SUPPLIER EVALUATION
function showSupplierEvaluation_Form() {
    $(document).ready(function () {
        $('#SupplierEvaluationFilter').addClass('supplier_filter');
        $('#SupplierEvaluationForm').removeClass('supplier_form');

        $('#btnGoBack').removeClass('action_button-hide');
        $('#btnCreateNew').addClass('action_button-hide');

    });
};

//FUNCTION SHOW MODAL DELETE MENU CRITERIA
function showCriteriaDeleteModal() {
    $(document).ready(function () {
        $('#CriteriaModalDelete').modal('show');
    });
};

//FUNCTION SHOW MODAL UPDATE MENU CRITERIAL
function showCriteriaUpdateModal() {
    $(document).ready(function () {
        $('#CriteriaModalUpdate').modal('show');
    });
};
