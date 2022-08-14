<%@ Page Title="" Language="C#" MasterPageFile="~/TERP.Master" AutoEventWireup="true" CodeBehind="frmSupplierComparisonReport.aspx.cs" Inherits="TERP.Forms.PMS.frmSupplierComparisonReport" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.3500.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TERPContentPlaceHolder" runat="server">
    <link href="../../Style/Browse/BrowseStyle.css" rel="stylesheet"/>
    <link href="../../Style/PMS/frmSupplierComparison.css" rel="stylesheet"/>


    <%-- Title Menu --%>
    <div class="title-padding" style="width:100%">
        <asp:Label runat="server" ID="frmSupplierComparison_lblTitle" Text="Supplier Comparison Report" CssClass="title_label"></asp:Label>
    </div>

    <div class="row" id="SupplierFilter">
        <div class="col-md-12">
            <div class="card card-border card-boxshadow">
                <div class="card-body">
                    <fieldset class="fieldSet">
                        <legend class="fieldSet_legend">
                            <asp:Label runat="server" ID="fieldSet_Filter" Text="Sreach Condition"></asp:Label>
                        </legend>
                            <div class="row">
                                <%-- Header and Action --%>
                                <div class="col-xs-12 col-sm-6 col-md-6 col-lg-3">
                                    <span>Code :</span>
                                    <asp:Label runat="server" ID="frmSupplierComparisonReport_lblCode"></asp:Label>
                                </div>
                                <div class="col-xs-12 col-sm-6 col-md-6 col-lg-3 ml-auto">
                                    <asp:DropDownList ID="ddReport_user" runat="server" CssClass="form-control" style="width:100%;">
                                        <asp:ListItem Selected="true">Route to User</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-xs-12 col-sm-6 col-md-6 col-lg-3">
                                    <asp:DropDownList ID="ddReport_action" runat="server" CssClass="form-control" style="width:100%;">
                                        <asp:ListItem Selected="True">Action</asp:ListItem>
                                        <asp:ListItem Text="New"></asp:ListItem>
                                        <asp:ListItem Text="Signed"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                    </fieldset>

                    <div class="row mt-4 justify-content-around">
                       <CR:CrystalReportViewer ID="CrystalReportViewer" runat="server" AutoDataBind="true" ReportSourceID="CrystalReportSource" ToolPanelWidth="200px" Width="350px" ToolPanelView="None" />
                        <CR:CrystalReportSource ID="CrystalReportSource" runat="server">
                            <Report FileName="/Report/SupplierComparison.rpt">
                            </Report>
                        </CR:CrystalReportSource>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
