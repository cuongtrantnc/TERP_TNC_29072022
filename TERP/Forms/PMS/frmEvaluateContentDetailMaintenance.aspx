<%@ Page Title="" Language="C#" MasterPageFile="~/TERP.Master" AutoEventWireup="true" CodeBehind="frmEvaluateContentDetailMaintenance.aspx.cs" Inherits="TERP.Forms.PMS.frmEvaluateContentDetailMaintenance" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TERPContentPlaceHolder" runat="server">
    <link href="../../Style/Browse/BrowseStyle.css" rel="stylesheet" />
    <link href="../../Style/PMS/frmEvaluateContentDetailMaintenance.css" rel="stylesheet"/>
    

     <%-- Title Menu --%>
    <div class="title-padding header-menu" style="width:100%">
        <asp:Label runat="server" ID="frmEvaluateContentDetailMaintenance_lblTitle" Text="Evaluate Content Detail Maintenace" CssClass="title_label"></asp:Label>

        <%-- Action : Create new && Import data --%>
        <div class="action">
            <span id="btnGoBack" class="action_button-hide"><asp:Button runat="server" ID="frmEvaluateContentDetailMaintenance_btnGoBack" CssClass="btn btn-outline-success action_button" Text="Go Back" OnClick="frmEvaluateContentDetailMaintenance_btnGoBack_Click"/></span>
            <span id="btnCreateNew"><asp:Button runat="server" ID="frmEvaluateContentDetailMaintenance_btnCreateNew"  CssClass="btn bg-gradient-success action_button" Text="Create New" OnClick="frmEvaluateContentDetailMaintenance_btnCreateNew_Click"/></span>
            <span id="btnUploadNew"><asp:Button runat="server" ID="frmEvaluateContentDetailMaintenance_btnUploadNew" ClientIDMode="Static" CssClass="btn btn-outline-success action_button" Text="Upload Data" OnClick="frmEvaluateContentDetailMaintenance_btnUploadNew_Click"/></span>
        
        </div>
    </div>

    

    <%-- Filter and View  --%>
    <div class="row " id="EvaluateFilter">
        <div class="col-md-12">
            <div class="card card-border card-boxshadow">
                <div class="card-body" style="overflow:auto;">
                    <%--Condition Filter--%>
                    <fieldset class="fieldSet">
                        <legend class="fieldSet_legend">
                            <asp:Label runat="server" ID="frmEvaluateContentDetailMaintenance_fieldSetFilter" Text="Sreach Condition"></asp:Label>
                        </legend>
                        <div class="row">
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmEvaluateContentDetailMaintenance_lblSupplCode" Text="Code" CssClass="filter_label filter_label--modify"></asp:Label>
                                    <asp:TextBox runat="server" ID="frmEvaluateContentDetailMaintenance_txtSupplCode" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmEvaluateContentDetailMaintenance_lblStatus" Text="Status" CssClass="filter_label filter_label--modify"></asp:Label>
                                    <asp:DropDownList ID="ddStatus" runat="server" CssClass="form-control">
                                        <asp:ListItem Selected="true" Text="Active"></asp:ListItem>
                                        <asp:ListItem Text="Inactive"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmEvaluateContentDetailMaintenance_lblContent" Text="Content" CssClass="filter_label filter_label--modify"></asp:Label>
                                    <asp:DropDownList ID="ddContent" runat="server" CssClass="select2" style="width:100%;">
                                    </asp:DropDownList>
                                </div>
                            </div>    
                        </div>
                        <div class="row flex-row-reverse">
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                <div class="filter_action">
                                    <asp:Button runat="server" ID="frmEvaluateContentDetailMaintenance_filterBtnSreach" Text="Sreach" CssClass="btn bg-gradient-success filter_button filter_button-modify"/>
                                    <asp:Button runat="server" ID="frmEvaluateContentDetailMaintenance_filterBtnClear" Text="Clear" CssClass="btn btn-outline-success filter_button filter_button-modify"/>
                                </div>
                            </div>
                        </div>
                        <%-- End Condition Filter --%>                    
                    </fieldset>

                     <%-- Paging --%>
                    <div class="paging">
                        <asp:Label ID="frmEvaluateContentDetailMaintenance_lblRecordPage" runat="server" Text="Record per Page" CssClass="mr-2"></asp:Label>
                        <asp:DropDownList ID="ddRecordPerPage" runat="server" CssClass="paging_record" DataSourceID="dsRowPerPage" DataTextField="value" DataValueField="value" AutoPostBack="True"  />

                        <asp:Label runat="server" ID="frmEvaluateContentDetailMaintenance_lblTotal" Text="Total" CssClass="ml-3 mr-1"></asp:Label>
                        <asp:Label runat="server" ID="frmEvaluateContentDetailMaintenance_lblValue" Text="20000"></asp:Label>
                    </div>


                    <%--Evaluate Content GridView--%>
                    <asp:GridView runat="server" ID="grEvaluateContent"  AutoGenerateColumns="False" CellPadding="2" ForeColor="#333333" ShowHeaderWhenEmpty="True" CssClass="table table-bordered mt-2 grview"
                    AllowPaging="True" DataSourceID="dsPOApproval" OnRowDataBound="grEvaluateContent_RowDataBound">
                    <HeaderStyle CssClass="table_header" />
                    <RowStyle CssClass="rowstyle"/>
                    <Columns>
                        <asp:BoundField DataField="po_no" HeaderText="Code" HeaderStyle-CssClass="grview_header" ItemStyle-HorizontalAlign="Center"/>
                        <asp:BoundField DataField="po_no" HeaderText="Name" />
                        <asp:BoundField DataField="po_no" HeaderText="Content" />
                        <asp:BoundField DataField="po_no" HeaderText="Remark" />
                        <asp:BoundField DataField="po_no" HeaderText="Order" HeaderStyle-CssClass="grview_header" ItemStyle-HorizontalAlign="Center"/>

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
                                    <asp:ImageButton runat="server" ID="btnEditEvaluate" ImageUrl="~/Images/edit.png" ToolTip="Edit" CssClass="itemTemplate-icon" OnClick="btnEditEvaluate_Click"/>
                                </div>
                            </ItemTemplate>
                            <ItemStyle CssClass="itemStyle" />
                            <HeaderStyle HorizontalAlign="Center" CssClass="grview_header"/>
                        </asp:TemplateField>

                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:Label runat="server" Text="Delete" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <div class="itemTemplate">
                                    <asp:ImageButton runat="server" ID="btnDeleteSupplier" ImageUrl="~/Images/trash.png" ToolTip="Delete" CssClass="itemTemplate-icon" OnClick="btnDeleteSupplier_Click"/>
                                </div>
                            </ItemTemplate>
                            <ItemStyle CssClass="itemStyle" />
                            <HeaderStyle HorizontalAlign="Center" CssClass="grview_header"/>
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

     <%-- Form Create Evaluate Content Detail and Edit --%>
     <div class="row evaluate_form" id="EvaluateForm">
        <div class="col-md-12">
            <div class="card card-border card-boxshadow">
                <div class="card-body">
                    <%-- Form input --%>
                    <fieldset class="fieldSet">
                        <legend class="fieldSet_legend">
                            <asp:Label runat="server" ID="frmEvaluateContentDetailMaintenance_fieldSetForm" Text="Evaluate Content Information"></asp:Label>
                        </legend>

                        <%-- Row 1 --%>
                        <div class="row">
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmEvaluateContentDetailMaintenance_formlblCode" Text="Code" CssClass="filter_label"></asp:Label><span class="span_require">*</span>
                                    <asp:TextBox runat="server" ID="frmEvaluateContentDetailMaintenance_formtxtCode" CssClass="form-control"></asp:TextBox>
                                </div>
                             </div>
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmEvaluateContentDetailMaintenance_formlblStatus" Text="Status" CssClass="filter_label filter_frmlabel--modify"></asp:Label>
                                    <asp:DropDownList runat="server" ID="ddFormStatus" CssClass="form-control">
                                        <asp:ListItem Text="Active" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="Inactive"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>

                        <%-- Row 2 --%>
                        <div class="row">
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmEvaluateContentDetailMaintenance_formlblName" Text="Name" CssClass="filter_label"></asp:Label><span class="span_require">*</span>
                                    <asp:TextBox runat="server" ID="frmEvaluateContentDetailMaintenance_formtxtName" CssClass="form-control"></asp:TextBox>
                                </div>
                             </div>
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmEvaluateContentDetailMaintenance_formlblContent" Text="Content" CssClass="filter_label filter_labelselect2"></asp:Label>
                                    <asp:DropDownList runat="server" ID="ddFormContent" CssClass="form-control select2" style="width:100%;">
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>

                        <%-- Row 3 --%>
                        <div class="row">
                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                            <div class="filter_item">
                                <asp:Label runat="server" ID="frmEvaluateContentDetailMaintenance_formlblRemark" Text="Remark" CssClass="filter_label filter_frmlabel--modify"></asp:Label>
                                <asp:TextBox runat="server" ID="frmSupplierMaintenance_formtxtRemark" CssClass="form-control"></asp:TextBox>
                            </div>
                         </div>
                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                            <div class="filter_item">
                                <asp:Label runat="server" ID="frmEvaluateContentDetailMaintenance_formlblOrder" Text="Order" CssClass="filter_label"></asp:Label><span class="span_require">*</span>
                                <asp:TextBox runat="server" TextMode="Number" ID="frmEvaluateContentDetailMaintenance_formtxtOrder" CssClass="form-control" step="1" min="0"></asp:TextBox>
                                
                            </div>
                        </div>
                    </div>
                    </fieldset>
                
                     <%-- Action : Save && Canncel --%>
                    <div class="text-right mt-4">
                        <asp:Button ID="frmEvaluateContentDetailMaintenance_btnSave" runat="server" Text="Save" CssClass="btn bg-gradient-success action_button action_button--modify" />
                        <asp:Button ID="frmEvaluateContentDetailMaintenance_btnCancel" runat="server" Text="Cancel" CssClass="btn btn-outline-dark action_button" />
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%-- Import/Upload Evaluate Content Detail Maintenance --%>
    <div class="row row-cols-1 row-cols-sm-1 row-cols-md-2 justify-content-center mt-4 evaluate_import" id="EvaluateImport">
            <div class="col">
                <div id="frmDropFile" class="box">
                    <div class="text-center">
                        <asp:Label runat="server" ID="frmEvaluateContentDetailMaintenance_lblDesc" class="box_description">Drag and Drop to upload data file (*.csv, *.xlsx) or import file from your computer</asp:Label>
                        <span class="box_icon"><i class="fa fa-cloud-upload-alt"></i></span>
                        <asp:FileUpload ID="fileUpload" runat="server" CssClass="box_import"/>
                    </div>
                </div>
                <hr />
                <div class="note">
                    <asp:Label runat="server" ID="frmEvaluateContentDetailMaintenance_lblNote" class="note_span mr-2">Note :</asp:Label>
                    <asp:Label runat="server" ID="frmEvaluateContentDetailMaintenance_lblComment" class="note_desc">This function allows import of data list from Excel or CSV file.</asp:Label>
                    <asp:Button runat="server" ID="frmEvaluateContentDetailMaintenance_link" class="note_link" Text="Template here"/>
                </div>
                <div class="mt-3 text-md-right">
                    <asp:Button ID="frmEvaluateContentDetailMaintenance_btnImport" runat="server" CssClass="btn bg-gradient-success rowButton-modal"/>
                </div>
            </div>
    </div>


    <%-- Modal popup confirm update status --%>
    <div class="modal fade" id="EvaluateModalUpdate" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
    <div class="modal fade" id="EvaluateModalDelete" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-md">
            <div class="modal-content card-border">
                <div class="modal-detail">
                    <div class="modal-icon">
                        <i class="fas fa-exclamation-triangle"></i>
                    </div>
                    <div class="modal-desc">
                        <asp:Label runat="server" ID="lblDeleteTitle" Text="Delete Evaluate" CssClass="modal-text1"></asp:Label>
                        <div class="mt-1">
                            <asp:Label runat="server" ID="lblDeleteDesc" Text="Are you sure you want to delete Evaluate Content Detail ?" CssClass="modal-text2" ></asp:Label>
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


    <%-- Add Data Source --%>
    <asp:SqlDataSource ID="dsPOApproval" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT po_no,amount,create_date,due_date,next_approver,status FROM vPMS_po_approval_browse"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsRowPerPage" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT value FROM TERP_row_per_page ORDER BY value"></asp:SqlDataSource>


    <%-- Call Script --%>
    <script src="/terp/Theme/plugins/jquery/jquery-3.6.0.min.js"></script>
    <script src="/terp/Libs/ModalMessage.js"></script>
    <script src="../../Libs/CountEmailJS.js"></script>
    <script src="../../Theme/plugins/select2/js/select2.full.min.js"></script>
    <script>
        $(function () {
            //Initialize Select2 Elements
            $('.select2').select2() 

        });
    </script>

</asp:Content>
