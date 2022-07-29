<%@ Page MasterPageFile="~/TERP.Master" Language="C#" AutoEventWireup="true" CodeBehind="frmSite.aspx.cs" Inherits="TERP.Forms.Setting.frmSite" %>

<asp:Content ContentPlaceHolderID="TERPContentPlaceHolder" runat="server">
    <link href="../../Style/Browse/BrowseStyle.css" rel="stylesheet" />
    <link href="../../Style/PMS/frmSite.css" rel="stylesheet" />

    <asp:UpdatePanel ID="UpdatePanelSite" runat="server">
        <ContentTemplate>
            <div style="width: 100%" class="title-padding">
            <asp:Label ID="Site_lblModuleTitle" runat="server" Text="Site Maintenance" Font-Bold="True" CssClass="h4"></asp:Label>
            <%--title-color--%>
        </div>

    <div class="row">
        <div class="col-md-12">  
            <div class="card card-success card-outline card-outline-tabs card-border">
                <div class="card-header p-0 border-bottom-0">
                    <ul class="nav nav-tabs" id="myTab">
                        <li class="nav-item">
                            <a href="#nav-site" class="nav-link active text-success" data-toggle="tab">
                                <asp:Label runat="server" ID="Site_tabSite" Text="Site Information"></asp:Label>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="#nav-department" class="nav-link text-success" data-toggle="tab">
                                <asp:Label runat="server" ID="Site_tabDepartment" Text="Department"></asp:Label>
                            </a>
                        </li>
                    </ul>
                </div>

                <%--        <div class="card card-info">--%>
                <div class="card-body">
                    <div class="tab-content" id="nav-tabContent">
                        <div class="tab-pane fade show active" id="nav-site" role="tabpanel" aria-labelledby="nav-site-tab">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
                                        <div class="col">
                                            <asp:Label ID="Site_lblSiteName" runat="server" Text="Site Code (*)" CssClass="my-2 form-text Filter__label"></asp:Label>
                                            <asp:TextBox ID="txtSiteName" runat="server" CssClass="form-control" MaxLength="8"></asp:TextBox>
                                            <asp:TextBox ID="txtSiteNameBackUp" runat="server" CssClass="form-control" MaxLength="8" Visible="false" ></asp:TextBox>
                                        </div>
                                        <div class="col">
                                            <asp:Label ID="Site_Description" runat="server" Text="Description" CssClass="my-2 form-text Filter__label"></asp:Label>
                                            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" MaxLength="80"></asp:TextBox>
                                        </div>
                                        <div class="col">
                                            <asp:Label ID="Site_lblStatus" runat="server" Text="Status" CssClass="my-2 form-text Filter__label"></asp:Label>
                                            <asp:DropDownList ID="ddAccessible" runat="server" CssClass="form-control">
                                                <asp:ListItem Text="Active"></asp:ListItem>
                                                <asp:ListItem Text="Inactive"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <p></p>
                                    <div class="row my-3">
                                        <div class="col col-sm-2 col-md-2 col-lg-1">
                                            <asp:Button ID="Site_btSiteAdd" runat="server" CssClass="btn bg-gradient-success button-font-size" Text="Add" Style="width: 100%;" OnClick="Site_btSiteAdd_Click" />
                                        </div>
                                        <div class="col col-sm-2 col-md-2 col-lg-1">
                                            <asp:Button ID="Site_btSiteUpdate" runat="server" CssClass="btn bg-gradient-success button-font-size" Text="Update" Style="width: 100%;" OnClick="Site_btSiteUpdate_Click" />
                                        </div>
                                        <div class="col col-sm-2 col-md-2 col-lg-1">
                                            <asp:Button ID="Site_btSiteDel" runat="server" CssClass="btn bg-gradient-success button-font-size" Text="Delete" Style="width: 100%;" OnClick="Site_btSiteDel_Click" />
                                        </div>
                                    </div>
                                    <p>
                                    </p>
                                    <div class="card card-boxshadow">
                                        <div class="card-header">
                                            <asp:Label ID="Site_lblSiteAvailableTitle" runat="server" CssClass="h6" Text="List Site Available"></asp:Label>
                                        </div>
                                        <div class="card-body" style="overflow: auto;">
                                             <div class="d-flex align-items-center rowperpage-modify">
                                                <asp:Label ID="Site_lblRowPerPage" runat="server" Text="Rows per Page" CssClass="mr-3"></asp:Label>
                                                <asp:DropDownList ID="ddRowPerPage" runat="server" DataSourceID="dsRowPerPage" DataTextField="value" DataValueField="value" OnSelectedIndexChanged="ddRowPerPage_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
                                                &nbsp;/&nbsp;
                                                <asp:Label ID="lblTotal" runat="server" Text="0" CssClass="mr-3"></asp:Label>
                                            </div>
                                            <div class="grid-wrapper" id="nav-site-scroll">
                                                <asp:GridView ID="grSite" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" ShowHeaderWhenEmpty="True" AllowPaging="True" DataSourceID="dsSite"
                                                CssClass="table table-bordered table-modify" OnSelectedIndexChanged="grSite_SelectedIndexChanged" OnRowDataBound="grSite_RowDataBound">
                                                <RowStyle CssClass="rowstyle" />
                                                <Columns>
                                                    <asp:CommandField ShowSelectButton="True">
                                                        <ControlStyle CssClass="btn btn-outline-success btn-sm" />
                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                        <HeaderStyle CssClass="header-selected" />
                                                    </asp:CommandField>
                                                    <asp:BoundField DataField="name" SortExpression="name" HeaderText="Code" HtmlEncode="false" ItemStyle-HorizontalAlign="left" HeaderStyle-HorizontalAlign="Center">
                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>

                                                        <ItemStyle CssClass="text-center" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="description" SortExpression="description" HtmlEncode="false" HeaderText="Description" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Center">
                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>

                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:TemplateField HeaderText="Status" SortExpression="status">
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="lblStatus" runat="server" Text='<%# Bind("status") %>'></asp:TextBox>
                                                        </EditItemTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblStatus" runat="server" Text='<%# Bind("status") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" />
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
                            </div>

                        </div>

                        <div class="tab-pane fade" id="nav-department" role="tabpanel" aria-labelledby="nav-department-tab">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="department-top">
                                            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
                                            <div class="col">
                                                <asp:Label ID="Site_lblSite" runat="server" Text="Site" CssClass="my-2 form-text Filter__label"></asp:Label>
                                                <asp:DropDownList ID="ddDeptSite" runat="server" CssClass="form-control" MaxLength="10" DataSourceID="dsDeptSite" DataTextField="site_name" DataValueField="site_id"></asp:DropDownList>
                                            </div>
                                            <div class="col">
                                                <asp:Label ID="SitelblDeptCode" runat="server" Text="Code" CssClass="my-2 form-text Filter__label"></asp:Label>
                                                <asp:TextBox ID="txtDeptCode" runat="server" CssClass="form-control" MaxLength="8"></asp:TextBox>
                                                <asp:TextBox ID="txtDeptCodeBackup" runat="server" CssClass="form-control" MaxLength="8" Visible="false"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
                                            <div class="col">
                                                <asp:Label ID="Site_lblDeptStatus" runat="server" Text="Status" CssClass="my-2 form-text Filter__label"></asp:Label>
                                                <asp:DropDownList ID="ddDeptStatus" runat="server" CssClass="form-control">
                                                    <asp:ListItem Text="Active"></asp:ListItem>
                                                    <asp:ListItem Text="Inactive"></asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                            <div class="col">
                                                <asp:Label ID="Site_lblDescription" runat="server" Text="Description" CssClass="my-2 form-text Filter__label"></asp:Label>
                                                <asp:TextBox ID="txtDeptDesc" runat="server" CssClass="form-control" MaxLength="80"></asp:TextBox>
                                            </div>
                                        </div>
                                        <p></p>
                                        <div class="row my-3">
                                            <div class="col col-sm-2 col-md-2 col-lg-1">
                                                <asp:Button ID="Site_btDeptAdd" runat="server" CssClass="btn bg-gradient-success button-font-size" Text="Add" Style="width: 100%;" OnClick="Site_btDeptAdd_Click" />
                                            </div>
                                            <div class="col col-sm-2 col-md-2 col-lg-1">
                                                <asp:Button ID="Site_btDeptUpdate" runat="server" CssClass="btn bg-gradient-success button-font-size" Text="Update" Style="width: 100%;" OnClick="Site_btDeptUpdate_Click" />
                                            </div>
                                            <div class="col col-sm-2 col-md-2 col-lg-1">
                                                <asp:Button ID="Site_btDeptDelete" runat="server" CssClass="btn bg-gradient-success button-font-size" Text="Delete" Style="width: 100%;" OnClick="Site_btDeptDelete_Click" />
                                            </div>
                                        </div>
                                        <p>
                                        </p>
                                    </div>
                                    <div class="card card-boxshadow">
                                        <div class="card-header">
                                            <asp:Label ID="Site_lblDepartmentTitle" runat="server" CssClass="h6" Text="List Of Department"></asp:Label>
                                        </div>
                                        <div class="card-body" style="overflow: auto;">
                                              <div class="d-flex align-items-center rowperpage-modify">
                                                    <asp:Label ID="Site_lblDeptRowPerPage" runat="server" Text="Rows per Page" CssClass="mr-3"></asp:Label>
                                                    <asp:DropDownList ID="ddDeptRowPerPage" runat="server" DataSourceID="dsDeptRowPerPage" DataTextField="value" DataValueField="value" OnSelectedIndexChanged="ddDeptRowPerPage_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
                                                     &nbsp;/&nbsp;
                                                    <asp:Label ID="lblTotalDepartment" runat="server" Text="0" CssClass="mr-3"></asp:Label>
                                                </div>
                                            <div class="grid-wrapper" id="nav-department-scroll">
                                                <asp:GridView ID="grDepartment" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" ShowHeaderWhenEmpty="True" AllowPaging="True" DataSourceID="dsDept"
                                                CssClass="table table-bordered" OnSelectedIndexChanged="grDepartment_SelectedIndexChanged" OnRowDataBound="grDepartment_RowDataBound">
                                                <RowStyle CssClass="rowstyle" />
                                                <Columns>
                                                    <asp:CommandField ShowSelectButton="True">
                                                        <ControlStyle CssClass="btn btn-outline-success btn-sm" />
                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                        <HeaderStyle CssClass="header-selected" />
                                                    </asp:CommandField>
                                                    <asp:BoundField DataField="name" SortExpression="name" HtmlEncode="false" HeaderText="Code" ItemStyle-HorizontalAlign="left" HeaderStyle-HorizontalAlign="Center">
                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>

                                                        <ItemStyle CssClass="text-center" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="description" SortExpression="description" HtmlEncode="false" HeaderText="Description" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Center">
                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>

                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="site_name" SortExpression="site_name" HeaderText="Site" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
                                                    <asp:TemplateField HeaderText="Status" SortExpression="status">
                                                        <EditItemTemplate>
                                                            <asp:Label ID="lblStatus" runat="server" Text='<%# Bind("status") %>'></asp:Label>
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
                                        </div>
                                    </div>

                                </div>
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

          $(document).ready(function () {
                $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {
                    localStorage.setItem('activeTabSiteMaint', $(e.target).attr('href'));
                });
            });

        var prm = Sys.WebForms.PageRequestManager.getInstance();
         prm.add_endRequest(function () {
             activeSelectedTab();
             selectTab();
         });
    </script>

    <script>

        function selectTab() {
            $(document).ready(function () {
                $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {
                    localStorage.setItem('activeTabSiteMaint', $(e.target).attr('href'));
                });
            });
        }

        function activeSelectedTab() {
             $(document).ready(function () {
                var activeTab = localStorage.getItem('activeTabSiteMaint');
                if (activeTab) {
                    $('#myTab a[href="' + activeTab + '"]').tab('show');
                }
             });
        }
       
    </script>

    <asp:SqlDataSource ID="dsTemp" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>" OnSelecting="dsTemp_Selecting"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsSite" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT name,description,status FROM TERP_site ORDER BY name" OnSelecting="dsTemp_Selecting"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsDeptSite" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT site_id, name as site_name FROM TERP_site WHERE status='Active' ORDER BY name" OnSelecting="dsTemp_Selecting"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsDept" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT name,description,site_name,status FROM vTERP_department ORDER BY name" OnSelecting="dsTemp_Selecting"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsRowPerPage" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT value FROM TERP_row_per_page ORDER BY value" OnSelecting="dsTemp_Selecting"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsDeptRowPerPage" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT value FROM TERP_row_per_page ORDER BY value" OnSelecting="dsTemp_Selecting"></asp:SqlDataSource>

    <script src="../../Libs/CountEmailJS.js"></script>

</asp:Content>
