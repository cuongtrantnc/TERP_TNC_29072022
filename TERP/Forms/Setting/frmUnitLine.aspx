<%@ Page MasterPageFile="~/TERP.Master" Language="C#" AutoEventWireup="true" CodeBehind="frmUnitLine.aspx.cs" Inherits="TERP.Forms.frmUnitLine" %>

<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>--%>

<asp:Content ContentPlaceHolderID="TERPContentPlaceHolder" runat="server">
    <link href="../../Style/Browse/BrowseStyle.css" rel="stylesheet" />
    <div>
        <div style="width: 100%" class="title-padding">
            <asp:Label ID="lblModuleTitle" runat="server" Text="Work Center - Production Line Maintenance" Font-Bold="True" CssClass="h4"></asp:Label>
            <%--title-color--%>
        </div>

        <div class="row">
            <div class="col-md-12">
                <div class="card card-success card-outline card-outline-tabs card-border">
                    <div class="card-header p-0 border-bottom-0">
                        <ul class="nav nav-tabs" id="myTab">
                            <li class="nav-item">
                                <a href="#nav-unit" class="nav-link active text-success" data-toggle="tab">Dept. - Work Cent.</a>
                            </li>
                            <li class="nav-item">
                                <a href="#nav-workline" class="nav-link text-success" data-toggle="tab">Prod. Line</a>
                            </li>
                        </ul>
                    </div>

                    <%--        <div class="card card-info">--%>
                    <div class="card-body">
                        <div class="tab-content" id="nav-tabContent">
                            <div class="tab-pane fade show active" id="nav-unit" role="tabpanel" aria-labelledby="nav-unit-tab">
                                <p></p>
                                <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
                                    <div class="col">
                                        <asp:Label ID="Label1" runat="server" Text="Code (*)" CssClass="my-2 form-text"></asp:Label>
                                        <asp:TextBox ID="txtUnitName" runat="server" CssClass="form-control" MaxLength="10"></asp:TextBox>
                                    </div>
                                    <div class="col">
                                        <asp:Label ID="Label4" runat="server" Text="Description" CssClass="my-2 form-text"></asp:Label>
                                        <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" MaxLength="150"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
                                    <div class="col">
                                        <asp:Label ID="Label5" runat="server" Text="Type" CssClass="my-2 form-text"></asp:Label>
                                        <asp:DropDownList ID="ddType" runat="server" CssClass="form-control">
                                            <asp:ListItem Text="Work Center" Value="0"></asp:ListItem>
                                            <asp:ListItem Text="Department" Value="1"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col">
                                        <asp:Label ID="Label6" runat="server" Text="Status" CssClass="my-2 form-text"></asp:Label>
                                        <asp:DropDownList ID="ddAccessible" runat="server" CssClass="form-control">
                                            <asp:ListItem Text="Active" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Inactive" Value="0"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <p></p>
                                <div class="row my-3">
                                    <div class="col col-sm-2 col-md-2 col-lg-1">
                                        <asp:Button ID="btUnitAdd" runat="server" CssClass="btn bg-gradient-success" Text="Add" Style="width: 100%;" OnClick="btUnitAdd_Click" />
                                    </div>
                                    <div class="col col-sm-2 col-md-2 col-lg-1">
                                        <asp:Button ID="btUnitUpdate" runat="server" CssClass="btn bg-gradient-success" Text="Update" Style="width: 100%;" OnClick="btUnitUpdate_Click" />
                                    </div>
                                    <div class="col col-sm-2 col-md-2 col-lg-1">
                                        <asp:Button ID="btUnitDel" runat="server" CssClass="btn bg-gradient-success" Text="Delete" Style="width: 100%;" OnClick="btUnitDel_Click" />
                                    </div>
                                </div>
                                <p>
                                </p>
                                <div class="card card-boxshadow">
                                    <div class="card-header">
                                        <asp:Label ID="Label9" runat="server" CssClass="h6" Text="List Department - Work Center available"></asp:Label>
                                    </div>
                                    <div class="card-body" style="overflow: auto;">
                                        <asp:GridView ID="grUnitDept" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" ShowHeaderWhenEmpty="True" AllowPaging="True" DataSourceID="dsUnitDept" CssClass="table table-bordered" OnRowDataBound="grUnitDept_RowDataBound" OnSelectedIndexChanged="grUnitDept_SelectedIndexChanged">
                                            <RowStyle CssClass="rowstyle" />
                                            <Columns>
                                                <%--<asp:TemplateField HeaderText="Status" HeaderStyle-CssClass="text-center">
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chkEnable" runat="server" Enabled="false" />
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkEnable" runat="server" Enabled="false" />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                        </asp:TemplateField>--%>

                                                <asp:CommandField ShowSelectButton="True">
                                                    <ControlStyle CssClass="btn btn-outline-success btn-sm" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                    <HeaderStyle CssClass="header-selected" />
                                                </asp:CommandField>
                                                <asp:BoundField DataField="name" SortExpression="name" HeaderText="Code" ItemStyle-HorizontalAlign="left" HeaderStyle-HorizontalAlign="Center">
                                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>

                                                    <ItemStyle CssClass="text-center" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="description" SortExpression="description" HeaderText="Description" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Center">
                                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>

                                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="is_unit" SortExpression="is_unit" HeaderText="Type" ItemStyle-HorizontalAlign="left" HeaderStyle-HorizontalAlign="Center">
                                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>

                                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:TemplateField HeaderText="Status">
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="lblStatus" runat="server" Text='<%# Bind("enable") %>'></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblStatus" runat="server" Text='<%# Bind("enable") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="text-center" />
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>

                                            </Columns>
                                            <FooterStyle BackColor="#e9ecef" Font-Bold="True" />
                                            <HeaderStyle BackColor="#e9ecef" HorizontalAlign="Center" />
                                            <PagerStyle CssClass="pageStyle" HorizontalAlign="Center" />
                                        </asp:GridView>
                                        <div class="d-flex align-items-center">
                                            <asp:Label ID="Label11" runat="server" Text="Rows per Page" CssClass="mr-3"></asp:Label>
                                            <asp:DropDownList ID="ddUnitRowPerPage" runat="server" DataSourceID="dsRowPerPage" DataTextField="value" DataValueField="value" OnSelectedIndexChanged="ddUnitRowPerPage_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="tab-pane fade" id="nav-workline" role="tabpanel" aria-labelledby="nav-workline-tab">
                                <p></p>
                                <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
                                    <div class="col">
                                        <asp:Label ID="Label3" runat="server" Text="Work Center" CssClass="my-2 form-text"></asp:Label>
                                        <asp:DropDownList ID="ddUnitLine" runat="server" CssClass="form-control" DataSourceID="dsUnitDeptLine" DataTextField="name" DataValueField="unit_dept_id" OnSelectedIndexChanged="ddUnitLine_SelectedIndexChanged" AutoPostBack="True" />
                                    </div>
                                    <div class="col">
                                        <asp:Label ID="Label2" runat="server" Text="Code" CssClass="my-2 form-text"></asp:Label>
                                        <asp:TextBox ID="txtWorkLine" runat="server" CssClass="form-control" MaxLength="10"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
                                    <div class="col">
                                        <asp:Label ID="Label8" runat="server" Text="Status" CssClass="my-2 form-text"></asp:Label>
                                        <asp:DropDownList ID="ddLineAccessible" runat="server" CssClass="form-control">
                                            <asp:ListItem Text="Active" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Inactive" Value="0"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <p></p>
                                <div class="row my-3">
                                    <div class="col col-sm-2 col-md-2 col-lg-1">
                                        <asp:Button ID="btWorklineAdd" runat="server" CssClass="btn bg-gradient-success" Text="Add" Style="width: 100%;" OnClick="btWorklineAdd_Click" />
                                    </div>
                                    <div class="col col-sm-2 col-md-2 col-lg-1">
                                        <asp:Button ID="btWorklineUpdate" runat="server" CssClass="btn bg-gradient-success" Text="Update" Style="width: 100%;" OnClick="btWorklineUpdate_Click" />
                                    </div>
                                    <div class="col col-sm-2 col-md-2 col-lg-1">
                                        <asp:Button ID="btWorklineDelete" runat="server" CssClass="btn bg-gradient-success" Text="Delete" Style="width: 100%;" OnClick="btWorklineDelete_Click" />
                                    </div>
                                </div>
                                <p>
                                </p>
                                <div class="card card-boxshadow">
                                    <div class="card-header">
                                        <h6>List Production line available</h6>
                                    </div>
                                    <div class="card-body" style="overflow: auto;">
                                        <asp:GridView ID="grLine" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" ShowHeaderWhenEmpty="True" AllowPaging="true" DataSourceID="dsLine" CssClass="table table-bordered" OnSelectedIndexChanged="grLine_SelectedIndexChanged" OnRowDataBound="grLine_RowDataBound">
                                            <RowStyle CssClass="rowstyle" />
                                            <Columns>
                                                <asp:CommandField ShowSelectButton="True">
                                                    <ControlStyle CssClass="btn btn-outline-success btn-sm" />
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                    <HeaderStyle CssClass="header-selected" />
                                                </asp:CommandField>
                                                <asp:BoundField DataField="name" SortExpression="name" HeaderText="Code" ItemStyle-HorizontalAlign="left" HeaderStyle-HorizontalAlign="Center">
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:BoundField>
                                                <asp:TemplateField HeaderText="Status">
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="lblStatus" runat="server" Text='<%# Bind("enable") %>'></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblStatus" runat="server" Text='<%# Bind("enable") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="text-center" />
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <%--<asp:BoundField DataField="enable" SortExpression="enable" HeaderText="Enable" ItemStyle-HorizontalAlign="left" HeaderStyle-HorizontalAlign="Center" />--%>
                                                <%--<asp:TemplateField HeaderText="Status" HeaderStyle-CssClass="text-center">
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="chkEnable" runat="server" Enabled="false" />
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkEnable" runat="server" Enabled="false" />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="center"></ItemStyle>
                                        </asp:TemplateField>--%>
                                            </Columns>
                                            <FooterStyle BackColor="#e9ecef" Font-Bold="True" />
                                            <HeaderStyle BackColor="#e9ecef" HorizontalAlign="Center" />
                                            <PagerStyle CssClass="pageStyle" HorizontalAlign="Center" />
                                        </asp:GridView>

                                        <div class="d-flex align-items-center">
                                            <asp:Label ID="Label7" runat="server" Text="Rows per Page" CssClass="mr-3"></asp:Label>
                                            <asp:DropDownList ID="ddLineRowPerPage" runat="server" DataSourceID="dsRowPerPage" DataTextField="value" DataValueField="value" OnSelectedIndexChanged="ddLineRowPerPage_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <script src="../../Theme/plugins/jquery/jquery.min.js"></script>
                            <script>
                                $(document).ready(function () {
                                    $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {
                                        localStorage.setItem('activeTab', $(e.target).attr('href'));
                                    });
                                    var activeTab = localStorage.getItem('activeTab');
                                    if (activeTab) {
                                        $('#myTab a[href="' + activeTab + '"]').tab('show');
                                    }
                                });

                                // VALIDATION FORM
                                $(function () {
                                    $('#quickForm').validate({
                                        rules: {
                                    <%= txtUnitName.UniqueID %>: {
                                    required: true,
                                    minlength: 3
                                },
                            },
                            messages: {
                                        <%= txtUnitName.UniqueID %>: {
                                        required: "Name can not be blank",
                                        minlength: "Name must be at least 3 characters"
                                    },
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
                            <script src="../../Libs/ModalMessage.js"></script>
                            <script src="../../Theme/plugins/toastr/toastr.min.js"></script>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <asp:SqlDataSource ID="dsTemp" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>" OnSelecting="dsTemp_Selecting"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsUnitDept" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT name,description,is_unit,enable FROM TERP_unit_dept ORDER BY name" OnSelecting="dsUnitDept_Selecting"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsUnitDeptLine" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT unit_dept_id,name FROM TERP_unit_dept WHERE is_unit=1 AND enable=1 ORDER BY name" OnSelecting="dsUnitDeptLine_Selecting"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsRowPerPage" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT value FROM TERP_row_per_page ORDER BY value" OnSelecting="dsRowPerPage_Selecting"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsLine" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT TOP (0) name,enable FROM TERP_line ORDER BY name" OnSelecting="dsLine_Selecting"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsLineRowPerPage" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT value FROM TERP_row_per_page ORDER BY value" OnSelecting="dsLineRowPerPage_Selecting"></asp:SqlDataSource>
</asp:Content>
