<%@ Page MasterPageFile="~/TERP.Master" Language="C#" AutoEventWireup="true" CodeBehind="frmUser.aspx.cs" Inherits="TERP.Forms.frmUser" %>

<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>--%>

<asp:Content ContentPlaceHolderID="TERPContentPlaceHolder" runat="server">
    <link href="../../Style/Browse/BrowseStyle.css" rel="stylesheet" />
    <link href="../../Style/PMS/frmUser.css" rel="stylesheet" />

    <div>
        <div style="width: 100%" class="title-padding">
            <asp:Label ID="User_lblModuleTitle" runat="server" Text="User Maintenance" Font-Bold="True" CssClass="h4"></asp:Label>
            <%--title-color--%>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="card card-success card-outline card-outline-tabs card-border">
                    <div class="card-header p-0 border-bottom-0">
                        <ul class="nav nav-tabs" id="myTab">
                            <li class="nav-item">
                                <a href="#nav-info" class="nav-link active text-success" data-toggle="tab">
                                    <asp:Label runat="server" ID="User_tabUserInfo" Text="User Information"></asp:Label>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="#nav-accessright" class="nav-link text-success" data-toggle="tab">
                                    <asp:Label runat="server" ID="User_tabRole" Text="Access Role"></asp:Label>
                                </a>
                            </li>
                        </ul>
                    </div>
                    <%--        <div class="card card-info">--%>
                    <div class="card-body">
                        <%--                <nav>
                            <div class="nav nav-tabs" id="nav-tab" role="tablist">
                                <button class="nav-link active" id="nav-info-tab" data-toggle="tab" data-target="#nav-info" type="button" role="tab" aria-controls="nav-info" aria-selected="true">User Information</button>
                                <button class="nav-link" id="nav-accessright-tab" data-toggle="tab" data-target="#nav-accessright" type="button" role="tab" aria-controls="nav-accessright" aria-selected="false">Access Right</button>
                            </div>
                        </nav>--%>
                        <div class="tab-content" id="nav-tabContent">
                            <div class="tab-pane fade show active" id="nav-info" role="tabpanel" aria-labelledby="nav-info-tab">
                                <div class="row">
                                    <div class="col-sm-8 g-3">
                                        <asp:UpdatePanel ID="upDepartmentUserInformation" runat="server">
                                            <ContentTemplate>
                                                <div class="row row-cols-1 row-cols-sm-2 row-cols-md-2 g-3">
                                                    <div class="col">
                                                        <%-- <asp:UpdatePanel ID="upDepartmentUserInformation" runat="server">
                                                    <ContentTemplate>--%>
                                                        <asp:Label ID="User_lblDepartmentName" runat="server" Text="Department" CssClass="my-2 form-label form-text"></asp:Label>
                                                        <asp:DropDownList ID="ddDepartment" runat="server" CssClass="form-control" data-live-search="true" DataSourceID="dsDepartment" DataTextField="name" DataValueField="department_id" AutoPostBack="True" OnSelectedIndexChanged="ddDepartment_SelectedIndexChanged">
                                                        </asp:DropDownList>
                                                        <%--  </ContentTemplate>
                                                </asp:UpdatePanel>--%>
                                                    </div>
                                                    <div class="col">
                                                        <asp:Label ID="User_lblUserLevel" runat="server" Text="User Level" CssClass="my-2 form-label form-text"></asp:Label>
                                                        <asp:DropDownList ID="ddUserLevel" runat="server" CssClass="form-control" DataSourceID="dsUserLevel" DataTextField="description" DataValueField="id">
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>
                                                <div class="row row-cols-1 row-cols-sm-2 row-cols-md-2 g-3">
                                                    <div class="col">
                                                        <asp:Label ID="User_lblUserMode" runat="server" Text="User Mode" CssClass="my-2 form-label form-text"></asp:Label>
                                                        <asp:DropDownList ID="ddUserMode" runat="server" CssClass="form-control">
                                                            <asp:ListItem Text="Active" Selected="True" Value="1"></asp:ListItem>
                                                            <asp:ListItem Text="Inactive" Value="0"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                    <div class="col">
                                                        <asp:Label ID="User_lblEmail" runat="server" Text="Email" CssClass="my-2 form-label form-text"></asp:Label>
                                                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Email" MaxLength="100"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="row row-cols-1 row-cols-sm-2 row-cols-md-2 g-3">
                                                    <div class="col">
                                                        <asp:Label ID="User_lblUserName" runat="server" Text="User Name" CssClass="my-2 form-label form-text"></asp:Label>
                                                        <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control" placeholder="User name" MaxLength="50"></asp:TextBox>
                                                    </div>
                                                    <div class="col">
                                                        <asp:Label ID="User_lblUserFullName" runat="server" Text="User Full Name" placeholder="Full name" CssClass="my-2 form-label form-text"></asp:Label>
                                                        <asp:TextBox ID="txtUserFullName" runat="server" CssClass="form-control" MaxLength="50" HtmlEncode="False" placeholder="Full Name"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="row row-cols-1 row-cols-sm-2 row-cols-md-2 g-3">
                                                    <div class="col">
                                                        <asp:Label ID="User_lblUserID" runat="server" Text="User ID *" CssClass="my-2 form-label form-text"></asp:Label>
                                                        <asp:TextBox ID="txtUserID" runat="server" CssClass="form-control" placeholder="User id" ToolTip="Update base on this field" MaxLength="6"></asp:TextBox>
                                                    </div>
                                                    <div class="col">
                                                        <asp:Label ID="User_lblUserCardID" runat="server" Text="User Card ID" CssClass="my-2 form-label form-text"></asp:Label>
                                                        <asp:TextBox ID="txtUserCID" runat="server" CssClass="form-control" placeholder="User cid" MaxLength="10" TextMode="Number"></asp:TextBox>
                                                    </div>
                                                </div>

                                                <div class="row row-cols-1 row-cols-sm-2 row-cols-md-2 g-3">
                                                    <div class="col">
                                                        <asp:Label ID="User_lblPassword" runat="server" Text="Password" CssClass="my-2 form-label form-text"></asp:Label>
                                                        <asp:TextBox ID="txtPassword" ClientIDMode="Static" runat="server" CssClass="form-control" placeholder="Password" TextMode="Password" MaxLength="50"></asp:TextBox>
                                                    </div>
                                                    <div class="col">
                                                        <asp:Label ID="User_lblPasswordConfirm" runat="server" Text="Password Confirm" CssClass="my-2 form-label form-text"></asp:Label>
                                                        <asp:TextBox ID="txtPasswordConfirm" runat="server" CssClass="form-control" placeholder="Confirm password" TextMode="Password" MaxLength="50"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                    <div class="col-sm-4 g-3">
                                        <div class="sign">
                                            <asp:Label runat="server" ID="User_lblSignImage" Text="Sign Image" CssClass="sign_label"></asp:Label>
                                            <div class="sign_image">
                                                <asp:Image ID="imgUserImage" runat="server" ClientIDMode="Static" CssClass="" />
                                            </div>
                                            <asp:Label runat="server" ID="User_lblNote" CssClass="sign_note" Text="Dụng lượng file tối đa 1 MB Định dạng: .JPEG, .PNG"></asp:Label>
                                            <asp:FileUpload runat="server" ID="fuSignature" type="file" accept="image/*" onchange="loadFile(event)" />
                                        </div>
                                    </div>
                                </div>
                                <asp:UpdatePanel ID="upControlUserInformation" runat="server">
                                    <ContentTemplate>
                                        <div class="row my-3">

                                            <div class="col col-sm-2 col-md-2 col-lg-1">
                                                <asp:Button ID="btUserAdd" runat="server" CssClass="btn bg-gradient-success button-font-size" Text="Add" Style="width: 100%;" OnClick="btUserAdd_Click" />
                                            </div>
                                            <div class="col col-sm-2 col-md-2 col-lg-1">
                                                <asp:Button ID="btUserUpdate" runat="server" CssClass="btn bg-gradient-success button-font-size" Text="Update" Style="width: 100%;" OnClick="btUserUpdate_Click" />
                                            </div>
                                            <div class="col col-sm-2 col-md-2 col-lg-1">
                                                <asp:Button ID="btUserDel" runat="server" CssClass="btn bg-gradient-success button-font-size" Text="Delete" Style="width: 100%;" OnClick="btUserDel_Click" />
                                            </div>

                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <div class="card card-boxshadow">
                                    <div class="card-header">
                                        <asp:Label runat="server" ID="User_lblListUserAvailable" Text="List User Available" CssClass="h6"></asp:Label>
                                    </div>
                                    <div class="card-body" style="overflow: auto;">
                                        <%--  <div class="paging">
                                                    <asp:Label ID="User_lblRowPerPage" runat="server" Text="Rows per Page" CssClass="mr-3"></asp:Label>
                                                    <asp:DropDownList ID="ddRowPerPage" runat="server" CssClass="paging_record" DataSourceID="dsRowPerPage" DataTextField="value" DataValueField="value" OnSelectedIndexChanged="ddRowPerPage_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
                                                    <asp:Label runat="server" ID="User_lblPageTotal" Text="Total" CssClass="ml-3 mr-1"></asp:Label>
                                                    <asp:Label ID="lblTotal" runat="server" Text="0" CssClass="mr-3"></asp:Label>
                                                </div>--%>
                                        <asp:UpdatePanel ID="upListUserInformation" runat="server">
                                            <ContentTemplate>
                                                <div class="d-flex align-items-center rowperpage-modify">
                                                    <asp:Label ID="User_lblRowPerPage" runat="server" Text="Rows per Page" CssClass="mr-3"></asp:Label>
                                                    <asp:DropDownList ID="ddRowPerPage" runat="server" DataSourceID="dsRowPerPage" DataTextField="value" DataValueField="value" OnSelectedIndexChanged="ddRowPerPage_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
                                                    &nbsp;/&nbsp;
                                                        <asp:Label ID="lblTotal" runat="server" Text="0" CssClass="mr-3"></asp:Label>
                                                </div>

                                                <div class="grid-wrapper">

                                                    <asp:GridView ID="grUser" runat="server" DataSourceID="dsUser" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="user_id" ForeColor="#333333" CssClass="table table-bordered"
                                                        OnSelectedIndexChanged="grUser_SelectedIndexChanged" PagerSettings-Visible="true" AllowPaging="True" ShowHeaderWhenEmpty="True" OnRowDataBound="grUser_RowDataBound">
                                                        <RowStyle CssClass="rowstyle" />
                                                        <Columns>
                                                            <asp:CommandField ShowSelectButton="True">
                                                                <ControlStyle CssClass="btn btn-outline-success btn-sm" />
                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                            </asp:CommandField>
                                                            <asp:BoundField DataField="user_name" HeaderText="Name" SortExpression="user_name" HeaderStyle-HorizontalAlign="Center">
                                                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="user_id" HeaderText="ID" ReadOnly="True" SortExpression="user_id" HeaderStyle-HorizontalAlign="Center">
                                                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="user_cid" HeaderText="Card ID" SortExpression="user_cid" HeaderStyle-HorizontalAlign="Center">
                                                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="user_full_name" HeaderText="Full Name" SortExpression="user_full_name" HeaderStyle-HorizontalAlign="Center" HtmlEncode="False">
                                                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="department_name" HeaderText="Department" SortExpression="department_name" HeaderStyle-HorizontalAlign="Center">
                                                                <ItemStyle CssClass="text-center" />
                                                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="user_email" HeaderText="Email" SortExpression="user_email" HeaderStyle-HorizontalAlign="Left">
                                                                <HeaderStyle HorizontalAlign="left"></HeaderStyle>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="role" HeaderText="Role" SortExpression="role" HeaderStyle-HorizontalAlign="Center">
                                                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                            </asp:BoundField>
                                                            <asp:TemplateField HeaderText="Status" SortExpression="enable">
                                                                <EditItemTemplate>
                                                                    <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("status") %>'></asp:Label>
                                                                </EditItemTemplate>
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblStatus" runat="server" Text='<%# Bind("status") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <ItemStyle CssClass="text-center" />
                                                                <HeaderStyle HorizontalAlign="Center" />
                                                            </asp:TemplateField>
                                                        </Columns>
                                                        <FooterStyle BackColor="#e9ecef" Font-Bold="True" />
                                                        <HeaderStyle BackColor="#e9ecef" HorizontalAlign="Center" />
                                                        <PagerStyle CssClass="pageStyle" HorizontalAlign="Center" />
                                                    </asp:GridView>

                                                </div>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                        <%--</div>--%>
                                    </div>
                                </div>

                            </div>
                            <div class="tab-pane fade" id="nav-accessright" role="tabpanel" aria-labelledby="nav-accessright-tab">
                                <%--                                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="ddDepartmentRight" EventName="SelectedIndexChanged" />
                                                <asp:AsyncPostBackTrigger ControlID="TERPContentPlaceHolder_chkAll"/>
                                                <asp:AsyncPostBackTrigger ControlID="grUserRight"/>
                                            </Triggers>
                                            <ContentTemplate>--%>
                                <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
                                    <div class="col">
                                        <asp:UpdatePanel ID="upDepartmentAccessRole" runat="server">
                                            <ContentTemplate>
                                                <asp:Label ID="User_lblSiteRight" runat="server" Text="Department" CssClass="my-2 form-text form-label"></asp:Label>
                                                <asp:DropDownList ID="ddDepartmentRight" runat="server" CssClass="form-control" DataSourceID="dsDepartment" DataTextField="name" DataValueField="name" OnSelectedIndexChanged="ddDepartmentRight_SelectedIndexChanged" AutoPostBack="True">
                                                </asp:DropDownList>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                </div>

                                <div class="row row-cols-1 row-cols-sm-1 row-cols-md-1 g-3 mt-3">
                                    <div class="col col-md-12">
                                        <div class="card card-boxshadow">
                                            <div class="card-header">
                                                <asp:Label runat="server" Text="User List" CssClass="h6"></asp:Label>
                                            </div>
                                            <div class="card-body" style="overflow: auto;">
                                                <%--<div style="display: inline-block; vertical-align: top; overflow: auto; max-height: 680px;">--%>
                                                <asp:UpdatePanel ID="upUserListAccessRole" runat="server">
                                                    <ContentTemplate>
                                                        <asp:GridView ID="grUserRight" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" ShowHeaderWhenEmpty="True" CssClass="table table-bordered" DataSourceID="dsUserRight" EnableViewState="true" Width="100%">
                                                            <RowStyle CssClass="rowstyle" />
                                                            <Columns>
                                                                <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="text-center">
                                                                    <HeaderTemplate>
                                                                        <asp:CheckBox ID="chkAll" runat="server" OnCheckedChanged="chkAll_CheckedChanged" AutoPostBack="True" />
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:CheckBox ID="chkSelect" runat="server" OnCheckedChanged="chkSelect_CheckedChanged" AutoPostBack="True" />
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                </asp:TemplateField>

                                                                <%--                                                                <asp:CommandField ShowSelectButton="True">
                                                                                        <ControlStyle CssClass="btn btn-outline-success btn-sm" />
                                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                                                    </asp:CommandField>--%>
                                                                <asp:BoundField DataField="user_name" HeaderText="Name" SortExpression="user_name" HeaderStyle-HorizontalAlign="Center" />
                                                                <asp:BoundField DataField="user_id" HeaderText="ID" ReadOnly="True" SortExpression="user_id" HeaderStyle-HorizontalAlign="Center" />
                                                                <asp:BoundField DataField="user_cid" HeaderText="Card ID" SortExpression="user_cid" HeaderStyle-HorizontalAlign="Center" />
                                                                <asp:BoundField DataField="user_full_name" HeaderText="Full Name" SortExpression="user_full_name" HeaderStyle-HorizontalAlign="Center" />
                                                                <asp:BoundField DataField="department_name" HeaderText="Department" SortExpression="department_name" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                                                            </Columns>
                                                            <FooterStyle BackColor="#e9ecef" Font-Bold="True" />
                                                            <HeaderStyle BackColor="#e9ecef" HorizontalAlign="Center" />
                                                            <PagerStyle CssClass="pageStyle" HorizontalAlign="Center" />
                                                        </asp:GridView>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                                <%--</div>--%>
                                            </div>
                                        </div>
                                    </div>
                                </div>


                                <asp:UpdatePanel ID="upAvailableModuleAccessRole" runat="server">
                                    <ContentTemplate>
                                        <div class="row row-cols-1 row-cols-sm-1 row-cols-md-1 g-3 mt-3">
                                            <div class="col col-md-12">
                                                <div class="card card-boxshadow">
                                                    <div class="card-header">
                                                        <asp:Label runat="server" ID="User_lblAvailableModule" Text="Available Modules" CssClass="h6"></asp:Label>
                                                        <asp:DropDownList runat="server" ID="ddGroupModule" DataSourceID="dsGroupModule" DataValueField="group_id" DataTextField="message_content" OnSelectedIndexChanged="ddGroupModule_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
                                                    </div>
                                                    <div class="card-body" style="overflow: auto;">
                                                        <%--<div style="display: inline-block; vertical-align: top; overflow: auto; max-height: 680px;">--%>
                                                        <asp:GridView ID="grModule" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" ShowHeaderWhenEmpty="True" CssClass="table table-bordered" DataSourceID="dsModule" Width="100%">
                                                            <RowStyle CssClass="rowstyle" />
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Status" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="text-center">
                                                                    <HeaderTemplate>
                                                                        <asp:CheckBox ID="chkEnableAll" runat="server" OnCheckedChanged="chkEnableAll_CheckedChanged" AutoPostBack="true" />
                                                                    </HeaderTemplate>
                                                                    <EditItemTemplate>
                                                                        <asp:CheckBox ID="chkEnable" runat="server" />
                                                                    </EditItemTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:CheckBox ID="chkEnable" runat="server" OnCheckedChanged="chkEnable_CheckedChanged" AutoPostBack="true" />
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField Visible="false">
                                                                    <EditItemTemplate>
                                                                        <asp:Label ID="lblID" runat="server" Text='<%# Bind("id") %>' />
                                                                    </EditItemTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblID" runat="server" Text='<%# Bind("id") %>' />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="menu_desc" HeaderText="Module Name" ItemStyle-HorizontalAlign="Left" SortExpression="menu_desc" HeaderStyle-HorizontalAlign="Center" />
                                                            </Columns>
                                                            <FooterStyle BackColor="#e9ecef" Font-Bold="True" />
                                                            <HeaderStyle BackColor="#e9ecef" HorizontalAlign="Center" />
                                                            <PagerStyle CssClass="pageStyle" HorizontalAlign="Center" />
                                                        </asp:GridView>
                                                        <%--</div>--%>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <%--    </ContentTemplate>
                                        </asp:UpdatePanel>--%>
                                        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3 mt-3">
                                            <div class="col col-md-12">
                                                <asp:Button ID="User_btUpdateUserAccessRight" runat="server" Text="Update Access Role" CssClass="btn bg-gradient-success button-font-size" OnClick="User_btUpdateUserAccessRight_Click" />
                                            </div>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>

                        <%--<script src="/TERP/Theme/plugins/jquery/jquery.min.js"></script>--%>

                        <%--                        <script src="../../Libs/Message.js"></script>
                                <script src="../../Libs/ModalMessage.js"></script>
                                <script src="../../Theme/plugins/toastr/toastr.min.js"></script>--%>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <script>
        $(document).ready(function () {
            $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {
                localStorage.setItem('activeTabUserMaint', $(e.target).attr('href'));
            });
        });

        var prm = Sys.WebForms.PageRequestManager.getInstance();
        prm.add_endRequest(function () {
            activeSelectedTab();
            selectTab();
            CheckValidationStatus();
        });
    </script>

    <script>

        function CheckValidationStatus(sender, args) { 
            if ($('#quickForm').valid()) {
               localStorage.setItem('formvalidate', true);
            }
        }

        function selectTab() {
            $(document).ready(function () {
                $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {
                    localStorage.setItem('activeTabUserMaint', $(e.target).attr('href'));
                });
            });
        }

        function activeSelectedTab() {
            $(document).ready(function () {
                var activeTab = localStorage.getItem('activeTabUserMaint');
                if (activeTab) {
                    $('#myTab a[href="' + activeTab + '"]').tab('show');
                }
            });
        }

        // VALIDATION FORM
        $(document).ready(function () {
            $('#quickForm').validate({
                rules: {
                                <%= txtUserName.UniqueID %>: {
                                    required: true,
                                    minlength:5
                                },
                                <%= txtUserID.UniqueID %>: {
                                    required: true,
                                    minlength:6
                                },
                             <%--    <%= txtUserCID.UniqueID %>: {
                                    required: true,
                                    minlength:10
                                },--%>
                                <%= txtUserFullName.UniqueID %>: {
                                    required: true,
                                    minlength:5
                                },
                                <%--<%= txtPassword.UniqueID %>: {
                                    required: true,
                                    minlength: 5
                                },
                                <%= txtPasswordConfirm.UniqueID %>: {
                                    required: true,
                                    equalTo: "#txtPassword"
                                },--%>
                            },
            messages: {
                                <%= txtUserName.UniqueID %>: {
                                    required: "Please enter a user name",
                                    minlength: "Your name must be at least 5 characters"
                                },
                                <%= txtUserID.UniqueID %>: {
                                    required: "Please enter a user id",
                                    minlength: "User id must be at least 6 characters"
                                },
                                 <%--     <%= txtUserCID.UniqueID %>: {
                                    required: "Please enter a user card id",
                                    minlength: "Your name must be at least 5 characters long"
                                },--%>
                                <%= txtUserFullName.UniqueID %>: {
                                    required: "Please enter full name",
                                    minlength: "Your name must be at least 5 characters"
                                },
                                <%--<%= txtPasswordConfirm.UniqueID %>: {
                                    required: "Please retype password",
                                },
                                <%= txtPassword.UniqueID %>: {
                                    required: "Please provide a password",
                                    minlength: "Your password must be at least 5 characters long"
                                }--%>
                            },
            errorElement: 'span',
            errorPlacement: function (error, element) {
                error.addClass('invalid-feedback');
                element.closest('.col').append(error);
            },
            highlight: function (element, errorClass, validClass) {
                $(element).addClass('is-invalid');
            },
            unhighlight: function (element, errorClass, validClass) {
                $(element).removeClass('is-invalid');
            }
                            });
                        });

    </script>

    <asp:SqlDataSource ID="dsTemp" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>" OnSelecting="dsTemp_Selecting"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT '' as name, 0 as department_id UNION SELECT name,department_id FROM TERP_department WHERE status='Active'" OnSelecting="dsTemp_Selecting"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsUser" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT TOP (0) user_name,user_id,user_cid,user_full_name,department_name,role,status FROM vTERP_Users WHERE department_name=''" OnSelecting="dsTemp_Selecting"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsUserRight" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT TOP (0) user_name,user_id,user_cid,user_full_name,department_name FROM vTERP_Users WHERE department_name=''" OnSelecting="dsTemp_Selecting"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsUserLevel" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT id, description FROM TERP_sys_level" OnSelecting="dsTemp_Selecting"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsModule" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT DISTINCT id, REPLACE(location,'Forms/','') + ' - ' + message_content as module_name FROM vTERP_menu WHERE parent_id!=0 AND enable=1 ORDER BY module_name" OnSelecting="dsTemp_Selecting"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsRowPerPage" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT value FROM TERP_row_per_page ORDER BY value" OnSelecting="dsTemp_Selecting"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsGroupModule" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT * FROM vTERP_group_module" OnSelecting="dsTemp_Selecting"></asp:SqlDataSource>

    <script src="../../Libs/CountEmailJS.js"></script>
    <script>

        // get file image and preview before submit
        var loadFile = function (event) {
            var reader = new FileReader();
            reader.onload = function () {
                var output = document.getElementById('imgUserImage');
                output.src = reader.result;
            };
            reader.readAsDataURL(event.target.files[0]);
        };

    </script>
</asp:Content>

