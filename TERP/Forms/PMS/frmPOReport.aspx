<%@ Page MasterPageFile="~/TERP.Master" Language="C#" AutoEventWireup="true" CodeBehind="frmPOReport.aspx.cs" Inherits="TERP.Forms.PMS.frmPOReport" %>

<asp:Content ContentPlaceHolderID="TERPContentPlaceHolder" runat="server">
    <link href="/terp/Style/TERP.css" rel="stylesheet" />

    <div style="width: 100%" class="title-padding">
        <asp:Label ID="POReport_lblModuleTitle" runat="server" Text="Localization String Definition" Font-Bold="True" CssClass="h4"></asp:Label>
        <%--title-color--%>
    </div>

    <div class="row">
        <div class="col-md-12">
            <div class="card card-border card-boxshadow">
                <div class="card-body">
                    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
                        <div class="col">
                            <asp:Label ID="POReport_lblModule" runat="server" Text="Module"></asp:Label>
                            <asp:DropDownList ID="ddModule" runat="server" CssClass="form-control" DataSourceID="dsModule" DataTextField="module_name" DataValueField="module_id"></asp:DropDownList>
                        </div>
                        <div class="col">
                            <br />
                            <asp:Button ID="POReport_btQuery" runat="server" Text="Query" CssClass="btn bg-gradient-success" OnClick="POReport_btQuery_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <asp:SqlDataSource ID="dsModule" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT module_id,module_prefix + ': ' + module_name as module_name FROM TERP_module WHERE enable=1 ORDER BY sort"></asp:SqlDataSource>

    <script src="../../Libs/CountEmailJS.js"></script>
</asp:Content>
