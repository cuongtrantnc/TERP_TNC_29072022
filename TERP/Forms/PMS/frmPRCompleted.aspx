<%@ Page MasterPageFile="~/TERP.Master" Language="C#" AutoEventWireup="true" CodeBehind="frmPRCompleted.aspx.cs" Inherits="TERP.Forms.PMS.frmPRCompleted" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ContentPlaceHolderID="TERPContentPlaceHolder" runat="server">
    <link href="../../Style/Browse/BrowseStyle.css" rel="stylesheet" />
    <link href="../../Style/PMS/frmPRCompleted.css" rel="stylesheet" />


    <%-- ------------------Title----------------------------%>
    <asp:UpdatePanel ID="upPRCompleted" runat="server">
        <ContentTemplate>
            <div style="width: 100%" class="title-padding">
                <asp:Label ID="PRCompleted_lblModuleTitle" runat="server" Text="Purchase Requisition Completed" Font-Bold="True" CssClass="h4"></asp:Label>
                <%--title-color--%>
            </div>
            <%-- ------------------END Title----------------------------%>

            <%-- ------------------Header Info----------------------------%>
            <div class="info">
                <div class="info-list">
                    <div class="row">
                        <div class="col-xs-12 col-sm-4">
                            <div class="info-item">
                                <asp:Label ID="PRCompleted_lblTotalPR" runat="server" Text="Total PR:" CssClass="modal-title h5"></asp:Label>
                                <asp:Label ID="lblTotalPRValue" runat="server" Text="10" CssClass="modal-title modal-title--modify h5"></asp:Label>
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-4">
                            <div class="info-item">
                                <asp:Label ID="PRCompleted_lblRejectedPR" runat="server" Text="Rejected PR:" CssClass="modal-title h5"></asp:Label>
                                <asp:Label ID="lblRejectedPRValue" runat="server" Text="3" CssClass="modal-title modal-title--modify h5"></asp:Label>
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-4">
                            <div class="info-item">
                                <asp:Label ID="PRCompleted_lblApprovalPR" runat="server" Text="Approval PR:" CssClass="modal-title h5"></asp:Label>
                                <asp:Label ID="lblApprovalPRValue" runat="server" Text="7" CssClass="modal-title modal-title--modify h5"></asp:Label>
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
                        <asp:Label runat="server" ID="PRCompleted_fieldSetFilter" Text="Filter Condition"></asp:Label>
                    </legend>
                    <div class="filter-list">
                        <div class="row">
                            <div class="col-xs-12 col-md-4">
                                <div class="filter-item">
                                    <asp:Label ID="PRCompleted_lblPRNo" runat="server" Text="PR No:"></asp:Label>
                                    <asp:TextBox ID="txtPRNo" runat="server" CssClass="form-control mt-2" MaxLength="8"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xs-12 col-md-4">
                                <div class="filter-item">
                                    <asp:Label ID="PRCompleted_lblItemNo" runat="server" Text="Item No:"></asp:Label>
                                    <asp:TextBox ID="txtItemNo" runat="server" CssClass="form-control mt-2" MaxLength="18"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xs-12 col-md-4">
                                <div class="filter-item">
                                    <asp:Label ID="PRCompleted_lblStatus" runat="server" Text="Status:"></asp:Label>
                                    <asp:DropDownList ID="ddStatus" runat="server" CssClass="form-control mt-2" DataSourceID="dsStatus" DataTextField="status" DataValueField="id" />
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-xs-12 col-md-4">
                                <div class="filter-item">
                                    <asp:Label ID="PRCompleted_lblDateForm" runat="server" Text="From:"></asp:Label>
                                    <div class="input-group mt-2">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                <i class="far fa-calendar-alt"></i>
                                            </span>
                                        </div>
                                        <asp:TextBox ID="txtDateForm" runat="server" CssClass="form-control" autocomplete="off" placeholder="MM/dd/yyyy"></asp:TextBox>
                                        <ajaxToolkit:CalendarExtender ID="txtDateForm_CalendarExtender" runat="server" BehaviorID="txtDateForm_CalendarExtender" TargetControlID="txtDateForm" />
                                        <%--<ajaxToolkit:CalendarExtender ID="PRCompleted_CalendarExtenderFrom" runat="server" BehaviorID="PRCompleted_CalendarExtenderFrom" TargetControlID="PRCompleted_txtDateForm"></ajaxToolkit:CalendarExtender>--%>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-12 col-md-4">
                                <div class="filter-item">
                                    <asp:Label ID="PRCompleted_lbDateTo" runat="server" Text="To:"></asp:Label>
                                    <div class="input-group mt-2">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                <i class="far fa-calendar-alt"></i>
                                            </span>
                                        </div>
                                        <asp:TextBox ID="txtDateTo" runat="server" CssClass="form-control" autocomplete="off" placeholder="MM/dd/yyyy"></asp:TextBox>
                                        <ajaxToolkit:CalendarExtender ID="txtDateTo_CalendarExtender" runat="server" BehaviorID="txtDateTo_CalendarExtender" TargetControlID="txtDateTo" />
                                        <%--<ajaxToolkit:CalendarExtender ID="PRCompleted_CalendarExtenderTo" runat="server" BehaviorID="PRCompleted_CalendarExtenderTo" TargetControlID="PRCompleted_txtDateTo"></ajaxToolkit:CalendarExtender>--%>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-12 col-md-4">
                                <div class="filter-item">
                                    <asp:Label ID="PRCompleted_lbSupplier" runat="server" Text="Supplier:"></asp:Label>
                                    <asp:TextBox ID="txtSupplier" runat="server" CssClass="form-control mt-2" MaxLength="8"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12 col-md-4 offset-md-8">
                                <div class="actions">
                                    <%--<div class="actions-list">--%>
                                       <%-- <div class="action-item">--%>
                                            <asp:Button ID="PRCompleted_btSearch" runat="server" Text="Search" CssClass="btn bg-gradient-success rowButton-modal button-font-size" OnClick="PRCompleted_btSearch_Click" />
                                            <asp:Button ID="PRCompleted_Clear" runat="server" Text="Clear" CssClass="btn bg-gradient-success rowButton-modal button-font-size" OnClick="PRCompleted_Clear_Click" />
                                       <%-- </div>--%>
                                   <%-- </div>--%>
                                </div>
                            </div>
                        </div>
                    </div>
                </fieldset>
                <%-- ------------------End Browse Filter----------------------------%>

                <%-- ------------------Browse----------------------------%>

                <div class="d-flex align-items-center rowperpage-modify">
                    <asp:Label ID="PRCompleted_lbRecordPerPage" runat="server" Text="Record per Page" CssClass="mr-3"></asp:Label>
                    <asp:DropDownList ID="ddRecordPerPage" runat="server" CssClass="" DataSourceID="dsRowPerPage" DataTextField="value" DataValueField="value" AutoPostBack="True" OnSelectedIndexChanged="ddRecordPerPage_SelectedIndexChanged" />
                    &nbsp;/&nbsp;
                    <asp:Label ID="lblTotal" runat="server" Text="0" CssClass="mr-3"></asp:Label>
                </div>

                <div class="grid-wrapper">
                    <asp:GridView ID="grPRCompleted" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" ShowHeaderWhenEmpty="True"
                        CssClass="table table-bordered table-modify" AllowPaging="True" DataSourceID="dsPRCompletedBrowse">
                        <RowStyle CssClass="rowstyle" />
                        <Columns>
                            <asp:BoundField DataField="pr_no" SortExpression="pr_no" HeaderText="PR NO." HeaderStyle-HorizontalAlign="Center"></asp:BoundField>
                            <asp:BoundField DataField="line" SortExpression="line" HeaderText="Line" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                            <asp:BoundField DataField="supplier" SortExpression="supplier" HeaderText="Supplier" HeaderStyle-HorizontalAlign="Center" />
                            <asp:BoundField DataField="supplier_name" SortExpression="supplier_name" HeaderText="Supplier_name" HeaderStyle-HorizontalAlign="Center" />
                            <asp:BoundField DataField="item_number" SortExpression="item_number" HeaderText="Item Number" HeaderStyle-HorizontalAlign="Center" />
                            <asp:BoundField DataField="description" SortExpression="description" HeaderText="Description" HeaderStyle-HorizontalAlign="Center" />
                            <asp:BoundField DataField="required_qty" SortExpression="required_qty" HeaderText="Qty Required" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Right" />
                            <asp:BoundField DataField="due_date" SortExpression="due_date" HeaderText="Due Date" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:MM/dd/yyyy}" />
                            <asp:BoundField DataField="status_id" SortExpression="status_id" HeaderText="status_id" HeaderStyle-HorizontalAlign="Center" Visible="false" />
                            <asp:BoundField DataField="status" SortExpression="status" HeaderText="Status" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
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
        SelectCommand="SELECT 0 as id, '' as status UNION SELECT id, status FROM PMS_pr_status WHERE id IN (3,4) ORDER BY id" OnSelecting="dsRowPerPage_Selecting"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsPRCompletedBrowse" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT TOP(0) pr_no,line,supplier,supplier_name,item_number,description,required_qty,due_date,status_id,status FROM vPMS_pr_completed" OnSelecting="dsRowPerPage_Selecting"></asp:SqlDataSource>

    <script src="../../Libs/CountEmailJS.js"></script>
</asp:Content>
