<%@ Page MasterPageFile="~/TERP.Master" Language="C#" AutoEventWireup="true" CodeBehind="frmPOApproval.aspx.cs" Inherits="TERP.Forms.PMS.frmPOApproval" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ContentPlaceHolderID="TERPContentPlaceHolder" runat="server">
    <link href="../../Style/Browse/BrowseStyle.css" rel="stylesheet" />
    <link href="../../Style/PMS/frmPOApproval.css" rel="stylesheet" />

    <%--Title Modul--%>
    <asp:UpdatePanel ID="upPOApproval" runat="server">
        <ContentTemplate>
            <div style="width: 100%" class="title-padding">
                <asp:Label ID="POApproval_lblModuleTitle" runat="server" Text="Purchase Order Approval" Font-Bold="True" CssClass="h4"></asp:Label>
            </div>

            <%--Conditon Filter--%>
            <div class="row" id="divCondition" runat="server">
                <div class="col-md-12">
                    <div class="card card-border card-boxshadow">
                        <div class="card-body" style="overflow: auto;">
                            <fieldset class="fieldSet">
                                <legend class="fieldSet_legend">
                                    <asp:Label runat="server" ID="POApproval_fieldSetFilter" Text="Filter Condition"></asp:Label>
                                </legend>
                                <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
                                    <div class="col">
                                        <asp:Label ID="POApproval_lblPurchase" runat="server" Text="Purchase Order" CssClass="form-label"></asp:Label>
                                        <asp:TextBox ID="txtPurchase" runat="server" CssClass="form-control mt-2" MaxLength="8"></asp:TextBox>
                                    </div>
                                    <div class="col">
                                        <asp:Label ID="POApproval_lblFromDate" runat="server" Text="From Date" CssClass="form-label"></asp:Label>
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
                                        <asp:Label ID="POApproval_lblToDate" runat="server" Text="To Date" CssClass="form-label"></asp:Label>
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
                                <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3 my-3">
                                    <div class="col">
                                        <asp:Label ID="POApproval_lblApprover" runat="server" Text="Approver" CssClass="form-label"></asp:Label>
                                        <asp:DropDownList ID="ddApprover" runat="server" CssClass="form-control" DataSourceID="dsApprover" DataTextField="user_name" DataValueField="user_id"></asp:DropDownList>
                                    </div>
                                    <div class="col">
                                        <asp:Label ID="POApproval_lblStatus" runat="server" Text="Status" CssClass="form-label"></asp:Label>
                                        <asp:DropDownList ID="ddStatus" runat="server" CssClass="form-control" DataSourceID="dsStatus" DataTextField="status" DataValueField="id"></asp:DropDownList>
                                    </div>
                                    <div class="col">
                                        <br />
                                        <asp:Button ID="POApproval_btQuery" runat="server" Text="Query" CssClass="btn bg-gradient-success rowButton-modal button-font-size" OnClick="POApproval_btQuery_Click" />
                                    </div>
                                </div>
                            </fieldset>

                            <%--POApproval GridView--%>
                            <div class="d-flex align-items-center rowperpage-modify">
                                <asp:Label ID="POApproval_lblRecordPage" runat="server" Text="Record per Page" CssClass="mr-3"></asp:Label>
                                <asp:DropDownList ID="ddRecordPerPage" runat="server" CssClass="" DataSourceID="dsRowPerPage" DataTextField="value" DataValueField="value" AutoPostBack="True" OnSelectedIndexChanged="ddRecordPerPage_SelectedIndexChanged" />
                                &nbsp;/&nbsp;
                                <asp:Label ID="lblTotal" runat="server" Text="0" CssClass="mr-3"></asp:Label>
                            </div>

                            <div class="grid-wrapper-maint-browse" id="poApproval-scroll">
                                <asp:GridView ID="grPOApproval" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" ShowHeaderWhenEmpty="True" CssClass="table table-bordered table-modify-maint-browse"
                                    AllowPaging="True" DataSourceID="dsPOApproval" OnRowDataBound="grPOApproval_RowDataBound">
                                    <RowStyle CssClass="rowstyle" />
                                    <Columns>
                                        <asp:BoundField DataField="po_no" HeaderText="PO No." SortExpression="po_no" />
                                        <asp:BoundField DataField="amount" HeaderText="Amount" SortExpression="amount" DataFormatString="{0:#,###.##}" />
                                        <asp:BoundField DataField="create_date" HeaderText="Create Date" ReadOnly="True" SortExpression="create_date" DataFormatString="{0:MM/dd/yyyy}" />
                                        <asp:BoundField DataField="due_date" HeaderText="Due Date" SortExpression="due_date" DataFormatString="{0:MM/dd/yyyy}" />
                                        <asp:BoundField DataField="next_approver" HeaderText="Next Approver" SortExpression="next_approver" />
                                        <asp:BoundField DataField="status" HeaderText="Status" SortExpression="status" />
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
                                            <ItemStyle CssClass="itemStyle" />
                                            <HeaderStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="order_" HeaderText="order" SortExpression="order_" />
                                    </Columns>
                                    <FooterStyle BackColor="#e9ecef" Font-Bold="True" />
                                    <HeaderStyle BackColor="#e9ecef" HorizontalAlign="Center" />
                                    <PagerStyle CssClass="pageStyle" HorizontalAlign="Center" />

                                </asp:GridView>
                            </div>
                            <%--End PRApproval GridView--%>
                        </div>
                    </div>
                </div>
            </div>

            <%--Modal Approval Loged--%>
            <div class="modal fade" id="POApproval_LogedModal" tabindex="-1" aria-labelledby="POApproval_LogedModal" aria-hidden="true">
                <div class="modal-dialog modal-xl modal-dialog-centered">
                    <div class="modal-content card-border">
                        <div class="modal-header">
                            <asp:Label runat="server" CssClass="modal-title h5" ID="POApproval_lblTitleLoged" Text="Approval Log" />
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row row-cols-1 row-cols-sm-1 row-cols-md-2 py-3">
                                <div class="approvalLog">
                                    <asp:Label runat="server" ID="POApproval_lblPONo" Text="PR No." CssClass="approvalLog-label" />
                                    <asp:TextBox runat="server" ID="txtPONo" ReadOnly="true" CssClass="approvalLog-input" MaxLength="8" />
                                </div>
                            </div>

                            <div class="row row-cols-md-1 py-3">
                                <div style="overflow: auto;">
                                    <asp:GridView ID="grApprovalLoged" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" ShowHeaderWhenEmpty="True" CssClass="table table-bordered" AllowPaging="False" DataSourceID="dsApprovalLoged">
                                        <Columns>
                                            <asp:BoundField DataField="row_number" HeaderText="No." ReadOnly="True" SortExpression="row_number" />
                                            <asp:BoundField DataField="po_no" HeaderText="pr_no" SortExpression="pr_no" Visible="false" />
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
                                    <asp:Label ID="POApproval_lblPONoView" runat="server" Text="PO No." CssClass="form-label my-2" />
                                    <asp:TextBox ID="txtPONoView" runat="server" ReadOnly="true" CssClass="form-control my-2" />
                                </div>
                                <div class="col">
                                    <asp:Label ID="POApproval_lblSupplier" runat="server" Text="Supplier" CssClass="form-label my-2" />
                                    <asp:TextBox ID="txtSupplierView" runat="server" ReadOnly="true" CssClass="form-control my-2" />
                                </div>
                            </div>

                            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3 justify-content-center">
                                <div class="col">
                                    <asp:Label ID="POApproval_lblCreatedDate" runat="server" Text="Created Date" CssClass="form-label my-2" />
                                    <asp:TextBox ID="txtCreatedDateView" runat="server" ReadOnly="true" CssClass="form-control my-2" />
                                </div>

                                <div class="col">
                                    <asp:Label ID="POApproval_lblDueDate" runat="server" Text="Due Date" CssClass="form-label my-2" />
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
                                        <asp:GridView ID="grPOApprovalDetail" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" ShowHeaderWhenEmpty="True"
                                            CssClass="table table-bordered table-modify-detail-browse" Style="overflow: auto;" AllowPaging="True" DataSourceID="dsPOApprovalDetail">
                                            <RowStyle CssClass="rowstyle" />
                                            <Columns>
                                                <asp:BoundField DataField="po_no" HeaderText="PO No." SortExpression="po_no" Visible="false" />
                                                <asp:BoundField DataField="line" HeaderText="Line" SortExpression="line" />
                                                <asp:BoundField DataField="item_number" HeaderText="Item No." SortExpression="item_number" />
                                                <asp:BoundField DataField="item_desc" HeaderText="Description" SortExpression="description" />
                                                <asp:BoundField DataField="unit_cost" HeaderText="Unit Cost" SortExpression="unit_cost" DataFormatString="{0:#,###.##}" />
                                                <asp:BoundField DataField="disc" HeaderText="Disc%" SortExpression="disc" DataFormatString="{0:#0.00%}" />
                                                <asp:BoundField DataField="ordered_qty" HeaderText="Qty" SortExpression="ordered_qty" />
                                                <asp:BoundField DataField="total" HeaderText="Total" ReadOnly="True" SortExpression="total" DataFormatString="{0:#,###.##}" />
                                                <asp:TemplateField>
                                                    <HeaderTemplate>
                                                        <asp:Label runat="server" Text="History" />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <div class="itemTemplate">
                                                            <asp:ImageButton runat="server" ID="btLast10POHistory" ImageUrl="~/Images/time.png" ToolTip="View History" CssClass="itemTemplate-icon" OnClick="btLast10POHistory_Click" />
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
                            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-2 g-3 justify-content-center">
                                <div class="col d-flex">
                                    <asp:Label runat="server" ID="POApproval_lblReason" Text="Reason" CssClass="form-label my-2" />
                                    <asp:TextBox runat="server" ID="txtReason" CssClass="form-control" MaxLength="48" />
                                </div>
                            </div>

                            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-1 g-3">
                                <hr />
                                <div class="row-modal">
                                    <asp:Button runat="server" ID="POApproval_btApproval" Text="Approval" CssClass="btn bg-gradient-success rowButton button-font-size" OnClick="POApproval_btApproval_Click" />
                                    <asp:Button runat="server" ID="POApproval_btReject" Text="Reject" CssClass="btn bg-gradient-success rowButton button-font-size" OnClick="POApproval_btReject_Click" />
                                    <asp:Button runat="server" ID="POApproval_btBack" Text="Back" CssClass="btn bg-gradient-success rowButton button-font-size" OnClick="POApproval_btBack_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <%-- Modal History PRApproval Item Detail View---%>
            <div class="modal fade" id="POApproval_HistoryItemView" tabindex="-1" aria-labelledby="POApproval_HistoryItemView" aria-hidden="true">
                <div class="modal-dialog modal-xl modal-dialog-centered">
                    <div class="modal-content card-border">
                        <div class="modal-header">
                            <asp:Label runat="server" CssClass="modal-title h5" ID="POApproval_lblTitleItemView" Text="Last 10 Purchase Order" />
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row row-cols-1 row-cols-sm-1 row-cols-md-2 py-3">
                                <div class="approvalLog">
                                    <asp:Label runat="server" ID="POApproval_lblItemPart" Text="Item Part" CssClass="approvalLog-label" />
                                    <asp:TextBox runat="server" ID="txtItemPart" ReadOnly="true" CssClass="approvalLog-input" />
                                </div>
                            </div>

                            <div class="row row-cols-md-1" style="overflow: auto;">
                                <asp:GridView ID="grHistoryItemView" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" ShowHeaderWhenEmpty="True"
                                    CssClass="table table-bordered table-modify-history-browse" AllowPaging="True" DataSourceID="dsHistoryItemView">
                                    <RowStyle CssClass="rowstyle" />
                                    <Columns>
                                        <%--                                <asp:BoundField DataField="item_number" HeaderText="item_number" SortExpression="item_number" />
                                <asp:BoundField DataField="description" HeaderText="description" SortExpression="description" />--%>
                                        <asp:BoundField DataField="po_no" HeaderText="PO No." SortExpression="po_no" />
                                        <asp:BoundField DataField="supplier" HeaderText="Supplier Code" SortExpression="supplier" />
                                        <asp:BoundField DataField="supplier_name" HeaderText="Supplier Name" SortExpression="supplier_name" />
                                        <asp:BoundField DataField="unit_cost" HeaderText="Price" SortExpression="unit_cost" DataFormatString="{0:#,###.##}" />
                                        <asp:BoundField DataField="create_date" HeaderText="Create Date" ReadOnly="True" SortExpression="create_date" DataFormatString="{0:MM/dd/yyyy}" />
                                    </Columns>
                                    <FooterStyle BackColor="#e9ecef" Font-Bold="True" />
                                    <HeaderStyle BackColor="#e9ecef" HorizontalAlign="Center" />
                                    <PagerStyle CssClass="pageStyle" HorizontalAlign="Center" />
                                </asp:GridView>
                            </div>
                            <div class="row row-cols-1 row-cols-sm-1 row-cols-md-1" id="divNoDataAvailable" runat="server">
                                <div class="text-center text-red text-bold">
                                    <asp:Label ID="POApproval_lblMessage" runat="server" CssClass="" Text="No Data Available" />
                                </div>
                            </div>
                            <p>&nbsp;</p>
                            <div class="row row-cols-1 row-cols-sm-1 row-cols-md-1">
                                <div class="text-right text-red text-bold">
                                    <asp:Button ID="POApproval_btColose" runat="server" Text="Close" data-dismiss="modal" CssClass="btn bg-gradient-success rowButton" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

    <script> 

        $(document).ready(function () {
            $('#poApproval-scroll').scrollTop(localStorage.poApprovalscrollposition);
            localStorage.poApprovalscrollposition = "";

        });

        var prm = Sys.WebForms.PageRequestManager.getInstance();
        prm.add_endRequest(function () {
            scrollToPrevPosition();
            saveCurrentScrollPosition();
        });
    </script>

    <script>
        //window refresh
        function scrollToPrevPosition() {
            $(document).ready(function () {
                $('#poApproval-scroll').scrollTop(localStorage.poApprovalscrollposition);
                localStorage.poApprovalscrollposition = "";

            });
        }


        //save position of scrollbar
        function saveCurrentScrollPosition() {
            $('#poApproval-scroll').scroll(function () {
                let topScroll = $('#poApproval-scroll').scrollTop();
                localStorage.poApprovalscrollposition = topScroll;
            });
        }

    </script>

    <%--Add DataSource--%>
    <asp:SqlDataSource ID="dsTemp" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsApprover" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT '' as user_name, '.' as user_id UNION SELECT user_name + ' - ' + user_full_name as user_name, user_id FROM [TERP_users] WHERE status='Active'"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsStatus" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT 0 as id, '' as status UNION SELECT id, status FROM PMS_po_status WHERE id IN (1,2) ORDER BY id"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsApprovalLoged" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT TOP (0) ROW_NUMBER() OVER (ORDER BY order_) AS row_number, po_no,approver_name,alt_approver_name,action_by,status,approval_time FROM vPMS_po_approval_log ORDER BY order_"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsRowPerPage" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT value FROM TERP_row_per_page ORDER BY value"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsPOApproval" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT TOP (0) po_no,amount,create_date,due_date,next_approver,status FROM vPMS_po_approval_browse"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsPOApprovalDetail" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT TOP (0) po_no,line,item_number,description,unit_cost,disc,ordered_qty,total FROM vPMS_po_approval_detail"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsHistoryItemView" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT TOP (0) po_no,supplier,supplier_name,unit_cost,create_date FROM vPMS_po_approval_item_history ORDER BY create_date DESC"></asp:SqlDataSource>


    <%--Call Script--%>
    <script src="/terp/Theme/plugins/jquery/jquery-3.6.0.min.js"></script>
    <script src="/terp/Libs/ModalMessage.js"></script>
    <script src="../../Libs/CountEmailJS.js"></script>

</asp:Content>

