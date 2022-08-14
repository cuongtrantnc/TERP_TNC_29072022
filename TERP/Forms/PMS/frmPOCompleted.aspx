<%@ Page MasterPageFile="~/TERP.Master" Language="C#" AutoEventWireup="true" CodeBehind="frmPOCompleted.aspx.cs" Inherits="TERP.Forms.PMS.frmPOCompleted" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ContentPlaceHolderID="TERPContentPlaceHolder" runat="server">
    <link href="../../Style/Browse/BrowseStyle.css" rel="stylesheet" />
    <link href="../../Style/PMS/frmPOCompleted.css" rel="stylesheet" />


    <%-- ------------------Title----------------------------%>
    <asp:UpdatePanel ID="upPOCompleted" runat="server">
        <ContentTemplate>
            <div style="width: 100%" class="title-padding">
                <asp:Label ID="POCompleted_lblModuleTitle" runat="server" Text="Purchase Order Completed" Font-Bold="True" CssClass="h4"></asp:Label>
                <%--title-color--%>
            </div>
            <%-- ------------------END Title----------------------------%>

            <%-- ------------------Header Info----------------------------%>
            <div class="info">
                <div class="info-list">
                    <div class="row">
                        <div class="col-xs-12 col-sm-4">
                            <div class="info-item">
                                <asp:Label ID="POCompleted_lblTotalPO" runat="server" Text="Total PO:" CssClass="modal-title h5"></asp:Label>
                                <asp:Label ID="lblTotalPOValue" runat="server" Text="10" CssClass="modal-title modal-title--modify h5"></asp:Label>
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-4">
                            <div class="info-item">
                                <asp:Label ID="POCompleted_lblRejectedPO" runat="server" Text="Rejected PO:" CssClass="modal-title h5"></asp:Label>
                                <asp:Label ID="lblRejectedPOValue" runat="server" Text="3" CssClass="modal-title modal-title--modify h5"></asp:Label>
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-4">
                            <div class="info-item">
                                <asp:Label ID="POCompleted_lblApprovalPO" runat="server" Text="Approval PO:" CssClass="modal-title h5"></asp:Label>
                                <asp:Label ID="lblApprovalPOValue" runat="server" Text="7" CssClass="modal-title modal-title--modify h5"></asp:Label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%-- ------------------End Header Info----------------------------%>

            
            <div class="filter card card-border card-boxshadow" style="overflow: auto;">
                <%-- ------------------Browse Filter----------------------------%>
                <fieldset class="fieldSet">
                    <legend class="fieldSet_legend">
                        <asp:Label runat="server" ID="POCompleted_fieldSetFilter" Text="Filter Condition"></asp:Label>
                    </legend>
                    <div class="filter-list">
                        <div class="row">
                            <div class="col-xs-12 col-md-4">
                                <div class="filter-item">
                                    <asp:Label ID="POCompleted_lblPONo" runat="server" Text="PO No:"></asp:Label>
                                    <asp:TextBox ID="txtPONo" runat="server" CssClass="form-control mt-2" MaxLength="8"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xs-12 col-md-4">
                                <div class="filter-item">
                                    <asp:Label ID="POCompleted_lblItemNo" runat="server" Text="Item No:"></asp:Label>
                                    <asp:TextBox ID="txtItemNo" runat="server" CssClass="form-control mt-2" MaxLength="18"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xs-12 col-md-4">
                                <div class="filter-item">
                                    <asp:Label ID="POCompleted_lblStatus" runat="server" Text="Status:"></asp:Label>
                                    <asp:DropDownList ID="ddStatus" runat="server" CssClass="form-control mt-2" DataSourceID="dsStatus" DataTextField="status" DataValueField="id" />
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-xs-12 col-md-4">
                                <div class="filter-item">
                                    <asp:Label ID="POCompleted_lblDateForm" runat="server" Text="From:"></asp:Label>
                                    <div class="input-group mt-2">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                <i class="far fa-calendar-alt"></i>
                                            </span>
                                        </div>
                                        <asp:TextBox ID="txtDateForm" runat="server" CssClass="form-control" autocomplete="off" placeholder="MM/dd/yyyy"></asp:TextBox>
                                        <ajaxToolkit:CalendarExtender ID="txtDateForm_CalendarExtender" runat="server" BehaviorID="txtDateForm_CalendarExtender" TargetControlID="txtDateForm" />
                                        <%--<ajaxToolkit:CalendarExtender ID="POCompleted_CalendarExtenderFrom" runat="server" BehaviorID="POCompleted_CalendarExtenderFrom" TargetControlID="POCompleted_txtDateForm"></ajaxToolkit:CalendarExtender>--%>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-12 col-md-4">
                                <div class="filter-item">
                                    <asp:Label ID="POCompleted_lbDateTo" runat="server" Text="To:"></asp:Label>
                                    <div class="input-group mt-2">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                <i class="far fa-calendar-alt"></i>
                                            </span>
                                        </div>
                                        <asp:TextBox ID="txtDateTo" runat="server" CssClass="form-control" autocomplete="off" placeholder="MM/dd/yyyy"></asp:TextBox>
                                        <ajaxToolkit:CalendarExtender ID="txtDateTo_CalendarExtender" runat="server" BehaviorID="txtDateTo_CalendarExtender" TargetControlID="txtDateTo" />
                                        <%--<ajaxToolkit:CalendarExtender ID="POCompleted_CalendarExtenderTo" runat="server" BehaviorID="POCompleted_CalendarExtenderTo" TargetControlID="POCompleted_txtDateTo"></ajaxToolkit:CalendarExtender>--%>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-12 col-md-4">
                                <div class="filter-item">
                                    <asp:Label ID="POCompleted_lbSupplier" runat="server" Text="Supplier:"></asp:Label>
                                    <asp:TextBox ID="txtSupplier" runat="server" CssClass="form-control mt-2" MaxLength="8"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12 col-md-4 offset-md-8">
                                <div class="actions">
                                    <asp:Button ID="POCompleted_btSearch" runat="server" Text="Search" CssClass="btn bg-gradient-success rowButton-modal button-font-size" OnClick="POCompleted_btSearch_Click" />
                                    <asp:Button ID="POCompleted_btClear" runat="server" Text="Clear" CssClass="btn bg-gradient-success rowButton-modal button-font-size" OnClick="POCompleted_Clear_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </fieldset>
                <%-- ------------------End Browse Filter----------------------------%>

                <%-- ------------------Browse----------------------------%>
                <div class="d-flex align-items-center rowperpage-modify">
                    <asp:Label ID="POCompleted_lbRecordPerPage" runat="server" Text="Record per Page" CssClass="mr-3"></asp:Label>
                    <asp:DropDownList ID="ddRecordPerPage" runat="server" CssClass="" DataSourceID="dsRowPerPage" DataTextField="value" DataValueField="value" AutoPostBack="True" OnSelectedIndexChanged="ddRecordPerPage_SelectedIndexChanged" />
                    &nbsp;/&nbsp;
                    <asp:Label ID="lblTotal" runat="server" Text="0" CssClass="mr-3"></asp:Label>
                </div>

                <div class="grid-wrapper">
                    <asp:GridView ID="grPOCompleted" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" ShowHeaderWhenEmpty="True"
                        CssClass="table table-bordered table-modify" AllowPaging="True" DataSourceID="dsPOCompletedBrowse">
                        <RowStyle CssClass="rowstyle" />
                        <Columns>
                            <asp:BoundField DataField="po_no" SortExpression="po_no" HeaderText="PO NO." HeaderStyle-HorizontalAlign="Center"></asp:BoundField>
                            <asp:BoundField DataField="line" SortExpression="line" HeaderText="Line" HeaderStyle-HorizontalAlign="Center" />
                            <asp:BoundField DataField="supplier" SortExpression="supplier" HeaderText="Supplier" HeaderStyle-HorizontalAlign="Center" />
                            <asp:BoundField DataField="supplier_name" SortExpression="supplier_name" HeaderText="Supplier_name" HeaderStyle-HorizontalAlign="Center" />
                            <asp:BoundField DataField="item_number" SortExpression="item_number" HeaderText="Item Number" HeaderStyle-HorizontalAlign="Center" />
                            <asp:BoundField DataField="description" SortExpression="description" HeaderText="Description" HeaderStyle-HorizontalAlign="Center" />
                            <asp:BoundField DataField="required_qty" SortExpression="required_qty" HeaderText="Qty Required" HeaderStyle-HorizontalAlign="Center" />
                            <asp:BoundField DataField="due_date" SortExpression="due_date" HeaderText="Due Date" HeaderStyle-HorizontalAlign="Center" DataFormatString="{0:MM/dd/yyyy}" />
                            <asp:BoundField DataField="status_id" SortExpression="status_id" HeaderText="status_id" HeaderStyle-HorizontalAlign="Center" Visible="false" />
                            <asp:BoundField DataField="status" SortExpression="status" HeaderText="Status" HeaderStyle-HorizontalAlign="Center" />
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
        document.getElementById('TERPContentPlaceHolder_txtDateForm').setAttribute('readonly', true);
        document.getElementById('TERPContentPlaceHolder_txtDateTo').setAttribute('readonly', true);
    </script>--%>

    <asp:SqlDataSource ID="dsRowPerPage" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT value FROM TERP_row_per_page ORDER BY value" OnSelecting="dsRowPerPage_Selecting"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsStatus" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT 0 as id, '' as status UNION SELECT id, status FROM PMS_po_status WHERE id IN (3,4) ORDER BY id" OnSelecting="dsRowPerPage_Selecting"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsPOCompletedBrowse" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT TOP(0) po_no,line,supplier,supplier_name,item_number,description,required_qty,due_date,status_id,status FROM vPMS_po_completed" OnSelecting="dsRowPerPage_Selecting"></asp:SqlDataSource>

    <script src="../../Libs/CountEmailJS.js"></script>

</asp:Content>
