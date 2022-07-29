<%@ Page MasterPageFile="~/TERP.Master" Language="C#" AutoEventWireup="true" CodeBehind="frmPRApproval.aspx.cs" Inherits="TERP.Forms.PMS.frmPRApproval" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ContentPlaceHolderID="TERPContentPlaceHolder" runat="server">
    <link href="../../Style/Browse/BrowseStyle.css" rel="stylesheet" />
    <link href="../../Style/PMS/frmPRApproval.css" rel="stylesheet" />

    <asp:UpdatePanel ID="upPRApproval" runat="server">
        <ContentTemplate>
            <%--Title Modul--%>
            <div style="width: 100%" class="title-padding">
                <asp:Label ID="PRApproval_lblModuleTitle" runat="server" Text="Purchase Requisition Approval" Font-Bold="True" CssClass="h4"></asp:Label>
            </div>

            <%--Conditon Filter--%>
            <div class="row" id="divCondition" runat="server">
                <div class="col-md-12">
                    <div class="card card-border card-boxshadow">
                        <div class="card-body">
                            <fieldset class="fieldSet">
                                <legend class="fieldSet_legend">
                                    <asp:Label runat="server" ID="PRApproval_fieldSetFilter" Text="Filter"></asp:Label>
                                </legend>
                                <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
                                    <div class="col">
                                        <asp:Label ID="PRApproval_lblPurchase" runat="server" Text="Purchase Requisition" CssClass="Form__label"></asp:Label>
                                        <asp:TextBox ID="txtPurchase" runat="server" CssClass="form-control mt-2" MaxLength="8"></asp:TextBox>
                                    </div>
                                    <div class="col">
                                        <asp:Label ID="PRApproval_lblFromDate" runat="server" Text="From Date" CssClass="Form__label"></asp:Label>
                                        <div class="input-group mt-2">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text">
                                                    <i class="far fa-calendar-alt"></i>
                                                </span>
                                            </div>
                                            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" autocomplete="off" placeholder="MM/dd/yyyy"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender ID="txtFromDate_CalendarExtender" runat="server" BehaviorID="txtFromDate_CalendarExtender" TargetControlID="txtFromDate" />
                                        </div>

                                    </div>
                                    <div class="col">
                                        <asp:Label ID="PRApproval_lblToDate" runat="server" Text="To Date" CssClass="Form__label"></asp:Label>
                                        <div class="input-group mt-2">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text">
                                                    <i class="far fa-calendar-alt"></i>
                                                </span>
                                            </div>
                                            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" autocomplete="off" placeholder="MM/dd/yyyy"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender ID="txtToDate_CalendarExtender" runat="server" BehaviorID="txtToDate_CalendarExtender" TargetControlID="txtToDate" />
                                        </div>

                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-12 col-md-4 offset-md-8">
                                        <div class="actions">
                                            <asp:Button ID="PRApproval_btQuery" runat="server" Text="Query" CssClass="btn bg-gradient-success Form__button button-font-size" OnClick="PRApproval_btQuery_Click" />
                                        </div>
                                    </div>
                                </div>
                            </fieldset>
                            <%--PRApproval GridView--%>
                            <div class="card card-border card-boxshadow mt-3">
                                <div class="card-body" style="overflow: auto;">
                                    <div class="d-flex align-items-center rowperpage-modify">
                                        <asp:Label ID="PRApproval_lblRecordPage" runat="server" Text="Record per Page" CssClass="mr-3"></asp:Label>
                                        <asp:DropDownList ID="ddRecordPerPage" runat="server" CssClass="" DataSourceID="dsRowPerPage" DataTextField="value" DataValueField="value" AutoPostBack="True" OnSelectedIndexChanged="ddRecordPerPage_SelectedIndexChanged" />
                                        &nbsp;/&nbsp;
                                <asp:Label ID="lblTotal" runat="server" Text="0" CssClass="mr-3"></asp:Label>
                                    </div>
                                    <div class="grid-wrapper-maint-browse" id="prApproval-scroll">
                                        <asp:GridView ID="grPRApproval" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" ShowHeaderWhenEmpty="True" CssClass="table table-bordered table-maint-browse-modify"
                                            AllowPaging="True" DataSourceID="dsPRApproval" OnRowDataBound="grPRApproval_RowDataBound">
                                            <RowStyle CssClass="rowstyle" />
                                            <Columns>
                                                <asp:BoundField DataField="pr_no" HeaderText="PR No." SortExpression="pr_no" />
                                                <asp:BoundField DataField="amount" HeaderText="Amount" SortExpression="amount" DataFormatString="{0:#,###.##}" ItemStyle-HorizontalAlign="Right" />
                                                <asp:BoundField DataField="create_date" HeaderText="Create Date" ReadOnly="True" SortExpression="create_date" DataFormatString="{0:MM/dd/yyyy}" ItemStyle-HorizontalAlign="Center" />
                                                <asp:BoundField DataField="due_date" HeaderText="Due Date" SortExpression="due_date" DataFormatString="{0:MM/dd/yyyy}" ItemStyle-HorizontalAlign="Center" />
                                                <asp:BoundField DataField="next_approver" HeaderText="Next Approver" SortExpression="next_approver" />
                                                <asp:BoundField DataField="status" HeaderText="Status" SortExpression="status" ItemStyle-HorizontalAlign="Center" />
                                                <asp:TemplateField>
                                                    <HeaderTemplate>
                                                        <asp:Label runat="server" Text="Action" />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <div class="itemTemplate">
                                                            <asp:ImageButton runat="server" ID="btDetailItemView" ImageUrl="~/Images/view.png" ToolTip="View Detail" CssClass="itemTemplate-icon" OnClick="btDetailItemView_Click" />
                                                        </div>
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="itemStyle" />
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>

                                                <asp:TemplateField>
                                                    <HeaderTemplate>
                                                        <asp:Label runat="server" Text="History" />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <div class="itemTemplate">
                                                            <asp:ImageButton runat="server" ID="btHistoryLogged" ImageUrl="~/Images/info.png" ToolTip="Loged" CssClass="itemTemplate-icon" OnClick="btHistoryLogged_Click" />
                                                        </div>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="order_" HeaderText="order" SortExpression="order_" />
                                            </Columns>
                                            <FooterStyle BackColor="#e9ecef" Font-Bold="True" />
                                            <HeaderStyle BackColor="#e9ecef" HorizontalAlign="Center" />
                                            <PagerStyle CssClass="pageStyle" HorizontalAlign="Center" />

                                        </asp:GridView>
                                    </div>

                                </div>
                            </div>
                            <%--End PRApproval GridView--%>
                        </div>
                    </div>
                </div>
            </div>

            <%--Modal Approval Loged--%>
            <div class="modal fade" id="prApproval_LogedModal" tabindex="-1" aria-labelledby="prApproval_LogedModal" aria-hidden="true">
                <div class="modal-dialog modal-xl modal-dialog-centered">
                    <div class="modal-content card-border">
                        <div class="modal-header">
                            <asp:Label runat="server" CssClass="modal-title h5" ID="PRApproval_lblTitleLoged" Text="Approval Log" />
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row row-cols-1 row-cols-sm-1 row-cols-md-2 py-3">
                                <div class="ApprovalLog">
                                    <asp:Label runat="server" ID="PRApproval_lblPrNo" Text="PR No." CssClass="ApprovalLog__label" />
                                    <asp:TextBox runat="server" ID="txtPrNo" ReadOnly="true" CssClass="ApprovalLog__input ApprovalLog__input--bg" MaxLength="8" />
                                </div>
                            </div>

                            <div class="row row-cols-md-1 py-3">
                                <div style="overflow: auto;">
                                    <asp:GridView ID="grApprovalLoged" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" ShowHeaderWhenEmpty="True" CssClass="table table-bordered" AllowPaging="False" DataSourceID="dsApprovalLoged">
                                        <RowStyle CssClass="rowstyle" />
                                        <Columns>
                                            <asp:BoundField DataField="row_number" HeaderText="No." ReadOnly="True" SortExpression="row_number" />
                                            <asp:BoundField DataField="pr_no" HeaderText="pr_no" SortExpression="pr_no" Visible="false" />
                                            <asp:BoundField DataField="approver_name" HeaderText="Main Approver" SortExpression="approver_name" />
                                            <asp:BoundField DataField="alt_approver_name" HeaderText="Alt Approver" SortExpression="alt_approver_name" />
                                            <asp:BoundField DataField="action_by" HeaderText="Action By" SortExpression="action_by" />
                                            <asp:BoundField DataField="status" HeaderText="Status" SortExpression="status" />
                                            <asp:BoundField DataField="approval_time" HeaderText="Date" SortExpression="approval_time" DataFormatString="{0:MM/dd/yyyy HH:mm:sss}" />
                                        </Columns>
                                        <FooterStyle BackColor="#e9ecef" Font-Bold="True" />
                                        <HeaderStyle BackColor="#e9ecef" HorizontalAlign="Center" />
                                        <PagerStyle CssClass="pageStyle" HorizontalAlign="Center" />
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <%--PRApproval Item Detail View--%>
            <div class="row approvalDetailView" id="divDetailview" runat="server" visible="false">
                <div class="col-md-12">
                    <div class="card card-border card-boxshadow">
                        <div class="card-body">
                            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3 justify-content-center">
                                <div class="col">
                                    <asp:Label ID="PRApproval_lblPrNoView" runat="server" Text="Pr No." CssClass="Form__label my-2" />
                                    <asp:TextBox ID="txtPrNoView" runat="server" ReadOnly="true" CssClass="form-control my-2" />
                                </div>
                                <div class="col">
                                    <asp:Label ID="PRApproval_lblSupplier" runat="server" Text="Supplier" CssClass="Form__label my-2" />
                                    <asp:TextBox ID="txtSupplierView" runat="server" ReadOnly="true" CssClass="form-control my-2" />
                                </div>
                            </div>

                            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3 justify-content-center">
                                <div class="col">
                                    <asp:Label ID="PRApproval_lblCreatedDate" runat="server" Text="Created Date" CssClass="Form__label my-2" />
                                    <asp:TextBox ID="txtCreatedDateView" runat="server" ReadOnly="true" CssClass="form-control my-2" />
                                </div>

                                <div class="col">
                                    <asp:Label ID="PRApproval_lblDueDate" runat="server" Text="Due Date" CssClass="Form__label my-2" />
                                    <asp:TextBox ID="txtDueDateView" runat="server" ReadOnly="true" CssClass="form-control my-2" />
                                </div>
                            </div>

                            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3 justify-content-center">
                                <div class="col">
                                    <asp:TextBox ID="txtApproverIDView" runat="server" ReadOnly="true" CssClass="form-control my-2" Visible="false" />
                                    <asp:TextBox ID="txtAltApproverIDView" runat="server" ReadOnly="true" CssClass="form-control my-2" Visible="false" />
                                </div>

                                <div class="col">
                                    <asp:TextBox ID="txtOrderView" runat="server" ReadOnly="true" CssClass="form-control my-2" Visible="false" />
                                    <asp:TextBox ID="txtApprovalCodeView" runat="server" ReadOnly="true" CssClass="form-control my-2" Visible="false" />
                                </div>
                            </div>

                            <div class="card card-border card-boxshadow mt-3">
                                <div class="card-body" style="overflow: auto;">
                                    <div class="grid-wrapper-detail-browse">
                                        <asp:GridView ID="grPRApprovalDetail" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" ShowHeaderWhenEmpty="True"
                                            CssClass="table table-bordered table-modify-detail-browse" Style="overflow: auto;" AllowPaging="True" DataSourceID="dsPRApprovalDetail">
                                            <RowStyle CssClass="rowstyle" />
                                            <Columns>
                                                <asp:BoundField DataField="pr_no" HeaderText="PR No." SortExpression="pr_no" Visible="false" />
                                                <asp:BoundField DataField="line" HeaderText="Line" SortExpression="line" />
                                                <asp:BoundField DataField="item_number" HeaderText="Item No." SortExpression="item_number" />
                                                <asp:BoundField DataField="description" HeaderText="Description" SortExpression="description" />
                                                <asp:BoundField DataField="unit_cost" HeaderText="Unit Cost" SortExpression="unit_cost" DataFormatString="{0:#,###.##}" ItemStyle-HorizontalAlign="Right" />
                                                <asp:BoundField DataField="disc" HeaderText="Disc%" SortExpression="disc" DataFormatString="{0:#0.00%}" ItemStyle-HorizontalAlign="Center" />
                                                <asp:BoundField DataField="required_qty" HeaderText="Qty" SortExpression="required_qty" DataFormatString="{0:#,###.##}" ItemStyle-HorizontalAlign="Right" />
                                                <asp:BoundField DataField="total" HeaderText="Total" ReadOnly="True" SortExpression="total" DataFormatString="{0:#,###.##}" ItemStyle-HorizontalAlign="Right" />
                                                <asp:TemplateField>
                                                    <HeaderTemplate>
                                                        <asp:Label runat="server" Text="History" />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <div class="itemTemplate">
                                                            <asp:ImageButton runat="server" ID="btLast10PRHistory" ImageUrl="~/Images/time.png" ToolTip="View History" CssClass="itemTemplate-icon" OnClick="btLast10PRHistory_Click" />
                                                        </div>
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="itemStyle" />
                                                    <HeaderStyle HorizontalAlign="Center" />
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

                        <div class="card-footer">
                            <div class="row row-cols-1 row-cols-sm-1 row-cols-md-2 row-cols-xl-2 g-3 justify-content-center">
                                <div class="d-flex justify-content-start align-items-center">
                                    <asp:Label runat="server" ID="PRApproval_lblReason" Text="Reason" CssClass="ApprovalLog__label my-2" />
                                    <asp:TextBox runat="server" ID="txtReason" CssClass="ApprovalLog__input" MaxLength="48" />
                                </div>
                            </div>

                            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-1 g-3">
                                <hr />
                                <div class="Form__action">
                                    <asp:Button runat="server" ID="PRApproval_btApproval" Text="Approval" CssClass="btn bg-gradient-success Form__button Form__action--button button-font-size" OnClick="PRApproval_btApproval_Click" />
                                    <asp:Button runat="server" ID="PRApproval_btReject" Text="Reject" CssClass="btn bg-gradient-success Form__button Form__action--button button-font-size" OnClick="PRApproval_btReject_Click" />
                                    <asp:Button runat="server" ID="PRApproval_btBack" Text="Back" CssClass="btn bg-gradient-success Form__button Form__action--button button-font-size" OnClick="PRApproval_btBack_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <%-- Modal History PRApproval Item Detail View---%>
            <div class="modal fade" id="prApproval_HistoryItemView" tabindex="-1" aria-labelledby="prApproval_HistoryItemView" aria-hidden="true">
                <div class="modal-dialog modal-xl modal-dialog-centered">
                    <div class="modal-content card-border">
                        <div class="modal-header">
                            <asp:Label runat="server" CssClass="modal-title h5" ID="PRApproval_lblTitleItemView" Text="Last 10 Purchase Requisition" />
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row row-cols-1 row-cols-sm-1 row-cols-md-2 py-3">
                                <div class="ApprovalLog">
                                    <asp:Label runat="server" ID="PRApproval_lblItemPart" Text="Item Part" CssClass="ApprovalLog__label" />
                                    <asp:TextBox runat="server" ID="txtItemPart" ReadOnly="true" CssClass="ApprovalLog__input ApprovalLog__input--bg" />
                                </div>
                            </div>

                            <div class="row row-cols-md-1" style="overflow: auto;">
                                <asp:GridView ID="grHistoryItemView" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" ShowHeaderWhenEmpty="True"
                                    CssClass="table table-bordered table-history-browse-modify" AllowPaging="True" DataSourceID="dsHistoryItemView">
                                    <RowStyle CssClass="rowstyle" />
                                    <Columns>
                                        <%--                                <asp:BoundField DataField="item_number" HeaderText="item_number" SortExpression="item_number" />
                                    <asp:BoundField DataField="description" HeaderText="description" SortExpression="description" />--%>
                                        <asp:BoundField DataField="pr_no" HeaderText="PR No." SortExpression="pr_no" />
                                        <asp:BoundField DataField="supplier" HeaderText="Supplier Code" SortExpression="supplier" ItemStyle-HorizontalAlign="Center" />
                                        <asp:BoundField DataField="supplier_name" HeaderText="Supplier Name" SortExpression="supplier_name" />
                                        <asp:BoundField DataField="unit_cost" HeaderText="Price" SortExpression="unit_cost" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:#,###.##}" />
                                        <asp:BoundField DataField="create_date" HeaderText="Create Date" ReadOnly="True" SortExpression="create_date" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:MM/dd/yyyy}" />
                                    </Columns>
                                    <FooterStyle BackColor="#e9ecef" Font-Bold="True" />
                                    <HeaderStyle BackColor="#e9ecef" HorizontalAlign="Center" />
                                    <PagerStyle CssClass="pageStyle" HorizontalAlign="Center" />
                                </asp:GridView>
                            </div>
                            <div class="row row-cols-1 row-cols-sm-1 row-cols-md-1" id="divNoDataAvailable" runat="server">
                                <div class="text-center text-red text-bold">
                                    <asp:Label ID="PRApproval_lblMessage" runat="server" CssClass="" Text="No Data Available" />
                                </div>
                            </div>
                            <p>&nbsp;</p>
                            <div class="row row-cols-1 row-cols-sm-1 row-cols-md-1">
                                <div class="text-right text-red text-bold">
                                    <asp:Button ID="PRApproval_btColose" runat="server" Text="Close" data-dismiss="modal" CssClass="btn bg-gradient-success Form__button button-font-size" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>


    <script>
        //window refresh
        $(document).ready(function () {
            $('#prApproval-scroll').scrollTop(localStorage.prApprovalscrollposition);
            localStorage.prApprovalscrollposition = "";

        });

        //save position of scrollbar
        $('#prApproval-scroll').scroll(function () {
            let topScroll = $('#prApproval-scroll').scrollTop();
            localStorage.prApprovalscrollposition = topScroll;
        });
    </script>

    <%--Add DataSource--%>
    <asp:SqlDataSource ID="dsTemp" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsApprovalLoged" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT TOP (0) ROW_NUMBER() OVER (ORDER BY order_) AS row_number, pr_no,approver_name,alt_approver_name,action_by,status,approval_time FROM vPMS_pr_approval_log ORDER BY order_"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsRowPerPage" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>" SelectCommand="SELECT value FROM TERP_row_per_page ORDER BY value"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsPRApproval" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT TOP (0) pr_no,amount,create_date,due_date,next_approver,status FROM vPMS_pr_approval_browse"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsPRApprovalDetail" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT TOP (0) pr_no,line,item_number,description,unit_cost,disc,required_qty,total FROM vPMS_pr_approval_detail"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsHistoryItemView" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT TOP (0) pr_no,supplier,supplier_name,unit_cost,create_date FROM vPMS_pr_approval_item_history ORDER BY create_date DESC"></asp:SqlDataSource>


    <%--Call Script--%>
    <%--     <script src="/terp/Theme/plugins/jquery/jquery-3.6.0.min.js"></script>
     <script src="/terp/Libs/ModalMessage.js"></script>--%>
    <script src="../../Libs/CountEmailJS.js"></script>

</asp:Content>

