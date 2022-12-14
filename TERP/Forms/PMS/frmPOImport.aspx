<%@ Page MasterPageFile="~/TERP.Master" Language="C#" AutoEventWireup="true" CodeBehind="frmPOImport.aspx.cs" Inherits="TERP.Forms.PMS.frmPOImport" %>

<asp:Content ContentPlaceHolderID="TERPContentPlaceHolder" runat="server">
    <link href="../../Style/Browse/BrowseStyle.css" rel="stylesheet" />
    <link href="../../Style/PMS/frmPOImport.css" rel="stylesheet" />

    <div>
        <div style="width: 100%" class="title-padding">
            <asp:Label ID="POImport_lblModuleTitle" runat="server" Text="PO Import" Font-Bold="True" CssClass="h4"></asp:Label>
        </div>

        <div class="row row-cols-1 row-cols-sm-1 row-cols-md-2 justify-content-center">
            <div class="col">
                <div id="divFilter" class="box">
                    <div class="text-center">
                        <asp:Label runat="server" ID="POImport_lblDesc" class="box_description">Drag and Drop to upload data file (*.csv, *.xlsx) or import file from your computer</asp:Label>
                        <span class="box_icon"><i class="fa fa-cloud-upload-alt"></i></span>
                        <asp:FileUpload ID="fileUpload" runat="server" CssClass="box_import"/>
                    </div>
                </div>
                <hr />
                    <div class="note">
                        <asp:Label runat="server" ID="POImport_lblNote" class="note_span mr-2">Note :</asp:Label>
                        <asp:Label runat="server" ID="POImport_lblComment" class="note_desc">This function allows import of data list from Excel or CSV file.</asp:Label>
                        <asp:Label runat="server" ID="POImport_link" class="note_link" Text="Template here"/>
                        <a href="../../Templates/PO_Import_Template.csv" class="note_link" >PO_Import_Template.csv</a>
                    </div>
                <div class="mt-3 text-md-right">
                    <asp:Button ID="POImport_btQuery" runat="server" Text="Upload" CssClass="btn bg-gradient-success rowButton-modal" OnClick="POImport_btQuery_Click"/>                    
                    <%--<asp:LinkButton runat="server" ID="POImport_btLink" CssClass="btn bg-gradient-success rowButton-modal" Text="Upload" HtmlEncode="False" OnClick="POImport_btQuery_Click"><i class="fa fa-upload mr-2"></i></asp:LinkButton>  --%>
                </div>
            </div>
        </div>

         <%--Script--%>
<%--        <script src="../../Theme/plugins/jquery/jquery.min.js"></script>
        <script src="../../Libs/ModalMessage.js"></script>
        <script src="../../Theme/plugins/toastr/toastr.min.js"></script>--%>
    </div>

    <asp:SqlDataSource ID="dsTemp" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>" OnSelecting="dsTemp_Selecting"></asp:SqlDataSource>

    <script src="../../Libs/CountEmailJS.js"></script>
</asp:Content>
