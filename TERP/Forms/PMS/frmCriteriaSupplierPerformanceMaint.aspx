<%@ Page Title="" Language="C#" MasterPageFile="~/TERP.Master" AutoEventWireup="true" CodeBehind="frmCriteriaSupplierPerformanceMaint.aspx.cs" Inherits="TERP.Forms.PMS.frmCriteriaSupplierPerformanceMaint" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TERPContentPlaceHolder" runat="server">
    <link href="../../Style/Browse/BrowseStyle.css" rel="stylesheet" />
    <link href="../../Style/PMS/frmCriteriaSupplierPerformanceMaint.css" rel="stylesheet" />

    <%-- Title Menu --%>
    <div class="title-padding header-menu" style="width: 100%">
        <asp:Label runat="server" ID="frmCriteriaSupplierPerformanceMaint_lblTitle" Text="Criteria Maintenance" CssClass="title_label"></asp:Label>
    
        <%-- Action : Create new && Import new --%>
        <div class="action">
            <span id="btnGoBack" class="action_button-hide">
                <asp:Button runat="server" ID="frmCriteriaSupplierPerformanceMaint_btnGoBack" CssClass="btn btn-outline-success action_button" Text="Go Back" OnClick="frmCriteriaSupplierPerformanceMaint_btnGoBack_Click" /></span>
            <span id="btnCreateNew">
                <asp:Button runat="server" ID="frmCriteriaSupplierPerformanceMaint_btnCreateNew" CssClass="btn bg-gradient-success action_button" Text="Create Criteria" OnClick="frmCriteriaSupplierPerformanceMaint_btnCreateNew_Click" /></span>
            <span id="btnUploadNew">
                <asp:Button runat="server" ID="frmCriteriaSupplierPerformanceMaint_btnUploadNew" ClientIDMode="Static" CssClass="btn btn-outline-success action_button" Text="Upload Criteria" OnClick="frmCriteriaSupplierPerformanceMaint_btnUploadNew_Click" /></span>
        </div>
    </div>

    <%-- Filter and View  --%>
    <div class="row " id="CriteriaMaintFilter">
        <div class="col-md-12">
            <div class="card card-border card-boxshadow">
                <div class="card-body">
                    <%--Condition Filter--%>
                    <fieldset class="fieldSet">
                        <legend class="fieldSet_legend">
                            <asp:Label runat="server" ID="fieldSet_Filter" Text="Filter"></asp:Label>
                        </legend>
                        <div class="row">
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                <div class="filter_validation">
                                    <div class="filter_item">
                                        <asp:Label runat="server" ID="frmCriteriaSupplierPerformanceMaint_lblCode" Text="Code" CssClass="filter_label filter_label--modify"></asp:Label>
                                        <asp:TextBox runat="server" ID="frmCriteriaSupplierPerformanceMaint_txtCode" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmCriteriaSupplierPerformanceMaint_lblStatus" Text="Status" CssClass="filter_label filter_label--modify"></asp:Label>
                                    <asp:DropDownList ID="ddStatus" runat="server" CssClass="form-control">
                                        <asp:ListItem Selected="true" Text="Active"></asp:ListItem>
                                        <asp:ListItem Text="Inactive"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmCriteriaSupplierPerformanceMaint_lblCategory" Text="Category" CssClass="filter_label filter_label--modify"></asp:Label>
                                    <asp:DropDownList ID="ddCategory" runat="server" CssClass="form-control">
                                        <asp:ListItem Selected="true" Text="Initial Evaluate"></asp:ListItem>
                                        <asp:ListItem Text="Annual Evaluate"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmCriteriaSupplierPerformanceMaint_lblContent" Text="Content" CssClass="filter_label filter_label--modify"></asp:Label>
                                    <asp:DropDownList ID="ddContent" runat="server" CssClass="form-control select2" Style="width: 100%;">
                                    </asp:DropDownList>
                                </div>
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmCriteriaSupplierPerformanceMaint_lblContentDetail" Text="Content Detail" CssClass="filter_label filter_label--modify"></asp:Label>
                                    <asp:DropDownList ID="ddContentDetail" runat="server" CssClass="form-control select2" Style="width: 100%;">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                <div class="filter_action">
                                    <asp:Button runat="server" ID="frmCriteriaSupplierPerformanceMaint_filterBtnSearch" Text="Search" CssClass="btn bg-gradient-success filter_button filter_button-modifile" />
                                    <asp:Button runat="server" ID="frmCriteriaSupplierPerformanceMaint_filterBtnClear" Text="Clear" CssClass="btn btn-outline-success filter_button filter_button-modifile" />
                                </div>
                            </div>
                        </div>
                        <%-- End Condition Filter --%>
                    </fieldset>


                    <%-- Paging --%>
                    <div class="paging">
                        <asp:Label ID="frmCriteriaSupplierPerformanceMaint_lblRecordPage" runat="server" Text="Record per Page" CssClass="mr-2"></asp:Label>
                        <asp:DropDownList ID="ddRecordPerPage" runat="server" CssClass="paging_record" DataSourceID="dsRowPerPage" DataTextField="value" DataValueField="value" AutoPostBack="True" />
                    </div>

                    <%--Supplier GridView--%>
                    <asp:GridView runat="server" ID="grCriteriaSupplierPerformanceMaint" AutoGenerateColumns="False" CellPadding="2" ForeColor="#333333" ShowHeaderWhenEmpty="True" CssClass="table table-bordered mt-2 grview "
                        AllowPaging="True" DataSourceID="dsPOApproval" OnRowDataBound="grCriteriaSupplierPerformanceMaint_RowDataBound">
                        <RowStyle CssClass="rowstyle" />
                        <Columns>
                            <asp:BoundField DataField="" HeaderText="Code" HeaderStyle-CssClass="grview_header" ItemStyle-HorizontalAlign="Center" />
                            <asp:BoundField DataField="" HeaderText="Name" />
                            <asp:BoundField DataField="" HeaderText="Content Detail" />
                            <asp:BoundField DataField="" HeaderText="Content" />
                            <asp:BoundField DataField="" HeaderText="Category" />

                            <asp:TemplateField HeaderText="Status" SortExpression="enable">
                                <EditItemTemplate>
                                    <asp:Label ID="lblStatus" runat="server" Text='<%# Bind("status") %>'></asp:Label>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnChangeStatus" runat="server" CssClass="grview_status" Text='<%# Bind("status") %>' ToolTip="Click to change Status" OnClick="btnChangeStatus_Click"></asp:LinkButton>
																																																																																																									  
										  
                                </ItemTemplate>
                                <ItemStyle CssClass="text-center grview_header" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:TemplateField>


                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label runat="server" Text="Edit" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <div class="itemTemplate">
                                        <asp:ImageButton runat="server" ID="btnEditCriteriaMaint" ImageUrl="~/Images/edit.png" ToolTip="Edit" CssClass="itemTemplate-icon" OnClick="btnEditCriteriaMaint_Click" />
                                    </div>
                                </ItemTemplate>
                                <ItemStyle CssClass="itemStyle grview_header" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label runat="server" Text="Delete" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <div class="itemTemplate">
                                        <asp:ImageButton runat="server" ID="btnDeleteCriteriaMaint" ImageUrl="~/Images/trash.png" ToolTip="Delete" CssClass="itemTemplate-icon" OnClick="btnDeleteCriteriaMaint_Click"/>
                                    </div>
                                </ItemTemplate>
                                <ItemStyle CssClass="itemStyle" />
                                <HeaderStyle HorizontalAlign="Center" CssClass="grview_header" />
                            </asp:TemplateField>
                        </Columns>
                        <FooterStyle BackColor="#e9ecef" Font-Bold="True" />
                        <HeaderStyle BackColor="#e9ecef" HorizontalAlign="Center" />
                        <PagerStyle CssClass="pageStyle" HorizontalAlign="Center" />
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>


    <%-- Form Create Supplier and Edit Supplier --%>
    <div class="row supplier_form" id="CriteriaMaintForm">
        <div class="col-md-12">
            <div class="card card-border card-boxshadow">
                <div class="card-body">
                    <%-- Form input --%>
                    <fieldset class="fieldSet">
                        <legend class="fieldSet_legend">
                            <asp:Label runat="server" ID="fieldSet_Form" Text="Criteria Supplier Performance Information"></asp:Label>
                        </legend>
                        <%-- Row 1 --%>
                        <div class="row">
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                                <div class="filter_validation">
                                    <div class="filter_item">
                                        <asp:Label runat="server" ID="frmCriteriaSupplierPerformanceMaint_formlblCode" Text="Code" CssClass="filter_label"></asp:Label><span class="span_require">*</span>
                                        <asp:TextBox runat="server" ID="frmCriteriaSupplierPerformanceMaint_formtxtCode" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmCriteriaSupplierPerformanceMaint_formlblStatus" Text="Status" CssClass="filter_label filter_frmlabel--modify"></asp:Label>
                                    <asp:DropDownList ID="ddFormStatus" runat="server" CssClass="form-control">
                                        <asp:ListItem Selected="true" Text="Active"></asp:ListItem>
                                        <asp:ListItem Text="Inactive"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>

                        <%-- Row 2 --%>
                        <div class="row">
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmCriteriaSupplierPerformanceMaint_formlblName" Text="Name" CssClass="filter_label filter_frmlabel--modify"></asp:Label>
                                    <asp:TextBox runat="server" ID="frmCriteriaSupplierPerformanceMaint_formtxtName" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmCriteriaSupplierPerformanceMaint_formlblContent" Text="Content" CssClass="filter_label filter_labelselect2"></asp:Label>
                                    <asp:DropDownList runat="server" ID="ddFormContent" CssClass="form-control select2" Style="width: 100%;">
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>

                        <%-- Row 3 --%>
                        <div class="row">
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmCriteriaSupplierPerformanceMaint_formlblCategory" Text="Category" CssClass="filter_label filter_frmlabel--modify"></asp:Label>
                                    <asp:DropDownList runat="server" ID="ddFormCategory" CssClass="form-control">
                                        <asp:ListItem Selected="true" Text="Initial Evaluate"></asp:ListItem>
                                        <asp:ListItem Text="Annual Evaluate"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmCriteriaSupplierPerformanceMaint_formlblContentDetail" Text="Content Detail" CssClass="filter_label filter_labelselect2"></asp:Label>
                                    <asp:DropDownList runat="server" ID="ddFormContentDetail" CssClass="form-control select2" Style="width: 100%;">
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>

                        <%-- Row 4 --%>
                        <div class="row">
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmCriteriaSupplierPerformanceMaint_formlblPoints" Text="Points" CssClass="filter_label filter_frmlabel--modify"></asp:Label>
                                    <asp:TextBox runat="server" ID="frmCriteriaSupplierPerformanceMaint_formtxtPoints" CssClass="form-control" TextMode="Number" step="0.5" max="5" min="1"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                                <div class="filter_validation">
                                    <div class="filter_item">
                                        <asp:Label runat="server" ID="frmCriteriaSupplierPerformanceMaint_formlblOrder" Text="Order" CssClass="filter_label filter_frmlabel--modify"></asp:Label>
                                        <asp:TextBox runat="server" ID="frmCriteriaSupplierPerformanceMaint_formtxtOrder" CssClass="form-control" TextMode="Number" step="1" min="1"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </fieldset>

                    <%-- Action : Save && Canncel --%>
                    <div class="text-right mt-4">
                        <span id="btnsave">
                            <asp:Button ID="frmCriteriaSupplierPerformanceMaint_btnSave" runat="server" Text="Save" CssClass="btn bg-gradient-success action_button action_button--modify" /></span>
                        <span id="btncancel">
                            <asp:Button ID="frmCriteriaSupplierPerformanceMaint_btnCancel" runat="server" Text="Cancel" CssClass="btn btn-outline-dark action_button" />
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </div>



    <%-- Import/Upload Supplier --%>
    <div class="row row-cols-1 row-cols-sm-1 row-cols-md-2 justify-content-center supplier_import" id="CriteriaMaintImport">
        <div class="col">
            <div id="frmDropFile" class="box">
                <div class="text-center">
                    <asp:Label runat="server" ID="frmCriteriaSupplierPerformanceMaint_lblDesc" class="box_description">Drag and Drop to upload data file (*.csv, *.xlsx) or import file from your computer</asp:Label>
                    <span class="box_icon"><i class="fa fa-cloud-upload-alt"></i></span>
                    <asp:FileUpload ID="fileUpload" runat="server" CssClass="box_import" />
                </div>
            </div>
            <hr />
            <div class="note">
                <asp:Label runat="server" ID="frmCriteriaSupplierPerformanceMaint_lblNote" class="note_span mr-2">Note :</asp:Label>
                <asp:Label runat="server" ID="frmCriteriaSupplierPerformanceMaint_lblComment" class="note_desc">This function allows import of data list from Excel or CSV file.</asp:Label>
                <asp:Button runat="server" ID="frmCriteriaSupplierPerformanceMaint_link" class="note_link" Text="Template here" />
            </div>
            <div class="mt-3 text-md-right">
                <asp:Button ID="frmCriteriaSupplierPerformanceMaint_btnImport" runat="server" CssClass="btn bg-gradient-success rowButton-modal" text="Upload"/>
            </div>
        </div>
    </div>

    <%-- Modal popup confirm update status --%>
    <div class="modal fade" id="CriteriaModalUpdate" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-md">
            <div class="modal-content card-border">
                <div class="modal-detail">
                    <div class="modal-icon">
                        <i class="fas fa-exclamation-triangle"></i>
                    </div>
                    <div class="modal-desc">
                        <asp:Label runat="server" ID="lblUpdateTitle" Text="Change Status" CssClass="modal-text1"></asp:Label>
                        <div class="mt-1">
                            <asp:Label runat="server" ID="lblUpdateDesc" Text="Are you sure you want to change the Status of item ?" CssClass="modal-text2" ></asp:Label>
                        </div>
                    </div>
                </div>
                <div class="modal-action">
                    <asp:Button runat="server" ID="btnUpdCanncel" CssClass="btn btn-outline-dark mr-2" Text="Canncel"/>
                    <asp:Button runat="server" ID="btnUpdateStatus" CssClass="btn bg-gradient-success" Text="Yes"/>
                </div>
            </div>
        </div>
    </div>

    <%-- Modal popup confirm delete record in browse --%>
    <div class="modal fade" id="CriteriaModalDelete" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-md">
            <div class="modal-content card-border">
                <div class="modal-detail">
                    <div class="modal-icon">
                        <i class="fas fa-exclamation-triangle"></i>
                    </div>
                    <div class="modal-desc">
                        <asp:Label runat="server" ID="lblDeleteTitle" Text="Delete Evaluate" CssClass="modal-text1"></asp:Label>
                        <div class="mt-1">
                            <asp:Label runat="server" ID="lblDeleteDesc" Text="Are you sure you want to delete Criteria  ?" CssClass="modal-text2" ></asp:Label>
                        </div>
                    </div>
                </div>
                <div class="modal-action">
                    <asp:Button runat="server" ID="btnDltCanncel" CssClass="btn btn-outline-dark mr-2" Text="Canncel"/>
                    <asp:Button runat="server" ID="btnDeleteStatus" CssClass="btn bg-gradient-success" Text="Yes"/>
                </div>
            </div>
        </div>
    </div>


    <script>

         $(function () {
             
              $('#btnGoBack').click(function () {
                 $('#quickForm')[0].submit();
              });

             $('#btncancel').click(function () {
                 $('#quickForm')[0].submit();
             });

             $('#btnsave').click(function () {
                  $('#quickForm').validate({
                  rules: {
                                    
                                      <%= frmCriteriaSupplierPerformanceMaint_formtxtCode.UniqueID %>: {
                                            required: true
                                      },
                                      <%= frmCriteriaSupplierPerformanceMaint_formtxtOrder.UniqueID %>: {
                                            required: true
                                      },
                    },

                  messages: {
                                  
                                      <%= frmCriteriaSupplierPerformanceMaint_formtxtCode.UniqueID %>: {
                                            required: "Criteria code can't be null",
                                      },
                                      <%= frmCriteriaSupplierPerformanceMaint_formtxtOrder.UniqueID %>: {
                                            required: "Criteria order can't be null",
                                      },
                     },
		
                errorElement: 'span',
                errorPlacement: function (error, element) {
                    error.addClass('invalid-feedback-mod');
                    element.closest('.filter_validation').append(error);
                },
                highlight: function (element, errorClass, validClass) {
                    $(element).addClass('is-invalid');
                },
                unhighlight: function (element, errorClass, validClass) {
                    $(element).removeClass('is-invalid');
                }

              });
             });

            
            });
         
    </script>

    <%-- Add Data Source --%>
    <asp:SqlDataSource ID="dsPOApproval" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT TOP(3) po_no,amount,create_date,due_date,next_approver,status FROM vPMS_po_approval_browse"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsRowPerPage" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT value FROM TERP_row_per_page ORDER BY value"></asp:SqlDataSource>

    <%-- Call Script --%>
    <script src="/terp/Theme/plugins/jquery/jquery-3.6.0.min.js"></script>
    <script src="/terp/Libs/ModalMessage.js"></script>
    <script src="../../Libs/CountEmailJS.js"></script>

    <script>
        $(function () {
            $('.select2').select2()
        })
    </script>
</asp:Content>
