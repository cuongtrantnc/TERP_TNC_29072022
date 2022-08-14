<%@ Page Title="" Language="C#" MasterPageFile="~/TERP.Master" AutoEventWireup="true" CodeBehind="frmSupplierMaintenance.aspx.cs" Inherits="TERP.Forms.PMS.frmSupplierMaintenance" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TERPContentPlaceHolder" runat="server">
    <link href="../../Style/Browse/BrowseStyle.css" rel="stylesheet"/>
    <link href="../../Style/PMS/frmSupplierMaintenance.css" rel="stylesheet"/>

    <%-- Title Menu --%>
    <div class="title-padding header-menu" style="width:100%">
        <asp:Label runat="server" ID="frmSupplierMaintenance_lblTitle" Text="Supplier Maintenace" CssClass="title_label"></asp:Label>
        <%-- Action : Create new && Import new --%>
        <div class="action">
            <span id="btnGoBack" class="action_button-hide"><asp:Button runat="server" ID="frmSupplierMaintenance_btnGoBack" CssClass="btn btn-outline-success action_button" Text="Go Back" OnClick="frmSupplierMaintenance_btnGoBack_Click"/></span>
            <span id="btnCreateNew"><asp:Button runat="server" ID="frmSupplierMaintenance_btnCreateNew"  CssClass="btn bg-gradient-success action_button" Text="Create Supplier" OnClick="frmSupplierMaintenance_btnCreateNew_Click"/></span>
            <span id="btnUploadNew"><asp:Button runat="server" ID="frmSupplierMaintenance_btnUploadNew" ClientIDMode="Static" CssClass="btn btn-outline-success action_button" Text="Upload Supplier" OnClick="frmSupplierMaintenance_btnUploadNew_Click"/></span>
        </div>
    </div>

    
    

    <%-- Filter and View  --%>
    <div class="row" id="SupplierFilter">
        <div class="col-md-12">
            <div class="card card-border card-boxshadow">
                <div class="card-body">
                    <%--Condition Filter--%>
                    <fieldset class="fieldSet">
                        <legend class="fieldSet_legend">
                            <asp:Label runat="server" ID="fieldSet_Filter" Text="Sreach Condition"></asp:Label>
                        </legend>
                        <div class="row">
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmSupplierMaintenance_lblSupplCode" Text="Supplier Code" CssClass="filter_label filter_label--modify"></asp:Label>
                                    <asp:TextBox runat="server" ID="frmSupplierMaintenance_txtSupplCode" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmSupplierMaintenance_lblStaffCharge" Text="Staff In Charge" CssClass="filter_label filter_label--modify"></asp:Label>
                                    <asp:TextBox runat="server" ID="frmSupplierMaintenance_txtStaffCharge" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmSupplierMaintenance_lblContactPerson" Text="Contact Person" CssClass="filter_label filter_label--modify"></asp:Label>
                                    <asp:TextBox runat="server" ID="frmSupplierMaintenance_txtContactPerson" CssClass="form-control"></asp:TextBox>
                                </div>                                
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmSupplierMaintenance_lblTransactions" Text="Transactions" CssClass="filter_label filter_label--modify"></asp:Label>
                                    <asp:DropDownList ID="ddTransactions" runat="server" CssClass="form-control">
                                        <asp:ListItem Selected="true" Text="Yes"></asp:ListItem>
                                        <asp:ListItem Text="No"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmSupplierMaintenance_lblStatus" Text="Status" CssClass="filter_label filter_label--modify"></asp:Label>
                                    <asp:DropDownList ID="ddStatus" runat="server" CssClass="form-control">
                                        <asp:ListItem Selected="true" Text="Active"></asp:ListItem>
                                        <asp:ListItem Text="Inactive"></asp:ListItem>
                                        <asp:ListItem Text="Pending"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                <div class="filter_action">
                                    <asp:Button runat="server" ID="frmSupplierMaintenance_filterBtnSreach" Text="Sreach" CssClass="btn bg-gradient-success filter_button filter_button-modifile"/>
                                    <asp:Button runat="server" ID="frmSupplierMaintenance_filterBtnClear" Text="Clear" CssClass="btn btn-outline-success filter_button filter_button-modifile"/>
                                </div>
                            </div>
                        </div>
                        <%-- End Condition Filter --%>                    
                    </fieldset>


                    <%-- Paging --%>
                    <div class="paging">
                        <div id="Paging_Left" class="paging_display">
                            <span id="btnRemove" class="paging_spanRemove"><asp:ImageButton runat="server" ID="frmSupplierMaintenance_btnRemove" ImageUrl="~/Images/trash.png" CssClass="paging_btnRemove" OnClick="frmSupplierMaintenance_btnRemove_Click"></asp:ImageButton></span>
                            <span id="btnPending"><asp:Button runat="server" ID="frmSupplierMaintenance_btnPending"  CssClass="btn bg-gradient-success action_button" Text="Pending" OnClick="frmSupplierMaintenance_btnPending_Click"/></span>
                            <span id="btnInactive"><asp:Button runat="server" ID="frmSupplierMaintenance_btnInactive" ClientIDMode="Static" CssClass="btn bg-gradient-success action_button" Text="Inactive"/></span>
                        </div>
                         <div class="paging_itemRight">
                            <asp:Label ID="frmSupplierMaintenance_lblRecordPage" runat="server" Text="Record per Page" CssClass="pr-2"></asp:Label>
                            <asp:DropDownList ID="ddRecordPerPage" runat="server" CssClass="paging_record" DataSourceID="dsRowPerPage" DataTextField="value" DataValueField="value" AutoPostBack="True"  />

                            <asp:Label runat="server" ID="frmSupplierMaintenance_lblPagingTotal" Text="Total" CssClass="pr-3 pl-3"></asp:Label>
                            <asp:Label runat="server" ID="frmSupplierMaintenance_txtPagingValue" Text="20000"></asp:Label>
                        </div>
                    </div>

                    <%--Supplier GridView--%>
                    <asp:GridView runat="server" ID="grSupplierMaintenance"  AutoGenerateColumns="False" CellPadding="2" ForeColor="#333333" ShowHeaderWhenEmpty="True" CssClass="table table-bordered mt-2 grview"
                    AllowPaging="True" DataSourceID="dsPOApproval" OnRowDataBound="grSupplierMaintenance_RowDataBound">
                    <HeaderStyle CssClass="table_header" />
                    <RowStyle CssClass="rowstyle"/>
                    <Columns>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:CheckBox runat="server" ID="ckAll" OnCheckedChanged="ckAll_CheckedChanged" AutoPostBack="True"/>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox runat="server" ID="ckCheck" OnCheckedChanged="ckCheck_CheckedChanged"/>
                            </ItemTemplate>
                            <ItemStyle  CssClass="text-center"/>
                            <HeaderStyle CssClass="text-center grview_header"/>
                        </asp:TemplateField>

                        <asp:BoundField DataField="po_no" HeaderText="Supplier Code" HeaderStyle-CssClass="grview_header" ItemStyle-HorizontalAlign="Center"/>
                        <asp:BoundField DataField="create_date" HeaderText="Last Modify" ReadOnly="True" DataFormatString="{0:MM/dd/yyyy}" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="grview_header" />
                        <asp:BoundField DataField="create_date" HeaderText="Last Transactions" ReadOnly="True" DataFormatString="{0:MM/dd/yyyy}" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="grview_header" />
                        <asp:BoundField DataField="po_no" HeaderText="Staff in charge" />
                        <asp:BoundField DataField="po_no" HeaderText="Contact Person" />
                        <asp:BoundField DataField="po_no" HeaderText="Supplier Name" />

                        <asp:TemplateField HeaderText="Status" SortExpression="enable">
                            <EditItemTemplate>
                                <asp:Label ID="lblStatus" runat="server" Text='<%# Bind("status") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblStatus" runat="server" Text='<%# Bind("status") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle CssClass="text-center grview_header" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </asp:TemplateField>

                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:Label runat="server" Text="Edit" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <div class="itemTemplate">
                                    <asp:ImageButton runat="server" ID="btnEditSupplier" ImageUrl="~/Images/edit.png" ToolTip="Edit" CssClass="itemTemplate-icon" OnClick="btnEditSupplier_Click"/>
                                </div>
                            </ItemTemplate>
                            <ItemStyle CssClass="itemStyle" />
                            <HeaderStyle HorizontalAlign="Center" CssClass="grview_header"/>
                        </asp:TemplateField>

                    </Columns>
                    <FooterStyle BackColor="#e9ecef" Font-Bold="True" />
                    <HeaderStyle BackColor="#e9ecef" HorizontalAlign="Center" />
                    <PagerStyle CssClass="pageStyle" HorizontalAlign="Center" />
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>


    <%-- Form Create Supplier and Edit Supplier --%>
     <div class="row supplier_form" id="SupplierForm">
        <div class="col-md-12">
            <div class="card card-border card-boxshadow">
                <div class="card-body">

                    <%-- Form input --%>
                    <fieldset class="fieldSet">
                        <legend class="fieldSet_legend">
                            <asp:Label runat="server" ID="fieldSet_Form" Text="Supplier Information"></asp:Label>
                        </legend>
                        <%-- Row 1 --%>
                        <div class="row">
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmSupplierMaintenance_formlblSupplCode" Text="Supplier Code" CssClass="filter_label"></asp:Label><span class="span_require">*</span>
                                    <asp:TextBox runat="server" ID="frmSupplierMaintenance_formtxtSupplCode" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <%-- Row 2 --%>
                        <div class="row">
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmSupplierMaintenance_formlblSupplName" Text="Supplier Name" CssClass="filter_label filter_frmlabel--modify"></asp:Label>
                                    <asp:TextBox runat="server" ID="frmSupplierMaintenance_formtxtSupplName" CssClass="form-control"></asp:TextBox>
                                </div>
                             </div>
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmSupplierMaintenance_formlblSite" Text="Site" CssClass="filter_label"></asp:Label><span class="span_require">*</span>
                                    <asp:DropDownList runat="server" ID="ddFormSite" CssClass="form-control">
                                        
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmSupplierMaintenance_formlblStaffCharge" Text="Staff in charge" CssClass="filter_label filter_frmlabel--modify"></asp:Label>
                                    <asp:TextBox runat="server" ID="frmSupplierMaintenance_formtxtStaffCharge" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <%-- Row 3 --%>
                        <div class="row">
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmSupplierMaintenance_formlblAddress" Text="Address" CssClass="filter_label filter_frmlabel--modify"></asp:Label>
                                    <asp:TextBox runat="server" ID="frmSupplierMaintenance_formtxtAddress" CssClass="form-control"></asp:TextBox>
                                </div>
                             </div>
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmSupplierMaintenance_formlblSupplType" Text="Supplier Type" CssClass="filter_label filter_frmlabel--modify"></asp:Label>
                                    <asp:TextBox runat="server" ID="frmSupplierMaintenance_formtxtSupplType" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmSupplierMaintenance_formlblPhone" Text="Phone Number" CssClass="filter_label filter_frmlabel--modify"></asp:Label>
                                    <%--<asp:TextBox runat="server"  ID="frmSupplierMaintenance_formtxtPhone" CssClass="form-control"></asp:TextBox>--%>
                                    <asp:TextBox runat="server"  ID="frmSupplierMaintenance_formtxtPhone" class="form-control" data-inputmask='"mask": "(999) 999-9999"' data-mask></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <%-- Row 4 --%>
                        <div class="row">
                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                            <div class="filter_item">
                                <asp:Label runat="server" ID="frmSupplierMaintenance_formlblTaxCode" Text="Tax Code" CssClass="filter_label filter_frmlabel--modify"></asp:Label>
                                <asp:TextBox runat="server" ID="frmSupplierMaintenance_formtxtTaxCode" CssClass="form-control"></asp:TextBox>
                            </div>
                         </div>
                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                            <div class="filter_item">
                                <asp:Label runat="server" ID="frmSupplierMaintenance_formlblStatus" Text="Status" CssClass="filter_label filter_frmlabel--modify"></asp:Label>
                                <asp:DropDownList runat="server" ID="ddFormStatus" CssClass="form-control">
                                    <asp:ListItem Selected="True" Text="Active"></asp:ListItem>
                                    <asp:ListItem Text="Inactive"></asp:ListItem>
                                    <asp:ListItem Text="Pending"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                            <div class="filter_item">
                                <asp:Label runat="server" ID="frmSupplierMaintenance_formlblEmail" Text="Email" CssClass="filter_label filter_frmlabel--modify"></asp:Label>
                                <asp:TextBox runat="server" ID="frmSupplierMaintenance_formtxtEmail" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    </fieldset>


                    <%-- Contact Person View --%>
                    <fieldset class="fieldSet mt-4">
                            <legend class="fieldSet_legend">
                                <asp:Label runat="server" ID="fieldSet_ViewContact" Text="Contact Person"></asp:Label>
                            </legend>
                            
                            <%-- Button Add new Contact Person --%>
                            <div class="contact">
                                <asp:Button ID="frmSupplierMaintenance_btnAddContact" runat="server" Text="Add New" CssClass="btn btn-success contact_button" />
                            </div>

                            <asp:Updatepanel runat="server" ID="contactPerson">
                                <ContentTemplate>
                                    <asp:GridView runat="server" ID="grContactPerson"  AutoGenerateColumns="False" CellPadding="2" ForeColor="#333333" ShowHeaderWhenEmpty="True" CssClass="table table-bordered grview"
                                       AllowPaging="true"  DataSourceID="dsPOApproval" >
                                        <HeaderStyle CssClass="table_header" />
                                        <RowStyle CssClass="rowstyle"/>
                                        <Columns>
                                            <asp:TemplateField HeaderText="Default">
                                                <ItemTemplate>
                                                    <asp:CheckBox runat="server" ID="ckCheck" />
                                                </ItemTemplate>
                                                <ItemStyle  CssClass="text-center"/>
                                                <HeaderStyle CssClass="text-center grview_header"/>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Name">
                                                <ItemTemplate>
                                                    <asp:TextBox runat="server" CssClass="form-control"  DataValueField="po_no"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Gender">
                                                <ItemTemplate>
                                                    <asp:DropDownList ID="ddGender" runat="server" CssClass="form-control"  DataValueField="user_id"
                                                        AutoPostBack="True">
                                                    </asp:DropDownList>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Title">
                                                <ItemTemplate>
                                                    <asp:TextBox runat="server" CssClass="form-control"  DataValueField="po_no"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Phone">
                                                <ItemTemplate>
                                                    <asp:TextBox runat="server" CssClass="form-control"  DataValueField="next_approver"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Email">
                                                <ItemTemplate>
                                                    <asp:TextBox runat="server" CssClass="form-control"  DataValueField="next_approver"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    <asp:Label runat="server" Text="Delete" />
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <div class="itemTemplate">
                                                        <asp:ImageButton runat="server" ID="frmSupplierMaintenance_btnContactDelete" ImageUrl="~/Images/trash.png" ToolTip="Delete" CssClass="itemTemplate-icon" />
                                                    </div>
                                                </ItemTemplate>
                                                <ItemStyle CssClass="itemStyle" />
                                                <HeaderStyle HorizontalAlign="Center" CssClass="grview_header"/>
                                            </asp:TemplateField>

                                        </Columns>
                                        <FooterStyle BackColor="#e9ecef" Font-Bold="True" />
                                        <HeaderStyle BackColor="#e9ecef" HorizontalAlign="Center" />
                                        <PagerStyle CssClass="pageStyle" HorizontalAlign="Center" />
                                    </asp:GridView>
                                    
                                </ContentTemplate>
                            </asp:Updatepanel>
                    </fieldset>


                    <%-- Banking View --%>
                    <fieldset class="fieldSet mt-4">
                        <legend class="fieldSet_legend">
                            <asp:Label runat="server" ID="fieldSet_ViewBanking" Text="Banking Account"></asp:Label>  
                        </legend>

                        <%-- Button Add new Banking --%>
                        <div class="banking">
                            <asp:Button ID="frmSupplierMaintenance_btnAddBanking" runat="server" Text="Add New" CssClass="btn btn-success banking_button" />
                        </div>

                        <asp:UpdatePanel ID="bankingView" runat="server">
                            <ContentTemplate>
                                <asp:GridView runat="server" ID="grBanking"  AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" ShowHeaderWhenEmpty="True" CssClass="table table-bordered grview"
                                       AllowPaging="true"  DataSourceID="dsPOApproval" >
                                        <HeaderStyle CssClass="table_header" />
                                        <RowStyle CssClass="rowstyle"/>
                                        <Columns>
                                            <asp:TemplateField HeaderText="Default">
                                                <ItemTemplate>
                                                    <asp:CheckBox runat="server" ID="ckCheck" />
                                                </ItemTemplate>
                                                <ItemStyle  CssClass="text-center"/>
                                                <HeaderStyle CssClass="text-center grview_header"/>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Own Bank Number">
                                                <ItemTemplate>
                                                    <asp:TextBox runat="server" CssClass="form-control"  DataValueField="po_no"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Supplier Bank Number">
                                                <ItemTemplate>
                                                    <asp:TextBox runat="server" CssClass="form-control"  DataValueField="po_no"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Bank Name">
                                                <ItemTemplate>
                                                    <asp:TextBox runat="server" CssClass="form-control"  DataValueField="po_no"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Bank Branch">
                                                <ItemTemplate>
                                                    <asp:TextBox runat="server" CssClass="form-control"  DataValueField="next_approver"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Account Holder">
                                                <ItemTemplate>
                                                    <asp:TextBox runat="server" CssClass="form-control"  DataValueField="next_approver"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Bank GL Account">
                                                <ItemTemplate>
                                                    <asp:TextBox runat="server" CssClass="form-control"  DataValueField="next_approver"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Status">
                                                <ItemTemplate>
                                                    <asp:DropDownList runat="server" CssClass="form-control">
                                                        <asp:ListItem Selected="true" Text="Active"></asp:ListItem>
                                                        <asp:ListItem Text="Inactive"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Note">
                                                <ItemTemplate>
                                                    <asp:TextBox runat="server" CssClass="form-control"  DataValueField="next_approver"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    <asp:Label runat="server" Text="Delete" />
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <div class="itemTemplate">
                                                        <asp:ImageButton runat="server" ID="frmSupplierMaintenance_btnContactDelete" ImageUrl="~/Images/trash.png" ToolTip="Delete" CssClass="itemTemplate-icon" />
                                                    </div>
                                                </ItemTemplate>
                                                <ItemStyle CssClass="itemStyle" />
                                                <HeaderStyle HorizontalAlign="Center" CssClass="grview_header"/>
                                            </asp:TemplateField>

                                        </Columns>
                                        <FooterStyle BackColor="#e9ecef" Font-Bold="True" />
                                        <HeaderStyle BackColor="#e9ecef" HorizontalAlign="Center" />
                                        <PagerStyle CssClass="pageStyle" HorizontalAlign="Center" />
                                    </asp:GridView>
                                    
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </fieldset>


                    <%-- Note Area --%>
                    <fieldset class="fieldSet mt-4">
                        <legend class="fieldSet_legend">
                           <asp:Label runat="server" ID="fieldSet_Note" Text="Note"></asp:Label>
                        </legend>
                        <textarea id="frmSupplierMaintenance_txtArea" cols="20" rows="5" class="w-100"></textarea>
                    </fieldset>

                    <%-- Action : Save && Canncel --%>
                    <div class="text-right mt-4">
                        <asp:Button ID="frmSupplierMaintenance_btnSave" runat="server" Text="Save" CssClass="btn bg-gradient-success action_button" />
                        <asp:Button ID="frmSupplierMaintenance_btnCancel" runat="server" Text="Cancel" CssClass="btn btn-outline-dark action_button" />
                    </div>
                </div>
            </div>
        </div>
    </div>



    <%-- Import/Upload Supplier --%>
    <div class="row row-cols-1 row-cols-sm-1 row-cols-md-2 justify-content-center supplier_import" id="SupplierImport">
            <div class="col">
                <div id="frmDropFile" class="box">
                    <div class="text-center">
                        <asp:Label runat="server" ID="frmSupplierMaintenance_lblDesc" class="box_description">Drag and Drop to upload data file (*.csv, *.xlsx) or import file from your computer</asp:Label>
                        <span class="box_icon"><i class="fa fa-cloud-upload-alt"></i></span>
                        <asp:FileUpload ID="fileUpload" runat="server" CssClass="box_import"/>
                    </div>
                </div>
                <hr />
                <div class="note">
                    <asp:Label runat="server" ID="frmSupplierMaintenance_lblNote" class="note_span mr-2">Note :</asp:Label>
                    <asp:Label runat="server" ID="frmSupplierMaintenance_lblComment" class="note_desc">This function allows import of data list from Excel or CSV file.</asp:Label>
                    <asp:Button runat="server" ID="frmSupplierMaintenance_link" class="note_link" Text="Template here"/>
                </div>
                <div class="mt-3 text-md-right">
                    <asp:Button ID="frmSupplierMaintenance_btnImport" runat="server" CssClass="btn bg-gradient-success rowButton-modal" Text="Upload"/>
                </div>
            </div>
    </div>

    <%-- Modal popup confirm update status --%>
    <div class="modal fade" id="SupplierModalUpdate" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-md">
            <div class="modal-content card-border">
                <div class="modal-detail">
                    <div class="modal-icon">
                        <i class="fas fa-exclamation-triangle"></i>
                    </div>
                    <div class="modal-desc">
                        <asp:Label runat="server" ID="lblUpdateTitle" Text="Change Status" CssClass="modal-text1"></asp:Label>
                        <div class="mt-1">
                            <asp:Label runat="server" ID="lblUpdateDesc" Text="Are you sure you want to change the staus of item ?" CssClass="modal-text2" ></asp:Label>
                        </div>
                    </div>
                </div>
                <div class="modal-action">
                    <asp:Button runat="server" ID="btnUpdCanncel" CssClass="btn btn-outline-dark mr-2" Text="Canncel"/>
                    <asp:Button runat="server" ID="btnUpdateStatus" CssClass="btn bg-gradient-success" Text="Yes"/>
                </div>
            </div>
        </div>
    </div>

    <%-- Modal popup confirm delete record in browse --%>
    <div class="modal fade" id="SupplierModalDelete" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-md">
            <div class="modal-content card-border">
                <div class="modal-detail">
                    <div class="modal-icon">
                        <i class="fas fa-exclamation-triangle"></i>
                    </div>
                    <div class="modal-desc">
                        <asp:Label runat="server" ID="lblDeleteTitle" Text="Delete Supplier" CssClass="modal-text1"></asp:Label>
                        <div class="mt-1">
                            <asp:Label runat="server" ID="lblDeleteDesc" Text="Are you sure you want to delete supplier ?" CssClass="modal-text2" ></asp:Label>
                        </div>
                    </div>
                </div>
                <div class="modal-action">
                    <asp:Button runat="server" ID="btnDltCanncel" CssClass="btn btn-outline-dark mr-2" Text="Canncel"/>
                    <asp:Button runat="server" ID="btnDeleteStatus" CssClass="btn bg-gradient-success" Text="Yes"/>
                </div>
            </div>
        </div>
    </div>

    <%-- Add Data Source --%>
    <asp:SqlDataSource ID="dsPOApproval" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT TOP(2) po_no,amount,create_date,due_date,next_approver,status FROM vPMS_po_approval_browse"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsRowPerPage" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT value FROM TERP_row_per_page ORDER BY value"></asp:SqlDataSource>

    <%-- Call Script --%>
    <script src="/terp/Theme/plugins/jquery/jquery-3.6.0.min.js"></script>
    <script src="/terp/Libs/ModalMessage.js"></script>
    <script src="../../Libs/CountEmailJS.js"></script>

    <script>
        //Money Euro
        $('[data-mask]').inputmask()
    </script>

</asp:Content>
