<%@ Page Title="" Language="C#" MasterPageFile="~/TERP.Master" AutoEventWireup="true" CodeBehind="frmSupplierEvaluationReport.aspx.cs" Inherits="TERP.Forms.PMS.frmSupplierEvaluationReport" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.3500.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>


<asp:Content ID="Content1" ContentPlaceHolderID="TERPContentPlaceHolder" runat="server">
    <link href="../../Style/Browse/BrowseStyle.css" rel="stylesheet"/>
    <link href="../../aspnet_client/system_web/4_0_30319/crystalreportviewers13/js/crviewer/images/style.css" rel="stylesheet"/>

    <%-- Title Menu --%>
    <div class="title-padding" style="width:100%">
        <asp:Label runat="server" ID="frmSupplierComparison_lblTitle" Text="Supplier Evaluation Report" CssClass="h4 title_label"></asp:Label>
    </div>

    <div class="row justify-content-around mt-2 " id="SupplierFilter">
        <div class="col-md-10">
            <div class="card card-border card-boxshadow">
                <div class="card-body">
                    <div class="d-flex justify-content-around">
                        <CR:CrystalReportViewer ID="CrystalReportViewer" runat="server" AutoDataBind="true" ToolPanelWidth="200px" Width="100%" ToolPanelView="None"/>
                            <CR:CrystalReportSource ID="CrystalReportSource" runat="server">
                                <Report FileName="Report\SupplierEvaluation.rpt">
                                </Report>
                        </CR:CrystalReportSource>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="../../aspnet_client/system_web/4_0_30319/crystalreportviewers13/js/crviewer/crv.js"></script>
    
</asp:Content>
