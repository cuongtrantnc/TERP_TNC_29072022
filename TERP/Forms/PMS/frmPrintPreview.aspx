<%@ Page MasterPageFile="~/TERP.Master" Language="C#" AutoEventWireup="true" CodeBehind="frmPrintPreview.aspx.cs" Inherits="TERP.Forms.PMS.frmPrintPreview" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.3500.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<asp:Content ContentPlaceHolderID="TERPContentPlaceHolder" runat="server">
    <link href="../../Style/Browse/BrowseStyle.css" rel="stylesheet"/>

    <div style="width: 100%" class="title-padding">
        <asp:Label ID="POBrowse_lblModuleTitle" runat="server" Text="Print Preview" Font-Bold="True" CssClass="h4"></asp:Label>
    </div>

    <div class="row">
        <div class="col-md-12">
            <div class="card card-border card-boxshadow">
                <div class="card-body">
                    <div class="d-flex justify-content-around">
                        <CR:CrystalReportViewer ID="crViewer" runat="server" AutoDataBind="True" ReportSourceID="CrystalReportSource1" ToolPanelWidth="200px" Width="100%" ToolPanelView="None" />
                        <CR:CrystalReportSource ID="CrystalReportSource1" runat="server">
                            <Report FileName="Report\rpPRDemo.rpt">
                            </Report>
                        </CR:CrystalReportSource>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <asp:SqlDataSource ID="dsTemp" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"></asp:SqlDataSource>
</asp:Content>
