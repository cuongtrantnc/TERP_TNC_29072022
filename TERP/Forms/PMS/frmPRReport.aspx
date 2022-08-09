<%@ Page Title="" Language="C#" MasterPageFile="~/TERP.Master" AutoEventWireup="true" CodeBehind="frmPRReport.aspx.cs" Inherits="TERP.Forms.PMS.PRReport" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.3500.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TERPContentPlaceHolder" runat="server">
    <link href="../../Style/Browse/BrowseStyle.css" rel="stylesheet"/>
    <link href="../../Style/PMS/frmPRReport.css" rel="stylesheet" />

     <%-- Title Menu --%>
    <div class="title-padding" style="width:100%">
        <asp:Label runat="server" ID="frmPRReport_lblTitle" Text="PR Report" CssClass="title_label"></asp:Label>
    </div>

    <div class="row justify-content-around" id="SupplierFilter">
        <div class="col-md-10">
            <div class="card card-border card-boxshadow">
                <div class="card-body">
                    <div class="d-flex justify-content-around">
                        <CR:CrystalReportViewer ID="CrystalReportViewer" runat="server" AutoDataBind="true" ToolPanelWidth="200px" Width="100%" ToolPanelView="None"/>
                        <CR:CrystalReportSource ID="CrystalReportSource" runat="server">
                            <Report FileName="\Report\PRReport.rpt"></Report>
                        </CR:CrystalReportSource>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
