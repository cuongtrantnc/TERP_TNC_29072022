<%@ Page MasterPageFile="~/TERP.Master" Language="C#" AutoEventWireup="true" CodeBehind="frmPOBrowse.aspx.cs" Inherits="TERP.Forms.PMS.frmPOBrowse" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ContentPlaceHolderID="TERPContentPlaceHolder" runat="server">
    <link href="../../Style/Browse/BrowseStyle.css" rel="stylesheet" />
    <link href="../../Style/PMS/frmPOBrowse.css" rel="stylesheet" />

    <asp:UpdatePanel ID="upPOBrowse" runat="server">
        <ContentTemplate>
            <%--Title Modul--%>
            <div style="width: 100%" class="title-padding">
                <asp:Label ID="POBrowse_lblModuleTitle" runat="server" Text="Purchase Order Browse" Font-Bold="True" CssClass="h4"></asp:Label>
            </div>

            
            <div class="row">
                <div class="col-md-12">
                    <div class="card card-border card-boxshadow">
                        <div class="card-body" style="overflow: auto;">
                            <%-- Filter Sreach --%>
                            <fieldset class="fieldSet">
                                <legend class="fieldSet_legend">
                                    <asp:Label runat="server" ID="POBrowse_fieldSetFilter" Text="Filter Condition"></asp:Label>
                                </legend>
                                <div class="row">
                                    <div class="col-12 col-sm-12 col-md-6 col-lg-4 d-flex justify-content-between align-items-center form-group">
                                        <asp:Label runat="server" ID="POBrowse_lblPONo" CssClass="w-25 mr-3 Filter__label">PO No.</asp:Label>
                                        <asp:TextBox runat="server" ID="txtPONo" CssClass="form-control" />
                                    </div>
                                    <div class="col-12 col-sm-12 col-md-6 col-lg-4 d-flex justify-content-between align-items-center form-group">
                                        <asp:Label runat="server" ID="POBrowse_lblItemNo" CssClass="w-25 mr-3 Filter__label">Item No.</asp:Label>
                                        <asp:TextBox runat="server" ID="txtItemNo" class="form-control" />
                                    </div>
                                    <div class="col-12 col-sm-12 col-md-6 col-lg-4 d-flex justify-content-between align-items-center form-group">
                                        <asp:Label runat="server" ID="POBrowse_lblStatus" CssClass="w-25 mr-3 Filter__label">Status</asp:Label>
                                        <asp:DropDownList ID="ddStatus" runat="server" CssClass="form-control mt-2" DataSourceID="dsStatus" DataTextField="status" DataValueField="id" />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-12 col-sm-12 col-md-6 col-lg-4 d-flex justify-content-between align-items-center form-group">
                                        <asp:Label runat="server" ID="POBrowse_lblFrom" CssClass="w-25 mr-3 Filter__label">From</asp:Label>
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text">
                                                    <i class="far fa-calendar-alt"></i>
                                                </span>
                                            </div>
                                            <asp:TextBox ID="txtFrom" runat="server" CssClass="form-control" autocomplete="off" placeholder="mm/dd/yyyy"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender ID="txtFrom_CalendarExtender" runat="server" BehaviorID="txtFrom_CalendarExtender" TargetControlID="txtFrom" />
                                            <%--                                <ajaxToolkit:CalendarExtender ID="POBrowse_txtFrom_CalendarExtender" runat="server" BehaviorID="POBrowse_txtFrom_CalendarExtender" TargetControlID="POBrowse_txtFrom"></ajaxToolkit:CalendarExtender>--%>
                                        </div>
                                    </div>
                                    <div class="col-12 col-sm-12 col-md-6 col-lg-4 d-flex justify-content-between align-items-center form-group">
                                        <asp:Label runat="server" ID="POBrowse_lblTo" CssClass="w-25 mr-3 Filter__label">To</asp:Label>
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text">
                                                    <i class="far fa-calendar-alt"></i>
                                                </span>
                                            </div>
                                            <asp:TextBox ID="txtTo" runat="server" CssClass="form-control" autocomplete="off" placeholder="mm/dd/yyyy"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender ID="txtTo_CalendarExtender" runat="server" BehaviorID="txtTo_CalendarExtender" TargetControlID="txtTo" />
                                            <%--<ajaxToolkit:CalendarExtender ID="POBrowse_txtTo_CalendarExtender" runat="server" BehaviorID="POBrowse_txtTo_CalendarExtender" TargetControlID="POBrowse_txtTo"></ajaxToolkit:CalendarExtender>--%>
                                        </div>
                                    </div>
                                    <div class="col-12 col-sm-12 col-md-6 col-lg-4 d-flex justify-content-between align-items-center form-group">
                                        <asp:Label runat="server" ID="POBrowse_lblSupplier" CssClass="w-25 mr-3 Filter__label" Text="Supplier"></asp:Label>
                                        <asp:TextBox runat="server" ID="txtSupplier" CssClass="form-control" />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-12 col-md-4 offset-md-8">
                                        <div class="actions">
                                            <asp:Button runat="server" ID="POBrowse_btSearch" Text="Search" CssClass="btn bg-gradient-success mr-3 rowButton button-font-size" OnClick="POBrowse_btSearch_Click" />
                                            <asp:Button runat="server" ID="POBrowse_btClear" Text="Clear" CssClass="btn bg-gradient-success rowButton button-font-size" OnClick="POBrowse_btClear_Click" />
                                        </div>
                                    </div>
                                </div>
                            </fieldset>
                        
                            <%-- Grid View --%>
                            <div class="d-flex align-items-center rowperpage-modify">
                                <asp:Label ID="POBrowse_lblRecordPerPage" runat="server" Text="Record per Page" CssClass="mr-3"></asp:Label>
                                <asp:DropDownList ID="ddRecordPerPage" runat="server" CssClass="" DataSourceID="dsRowPerPage" DataTextField="value" DataValueField="value" AutoPostBack="True" OnSelectedIndexChanged="ddRecordPerPage_SelectedIndexChanged" />
                                &nbsp;/&nbsp;
                                <asp:Label ID="lblTotal" runat="server" Text="0" CssClass="mr-3"></asp:Label>
                            </div>
                            <div class="grid-wrapper">
                                <asp:GridView ID="grPOBrowse" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" ShowHeaderWhenEmpty="True" CssClass="table table-bordered table-modify" AllowPaging="True" DataSourceID="dsPOBrowse">
                                    <RowStyle CssClass="rowstyle" />
                                    <Columns>
                                        <asp:BoundField DataField="po_no" HeaderText="Po No." SortExpression="po_no" />
                                        <asp:BoundField DataField="line" HeaderText="Line" SortExpression="line" ItemStyle-HorizontalAlign="Center" />
                                        <asp:BoundField DataField="supplier" HeaderText="Supplier" SortExpression="supplier" />
                                        <asp:BoundField DataField="supplier_name" HeaderText="Supplier Desc" SortExpression="supplier_name" />
                                        <asp:BoundField DataField="item_number" HeaderText="Item Number" SortExpression="item_number" />
                                        <asp:BoundField DataField="item_desc" HeaderText="Item Desc" SortExpression="item_desc" />
                                        <asp:BoundField DataField="required_qty" HeaderText="Required Qty" SortExpression="required_qty" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:#,###.##}" />
                                        <asp:BoundField DataField="unit_cost" HeaderText="Unit Cost" SortExpression="unit_cost" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:0,##.##}" />
                                        <asp:BoundField DataField="disc" HeaderText="Discount" SortExpression="disc" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:0.##}" />
                                        <asp:BoundField DataField="total" HeaderText="Total" SortExpression="total" ReadOnly="True" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:#,###.##}" />
                                        <asp:BoundField DataField="due_date" HeaderText="Due Date" SortExpression="due_date" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:MM/dd/yyyy}" />
                                        <asp:BoundField DataField="status" HeaderText="Status" SortExpression="status" ItemStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" />
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
        </ContentTemplate>
    </asp:UpdatePanel>

    <%--Add DataSource--%>
    <asp:SqlDataSource ID="dsTemp" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsStatus" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT 0 as id, '' as status UNION SELECT id, status FROM PMS_po_status WHERE id IN (1,2) ORDER BY id" OnSelecting="dsPOBrowse_Selecting"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsRowPerPage" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT value FROM TERP_row_per_page ORDER BY value" OnSelecting="dsPOBrowse_Selecting"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsPOBrowse" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT * FROM vPMS_master_po_browse" OnSelecting="dsPOBrowse_Selecting"></asp:SqlDataSource>

    <script src="../../Libs/CountEmailJS.js"></script>
</asp:Content>
