<%@ Page MasterPageFile="~/TERP.Master" Language="C#" AutoEventWireup="true" CodeBehind="frmProfile.aspx.cs" Inherits="TERP.Forms.Setting.frmProfile" %>

<asp:Content ContentPlaceHolderID="TERPContentPlaceHolder" runat="server">
    <link href="../../Style/Browse/BrowseStyle.css" rel="stylesheet" />
    <link href="../../Style/PMS/frmProfile.css" rel="stylesheet" />

    <div>
        <div style="width: 100%" class="title-padding">
            <asp:Label ID="Profile_lblModuleTitle" runat="server" Text="User Profile" Font-Bold="True" CssClass="h4"></asp:Label>
            <%--title-color--%>
        </div>

        <div class="Profile">
            <div class="Profile__avata">
                <div class="card card-border card-boxshadow">
                    <div class="card-body">
                        <div class="Profile__image">
                            <asp:Label ID="Profile_lblUserImage" runat="server" Text=""></asp:Label>
                            <asp:Image ID="imgUserImage" runat="server"/>
                        </div>
                        <div class="Profile__upload">
                            <asp:Label ID="Profile_lblUpload" runat="server" Text="Upload image"></asp:Label>
                            <asp:FileUpload ID="fileUpload" runat="server"/>
                            <asp:Button runat="server" ID="Profile_btUpload" Text="Upload" CssClass="btn bg-gradient-success Form__button Form__button--upload" OnClick="Profile_btUpload_Click" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="Profile__infor">
                <div class="card card-border card-boxshadow">
                    <div class="card-body">
                        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4">
                            <div class="col">
                                <asp:Label ID="Profile_lblUserID" runat="server" Text="User ID" CssClass="my-2 form-text Form__label"></asp:Label>
                                <asp:Label ID="lblUserID" runat="server" Text="" CssClass="form-control" BackColor="#CCCCCC"></asp:Label>
                            </div>
                        </div>
                        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 my-3">
                            <div class="col">
                                <asp:Label ID="Profile_lblUserName" runat="server" Text="User Name" CssClass="my-2 form-text Form__label"></asp:Label>
                                <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="col">
                                <asp:Label ID="Profile_lblUserFullName" runat="server" Text="User Full Name" CssClass="my-2 form-text Form__label"></asp:Label>
                                <asp:TextBox ID="txtUserFullName" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 my-3">
                            <div class="col">
                                <asp:Label ID="Profile_lblCardID" runat="server" Text="Card ID" CssClass="my-2 form-text Form__label"></asp:Label>
                                <asp:TextBox ID="txtCardID" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="col">
                                <asp:Label ID="Profile_lblEmail" runat="server" Text="Email" CssClass="my-2 form-text Form__label"></asp:Label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 my-3">
                            <div class="col">
                                <asp:Label ID="Profile_lblPassword" runat="server" Text="Password" CssClass="my-2 form-text Form__label"></asp:Label>
                                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                            </div>
                            <div class="col">
                                <asp:Label ID="Profile_lblConfirmPassword" runat="server" Text="Confirm Password" CssClass="my-2 form-text Form__label"></asp:Label>
                                <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4">
                            <div class="col">
                                <asp:Button ID="Profile_btSave" runat="server" Text="Save" CssClass="btn bg-gradient-success Form__button" OnClick="Profile_btSave_Click" />
                            </div>
                        </div>
                    
                    </div>
                </div>
            </div>
            
        </div>
    </div>
    
    <asp:SqlDataSource ID="dsTemp" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>" OnSelecting="dsTemp_Selecting"></asp:SqlDataSource>

    <script src="../../Libs/CountEmailJS.js"></script>

</asp:Content>
