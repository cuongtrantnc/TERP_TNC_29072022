<%@ Page Title="" Language="C#" MasterPageFile="~/TERP.Master" AutoEventWireup="true" CodeBehind="frmSupplierQuotation.aspx.cs" Inherits="TERP.Forms.PMS.frmSupplierQuotation" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TERPContentPlaceHolder" runat="server">
    <link href="../../Style/Browse/BrowseStyle.css" rel="stylesheet" />
    <link href="../../Style/PMS/frmSupplierQuotation.css" rel="stylesheet"/>
    

     <%-- Title Menu --%>
    <div class="title-padding header-menu" style="width:100%">
        <asp:Label runat="server" ID="frmSupplierQuotation_lblTitle" Text="Supplier Quotation" CssClass="title_label"></asp:Label>
        <%-- Action : Create new && Import data --%>
        <div class="action">
            <span id="btnGoBack" class="action_button-hide"><asp:Button runat="server" ID="frmSupplierQuotation_btnGoBack" CssClass="btn btn-outline-success action_button" Text="Go Back" OnClick="frmSupplierQuotation_btnGoBack_Click"/></span>
            <span id="btnCreateNew"><asp:Button runat="server" ID="frmSupplierQuotation_btnCreateNew"  CssClass="btn bg-gradient-success action_button" Text="Create New" OnClick="frmSupplierQuotation_btnCreateNew_Click"/></span>
            <span id="btnUploadNew"><asp:Button runat="server" ID="frmSupplierQuotation_btnUploadNew" ClientIDMode="Static" CssClass="btn btn-outline-success action_button" Text="Upload Data" OnClick="frmSupplierQuotation_btnUploadNew_Click"/></span>
        
        </div>
    </div>

    

    <%-- Filter and View  --%>
    <div class="row " id="SupplierFilter">
        <div class="col-md-12">
            <div class="card card-border card-boxshadow">
                <div class="card-body" style="overflow:auto;">
                    <%--Condition Filter--%>
                    <fieldset class="fieldSet">
                        <legend class="fieldSet_legend">
                            <asp:Label runat="server" ID="frmSupplierQuotation_fieldSetFilter" Text="Sreach Condition"></asp:Label>
                        </legend>
                        <div class="row">
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmSupplierQuotation_lblCode" Text="Code" CssClass="filter_label filter_label--modify"></asp:Label>
                                    <asp:TextBox runat="server" ID="frmSupplierQuotation_txtCode" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmSupplierQuotation_lblItemCode" Text="Item Code" CssClass="filter_label filter_labelselect2"></asp:Label>
                                    <asp:DropDownList ID="ddItemCode" runat="server" CssClass="form-control select2" style="width:100%;">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmSupplierQuotation_lblStatus" Text="Status" CssClass="filter_label filter_label--modify"></asp:Label>
                                    <asp:DropDownList ID="ddStatus" runat="server" CssClass="form-control form-control__modify">
                                        <asp:ListItem Selected="true" Text="Active"></asp:ListItem>
                                        <asp:ListItem Text="Inactive"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmSupplierQuotation_lblSupplCode" Text="Supplier Code" CssClass="filter_label filter_labelselect2"></asp:Label>
                                    <asp:DropDownList ID="ddSupplCode" runat="server" CssClass="form-control select2" style="width:100%;">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmSupplierQuotation_lblExpired" Text="Expired Date" CssClass="filter_label filter_label--modify"></asp:Label>
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                <i class="far fa-calendar-alt"></i>
                                            </span>
                                        </div>
                                        <asp:TextBox ID="frmSupplierQuotation_txtFromDate" runat="server"  CssClass="form-control form-control__modify" autocomplete="off" placeholder="MM/dd/yyyy"></asp:TextBox>
                                        <ajaxToolkit:CalendarExtender ID="txtFromDate_CalendarExtender" runat="server" BehaviorID="txtFromDate_CalendarExtender" TargetControlID="frmSupplierQuotation_txtFromDate" />
                                    </div>
                                </div>
                                <div class="filter_action">
                                    <asp:Button runat="server" ID="frmSupplierQuotation_filterBtnSreach" Text="Sreach" CssClass="btn bg-gradient-success filter_button filter_button-modify"/>
                                    <asp:Button runat="server" ID="frmSupplierQuotation_filterBtnClear" Text="Clear" CssClass="btn btn-outline-success filter_button filter_button-modify"/>
                                </div>
                            </div>    
                        </div>
                        <div class="row">
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                
                            </div>
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                
                            </div>
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                
                            </div>
                        </div>
                        <%-- End Condition Filter --%>                    
                    </fieldset>

                     <%-- Paging --%>
                    <div class="paging">
                        <asp:Button runat="server" ID="frmSupplierQuotation_btnComparison" Text="Comparison" CssClass="btn bg-gradient-success paging_buttonCompar"/>
                        <asp:Label ID="frmSupplierQuotation_lblRecordPage" runat="server" Text="Record per Page" CssClass="pr-2"></asp:Label>
                        <asp:DropDownList ID="ddRecordPerPage" runat="server" CssClass="paging_record" DataSourceID="dsRowPerPage" DataTextField="value" DataValueField="value" AutoPostBack="True"  />
                        
                        <asp:Label runat="server" ID="frmSupplierQuotation_lblTotal" Text="Total" CssClass="pl-3 pr-3"></asp:Label>
                        <asp:Label runat="server" ID="frmSupplierQuotation_lblvalue" Text="20000"></asp:Label>
                    </div>


                    <%--Evaluate Content GridView--%>
                    <asp:GridView runat="server" ID="grSupplQuotation"  AutoGenerateColumns="False" CellPadding="2" ForeColor="#333333" ShowHeaderWhenEmpty="True" CssClass="table table-bordered mt-2 grview"
                    AllowPaging="True" DataSourceID="dsPOApproval" OnRowDataBound="grSupplQuotation_RowDataBound">
                    <HeaderStyle CssClass="table_header" />
                    <RowStyle CssClass="rowstyle"/>
                    <Columns>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:CheckBox runat="server" ID="ckAll"  AutoPostBack="True"/>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <div class="itemTemplate">
                                    <asp:CheckBox runat="server" ID="ckCheck"/>
                                </div>
                            </ItemTemplate>
                            <ItemStyle  CssClass="itemStyle"/>
                            <HeaderStyle CssClass="text-center grview_header"/>
                        </asp:TemplateField>
                        <asp:BoundField DataField="po_no" HeaderText="Code" HeaderStyle-CssClass="grview_header" ItemStyle-HorizontalAlign="Center"/>
                        <asp:BoundField DataField="po_no" HeaderText="Item Code" />
                        <asp:BoundField DataField="po_no" HeaderText="Supplier Code" />
                        <asp:BoundField DataField="amount" HeaderText="Unit Price" DataFormatString="{0:0,##.##}" ItemStyle-HorizontalAlign="right"/>
                        <asp:BoundField DataField="po_no" HeaderText="Discount" HeaderStyle-CssClass="grview_header" ItemStyle-HorizontalAlign="Center"/>
                        <asp:BoundField DataField="amount" HeaderText="Quantity" DataFormatString="{0:0,##.##}" HeaderStyle-CssClass="grview_header" ItemStyle-HorizontalAlign="right"/>


                        <asp:BoundField DataField="create_date" HeaderText="Expired Date" DataFormatString="{0:MM/dd/yyyy}" HeaderStyle-CssClass="grview_header" ItemStyle-HorizontalAlign="Center"/>

                        <asp:TemplateField HeaderText="Status" SortExpression="enable">
                            <EditItemTemplate>
                                <asp:Label ID="lblStatus" runat="server" Text='<%# Bind("status") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:LinkButton ID="btnChangeStatus" runat="server" CssClass="grview_status" Text='<%# Bind("status") %>' ToolTip="Change Status" OnClick="btnChangeStatus_Click"></asp:LinkButton>
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
     <div class="row supplier_form" id="SupplierForm">
        <div class="col-md-12">
            <div class="card card-border card-boxshadow">
                <div class="card-body">
                    <%-- Form input --%>
                    <fieldset class="fieldSet">
                        <legend class="fieldSet_legend">
                            <asp:Label runat="server" ID="frmSupplierQuotation_fieldSetForm" Text="Supplier Quotation Information"></asp:Label>
                        </legend>

                        <%-- Row 1 --%>
                        <div class="row">
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmSupplierQuotation_formlblCode" Text="Code" CssClass="filter_label"></asp:Label><span class="span_require">*</span>
                                    <asp:TextBox runat="server" ID="frmSupplierQuotation_formtxtCode" CssClass="form-control form-control__modify"></asp:TextBox>
                                </div>
                             </div>
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmSupplierQuotation_formlblSupplCode" Text="Supplier Code" CssClass="filter_label filter_labelselect2"></asp:Label>
                                    <asp:DropDownList runat="server" ID="ddFormSupplCode" CssClass="form-control select2" style="width:100%;">
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>

                        <%-- Row 2 --%>
                        <div class="row">
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmSupplierQuotation_formlblStatus" Text="Status" CssClass="filter_label filter_label--modify"></asp:Label>
                                    <asp:DropDownList runat="server" ID="ddFormStatus" CssClass="form-control form-control__modify">
                                        <asp:ListItem Text="Active" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="Inactive"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                             </div>
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmSupplierQuotation_formlblEffectiveDate" Text="Effective Date" CssClass="filter_label filter_labelselect2"></asp:Label>
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                <i class="far fa-calendar-alt"></i>
                                            </span>
                                        </div>
                                        <asp:TextBox ID="frmSupplierQuotation_formEffectiveDate" runat="server" CssClass="form-control form-control__modify" autocomplete="off" placeholder="MM/dd/yyyy"></asp:TextBox>
                                        <ajaxToolkit:CalendarExtender ID="formEffectiveDate_CalendarExtender" runat="server" BehaviorID="formEffectiveDate_CalendarExtender" TargetControlID="frmSupplierQuotation_formEffectiveDate" />
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%-- Row 3 --%>
                        <div class="row">
                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                            <div class="filter_item">
                                <asp:Label runat="server" ID="frmSupplierQuotation_formlblExpiredDate" Text="Expired Date" CssClass="filter_label filter_labelselect2"></asp:Label>
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">
                                            <i class="far fa-calendar-alt"></i>
                                        </span>
                                    </div>
                                    <asp:TextBox ID="frmSupplierQuotation_formExpiredDate" runat="server" CssClass="form-control form-control__modify" autocomplete="off" placeholder="MM/dd/yyyy"></asp:TextBox>
                                    <ajaxToolkit:CalendarExtender ID="formExpiredDate_CalendarExtender" runat="server" BehaviorID="formExpiredDate_CalendarExtender" TargetControlID="frmSupplierQuotation_formExpiredDate" />
                                </div>
                            </div>
                         </div>
                    </div>
                    
                        <hr />
                        <%-- Button Add new line --%>
                        <div class="line">
                            <asp:Button ID="frmSupplierQuotation_btnAddLine" runat="server" Text="Add New" CssClass="btn btn-success line_button" />
                        </div>
                        <%-- Create new Line view --%>
                        <asp:Updatepanel runat="server" ID="SupplLine">
                            <ContentTemplate>
                                <asp:GridView runat="server" ID="grSupplLine"  AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" ShowHeaderWhenEmpty="True" CssClass="table table-bordered grview"
                                    AllowPaging="true"  DataSourceID="dsPOApproval" >
                                    <HeaderStyle CssClass="table_header" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Line">
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" CssClass="form-control"  DataValueField="po_no"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="grview_header" />
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Item Code">
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddItemCode" runat="server" CssClass="form-control select2"  DataValueField="user_id"
                                                    AutoPostBack="True">
                                                </asp:DropDownList>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="grview_itemcode" />
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Description">
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" CssClass="form-control"  DataValueField="po_no"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Unit of measure">
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddUnit" runat="server" CssClass="form-control"  DataValueField="user_id"
                                                    AutoPostBack="True">
                                                </asp:DropDownList>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="grview_header" />
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Unit Price">
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" CssClass="form-control"  DataValueField="next_approver"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="grview_price" />
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Discount">
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" CssClass="form-control"  DataValueField="next_approver"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="grview_header" />
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Quantity">
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" CssClass="form-control"  DataValueField="next_approver"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="grview_header" />
                                        </asp:TemplateField>
                                            
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <asp:Label runat="server" Text="Delete" />
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <div class="itemTemplate">
                                                    <asp:ImageButton runat="server" ID="frmSupplierQuotation_btnLineDelete" ImageUrl="~/Images/trash.png" ToolTip="Delete" CssClass="itemTemplate-icon" />
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
                                    
                            </ContentTemplate>
                        </asp:Updatepanel>

                    </fieldset>
                
                     <%-- Action : Save && Canncel --%>
                    <div class="text-right mt-4">
                        <asp:Button ID="frmSupplierQuotation_btnSave" runat="server" Text="Save" CssClass="btn bg-gradient-success action_button action_button--modify" />
                        <asp:Button ID="frmSupplierQuotation_btnCancel" runat="server" Text="Cancel" CssClass="btn btn-outline-dark action_button" />
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%-- Import/Upload Evaluate Content Detail Maintenance --%>
    <div class="row row-cols-1 row-cols-sm-1 row-cols-md-2 justify-content-center supplier_import" id="SupplierImport">
            <div class="col">
                <div id="frmDropFile" class="box">
                    <div class="text-center">
                        <asp:Label runat="server" ID="frmSupplierQuotation_lblDesc" class="box_description">Drag and Drop to upload data file (*.csv, *.xlsx) or import file from your computer</asp:Label>
                        <span class="box_icon"><i class="fa fa-cloud-upload-alt"></i></span>
                        <asp:FileUpload ID="fileUpload" runat="server" CssClass="box_import"/>
                    </div>
                </div>
                <hr />
                <div class="note">
                    <asp:Label runat="server" ID="frmSupplierQuotation_lblNote" class="note_span mr-2">Note :</asp:Label>
                    <asp:Label runat="server" ID="frmSupplierQuotation_lblComment" class="note_desc">This function allows import of data list from Excel or CSV file.</asp:Label>
                    <asp:Button runat="server" ID="frmSupplierQuotation_link" class="note_link" Text="Template here"/>
                </div>
                <div class="mt-3 text-md-right">
                    <asp:Button ID="frmSupplierQuotation_btnImport" runat="server" CssClass="btn bg-gradient-success rowButton-modal" Text="Upload"/>
                </div>
            </div>
    </div>

    <%-- Modal popup confirm update status --%>
    <div class="modal fade" id="SupplierModalUpdate" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
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



    <%-- Add Data Source --%>
    <asp:SqlDataSource ID="dsPOApproval" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT TOP(4) po_no,amount,create_date,due_date,next_approver,status FROM vPMS_po_approval_browse"></asp:SqlDataSource>

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
