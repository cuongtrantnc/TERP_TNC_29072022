<%@ Page MasterPageFile="~/TERP.Master" Language="C#" AutoEventWireup="true" CodeBehind="frmPRMaintenance.aspx.cs" Inherits="TERP.Forms.PMS.frmPRMaintenance" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ContentPlaceHolderID="TERPContentPlaceHolder" runat="server">
    <link href="../../Style/Browse/BrowseStyle.css" rel="stylesheet" />
    <link href="../../Style/PMS/frmPRMaintenance.css" rel="stylesheet" />

    <%--  ----------------PR MAINT---------------%>
    <div class="top title-padding" style="width: 100%">
        <asp:Label ID="PRMaintenance_lblModuleTitle" runat="server" Text="PR Maintenance" Font-Bold="True" CssClass="h4"></asp:Label>
        <div class="create">
            <asp:Button ID="PRMaintenance_btCreate" runat="server" Text="Create PR" CssClass="btn bg-gradient-success create-button btn-font-size" OnClick="btCreate_Click" />
        </div>
    </div>

    <div id="divAddEdit" runat="server" visible="false">
        <div class="create-form-group card-boxshadow">
            <div class="modal-header">
                <asp:Label ID="PRMaintenance_lbModalTitle" runat="server" Text="Create PR" CssClass="modal-title h5"></asp:Label>
            </div>
            <div class="modal-body">
                <div class="form-group-modal">
                    <fieldset class="fieldSet">
                        <legend class="fieldSet_legend">
                            <asp:Label runat="server" ID="PRMaintenance_fieldSetInfomation" Text="Information"></asp:Label>
                        </legend>
                        <div class="row">
                            <div class="col-xs-12 col-sm-6">
                                <div class="right-list-modal">
                                    <div class="form-item-modal">
                                        <asp:Label ID="PRMaintenance_lblSupplierModal" runat="server" Text="Suppiler:"></asp:Label>
                                        <asp:DropDownList ID="ddSuppilerModal" runat="server" CssClass="form-control mt-2" DataTextField="supplier" DataValueField="supplier_name" DataSourceID="dsSupplierModal" />
                                        <asp:Label ID="lblCurrentPR" runat="server" Text="" Visible="false"></asp:Label>
                                    </div>
                                    <div class="form-item-modal">
                                        <asp:Label ID="PRMaintenance_lbShipToModal" runat="server" Text="Ship To:"></asp:Label>
                                        <asp:TextBox ID="txtShipToModal" runat="server" CssClass="form-control mt-2" MaxLength="20"> </asp:TextBox>
                                    </div>
                                    <div class="form-item-modal">
                                        <asp:Label ID="PRMaintenance_lblAprovalCodeModal" runat="server" Text="Aproval Code"></asp:Label>
                                        <asp:DropDownList ID="ddAprovalCodeModal" runat="server" CssClass="form-control mt-2" DataTextField="approval_code" DataValueField="approval_code" DataSourceID="dsAprovalCodeModal" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-6">
                                <div class="left-list-modal">
                                    <div class="form-item-modal">
                                        <asp:Label ID="PRMaintenance_lbSiteModal" runat="server" Text="Site:"></asp:Label>
                                        <asp:DropDownList ID="ddSiteModal" runat="server" CssClass="form-control mt-2" DataSourceID="dsSiteModal" DataTextField="site_name" DataValueField="site_name" />
                                    </div>
                                    <div class="form-item-modal">
                                        <asp:Label ID="PRMaintenance_lblRequestByModal" runat="server" Text="Request By"></asp:Label>
                                        <asp:TextBox ID="txtRequestByModal" runat="server" CssClass="form-control mt-2" MaxLength="60"></asp:TextBox>
                                    </div>
                                    <div class="form-item-modal">
                                        <asp:Label ID="PRMaintenance_lbEndUserModal" runat="server" Text="End User:"></asp:Label>
                                        <asp:TextBox ID="txtEndUserModal" runat="server" CssClass="form-control mt-2" MaxLength="100"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </fieldset>
                </div>
            </div>
            <div class="detail-modal">
                <asp:GridView ID="grPRMaintModal" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" ShowHeaderWhenEmpty="True" CssClass="table table-bordered" AllowPaging="True"
                    DataSourceID="dsPRMaintDetailModal" OnRowDataBound="grPRMaintModal_RowDataBound">
                    <RowStyle CssClass="rowstyle" />
                    <Columns>
                        <asp:BoundField DataField="id" SortExpression="id" />
                        <asp:TemplateField HeaderText="Line">
                            <ItemTemplate>
                                <asp:Label ID="lblLine" runat="server" Text='<%# Bind("line") %>' CssClass="form-control mt-2" BackColor="#CCCCCC"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle CssClass="text-center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Item">
                            <ItemTemplate>
                                <asp:Label ID="lblItemModal" runat="server" CssClass="form-control" autocomplete="off" ReadOnly="true" Text='<%# Bind("item_number") %>' Visible="true"></asp:Label>
                                <asp:DropDownList ID="ddItemModal" runat="server" CssClass="form-control mt-2" AutoPostBack="True"
                                    OnSelectedIndexChanged="ddItemModal_SelectedIndexChanged" />
                            </ItemTemplate>
                            <ItemStyle CssClass="text-center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Need Date">
                            <ItemTemplate>
                                <div class="input-group mt-2">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">
                                            <i class="far fa-calendar-alt"></i>
                                        </span>
                                    </div>
                                    <asp:TextBox ID="txtNeedDate" runat="server" CssClass="form-control" autocomplete="off" ReadOnly="false" Text='<%# Bind("need_date") %>' AutoPostBack="True" TextMode="DateTime" OnTextChanged="txtNeedDate_TextChanged"></asp:TextBox>
                                    <ajaxToolkit:CalendarExtender ID="txtNeedDate_CalendarExtender" runat="server"  TargetControlID="txtNeedDate"></ajaxToolkit:CalendarExtender>
                                </div>
                            </ItemTemplate>
                            <ItemStyle CssClass="text-center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Due Date">
                            <ItemTemplate>
                                <div class="input-group mt-2">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">
                                            <i class="far fa-calendar-alt"></i>
                                        </span>
                                    </div>
                                    <asp:TextBox ID="txtDueDate" runat="server" CssClass="form-control" autocomplete="off" ReadOnly="false" Text='<%# Bind("due_date") %>' TextMode="DateTime" AutoPostBack="True" OnTextChanged="txtDueDate_TextChanged"></asp:TextBox>
                                    <ajaxToolkit:CalendarExtender ID="txtDueDate_CalendarExtender" runat="server" TargetControlID="txtDueDate"></ajaxToolkit:CalendarExtender>
                                </div>
                            </ItemTemplate>
                            <ItemStyle CssClass="text-center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Qty Required">
                            <ItemTemplate>
                                <asp:TextBox ID="txtRequiredQty" runat="server" CssClass="form-control mt-2" MaxLength="20" AutoPostBack="True" Text='<%# Bind("required_qty","{0:#,##0.00}") %>' OnTextChanged="txtRequiredQty_TextChanged"></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle CssClass="text-center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Qty Order" Visible="false">
                            <ItemTemplate>
                                <asp:TextBox ID="txtOrder" runat="server" CssClass="form-control mt-2" MaxLength="20" AutoPostBack="True" Text='<%# Bind("ordered_qty", "{0:#,##0.00}") %>' OnTextChanged="txtOrder_TextChanged"></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle CssClass="text-center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Unit Cost">
                            <ItemTemplate>
                                <asp:TextBox ID="txtUnitCost" runat="server" CssClass="form-control mt-2" MaxLength="20" AutoPostBack="True" Text='<%# Bind("unit_cost", "{0:#,##0.00}") %>' OnTextChanged="txtUnitCost_TextChanged"></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle CssClass="text-center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Discount">
                            <ItemTemplate>
                                <asp:TextBox ID="txtDiscount" runat="server" CssClass="form-control mt-2" MaxLength="20" AutoPostBack="True" Text='<%# Bind("disc") %>' OnTextChanged="txtDiscount_TextChanged"></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle CssClass="text-center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Um">
                            <ItemTemplate>
                                <asp:TextBox ID="PRMaintenance_txtUm" runat="server" CssClass="form-control mt-2" ReadOnly="true" Text='<%# Bind("um") %>'></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle CssClass="text-center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Delete" HeaderStyle-Width="10px">
                            <ItemTemplate>
                                <asp:Button ID="PRMaintenance_btDelete" runat="server" Text="Delete" CssClass="btn btn-danger btn-font-size" OnClick="PRMaintenance_btDelete_Click" />
                            </ItemTemplate>
                            <ItemStyle CssClass="text-center" />
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="#e9ecef" Font-Bold="True" />
                    <HeaderStyle BackColor="#e9ecef" HorizontalAlign="Center" />
                    <PagerStyle CssClass="pageStyle" HorizontalAlign="Center" />
                </asp:GridView>
            </div>
            <div class="control">
                <asp:Button ID="PRMaintenance_btModalAdd" runat="server" Text="Add Row" CssClass="btn btn-success btn-font-size" OnClick="PRMaintenance_btModalAdd_Click" />
            </div>

            <div class="control-extra">
                <asp:Label ID="PRMaintenance_lbApprovalNotify" runat="server" Text="Do You Want To Notify Approval?"></asp:Label>
                <asp:DropDownList ID="ddApprovalNoti" runat="server" CssClass="form-control mt-2">
                    <asp:ListItem Text="" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="Yes"></asp:ListItem>
                    <asp:ListItem Text="No"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="modal-footer">
                <div class="modal-item">
                    <asp:Button ID="PRMaintenance_btCancel" runat="server" Text="Cancel" CssClass="btn btn-secondary modal-button btn-font-size" OnClick="PRMaintenance_btCancel_Click" />
                </div>
                <div class="modal-item">
                    <asp:Button ID="PRMaintenance_btSave" runat="server" Text="Save" CssClass="btn btn-success modal-button btn-font-size" OnClick="PRMaintenance_btSave_Click" />
                </div>
            </div>
        </div>
    </div>

    <div id="divMain" runat="server">
        <%-- ----------------Filter------------------%>

        <div class="create-form-group card-boxshadow" style="overflow: auto;">
            <fieldset class="fieldSet">
                <legend class="fieldSet_legend">
                    <asp:Label runat="server" ID="PRMaintenance_fieldSetFilter" Text="Filter Condition"></asp:Label>
                </legend>
                <div class="row">

                    <div class="col-xs-12 col-sm-5">
                        <div class="right-list">
                            <div class="form-item">
                                <asp:Label ID="PRMaintenance_lblPRNo" runat="server" Text="PR No."></asp:Label>
                                <asp:TextBox ID="txtPRNo" runat="server" CssClass="form-control mt-2" MaxLength="8"></asp:TextBox>
                            </div>
                            <div class="form-item">
                                <asp:Label ID="PRMaintenance_lbStatus" runat="server" Text="Status:"></asp:Label>
                                <asp:DropDownList ID="ddStatus" runat="server" CssClass="form-control mt-2" DataSourceID="dsStatus" DataTextField="status" DataValueField="id" />
                            </div>
                            <div class="form-item">
                                <asp:Label ID="PRMaintenance_lblDueDateFrom" runat="server" Text="Due Date From:"></asp:Label>
                                <div class="input-group mt-2">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">
                                            <i class="far fa-calendar-alt"></i>
                                        </span>
                                    </div>
                                    <asp:TextBox ID="txtDueDateFrom" runat="server" CssClass="form-control" autocomplete="off" placeholder="yyyy/mm/dd" TextMode="DateTime"></asp:TextBox>
                                    <ajaxToolkit:CalendarExtender ID="txtDueDateFrom_CalendarExtender" runat="server" BehaviorID="txtDueDateFrom_CalendarExtender" TargetControlID="txtDueDateFrom"></ajaxToolkit:CalendarExtender>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-12 col-sm-5">
                        <div class="left-list">
                            <div class="form-item">
                                <asp:Label ID="PRMaintenance_lblSupplier" runat="server" Text="Supplier:"></asp:Label>
                                <asp:DropDownList ID="ddSupplier" runat="server" CssClass="form-control mt-2" DataSourceID="dsSupplier" DataTextField="supplier" DataValueField="supplier"></asp:DropDownList>
                            </div>
                            <div class="form-item">
                                <asp:Label ID="PRMaintenance_lbRequestBy" runat="server" Text="Request By:"></asp:Label>
                                <asp:TextBox ID="txtRequestBy" runat="server" CssClass="form-control mt-2" MaxLength="20"></asp:TextBox>
                            </div>
                            <div class="form-item">
                                <asp:Label ID="PRMaintenance_lbDueDateTo" runat="server" Text="Due Date To:"></asp:Label>
                                <div class="input-group mt-2">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">
                                            <i class="far fa-calendar-alt"></i>
                                        </span>
                                    </div>
                                    <asp:TextBox ID="txtDueDateTo" runat="server" CssClass="form-control" autocomplete="off" placeholder="yyyy/mm/dd" TextMode="DateTime"></asp:TextBox>
                                    <ajaxToolkit:CalendarExtender ID="txtDueDateTo_CalendarExtender" runat="server" BehaviorID="txtDueDateTo_CalendarExtender" TargetControlID="txtDueDateTo" ></ajaxToolkit:CalendarExtender>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-12 col-sm-2">
                        <div class="actions">
                            <div class="actions-list">
                                <div class="actions-item">
                                    <asp:Button ID="PRMaintenance_btSearch" runat="server" Text="Search" CssClass="btn bg-gradient-success actions-button btn-font-size" OnClick="btSearch_Click" />
                                </div>
                                <div class="actions-item">
                                    <asp:Button ID="PRMaintenance_btClear" runat="server" Text="Clear" CssClass="btn bg-gradient-success actions-button btn-font-size" OnClick="btClear_Click" />
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </fieldset>
            <%-- ----------------END Filter------------------%>
        
            <%-- ----------------Browse------------------%>
            <div class="d-flex align-items-center rowperpage-modify">
                <asp:Label ID="PRMaintenance_lbRecordPerPage" runat="server" Text="Record per Page" CssClass="mr-3"></asp:Label>
                <asp:DropDownList ID="ddRecordPerPage" runat="server" CssClass="" DataSourceID="dsRowPerPage" DataTextField="value" DataValueField="value" AutoPostBack="True" OnSelectedIndexChanged="ddRecordPerPage_SelectedIndexChanged" />
                &nbsp;/&nbsp;
                <asp:Label ID="lblTotal" runat="server" Text="0" CssClass="mr-3"></asp:Label>
            </div>

            <div class="grid-wrapper" id="PRMaint-scroll">
                <asp:GridView ID="grPRMaint" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" ShowHeaderWhenEmpty="True"
                    CssClass="table table-bordered table-modify" AllowPaging="True" DataSourceID="dsPRMaintBrowse" OnRowDataBound="grPRMaint_RowDataBound">
                    <RowStyle CssClass="rowstyle" />
                    <Columns>
                        <asp:BoundField DataField="pr_no" SortExpression="pr_no" HeaderText="PR No." HeaderStyle-HorizontalAlign="Center"></asp:BoundField>

                        <asp:BoundField DataField="request_by" SortExpression="request_by" HeaderText="Request By" HeaderStyle-HorizontalAlign="Center" />

                        <asp:BoundField DataField="supplier" SortExpression="supplier" HeaderText="Supplier" HeaderStyle-HorizontalAlign="Center" />

                        <asp:BoundField DataField="purchaser_email" HeaderText="Purchaser Email" SortExpression="purchaser_email" HeaderStyle-HorizontalAlign="Center" />

                        <asp:BoundField DataField="due_date" HeaderText="Due Date" SortExpression="due_date" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:yyyy/MM/dd}" />

                        <asp:BoundField DataField="status" HeaderText="Status" SortExpression="status" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />

                        <asp:TemplateField HeaderText="Edit" HeaderStyle-Width="5px">
                            <ItemTemplate>
                                <asp:ImageButton ID="btEdit" runat="server" ImageUrl="~/Images/edit.png" CssClass="itemTemplate-icon" OnClick="btEdit_Click" />
                            </ItemTemplate>
                            <ItemStyle CssClass="text-center" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Print" HeaderStyle-Width="5px">
                            <ItemTemplate>
                                <asp:ImageButton ID="btPrint" runat="server" ImageUrl="~/Images/print.png" CssClass="itemTemplate-icon" OnClick="btPrint_Click" />
                            </ItemTemplate>
                            <ItemStyle CssClass="text-center" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Close" HeaderStyle-Width="5px">
                            <ItemTemplate>
                                <asp:ImageButton ID="btClose" runat="server" ImageUrl="~/Images/trash.png" CssClass="itemTemplate-icon" OnClick="btClose_Click" />
                            </ItemTemplate>
                            <ItemStyle CssClass="text-center" />
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="#e9ecef" Font-Bold="True" />
                    <HeaderStyle BackColor="#e9ecef" HorizontalAlign="Center" />
                    <PagerStyle CssClass="pageStyle" HorizontalAlign="Center" />
                </asp:GridView>
            </div>
            <%-- ----------------END Browse------------------%>
        </div>    
        
    </div>

    <script>
        //window refresh
        $(document).ready(function () {
            $('#PRMaint-scroll').scrollTop(localStorage.prMaintscrollposition);
            localStorage.prMaintscrollposition = "";

        });

        //save position of scrollbar
        $('#PRMaint-scroll').scroll(function () {
            let topScroll = $('#PRMaint-scroll').scrollTop();
            localStorage.prMaintscrollposition = topScroll;
        });
    </script>
    <%--  ----------------END PR MAINT---------------%>

    <asp:SqlDataSource ID="dsStatus" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT 0 as id, '' as status UNION SELECT id, status FROM PMS_pr_status ORDER BY id"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsSiteModal" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT site_name FROM vPMS_site ORDER BY site_name"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsAprovalCodeModal" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT '' approval_code UNION SELECT approval_code FROM PMS_approval WHERE status='Active' ORDER BY approval_code"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsSupplier" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT '' as supplier, '' as supplier_name UNION SELECT DISTINCT supplier,supplier_name FROM PMS_master_pr ORDER BY supplier_name"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsSupplierModal" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT DISTINCT supplier,supplier_name FROM PMS_master_pr ORDER BY supplier_name"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsItemModal" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsRowPerPage" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT value FROM TERP_row_per_page ORDER BY value"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsPRMaintBrowse" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT DISTINCT TOP (0) pr_no,request_by,supplier,purchaser_email,due_date,status FROM vPMS_master_pr_browse "></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsPRMaintDetailModal" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT TOP (0) '' id,line,item_number,need_date,due_date,required_qty,ordered_qty,unit_cost,disc,um FROM PMS_master_pr"></asp:SqlDataSource>

    <%--    <script src="../../Theme/plugins/jquery/jquery-3.6.0.min.js"></script>
    <script src="../../Libs/ModalMessage.js"></script>--%>
    <script src="../../Libs/CountEmailJS.js"></script>

</asp:Content>

