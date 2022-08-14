<%@ Page MasterPageFile="~/TERP.Master" Language="C#" AutoEventWireup="true" CodeBehind="frmLocalization.aspx.cs" Inherits="TERP.Forms.Setting.frmLocalization" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ContentPlaceHolderID="TERPContentPlaceHolder" runat="server">
    <%--    <link href="/terp/Style/TERP.css" rel="stylesheet" />--%>
    <link href="../../Style/Browse/BrowseStyle.css" rel="stylesheet" />
    <link href="../../Style/PMS/frmLocalization.css" rel="stylesheet"/>

    <asp:UpdatePanel ID="UpdatePanelLocalization" runat="server">
        <ContentTemplate>
            <div style="width: 100%" class="title-padding">
                <asp:Label ID="lblModuleTitle" runat="server" Text="Localization String Definition" Font-Bold="True" CssClass="h4"></asp:Label>
                <%--title-color--%>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="card card-border card-boxshadow">
                        <div class="card-body">
                            <fieldset class="fieldSet">
                                <legend class="fieldSet_legend">
                                    <asp:Label runat="server" ID="frmLocalization_fieldSetFilter" Text="Filter Condition"></asp:Label>
                                </legend>
                                <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
                                    <div class="col">
                                        <asp:Label ID="lblModule" runat="server" Text="Module" CssClass="my-2 form-label form-text"></asp:Label>
                                        <asp:DropDownList ID="ddModule" runat="server" CssClass="form-control" DataSourceID="dsModule" DataTextField="module_name" DataValueField="module_id" AutoPostBack="True" OnSelectedIndexChanged="ddModule_SelectedIndexChanged"></asp:DropDownList>
                                    </div>
                                    <div class="col">
                                        <asp:Label ID="Label1" runat="server" Text="Prefix" CssClass="my-2 form-label form-text"></asp:Label>
                                        <asp:DropDownList ID="ddPrefix" runat="server" CssClass="form-control" DataSourceID="dsPrefix" DataTextField="prefix_name" DataValueField="prefix_name"></asp:DropDownList>
                                    </div>
                                    <div class="col col-button">
                                        <asp:Button ID="btQuery" runat="server" Text="Query" CssClass="btn bg-gradient-success query-button" OnClick="btQuery_Click" />
                                    </div>
                                </div>
                            </fieldset>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <div id="divFilter">
                        <div class="card card-border card-boxshadow mt-3">
                            <div class="card-body" style="overflow: auto;">
                                <div class="d-flex align-items-center rowperpage-modify">
                                    <asp:Label ID="Label6" runat="server" Text="Record per Page" CssClass="mr-3"></asp:Label>
                                    <asp:DropDownList ID="ddRecordPerPage" runat="server" CssClass="" DataSourceID="dsRowPerPage" DataTextField="value" DataValueField="value" AutoPostBack="True" OnSelectedIndexChanged="ddRecordPerPage_SelectedIndexChanged" />
                                    &nbsp;/&nbsp;
                            <asp:Label ID="lblTotal" runat="server" Text="0" CssClass="mr-3"></asp:Label>
                                </div>
                                <div class="grid-wrapper" id="grid-localization">
                                    <asp:GridView ID="grLocalization" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" ShowHeaderWhenEmpty="True" CssClass="table table-bordered" AllowPaging="True" DataSourceID="dsLocalization" OnRowEditing="grLocalization_RowEditing" OnRowUpdating="grLocalization_RowUpdating" OnRowDeleting="grLocalization_RowDeleting">
                                        <RowStyle CssClass="rowstyle" />
                                        <Columns>
                                            <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                                            <%--<asp:TemplateField ShowHeader="False">
                                    <EditItemTemplate>
                                        <div class="itemTemplate">
                                            <asp:ImageButton ID="LinkButton1" runat="server" ImageUrl="~/Images/save-file.png" CssClass="itemTemplate-icon" CausesValidation="True" CommandName="Update" ToolTip="Update"></asp:ImageButton>
                                            <asp:ImageButton ID="LinkButton2" runat="server" ImageUrl="~/Images/close.png" CssClass="itemTemplate-icon" CausesValidation="False" CommandName="Cancel" ToolTip="Cancel"></asp:ImageButton>
                                        </div>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <div class="itemTemplate">
                                            <asp:ImageButton ID="LinkButton3" runat="server" ImageUrl="~/Images/edit.png" CssClass="itemTemplate-icon" CausesValidation="False" CommandName="Edit" ToolTip="Edit"/>
                                        </div>
                                    </ItemTemplate>
                                    <ItemStyle CssClass="text-center" />
                                </asp:TemplateField>--%>
                                            <asp:BoundField DataField="id" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="id" ItemStyle-HorizontalAlign="Center" />
                                            <asp:BoundField DataField="module_prefix" HeaderText="Module Prefix" SortExpression="module_prefix" ItemStyle-HorizontalAlign="Center" ReadOnly="True" />
                                            <asp:TemplateField HeaderText="Message ID" SortExpression="message_id">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtMessageID" runat="server" Text='<%# Bind("message_id") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMessageID" runat="server" Text='<%# Bind("message_id") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Message Content" SortExpression="message_content">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtMessageContent" runat="server" Text='<%# Bind("message_content") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMessageContent" runat="server" Text='<%# Bind("message_content") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="language_code" HeaderText="Language Code" SortExpression="language_code" ReadOnly="True" ItemStyle-HorizontalAlign="Center" />
                                            <asp:BoundField DataField="note" HeaderText="note" SortExpression="note" Visible="False" />
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

            <div class="row">
                <div class="col-md-12">
                    <div class="card card-border card-boxshadow mt-3">
                        <div class="card-header">
                            <asp:Label runat="server" Text="New Localization String" CssClass="h6"></asp:Label>
                        </div>

                        <div class="card-body" style="overflow: auto;">
                            <div class="row row-cols-1 row-cols-sm-1 row-cols-md-1">
                                <div class="col">
                                    <asp:Label ID="Label2" runat="server" Text="Message ID" CssClass="my-2 form-label form-text"></asp:Label>
                                    <asp:TextBox runat="server" ID="txtMessageID" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row row-cols-1 row-cols-sm-1 row-cols-md-1 mt-3">
                                <div class="col">
                                    <asp:Panel runat="server" ID="pnLiteral">
                                        <%--<asp:Literal runat="server" ID="ltNewString"></asp:Literal>--%>
                                    </asp:Panel>
                                </div>
                            </div>
                            <%--<div class="row row-cols-1 row-cols-sm-2 row-cols-md-6">
                    </div>--%>
                            <div class="row row-cols-1 row-cols-sm-1 row-cols-md-1 mt-3">
                                <div class="col">
                                    <asp:Button ID="btAdd" runat="server" Text="Add" CssClass="btn btn-success rowButton-modal button-font-size" OnClick="btAdd_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>


    <%--    <script src="/TERP/Theme/plugins/jquery/jquery.min.js"></script>
    <script src="/TERP/Theme/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="/TERP/Theme/plugins/toastr/toastr.min.js"></script>
    <script src="/TERP/Libs/Message.js"></script>--%>
    <script>
        var prm = Sys.WebForms.PageRequestManager.getInstance();
        prm.add_endRequest(function () {
            scrollToPrevPosition();
            saveCurrentScrollPosition();
        });
    </script>

    <script>
        function scrollToPrevPosition() {
            $(document).ready(function () {
                $('#grid-localization').scrollTop(localStorage.localizationscrollposition);
                localStorage.localizationscrollposition = "";

            });
        }

        function saveCurrentScrollPosition() {
            $('#grid-localization').scroll(function () {
                let topScroll = $('#grid-localization').scrollTop();
                localStorage.localizationscrollposition = topScroll;
            });
        }


    </script>

    <asp:SqlDataSource ID="dsRowPerPage" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>" OnSelecting="dsTemp_Selecting"
        SelectCommand="SELECT value FROM TERP_row_per_page ORDER BY value"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsTemp" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>" OnSelecting="dsTemp_Selecting"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsLocalization" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT TOP (0) * FROM TERP_message_localization"
        OnSelecting="dsTemp_Selecting"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsModule" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT module_id,module_prefix + ': ' + module_name as module_name FROM TERP_module WHERE enable=1 ORDER BY sort"
        OnSelecting="dsTemp_Selecting"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsPrefix" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        OnSelecting="dsTemp_Selecting"></asp:SqlDataSource>
</asp:Content>
