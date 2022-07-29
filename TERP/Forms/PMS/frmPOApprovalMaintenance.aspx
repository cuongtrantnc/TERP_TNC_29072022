<%@ Page MasterPageFile="~/TERP.Master" Language="C#" AutoEventWireup="true" CodeBehind="frmPOApprovalMaintenance.aspx.cs" Inherits="TERP.Forms.PMS.frmPOApprovalMaintenance" %>

<asp:Content ContentPlaceHolderID="TERPContentPlaceHolder" runat="server">
    <link href="../../Style/Browse/BrowseStyle.css" rel="stylesheet" />
    <link href="../../Style/PMS/frmPOApprovalMaintenance.css" rel="stylesheet" />

    <asp:UpdatePanel ID="upPOApprovalMaintControl" runat="server">
        <ContentTemplate>
            <div class="top">
                <div style="width: 100%" class="title-padding">
                    <asp:Label ID="POApprovalMaintenance_lblModuleTitle" runat="server" Text="PO Approval Maintenance" Font-Bold="True" CssClass="h4"></asp:Label>
                </div>
                <div class="Create">
                    <asp:Button ID="POApprovalMaintenance_btnCreate" runat="server" Text="Create" CssClass="btn bg-gradient-success Create-button button-font-size" OnClick="POApprovalMaintenance_btnCreate_Click" />
                </div>
            </div>
            <%----------------Filter-----------------------%>

            <div class="filter card card-border card-boxshadow">
                <fieldset class="fieldSet">
                    <legend class="fieldSet_legend">
                        <asp:Label runat="server" ID="POApprovalMaintenance_fieldSetFilter" Text="Filter"></asp:Label>
                    </legend>
                    <div class="filter-list">
                        <div class="row">
                            <div class="col-xs-12 col-md-4">
                                <div class="filter-item">
                                    <asp:Label ID="POApprovalMaintenance_filterLbPOCode" runat="server"></asp:Label>
                                    <asp:TextBox ID="POApprovalMaintenance_filterTxtPOCode" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xs-12 col-md-4">
                                <div class="filter-item">
                                    <asp:Label ID="POApprovalMaintenance_filterLbStatus" runat="server"></asp:Label>
                                    <asp:DropDownList ID="POApprovalMaintenance_filterDlStatus" runat="server" CssClass="form-control">
                                        <asp:ListItem Selected="true" Text="Active"></asp:ListItem>
                                        <asp:ListItem Text="Inactive"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-xs-12 col-md-4">
                                <div class="filter-item">
                                    <asp:Button ID="POApprovalMaintenance_btnSreach" runat="server" Text="Sreach" CssClass="btn bg-gradient-success rowButton-modal button-font-size" OnClick="POApprovalMaintenance_btnSreach_Click" />
                                    <asp:Button ID="POApprovalMaintenance_btnClear" runat="server" Text="Clear" CssClass="btn bg-gradient-success rowButton-modal button-font-size" OnClick="POApprovalMaintenance_btnClear_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </fieldset>
            </div>

            <%----------------End Filter-----------------------%>
        </ContentTemplate>
    </asp:UpdatePanel>

    <%----------------END Create Button-----------------------%>


    <%----------------------------Modal-------------------------------%>
    <div class="modal fade" id="POapprovalModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-backdrop="static">
        <div class="modal-dialog modal-dialog-centered modal-xl">
            <div class="modal-content card-border">
                <div class="modal-header">
                    <asp:Label ID="POApprovalMaintenance_lblModaltitle" runat="server" Text="Create Approval" CssClass="modal-title h5"></asp:Label>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel runat="server" ID="upModal">
                        <ContentTemplate>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-xs-12 col-md-6">
                                        <div class="form-item">
                                            <asp:Label ID="POApprovalMaintenance_lbApprovalCode" runat="server" Text="Approval Code:"></asp:Label>
                                            <asp:TextBox ID="txtApprovalCode" runat="server" CssClass="form-control mt-2" MaxLength="8" AutoPostBack="True" OnTextChanged="txtApprovalCode_TextChanged"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-xs-12 col-md-6">
                                        <div class="form-item">
                                            <asp:Label ID="POApprovalMaintenance_lblStatus" runat="server" Text="Status:"></asp:Label>
                                            <asp:DropDownList ID="ddStatus" runat="server" CssClass="form-control mt-2">
                                                <asp:ListItem Selected="true" Text="Active"></asp:ListItem>
                                                <asp:ListItem Text="Inactive"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>

                                <div class="row mt-3">
                                    <div class="col-xs-12 col-md-12">
                                        <div class="form-item">
                                            <asp:Label ID="POApprovalMaintenance_lbDescription" runat="server" Text="Description:" CssClass="custom-width"></asp:Label>
                                            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control mt-2" MaxLength="48"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <br />
                            <div class="detail">
                                <asp:GridView ID="grPOApprovalModal" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" ShowHeaderWhenEmpty="True" CssClass="table table-bordered"
                                    AllowPaging="True" DataSourceID="dsPOApprovalModal" OnRowDataBound="grPOApprovalModal_RowDataBound">
                                    <RowStyle CssClass="rowstyle" />
                                    <Columns>
                                        <asp:BoundField DataField="approver_id" SortExpression="approver_id" HeaderText="Approver" HeaderStyle-HorizontalAlign="Center" />
                                        <asp:TemplateField HeaderText="Approver">
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddApprover" runat="server" CssClass="form-control" DataSourceID="dsApprover" DataTextField="user_name" DataValueField="user_id"
                                                    AutoPostBack="True" OnSelectedIndexChanged="ddApprover_SelectedIndexChanged">
                                                </asp:DropDownList>
                                            </ItemTemplate>
                                            <%--<ItemStyle CssClass="text-center" />--%>
                                        </asp:TemplateField>

                                        <asp:BoundField DataField="alt_approver_id" SortExpression="alt_approver_id" HeaderText="Alt Approver" HeaderStyle-HorizontalAlign="Center" />
                                        <asp:TemplateField HeaderText="Alt Approver">
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddAltApprover" runat="server" CssClass="form-control" DataSourceID="dsAltApprover" DataTextField="user_name" DataValueField="user_id"
                                                    AutoPostBack="True" OnSelectedIndexChanged="ddAltApprover_SelectedIndexChanged">
                                                </asp:DropDownList>
                                            </ItemTemplate>
                                            <%--<ItemStyle CssClass="text-center" />--%>
                                        </asp:TemplateField>

                                        <asp:BoundField DataField="order_" SortExpression="order_" HeaderText="Order" HeaderStyle-HorizontalAlign="Center" />
                                        <asp:TemplateField HeaderText="Order" HeaderStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtOrder" runat="server" CssClass="form-control" TextMode="Number" AutoPostBack="True"></asp:TextBox>
                                            </ItemTemplate>
                                            <%--<ItemStyle CssClass="text-center" />--%>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Delete">
                                            <ItemTemplate>
                                                <asp:Button ID="POApprovalMaintenance_btnDelete" runat="server" Text="Delete" CssClass="btn btn-danger button-font-size" OnClick="POApprovalMaintenance_btnDelete_Click" />
                                            </ItemTemplate>
                                            <ItemStyle CssClass="text-center" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="id" SortExpression="id" HeaderText="ID" HeaderStyle-HorizontalAlign="Center" />
                                    </Columns>
                                    <FooterStyle BackColor="#e9ecef" Font-Bold="True" />
                                    <HeaderStyle BackColor="#e9ecef" HorizontalAlign="Center" />
                                    <PagerStyle CssClass="pageStyle" HorizontalAlign="Center" />
                                </asp:GridView>
                            </div>

                            <div class="control">
                                <asp:Button ID="POApprovalMaintenance_btnMoDalAdd" runat="server" Text="Add Row" CssClass="btn btn-success button-font-size" OnClick="POApprovalMaintenance_btnMoDalAdd_Click" />
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="POApprovalMaintenance_btnCancel" runat="server" Text="Cancel" CssClass="btn btn-secondary button-font-size" data-dismiss="modal" OnClick="POApprovalMaintenance_btnCancel_Click" />
                    <asp:UpdatePanel runat="server" ID="upBtnSaveModal">
                        <ContentTemplate>
                            <asp:Button ID="POApprovalMaintenance_btnSave" runat="server" Text="Save" CssClass="btn btn-success button-font-size" OnClick="POApprovalMaintenance_btnSave_Click" />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
    <%----------------------------End Modal-------------------------------%>

    <%----------------------------Maint Browse-------------------------------%>
    <div class="row">
        <div class="col-md-12">
            <div class="card card-border card-boxshadow mt-3">
                <div class="card-body" style="overflow: auto;">
                    <asp:UpdatePanel ID="upPOApprovalMaintBrowse" runat="server">
                        <ContentTemplate>
                            <div class="d-flex align-items-center rowperpage-modify">
                                <asp:Label ID="POApprovalMaintenance_lblRecordPerPage" runat="server" Text="Record Per Page" CssClass="mr-3"></asp:Label>
                                <asp:DropDownList ID="ddRecordPerPage" runat="server" CssClass="" DataSourceID="dsRowPerPage" DataTextField="value" DataValueField="value" AutoPostBack="True" OnSelectedIndexChanged="ddRecordPerPage_SelectedIndexChanged" />
                                &nbsp;/&nbsp;
                        <asp:Label ID="lblTotal" runat="server" Text="0" CssClass="mr-3"></asp:Label>
                            </div>
                            <div class="grid-wrapper" id="poAppovalmaint-scroll">
                                <asp:GridView ID="grPOApprovalMaintenance" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" ShowHeaderWhenEmpty="True"
                                    CssClass="table table-bordered table-modify" AllowPaging="True" DataSourceID="dsPOApprovalMaintenanceBrowse" OnRowDataBound="grPOApprovalMaintenance_RowDataBound">
                                    <RowStyle CssClass="rowstyle" />
                                    <Columns>
                                        <asp:BoundField DataField="approval_code" SortExpression="approval_code" HeaderText="Approval Code" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></asp:BoundField>

                                        <asp:BoundField DataField="description" SortExpression="description" HeaderText="Description" HeaderStyle-HorizontalAlign="Center">
                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                        </asp:BoundField>

                                        <asp:TemplateField HeaderText="Status" SortExpression="status">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="lblStatus" runat="server" Text='<%# Bind("status") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblStatus" runat="server" Text='<%# Bind("status") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle CssClass="text-center" />
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Option" HeaderStyle-Width="10px">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="btEdit" runat="server" ImageUrl="~/Images/edit.png" Width="20px" Height="20px" OnClick="btEdit_Click" />
                                            </ItemTemplate>
                                            <ItemStyle CssClass="text-center" />
                                        </asp:TemplateField>

                                    </Columns>
                                    <FooterStyle BackColor="#e9ecef" Font-Bold="True" />
                                    <HeaderStyle BackColor="#e9ecef" HorizontalAlign="Center" />
                                    <PagerStyle CssClass="pageStyle" HorizontalAlign="Center" />
                                </asp:GridView>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
    <%----------------------------End Maint Browse-------------------------------%>

    <script>

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
                $('#poAppovalmaint-scroll').scrollTop(localStorage.poApprovalMaintscrollposition);
                localStorage.poApprovalMaintscrollposition = "";

            });
        }


        //save position of scrollbar
        function saveCurrentScrollPosition() {
            $('#poAppovalmaint-scroll').scroll(function () {
                let topScroll = $('#poAppovalmaint-scroll').scrollTop();
                localStorage.poApprovalMaintscrollposition = topScroll;
            });
        }

    </script>

    <asp:SqlDataSource ID="dsRowPerPage" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT value FROM TERP_row_per_page ORDER BY value" OnSelecting="dsRowPerPage_Selecting"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsPOApprovalMaintenanceBrowse" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT approval_code, description, status FROM [PMS_po_approval]"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsPOApprovalModal" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsApprover" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT user_name + ' - ' + user_full_name as user_name, user_id FROM [TERP_users] WHERE status='Active'"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsAltApprover" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT user_name + ' - ' + user_full_name as user_name, user_id FROM [TERP_users] WHERE status='Active'"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsTemp" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"></asp:SqlDataSource>

    <%--    <script src="../../Theme/plugins/jquery/jquery-3.6.0.min.js"></script>
    <script src="../../Libs/ModalMessage.js"></script>--%>
    <script src="../../Libs/CountEmailJS.js"></script>
</asp:Content>
