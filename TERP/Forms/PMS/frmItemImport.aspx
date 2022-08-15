<%@ Page MasterPageFile="~/TERP.Master" Language="C#" AutoEventWireup="true" CodeBehind="frmItemImport.aspx.cs" Inherits="TERP.Forms.PMS.frmItemImport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ContentPlaceHolderID="TERPContentPlaceHolder" runat="server">
    <link href="../../Style/Browse/BrowseStyle.css" rel="stylesheet" />
    <link href="../../Style/PMS/frmItemImport.css" rel="stylesheet" />

    <div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <Triggers>
                <asp:PostBackTrigger ControlID="ItemImport_btUpload" />
            </Triggers>
            <ContentTemplate>
                <div style="width: 100%" class="title-padding">
                    <asp:Label ID="ItemImport_lblModuleTitle" runat="server" Text="Item Master Import" Font-Bold="True" CssClass="h4"></asp:Label>
                </div>

                <div class="row row-cols-1 row-cols-sm-1 row-cols-md-2 justify-content-center">
                    <div class="col">
                        <div id="divFilter" class="box">
                            <div class="text-center">
                                <asp:Label runat="server" ID="ItemImport_lblDesc" class="box_description">Drag and Drop to upload data file (*.csv, *.xlsx) or import file from your computer</asp:Label>
                                <span class="box_icon"><i class="fa fa-cloud-upload-alt"></i></span>
                                <asp:FileUpload ID="fileUpload" runat="server" CssClass="box_import"/>
                            </div>
                        </div>
                        <hr />
                        <div class="note">
                            <asp:Label runat="server" ID="ItemImport_lblNote" class="note_span mr-2">Note :</asp:Label>
                            <asp:Label runat="server" ID="ItemImport_lblComment" class="note_desc">This function allows import of data list from Excel or CSV file.</asp:Label>
                            <asp:Button runat="server" ID="ItemImport_link" class="note_link" Text="Template here"/>
                            <a href="../../Templates/Item_Import_Template.csv" class="note_link" >Item_Import_Template.csv</a>
                        </div>
                        <div class="mt-3 text-md-right">
                            <asp:Button ID="ItemImport_btUpload" runat="server" Text="Upload" CssClass="btn bg-gradient-success rowButton-modal" OnClick="ItemImport_btUpload_Click" />
                            <%--<asp:LinkButton runat="server" ID="ItemImport" Text="Upload" CssClass="btn bg-gradient-success rowButton-modal"><i class="fa fa-upload mr-2">aa</i></asp:LinkButton>                       --%>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>

        <button type="button" style="display: none;" id="btnShowPopup" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#centralModalLg">Modal</button>
        <div class="modal fade" id="centralModalLg" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <!--Content-->
                <div class="modal-content">
                    <!--Header-->
                    <div class="modal-header">
                        <h4 class="modal-title w-100">
                            <asp:Label runat="server" ID="myModalLabel"></asp:Label></h4>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <!--Body-->
                    <div class="modal-body">
                        <asp:Label runat="server" ID="lblSuccess" ForeColor="Red"></asp:Label>
                        <br />
                        <asp:Label runat="server" ID="lblDuplicate" ForeColor="Red"></asp:Label>
                    </div>
                    <!--Footer-->
                    <div class="modal-footer">
                        <asp:Button runat="server" class="btn btn-secondary" data-dismiss="modal" ID="btModalClose"></asp:Button>
                    </div>
                </div>
                <!--/.Content-->
            </div>
        </div>

<%--        <script src="/TERP/Theme/plugins/jquery/jquery.min.js"></script>
        <script src="/TERP/Theme/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="/TERP/Theme/plugins/toastr/toastr.min.js"></script>
        <script src="/TERP/Libs/Message.js"></script>--%>

        <script type="text/javascript">
            function openModal(title, success, failed, button) {
                $('#<%=myModalLabel.ClientID%>').text(title);
                $('#<%=lblSuccess.ClientID%>').text(success);
                $('#<%=lblDuplicate.ClientID%>').html(failed);
                $('#<%=btModalClose.ClientID%>').val(button);
                $("#btnShowPopup").click();
            }
        </script>
    </div>

    <asp:SqlDataSource ID="dsTemp" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>" OnSelecting="dsTemp_Selecting"></asp:SqlDataSource>

    <script src="../../Libs/CountEmailJS.js"></script>
</asp:Content>
