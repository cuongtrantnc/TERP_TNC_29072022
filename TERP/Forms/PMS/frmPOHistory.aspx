<%@ Page MasterPageFile="~/TERP.Master" Language="C#" AutoEventWireup="true" CodeBehind="frmPOHistory.aspx.cs" Inherits="TERP.Forms.PMS.frmPOHistory" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ContentPlaceHolderID="TERPContentPlaceHolder" runat="server">
    <link href="../../Style/Browse/BrowseStyle.css" rel="stylesheet" />
    <link href="../../Style/PMS/frmPOHistory.css" rel="stylesheet" />


    <%-- ------------------Title----------------------------%>
    <asp:UpdatePanel ID="upPOHistory" runat="server">
        <ContentTemplate>
            <div style="width: 100%" class="title-padding">
                <asp:Label ID="POHistory_lblModuleTitle" runat="server" Text="Purchase Order History" Font-Bold="True" CssClass="h4"></asp:Label>
            </div>
            <%-- ------------------END Title----------------------------%>

            
            <div class="filter card card-border card-boxshadow" style="overflow: auto;">
                <%-- ------------------Browse Filter----------------------------%>
                <fieldset class="fieldSet">
                    <legend class="fieldSet_legend">
                        <asp:Label runat="server" ID="POHistory_fieldSetFilter" Text="Filter Condition"></asp:Label>
                    </legend>
                    <div class="filter-list">
                        <div class="row">
                            <div class="col-xs-12 col-md-6">
                                <div class="filter-item">
                                    <asp:Label ID="POHistory_lblPONo" runat="server" Text="PO No:"></asp:Label>
                                    <asp:TextBox ID="txtPONo" runat="server" CssClass="form-control mt-2" MaxLength="8"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xs-12 col-md-6">
                                <div class="filter-item">
                                    <asp:Label ID="POHistory_lblSupplier" runat="server" Text="Supplier:"></asp:Label>
                                    <asp:TextBox ID="txtSupplier" runat="server" CssClass="form-control mt-2" MaxLength="8"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12 col-md-6">
                                <div class="filter-item">
                                    <asp:Label ID="POHistory_lbStatus" runat="server" Text="Status:"></asp:Label>
                                    <asp:DropDownList ID="ddStatus" runat="server" CssClass="form-control mt-2" DataSourceID="dsStatus" DataTextField="status" DataValueField="id" />
                                </div>
                            </div>
                            <div class="col-xs-12 col-md-6">
                                <div class="filter-item">
                                    <asp:Label ID="POHistory_lblRequestBy" runat="server" Text="Request By:"></asp:Label>
                                    <asp:TextBox ID="txtRequestBy" runat="server" CssClass="form-control mt-2" MaxLength="60"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12 col-md-6">
                                <div class="filter-item">
                                    <asp:Label ID="POHistory_lblDueDateFrom" runat="server" Text="Due Date From:"></asp:Label>
                                    <div class="input-group mt-2">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                <i class="far fa-calendar-alt"></i>
                                            </span>
                                        </div>
                                        <asp:TextBox ID="txtDueDateFrom" runat="server" CssClass="form-control" autocomplete="off"></asp:TextBox>
                                        <ajaxToolkit:CalendarExtender ID="txtDueDateFrom_CalendarExtender" runat="server" BehaviorID="txtDueDateFrom_CalendarExtender" TargetControlID="txtDueDateFrom" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-12 col-md-6">
                                <div class="filter-item">
                                    <asp:Label ID="POHistory_lbDueDateTo" runat="server" Text="Due Date To:"></asp:Label>
                                    <div class="input-group mt-2">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                <i class="far fa-calendar-alt"></i>
                                            </span>
                                        </div>
                                        <asp:TextBox ID="txtDueDateTo" runat="server" CssClass="form-control" autocomplete="off"></asp:TextBox>
                                        <ajaxToolkit:CalendarExtender ID="txtDueDateTo_CalendarExtender" runat="server" BehaviorID="txtDueDateTo_CalendarExtender" TargetControlID="txtDueDateTo" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12 col-md-6 offset-md-6">
                                <div class="actions">
                                    <asp:Button ID="POHistory_btSearch" runat="server" Text="Search" CssClass="btn bg-gradient-success rowButton-modal button-font-size" OnClick="POHistory_btSearch_Click" />

                                </div>
                            </div>
                        </div>
                    </div>
                </fieldset>
                <%-- ------------------End Browse Filter----------------------------%>

                <%-- ------------------Browse----------------------------%>
                <div class="d-flex align-items-center rowperpage-modify">
                    <asp:Label ID="POHistory_lbRecordPerPage" runat="server" Text="Record per Page" CssClass="mr-3"></asp:Label>
                    <asp:DropDownList ID="ddRecordPerPage" runat="server" CssClass="" DataSourceID="dsRowPerPage" DataTextField="value" DataValueField="value" AutoPostBack="True" OnSelectedIndexChanged="ddRecordPerPage_SelectedIndexChanged" />
                    &nbsp;/&nbsp;
                    <asp:Label ID="lblTotal" runat="server" Text="0" CssClass="mr-3"></asp:Label>
                </div>

                <div class="grid-wrapper">
                    <asp:GridView ID="grPOHistory" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" ShowHeaderWhenEmpty="True" CssClass="table table-bordered table-modify"
                        AllowPaging="True" DataSourceID="dsPOHistoryBrowse">
                        <RowStyle CssClass="rowstyle" />
                        <Columns>
                            <asp:BoundField DataField="po_no" HeaderText="PO No." SortExpression="po_no" />
                            <asp:BoundField DataField="request_by" HeaderText="Request By" SortExpression="request_by" />
                            <asp:BoundField DataField="supplier" HeaderText="Supplier" SortExpression="supplier" />
                            <asp:BoundField DataField="status_id" HeaderText="status_id" SortExpression="status_id" Visible="false" />
                            <asp:BoundField DataField="status" HeaderText="Status" ReadOnly="True" SortExpression="status" />
                            <asp:BoundField DataField="item_number" HeaderText="Item No." SortExpression="item_number" />
                            <asp:BoundField DataField="need_date" HeaderText="Need Date" SortExpression="need_date" DataFormatString="{0:MM/dd/yyyy}" />
                            <asp:BoundField DataField="due_date" HeaderText="Due Date" SortExpression="due_date" DataFormatString="{0:MM/dd/yyyy}" />
                            <asp:BoundField DataField="required_qty" HeaderText="Qty" SortExpression="required_qty" />
                            <asp:BoundField DataField="approver" HeaderText="User" ReadOnly="True" SortExpression="approver" />
                            <asp:BoundField DataField="approval_time" HeaderText="Time Stamp" ReadOnly="True" SortExpression="approval_time" DataFormatString="{0:MM/dd/yyyy HH:mm:ss}" />
                        </Columns>
                        <FooterStyle BackColor="#e9ecef" Font-Bold="True" />
                        <HeaderStyle BackColor="#e9ecef" HorizontalAlign="Center" />
                        <PagerStyle CssClass="pageStyle" HorizontalAlign="Center" />
                    </asp:GridView>
                </div>
                <%-- ------------------End Browse----------------------------%>
            </div>         
        </ContentTemplate>
    </asp:UpdatePanel>
    

    <%--    <script type="text/javascript">
        document.getElementById('TERPContentPlaceHolder_txtDueDateFrom').setAttribute('readonly', true);
        document.getElementById('TERPContentPlaceHolder_txtDueDateTo').setAttribute('readonly', true);
    </script>--%>

    <asp:SqlDataSource ID="dsStatus" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT 0 as id, '' as status UNION SELECT id, status FROM PMS_po_status ORDER BY id" OnSelecting="dsStatus_Selecting"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsRowPerPage" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>" OnSelecting="dsStatus_Selecting"
        SelectCommand="SELECT value FROM TERP_row_per_page ORDER BY value"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsPOHistoryBrowse" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>" OnSelecting="dsStatus_Selecting"
        SelectCommand="SELECT TOP (0) po_no,request_by,supplier,status_id,'' status,item_number,need_date,due_date,required_qty,'' approver,'' approval_time FROM PMS_master_po"></asp:SqlDataSource>

    <script src="../../Libs/CountEmailJS.js"></script>
</asp:Content>
