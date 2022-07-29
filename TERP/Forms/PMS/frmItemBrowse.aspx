<%@ Page MasterPageFile="~/TERP.Master" Language="C#" AutoEventWireup="true" CodeBehind="frmItemBrowse.aspx.cs" Inherits="TERP.Forms.PMS.frmItemBrowse" %>

<asp:Content ContentPlaceHolderID="TERPContentPlaceHolder" runat="server">
    <link href="/terp/Style/Browse/BrowseStyle.css" rel="stylesheet" />
    <link href="../../Style/PMS/frmItemBrowse.css" rel="stylesheet" />

    <asp:UpdatePanel ID="UpdatePanelItemBrowse" runat="server">
        <ContentTemplate>
            <div style="width: 100%" class="title-padding">
                <asp:Label ID="ItemBrowse_lblModuleTitle" runat="server" Text="Item Master Browse" Font-Bold="True" CssClass="h4"></asp:Label>
                <%--title-color--%>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="card card-border card-boxshadow">
                        <div class="card-body" style="overflow: auto;">
                            <%-- Filter Condition --%>
                            <fieldset class="fieldSet">
                                <legend class="fieldSet_legend">
                                    <asp:Label runat="server" ID="ItemBrowse_fieldSetFilter" Text="Filter Condition"></asp:Label>
                                </legend>
                                <div class="row">
                                    <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                        <div class="Filter_item">
                                            <asp:Label runat="server" ID="ItemBrowse_lblFilterSite" Text="Site" CssClass="font-weight-bold text-right w-50 mr-3"></asp:Label>
                                            <asp:TextBox runat="server" ID="ItemBrowse_txtFilterSite" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                        <div class="Filter_item">
                                            <asp:Label runat="server" ID="ItemBrowse_lblFilterItemNumber" Text="Item Number" CssClass="font-weight-bold text-right w-50 mr-3"></asp:Label>
                                            <asp:TextBox runat="server" ID="ItemBrowse_txtFilterItemNumber" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                        <div class="Filter_item">
                                            <asp:Label runat="server" ID="ItemBrowse_lblFilterProductLine" Text="Product Line" CssClass="font-weight-bold text-right w-50 mr-3"></asp:Label>
                                            <asp:TextBox runat="server" ID="ItemBrowse_txtFilterProductLine" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                        <div class="Filter_item">
                                            <asp:Label runat="server" ID="ItemBrowse_lblFilterType" Text="Type" CssClass="font-weight-bold text-right w-50 mr-3"></asp:Label>
                                            <asp:TextBox runat="server" ID="ItemBrowse_txtFilterType" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                        <div class="Filter_item">
                                            <asp:Label runat="server" ID="ItemBrowse_lblFilterStatus" Text="Status" CssClass="font-weight-bold text-right w-50 mr-3"></asp:Label>
                                            <asp:DropDownList ID="ddStatus" runat="server" CssClass="form-control">
                                                <asp:ListItem Selected="true" Text="Active"></asp:ListItem>
                                                <asp:ListItem Text="Inactive"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                        <div class="Filter_action">
                                            <asp:Button runat="server" ID="ItemBrowse_filterBtnSreach" Text="Sreach" CssClass="btn bg-gradient-success Filter_button Filter_button-modifile button-font-size" OnClick="ItemBrowse_filterBtnSreach_Click" />
                                            <asp:Button runat="server" ID="ItemBrowse_filterBtnClear" Text="Clear" CssClass="btn btn-outline-success Filter_button Filter_button-modifile button-font-size" OnClick="ItemBrowse_filterBtnClear_Click" />
                                        </div>
                                    </div>
                                </div>
                                <%-- End Condition Filter --%>
                            </fieldset>

                            <div class="d-flex align-items-center rowperpage-modify">
                                <asp:Label ID="ItemBrowse_lblRecordPerPage" runat="server" Text="Record Per Page" CssClass="mr-3"></asp:Label>
                                <asp:DropDownList ID="ddRecordPerPage" runat="server" CssClass="" DataSourceID="dsRowPerPage" DataTextField="value" DataValueField="value" AutoPostBack="True" OnSelectedIndexChanged="ddRecordPerPage_SelectedIndexChanged" />
                                &nbsp;/&nbsp;
                                <asp:Label ID="lblTotal" runat="server" Text="0" CssClass="mr-3"></asp:Label>
                            </div>

                            <div class="grid-wrapper" id="itembrowse-scroll">
                                <asp:GridView ID="grItemBrowse" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" ShowHeaderWhenEmpty="True"
                                    CssClass="table table-bordered" AllowPaging="True" DataSourceID="dsItemBrowse" OnRowDataBound="grItemBrowse_RowDataBound">
                                    <RowStyle CssClass="rowstyle" />
                                    <Columns>
                                        <asp:BoundField DataField="id" HeaderText="id" ReadOnly="True" SortExpression="id" InsertVisible="False" Visible="false" />
                                        <asp:BoundField DataField="site" HeaderText="Site" SortExpression="Site" />
                                        <asp:BoundField DataField="item_number" HeaderText="Item Number" SortExpression="item_number" />
                                        <asp:BoundField DataField="description" HeaderText="Description" SortExpression="description" HtmlEncode="false" />
                                        <asp:BoundField DataField="um" HeaderText="UM" SortExpression="um" ItemStyle-CssClass="text-center" />
                                        <asp:BoundField DataField="prod_line" HeaderText="Product Line" SortExpression="prod_line" ItemStyle-CssClass="text-center" />
                                        <asp:BoundField DataField="type" HeaderText="Type" SortExpression="type" />
                                        <asp:TemplateField HeaderText="Status" SortExpression="enable">
                                            <EditItemTemplate>
                                                <asp:Label ID="lblStatus" runat="server" Text='<%# Bind("status") %>'></asp:Label>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblStatus" runat="server" Text='<%# Bind("status") %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="text-center" />
                                            <HeaderStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="upload_time" HeaderText="upload_time" SortExpression="upload_time" Visible="false" />
                                        <asp:BoundField DataField="upload_by" HeaderText="upload_by" SortExpression="upload_by" Visible="false" />
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <asp:Label runat="server" Text="Option" />
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <div class="itemTemplate">
                                                    <asp:ImageButton runat="server" ImageUrl="~/Images/edit.png" ToolTip="Edit" CssClass="itemTemplate-icon" OnClick="Edit_Click" />
                                                    <%--data-toggle="modal" data-target="#editFormModal" --%>
                                                    <asp:ImageButton runat="server" ImageUrl="~/Images/trash.png" ToolTip="Delete" CssClass="itemTemplate-icon" OnClick="Delete_Click" />
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

                        <%-- Edit Modal --%>
                        <div class="modal fade pl-2" id="editFormModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
                            <div class="modal-dialog modal-dialog-centered modal-xl">
                                <div class="modal-content card-border">
                                    <div class="p-3">
                                        <div style="width: 100%" class="title-padding">
                                            <asp:Label ID="ItemBrowse_lblEditTitleModal" runat="server" CssClass="h4" Text="Edit Item" Font-Bold="True" />
                                            <hr />
                                        </div>

                                        <div class="row row-cols-1 row-cols-sm-1 row-cols-md-3 g-3">
                                            <div class="col">
                                                <asp:Label ID="ItemBrowse_lblItemNumber" runat="server" Text="Item Number" CssClass="my-2 form-text Form__label"></asp:Label>
                                                <asp:TextBox ID="txtItemNumber" runat="server" CssClass="form-control" data-live-search="true" ReadOnly="true"></asp:TextBox>
                                            </div>
                                            <div class="col">
                                                <asp:Label ID="ItemBrowse_lblDescription" runat="server" Text="Description" CssClass="my-2 form-text Form__label"></asp:Label>
                                                <asp:TextBox ID="txtItemDescription" runat="server" CssClass="form-control" data-live-search="true"></asp:TextBox>
                                            </div>
                                            <div class="col">
                                                <asp:Label ID="ItemBrowse_lblProductLine" runat="server" Text="Product Line" CssClass="my-2 form-text Form__label"></asp:Label>
                                                <asp:TextBox ID="txtProductline" runat="server" CssClass="form-control" data-live-search="true"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="row row-cols-1 row-cols-sm-1 row-cols-md-3 g-3">
                                            <div class="col">
                                                <asp:Label ID="ItemBrowse_lblItemType" runat="server" Text="Item Type" CssClass="my-2 form-text Form__label"></asp:Label>
                                                <asp:TextBox ID="txtItemType" runat="server" CssClass="form-control" data-live-search="true"></asp:TextBox>
                                            </div>
                                            <div class="col">
                                                <asp:Label ID="ItemBrowse_lblSite" runat="server" Text="Site" CssClass="my-2 form-text Form__label"></asp:Label>
                                                <asp:TextBox ID="txtSite" runat="server" CssClass="form-control" data-live-search="true"></asp:TextBox>
                                            </div>
                                            <div class="col">
                                                <asp:Label ID="ItemBrowse_lblStatus" runat="server" Text="Status" CssClass="my-2 form-text Form__label"></asp:Label>
                                                <asp:DropDownList ID="ddModalStatus" runat="server" CssClass="form-control">
                                                    <asp:ListItem Selected="true" Text="Active"></asp:ListItem>
                                                    <asp:ListItem Text="Inactive"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="Form__footer">
                                            <asp:Button runat="server" ID="ItemBrowse_btCancel" Text="Cancel" CssClass="btn bg-gradient-success Form__button button-font-size" OnClick="ItemBrowse_btCancel_Click" />
                                            <asp:Button runat="server" ID="ItemBrowse_btSave" Text="Save" CssClass="btn bg-gradient-success Form__button button-font-size" OnClick="ItemBrowse_btSave_Click" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%--Delete Confirm Modal--%>
                        <div class="modal fade" id="comfirmDeleteModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content card-border">
                                    <div class="modal-header">
                                        <asp:Label runat="server" class="modal-title h5" ID="ItemBrowse_lblTitleConfirm" Text="Delete Item" />
                                    </div>
                                    <div class="modal-body">
                                        <asp:Label runat="server" ID="ItemBrowse_lblFirstText" Text="Item number" />
                                        <asp:Label runat="server" ID="ItemBrowse_lblIemDelete" Text="" />
                                        <asp:Label runat="server" ID="ItemBrowse_lblLastText" Text=" will be delete, Are you sure?" />
                                    </div>
                                    <div class="modal-footer row-modal">
                                        <asp:Button runat="server" ID="ItemBrowse_btCancelConfirm" Text="Cancel" CssClass="btn bg-gradient-success rowButton-modal" OnClick="ItemBrowse_btCancelConfirm_Click" />
                                        <asp:Button runat="server" ID="ItemBrowse_btConfirm" Text="Ok" CssClass="btn bg-gradient-success rowButton-modal" OnClick="ItemBrowse_btConfirm_Click" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

      <script>
          
          var prm = Sys.WebForms.PageRequestManager.getInstance();
             prm.add_endRequest(function () {
                 scrollToPrevPosition();
                 saveCurrentScrollPosition();
                 closeBackDropModal();
          });
    </script>

    <script>
        //window refresh
        function scrollToPrevPosition() {
             $(document).ready(function () {
                $('#itembrowse-scroll').scrollTop(localStorage.itembrowsescrollposition);
                localStorage.itembrowsescrollposition = "";

            });
        }
       
        //save position of scrollbar       
         function saveCurrentScrollPosition() {
            $('#itembrowse-scroll').scroll(function () {
                let topScroll = $('#itembrowse-scroll').scrollTop();
                localStorage.itembrowsescrollposition = topScroll;
            });
        }

        
    </script>

    <%--Add DataSource--%>
    <asp:SqlDataSource ID="dsTemp" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>" OnSelecting="dsRowPerPage_Selecting"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsRowPerPage" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT value FROM TERP_row_per_page ORDER BY value" OnSelecting="dsRowPerPage_Selecting"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsItemBrowse" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT * FROM PMS_master_item" OnSelecting="dsRowPerPage_Selecting"></asp:SqlDataSource>

    <script src="../../Libs/CountEmailJS.js"></script>
    <%--<link rel="stylesheet" href="/iotdemo/Theme/plugins/bootstrap/js/bootstrap.min.js" />--%>
</asp:Content>
