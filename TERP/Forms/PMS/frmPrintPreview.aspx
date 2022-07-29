<%@ Page MasterPageFile="~/TERP.Master" Language="C#" AutoEventWireup="true" CodeBehind="frmPrintPreview.aspx.cs" Inherits="TERP.Forms.PMS.frmPrintPreview" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.4000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<asp:Content ContentPlaceHolderID="TERPContentPlaceHolder" runat="server">
    <div style="width: 100%" class="title-padding">
        <asp:Label ID="POBrowse_lblModuleTitle" runat="server" Text="Print Preview" Font-Bold="True" CssClass="h4"></asp:Label>
    </div>

    <div class="row">
        <div class="col-md-12">
            <div class="card card-border card-boxshadow mt-3">
                <div class="card-body">
                    <div class="row">
                        <CR:CrystalReportViewer ID="crViewer" runat="server" AutoDataBind="True" GroupTreeImagesFolderUrl="" Height="50px" ReportSourceID="CrystalReportSource1" ToolbarImagesFolderUrl="" ToolPanelWidth="200px" Width="350px" ToolPanelView="None" />
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
