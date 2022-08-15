<%@ Page MasterPageFile="~/TERP.Master" Language="C#" AutoEventWireup="true" CodeBehind="frmPOReport.aspx.cs" Inherits="TERP.Forms.PMS.frmPOReport" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.3500.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:Content ContentPlaceHolderID="TERPContentPlaceHolder" runat="server">
    <link href="../../Style/Browse/BrowseStyle.css" rel="stylesheet"/>
    <link href="../../Style/PMS/frmPOReport.css" rel="stylesheet" />

    <%-- Title Menu --%>
    <div style="width: 100%" class="title-padding">
        <asp:Label ID="POReport_lblModuleTitle" runat="server" Text="PO Report" CssClass="title_label"></asp:Label>
    </div>

    <div class="row justify-content-around" id="SupplierFilter">
        <div class="col-md-10">
            <div class="card card-border card-boxshadow">
                <div class="card-body">
                    <div class="d-flex justify-content-around">
                        <CR:CrystalReportViewer ID="CrystalReportViewer" runat="server" AutoDataBind="true" ToolPanelWidth="200px" Width="100%" ToolPanelView="None"/>
                        <CR:CrystalReportSource ID="CrystalReportSource" runat="server">
                            <Report FileName="\Report\POReport.rpt"></Report>
                        </CR:CrystalReportSource>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="../../Libs/CountEmailJS.js"></script>
</asp:Content>
