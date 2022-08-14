<%@ Page Title="" Language="C#" MasterPageFile="~/TERP.Master" AutoEventWireup="true" CodeBehind="frmSupplierComparison.aspx.cs" Inherits="TERP.Forms.PMS.frmSupplierComparison" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.3500.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TERPContentPlaceHolder" runat="server">
    <link href="../../Style/Browse/BrowseStyle.css" rel="stylesheet"/>
    <link href="../../Style/PMS/frmSupplierComparison.css" rel="stylesheet"/>
    <link href="../../aspnet_client/system_web/4_0_30319/crystalreportviewers13/js/crviewer/images/style.css" rel="stylesheet"/>

    <%-- Title Menu --%>
    <div class="title-padding header-menu" style="width:100%">
        <asp:Label runat="server" ID="frmSupplierComparison_lblTitle" Text="Supplier Comparison" CssClass="title_label"></asp:Label>

         <%-- Action : Create new && Import new --%>
        <div class="action">
            <span id="btnGoBack" class="action_button-hide"><asp:Button runat="server" ID="frmSupplierComparison_btnGoBack" CssClass="btn btn-outline-success action_button" Text="Go Back" /></span>
            <span id="btnCreateNew"><asp:Button runat="server" ID="frmSupplierComparison_btnCreateNew"  CssClass="btn bg-gradient-success action_button" Text="Create New" OnClick="frmSupplierComparison_btnCreateNew_Click"/></span>
        </div>
    </div>

   

    <%-- Filter and View  --%>
    <div class="row " id="SupplierFilter">
        <div class="col-md-12">
            <div class="card card-border card-boxshadow">
                <div class="card-body">
                    <%--Condition Filter--%>
                    <fieldset class="fieldSet">
                        <legend class="fieldSet_legend">
                            <asp:Label runat="server" ID="fieldSet_Filter" Text="Sreach Condition"></asp:Label>
                        </legend>
                        <div class="row">
                            <div class="col-sm-8 g-3">
                                <div class="row row-cols-1 row-cols-sm-2 row-cols-md-2 g-3">
                                    <div class="col">
                                        <div class="filter_item">
                                            <asp:Label runat="server" ID="frmSupplierComparison_lblCode" Text="Code" CssClass="filter_label filter_label--modify"></asp:Label>
                                            <asp:TextBox runat="server" ID="frmSupplierComparison_txtCode" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="filter_item">
                                            <asp:Label runat="server" ID="frmSupplierComparison_lblStatus" Text="Status" CssClass="filter_label filter_label--modify"></asp:Label>
                                            <asp:DropDownList ID="ddStatus" runat="server" CssClass="form-control">
                                                <asp:ListItem Selected="true" Text="New"></asp:ListItem>
                                                <asp:ListItem Text="Signed"></asp:ListItem>
                                                <asp:ListItem Text="Completed"></asp:ListItem>
                                                <asp:ListItem Text="Un-Signed"></asp:ListItem>
                                                <asp:ListItem Text="Close"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="row row-cols-1 row-cols-sm-2 row-cols-md-2 g-3">
                                    <div class="col">
                                        <div class="filter_item">
                                            <asp:Label runat="server" ID="frmSupplierComparison_lblEffDate" Text="Effective Date" CssClass="filter_label filter_datalabel"></asp:Label>
                                            <div class="input-group">
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text">
                                                        <i class="far fa-calendar-alt"></i>
                                                    </span>
                                                </div>
                                                <asp:TextBox ID="frmSupplierComparison_txtEffDate" runat="server"  CssClass="form-control" autocomplete="off" placeholder="MM/dd/yyyy"></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender ID="txtEffDate_CalendarExtender" runat="server" BehaviorID="txtEffDate_CalendarExtender" TargetControlID="frmSupplierComparison_txtEffDate" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="filter_item">
                                            <asp:Label runat="server" ID="frmSupplierComparison_lblExpDate" Text="Expired Date" CssClass="filter_label filter_datalabel"></asp:Label>
                                            <div class="input-group">
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text">
                                                        <i class="far fa-calendar-alt"></i>
                                                    </span>
                                                </div>
                                                <asp:TextBox ID="frmSupplierComparison_txtExpDate" runat="server"  CssClass="form-control" autocomplete="off" placeholder="MM/dd/yyyy"></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender ID="txtExpDate_CalendarExtender" runat="server" BehaviorID="txtExpDate_CalendarExtender" TargetControlID="frmSupplierComparison_txtExpDate" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-4 g-3">
                                <div class="filter_action">
                                    <asp:Button runat="server" ID="frmSupplierComparison_filterBtnSreach" Text="Sreach" CssClass="btn bg-gradient-success filter_button filter_button-modifile"/>
                                    <asp:Button runat="server" ID="frmSupplierComparison_filterBtnClear" Text="Clear" CssClass="btn btn-outline-success filter_button filter_button-modifile"/>
                                </div>
                            </div>
                        </div>
                        <%-- End Condition Filter --%>                    
                    </fieldset>


                    <%-- Paging --%>
                    <div class="paging">
                        <asp:Label ID="frmSupplierComparison_lblRecordPage" runat="server" Text="Record per Page" CssClass="pr-2"></asp:Label>
                        <asp:DropDownList ID="ddRecordPerPage" runat="server" CssClass="paging_record" DataSourceID="dsRowPerPage" DataTextField="value" DataValueField="value" AutoPostBack="True"  />

                        <asp:Label runat="server" ID="frmSupplierComparison_lblPageTotal" Text="Total" CssClass="pl-3 pr-3"></asp:Label>
                        <asp:Label runat="server" ID="lblTotal" Text="20000"></asp:Label>
                    </div>

                    <%--Supplier GridView--%>
                    <asp:GridView runat="server" ID="grSupplierMaintenance"  AutoGenerateColumns="False" CellPadding="2" ForeColor="#333333" ShowHeaderWhenEmpty="True" CssClass="table table-bordered mt-2 grview"
                    AllowPaging="True" DataSourceID="dsPOApproval">
                    <HeaderStyle CssClass="table_header" />
                    <RowStyle CssClass="rowstyle"/>
                    <Columns>

                        <asp:BoundField DataField="po_no" HeaderText="Code" HeaderStyle-CssClass="grview_headerCode" ItemStyle-HorizontalAlign="Center"/>
                        <asp:BoundField DataField="create_date" HeaderText="Effective Date" ReadOnly="True" DataFormatString="{0:MM/dd/yyyy}" ItemStyle-HorizontalAlign="Center"  />
                        <asp:BoundField DataField="create_date" HeaderText="Expired Date" ReadOnly="True" DataFormatString="{0:MM/dd/yyyy}" ItemStyle-HorizontalAlign="Center" />

                        <asp:TemplateField HeaderText="Status" SortExpression="enable">
                            <EditItemTemplate>
                                <asp:Label ID="lblStatus" runat="server" Text='<%# Bind("status") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblStatus" runat="server" Text='<%# Bind("status") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle CssClass="text-center grview_header" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </asp:TemplateField>

                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:Label runat="server" Text="Preview" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <div class="itemTemplate">
                                    <asp:ImageButton runat="server" ID="btnDetailItemView" ImageUrl="~/Images/view.png" ToolTip="View Detail" CssClass="itemTemplate-icon" OnClick="btnDetailItemView_Click"/>
                                </div>
                            </ItemTemplate>
                            <ItemStyle CssClass="itemStyle" />
                            <HeaderStyle HorizontalAlign="Center"  CssClass="grview_header"/>
                        </asp:TemplateField>

                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:Label runat="server" Text="Edit" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <div class="itemTemplate">
                                    <asp:ImageButton runat="server" ID="btnEditSupplier" ImageUrl="~/Images/edit.png" ToolTip="Edit" CssClass="itemTemplate-icon" OnClick="btnEditSupplier_Click"/>
                                </div>
                            </ItemTemplate>
                            <ItemStyle CssClass="itemStyle" />
                            <HeaderStyle HorizontalAlign="Center" CssClass="grview_header"/>
                        </asp:TemplateField>

                        <%--<asp:TemplateField>
                            <HeaderTemplate>
                                <asp:Label runat="server" Text="Print" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <div class="itemTemplate">
                                    <asp:ImageButton runat="server" ID="btnDeleteSupplier" ImageUrl="~/Images/print.png" ToolTip="Delete" CssClass="itemTemplate-icon" />
                                </div>
                            </ItemTemplate>
                            <ItemStyle CssClass="itemStyle" />
                            <HeaderStyle HorizontalAlign="Center" CssClass="grview_header"/>
                        </asp:TemplateField>--%>
                    </Columns>
                    <FooterStyle BackColor="#e9ecef" Font-Bold="True" />
                    <HeaderStyle BackColor="#e9ecef" HorizontalAlign="Center" />
                    <PagerStyle CssClass="pageStyle" HorizontalAlign="Center" />
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>


    <%-- Form Create Supplier Comparison Detail and Edit --%>
     <div class="row supplier_form" id="SupplierForm">
        <div class="col-md-12">
            <div class="card card-border card-boxshadow">
                <div class="card-body">
                    <%-- Form input --%>
                    <fieldset class="fieldSet">
                        <legend class="fieldSet_legend">
                            <asp:Label runat="server" ID="frmSupplierComparison_fieldSetForm" Text="Supplier Comparison Information"></asp:Label>
                        </legend>

                        <%-- Row 1 --%>
                        <div class="row">
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmSupplierComparison_formlblCode" Text="Code" CssClass="filter_label"></asp:Label><span class="span_require">*</span>
                                    <asp:TextBox runat="server" ID="frmSupplierComparison_formtxtCode" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmSupplierComparison_formlblEffdate" Text="Effective Date" CssClass="filter_label filter_labelselect2"></asp:Label>
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                <i class="far fa-calendar-alt"></i>
                                            </span>
                                        </div>
                                        <asp:TextBox ID="frmSupplierComparison_formtxtEffDate" runat="server"  CssClass="form-control" autocomplete="off" placeholder="MM/dd/yyyy"></asp:TextBox>
                                        <ajaxToolkit:CalendarExtender ID="formtxtEffDate_CalendarExtender" runat="server" BehaviorID="formtxtEffDate_CalendarExtender" TargetControlID="frmSupplierComparison_formtxtEffDate" />
                                    </div>
                                </div>
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmSupplierComparison_formlblExpDate" Text="Expired Date" CssClass="filter_label filter_labelselect2"></asp:Label>
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                <i class="far fa-calendar-alt"></i>
                                            </span>
                                        </div>
                                        <asp:TextBox ID="frmSupplierComparison_formtxtExpDate" runat="server"  CssClass="form-control" autocomplete="off" placeholder="MM/dd/yyyy"></asp:TextBox>
                                        <ajaxToolkit:CalendarExtender ID="formtxtExpDate_CalendarExtender" runat="server" BehaviorID="formtxtExpDate_CalendarExtender" TargetControlID="frmSupplierComparison_formtxtExpDate" />
                                    </div>
                                </div>
                             </div>
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                                <div class="filter_item filter_itemTextArea">
                                    <asp:Label runat="server" ID="frmSupplierComparison_formlblConclusion" Text="Conclusion" CssClass="filter_label filter_labelselect2"></asp:Label>
                                    <textarea id="frmSupplierComparison_txtArea" cols="20" rows="5" class="w-100"></textarea>
                                </div>
                            </div>
                        </div>

                       
                    
                        <hr />
                        <%-- Button Add new line --%>
                        <div class="line">
                            <asp:Button ID="frmSupplierComparison_btnAddLine" runat="server" Text="Add New" CssClass="btn btn-success line_button" />
                        </div>
                        <%-- Create new Line view --%>
                        <asp:Updatepanel runat="server" ID="SupplLine">
                            <ContentTemplate>
                                <asp:GridView runat="server" ID="grSupplLine"  AutoGenerateColumns="False" CellPadding="2" ForeColor="#333333" ShowHeaderWhenEmpty="True" CssClass="table table-bordered grview"
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
                                            <HeaderStyle CssClass="" />
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Item Description">
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" CssClass="form-control"  DataValueField="po_no"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Quantity">
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" CssClass="form-control"  DataValueField="next_approver"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="grview_header" />
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Unit of measure">
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddUnit" runat="server" CssClass="form-control"  DataValueField="user_id"
                                                    AutoPostBack="True">
                                                </asp:DropDownList>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="grview_header" />
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Supplier">
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddSupplier" runat="server" CssClass="form-control"  DataValueField="user_id"
                                                    AutoPostBack="True">
                                                </asp:DropDownList>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="" />
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Unit Price">
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" CssClass="form-control"  DataValueField="next_approver"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="grview_amount" />
                                            <ItemStyle CssClass="text-right" />
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Discount">
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" CssClass="form-control"  DataValueField="next_approver"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="grview_header" />
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Total">
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" CssClass="form-control"  DataValueField="next_approver"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="grview_amount" />
                                            <ItemStyle CssClass="text-right" />
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Proposal">
                                            <ItemTemplate>
                                                <div class="itemTemplate">
                                                    <asp:CheckBox runat="server" ID="ckCheck"/>
                                                </div>
                                            </ItemTemplate>
                                            <ItemStyle  CssClass="itemStyle"/>
                                            <HeaderStyle CssClass="text-center"/>
                                        </asp:TemplateField>
                                            
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <asp:Label runat="server" Text="Delete" />
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <div class="itemTemplate">
                                                    <asp:ImageButton runat="server" ID="frmSupplierComparison_btnLineDelete" ImageUrl="~/Images/trash.png" ToolTip="Delete" CssClass="itemTemplate-icon" />
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
                        <asp:Button ID="frmSupplierComparison_btnSave" runat="server" Text="Save" CssClass="btn bg-gradient-success action_button action_button--modify" />
                        <asp:Button ID="frmSupplierComparison_btnCancel" runat="server" Text="Cancel" CssClass="btn btn-outline-dark action_button" />
                    </div>
                </div>
            </div>
        </div>
    </div>


    <%-- Modal popup confirm update status --%>
    <div class="modal fade" id="SupplierComparison_ViewReport" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-xl">
            <div class="modal-content card-border">
                <div class="modal-header">
                    <asp:Label runat="server" CssClass="modal-title" ID="PRApproval_lblTitleLoged" Text="Approval Log" />
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <fieldset class="fieldSet">
                        <legend class="fieldSet_legend">
                            <asp:Label runat="server" ID="Label1" Text="Sreach Condition"></asp:Label>
                        </legend>
                            <div class="row">
                                <%-- Header and Action --%>
                                <div class="col-xs-12 col-sm-6 col-md-6 col-lg-3">
                                    <span>Code :</span>
                                    <asp:Label runat="server" ID="frmSupplierComparisonReport_lblCode"></asp:Label>
                                </div>
                                <div class="col-xs-12 col-sm-6 col-md-6 col-lg-3 ml-auto">
                                    <asp:DropDownList ID="ddReport_user" runat="server" CssClass="form-control" style="width:100%;">
                                        <asp:ListItem Selected="true">Route to User</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-xs-12 col-sm-6 col-md-6 col-lg-3">
                                    <asp:DropDownList ID="ddReport_action" runat="server" CssClass="form-control" style="width:100%;">
                                        <asp:ListItem Selected="True">Action</asp:ListItem>
                                        <asp:ListItem Text="New"></asp:ListItem>
                                        <asp:ListItem Text="Signed"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                    </fieldset>

                    <div class="row mt-4 justify-content-around">
                       <CR:CrystalReportViewer ID="CrystalReportViewer" runat="server" AutoDataBind="true" ReportSourceID="CrystalReportSource" ToolPanelWidth="200px" Width="350px" ToolPanelView="None" />
                        <CR:CrystalReportSource ID="CrystalReportSource" runat="server">
                            <Report FileName="/Report/SupplierComparison.rpt">
                            </Report>
                        </CR:CrystalReportSource>
                    </div>
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
    <%--<script src="/terp/Theme/plugins/jquery/jquery-3.6.0.min.js"></script>--%>
    <script src="/terp/Libs/ModalMessage.js"></script>
    <script src="../../Libs/CountEmailJS.js"></script>
    <script src="../../aspnet_client/system_web/4_0_30319/crystalreportviewers13/js/crviewer/crv.js"></script>
    
</asp:Content>
