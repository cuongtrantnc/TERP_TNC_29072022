<%@ Page Title="" Language="C#" MasterPageFile="~/TERP.Master" AutoEventWireup="true" CodeBehind="frmSupplierEvaluation.aspx.cs" Inherits="TERP.Forms.PMS.frmSupplierEvaluation" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TERPContentPlaceHolder" runat="server">
    <link href="../../Style/Browse/BrowseStyle.css" rel="stylesheet" />
    <link href="../../Style/PMS/frmSupplierEvaluation.css" rel="stylesheet" />

    <%-- Title Menu --%>
    <div class="title-padding header-menu" style="width: 100%">
        <asp:Label runat="server" ID="frmSupplierEvaluation_lblTitle" Text="Supplier Evaluate" CssClass="title_label"></asp:Label>

    <%-- Action : Create new && Import new --%>
        <div class="action">
            <span id="btnGoBack" class="action_button-hide">
                <asp:Button runat="server" ID="frmSupplierEvaluation_btnGoBack" CssClass="btn btn-outline-success action_button" Text="Go Back" OnClick="frmSupplierEvaluation_btnGoBack_Click" /></span>
            <span id="btnCreateNew">
                <asp:Button runat="server" ID="frmSupplierEvaluation_btnCreateNew" CssClass="btn bg-gradient-success action_button" Text="Create Criteria" OnClick="frmSupplierEvaluation_btnCreateNew_Click" /></span>
        </div>
    </div>

    <%-- Filter and View  --%>
    <div class="row " id="SupplierEvaluationFilter">
        <div class="col-md-12">
            <div class="card card-border card-boxshadow">
                <div class="card-body">
                    <%--Condition Filter--%>
                    <fieldset class="fieldSet">
                        <legend class="fieldSet_legend">
                            <asp:Label runat="server" ID="fieldSet_Filter" Text="Filter"></asp:Label>
                        </legend>
                        <div class="row">
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmSupplierEvaluation_lblCode" Text="Code" CssClass="filter_label filter_label--modify"></asp:Label>
                                    <asp:TextBox runat="server" ID="frmSupplierEvaluation_txtCode" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmSupplierEvaluation_lblEffDate" Text="Effective Date" CssClass="filter_label filter_labelselect2"></asp:Label>
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                <i class="far fa-calendar-alt"></i>
                                            </span>
                                        </div>
                                        <asp:TextBox ID="frmSupplierEvaluation_txtEffDate" runat="server" CssClass="form-control" autocomplete="off" placeholder="MM/dd/yyyy"></asp:TextBox>
                                        <ajaxtoolkit:calendarextender id="frmSupplierEvaluation_txtEffDate_CalendarExtender" runat="server" behaviorid="frmSupplierEvaluation_txtEffDate_CalendarExtender" targetcontrolid="frmSupplierEvaluation_txtEffDate" />
                                    </div>
                                </div>
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmSupplierEvaluation_lblCategory" Text="Category" CssClass="filter_label filter_label--modify"></asp:Label>
                                    <asp:DropDownList ID="ddCategory" runat="server" CssClass="form-control">
                                        <asp:ListItem Selected="true" Text="Initial Evaluate"></asp:ListItem>
                                        <asp:ListItem Text="Annual Evaluate"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmSupplierEvaluation_lblItem" Text="Item" CssClass="filter_label filter_labelselect2"></asp:Label>
                                    <asp:DropDownList ID="ddItem" runat="server" CssClass="form-control select2" Style="width: 100%;">
                                    </asp:DropDownList>
                                </div>
                                <div class="filter_item">
                                    <asp:Label ID="frmSupplierEvaluation_lblSupplier" runat="server" Text="Supplier" CssClass="filter_label filter_labelselect2"></asp:Label>
                                    <asp:DropDownList ID="ddSupplier" runat="server" CssClass="form-control select2" Style="width: 100%;">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-4">
                                <div class="filter_action">
                                    <asp:Button runat="server" ID="frmSupplierEvaluation_filterBtnSearch" Text="Search" CssClass="btn bg-gradient-success filter_button filter_button-modifile" />
                                    <asp:Button runat="server" ID="frmSupplierEvaluation_filterBtnClear" Text="Clear" CssClass="btn btn-outline-success filter_button filter_button-modifile" />
                                </div>
                            </div>
                        </div>
                        <%-- End Condition Filter --%>
                    </fieldset>


                    <%-- Paging --%>
                    <div class="paging">
                        <asp:Label ID="frmSupplierEvaluation_lblRecordPage" runat="server" Text="Record per Page" CssClass="mr-2"></asp:Label>
                        <asp:DropDownList ID="ddRecordPerPage" runat="server" CssClass="paging_record" DataSourceID="dsRowPerPage" DataTextField="value" DataValueField="value" AutoPostBack="True" />
                    </div>

                    <%--Supplier GridView--%>
                    <asp:GridView runat="server" ID="grSupplierEvaluation" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" ShowHeaderWhenEmpty="True" CssClass="table table-bordered mt-2 grview grview-browse"
                        AllowPaging="True" DataSourceID="dsPOApproval">
                        <HeaderStyle CssClass="table_header" />
                        <RowStyle CssClass="rowstyle" />
                        <Columns>
                            <asp:BoundField DataField="" HeaderText="Code" HeaderStyle-CssClass="grview_header" ItemStyle-HorizontalAlign="Center" />
                            <asp:BoundField DataField="" HeaderText="Supplier" />
                            <asp:BoundField DataField="" HeaderText="Category" />
                            <asp:BoundField DataField="" HeaderText="Item" />
                            <asp:BoundField DataField="" HeaderText="Effective Date" />
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label runat="server" Text="Edit" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <div class="itemTemplate">
                                        <asp:ImageButton runat="server" ID="btnEditCriteriaMaint" ImageUrl="~/Images/edit.png" ToolTip="Edit" CssClass="itemTemplate-icon" OnClick="btnEditSupplierEvaluation_Click" />
                                    </div>
                                </ItemTemplate>
                                <ItemStyle CssClass="itemStyle" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label runat="server" Text="Print" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <div class="itemTemplate">
                                        <asp:ImageButton runat="server" ID="btnPrintSupplierEvaluation" ImageUrl="~/Images/print.png" ToolTip="Click to preview" CssClass="itemTemplate-icon" OnClick="btnPrintSupplierEvaluation_Click"/>
                                    </div>
                                </ItemTemplate>
                                <ItemStyle CssClass="itemStyle" />
                                <HeaderStyle HorizontalAlign="Center" CssClass="grview_header" />
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
    <div class="row supplier_form" id="SupplierEvaluationForm">
        <div class="col-md-12">
            <div class="card card-border card-boxshadow">
                <div class="card-body">

                    <%-- Form input --%>
                    <fieldset class="fieldSet">
                        <legend class="fieldSet_legend">
                            <asp:Label runat="server" ID="fieldSet_Form" Text="Supplier Evaluation Information"></asp:Label>
                        </legend>
                        <%-- Row 1 --%>
                        <div class="row">
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmSupplierEvaluation_formlblCode" Text="Code" CssClass="filter_label filter_frmlabel--modify"></asp:Label>
                                    <asp:TextBox runat="server" ID="frmSupplierEvaluation_formtxtCode" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                                <div class="filter_validation">
                                    <div class="filter_item">
                                        <asp:Label runat="server" ID="frmSupplierEvaluation_formlblSupplier" Text="Supplier" CssClass="filter_label filter_frmlabelselect2"></asp:Label>
                                        <asp:DropDownList ID="ddFormSupplier" runat="server" CssClass="form-control select2" Style="width: 100%;">
                                            <asp:ListItem Text="Value 1"></asp:ListItem>
                                            <asp:ListItem Text="Value 2"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%-- Row 2 --%>
                        <div class="row">
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                                <div class="filter_item">
                                    <asp:Label ID="frmSupplierEvaluation_formlblEffDate" runat="server" Text="Effective Date" CssClass="filter_label filter_frmlabelselect2"></asp:Label>
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                <i class="far fa-calendar-alt"></i>
                                            </span>
                                        </div>
                                        <asp:TextBox ID="frmSupplierEvaluation_formtxtEffDate" runat="server" CssClass="form-control" autocomplete="off" placeholder="MM/dd/yyyy"></asp:TextBox>
                                        <ajaxtoolkit:calendarextender id="frmSupplierEvaluation_formtxtEffDate_CalendarExtender" runat="server" behaviorid="frmSupplierEvaluation_formtxtEffDate_CalendarExtender" targetcontrolid="frmSupplierEvaluation_formtxtEffDate" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmSupplierEvaluation_formlblCategory" Text="Category" CssClass="filter_label filter_frmlabel--modify"></asp:Label>
                                    <asp:DropDownList runat="server" ID="ddFormCategory" CssClass="form-control">
                                        <asp:ListItem Selected="true" Text="Initial Evaluate"></asp:ListItem>
                                        <asp:ListItem Text="Annual Evaluate"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>

                        <%-- Row 3 --%>
                        <div class="row">
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                                <div class="filter_validation">
                                    <div class="filter_item">
                                        <asp:Label runat="server" ID="frmSupplierEvaluation_formlblItem" Text="Item" CssClass="filter_label filter_frmlabelselect2"></asp:Label>
                                        <asp:DropDownList runat="server" ID="ddFormItem" CssClass="form-control select2 validation-mod" Style="width: 100%;" AppendDataBoundItems="true">
                                            <asp:ListItem Value="">Please Select</asp:ListItem>
                                            <asp:ListItem Text="Value 1"></asp:ListItem>
                                            <asp:ListItem Text="Value 2"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
                                <div class="filter_item">
                                    <asp:Label runat="server" ID="frmSupplierEvaluation_formlblComment" Text="Comment" CssClass="filter_label filter_frmlabel--modify"></asp:Label>
                                    <asp:TextBox runat="server" ID="frmSupplierEvaluation_formtxtComment" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <%-- Form gridview --%>
                        <hr>
                        <div class="banking">
                            <asp:Button ID="frmSupplierEvaluation_btnAddSupplierEvaluation" runat="server" Text="Add New" CssClass="btn btn-success banking_button" />
                        </div>

                        <asp:UpdatePanel ID="SupplierEvaluationView" runat="server">
                            <ContentTemplate>
                                <asp:GridView runat="server" ID="grSupplierEvaluationCreate" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" ShowHeaderWhenEmpty="True" CssClass="table table-bordered grview grview-create"
                                    AllowPaging="true" DataSourceID="dsPOApproval">
                                    <HeaderStyle CssClass="table_header" />
                                    <RowStyle CssClass="rowstyle" />
                                    <Columns>

                                        <asp:TemplateField HeaderText="Line">
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" CssClass="form-control" DataValueField="po_no"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Content">
                                            <ItemTemplate>
                                                <asp:DropDownList runat="server" CssClass="form-control select2" Style="width: 100%;">
                                                </asp:DropDownList>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Name">
                                            <ItemTemplate>
                                                <asp:DropDownList runat="server" CssClass="form-control select2" Style="width: 100%;">
                                                </asp:DropDownList>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Scores">
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" CssClass="form-control" DataValueField="next_approver"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Delete">
                                            <ItemTemplate>
                                                <asp:Button ID="frmSupplierEvaluation_btnSupplierValuationDelete" runat="server" Text="Delete" CssClass="btn btn-danger grview_ctldelete" />
                                            </ItemTemplate>
                                            <ItemStyle CssClass="text-center" />
                                        </asp:TemplateField>
                                    </Columns>
                                    <FooterStyle BackColor="#e9ecef" Font-Bold="True" />
                                    <HeaderStyle BackColor="#e9ecef" HorizontalAlign="Center" />
                                    <PagerStyle CssClass="pageStyle" HorizontalAlign="Center" />
                                </asp:GridView>

                            </ContentTemplate>
                        </asp:UpdatePanel>

                    </fieldset>

                    <%-- Action : Save && Canncel --%>
                    <div class="text-right mt-4">
                        <span id="btnsave">
                            <asp:Button ID="frmCriteriaSupplierPerformanceMaint_btnSave" runat="server" Text="Save" CssClass="btn bg-gradient-success action_button action_button--modify" /></span>
                        <asp:Button ID="frmCriteriaSupplierPerformanceMaint_btnCancel" runat="server" Text="Cancel" CssClass="btn btn-outline-dark action_button" />
                    </div>
                </div>
            </div>
        </div>
    </div>


    <%-- Add Data Source --%>
    <asp:SqlDataSource ID="dsPOApproval" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT TOP(3) po_no,amount,create_date,due_date,next_approver,status FROM vPMS_po_approval_browse"></asp:SqlDataSource>

    <asp:SqlDataSource ID="dsRowPerPage" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT value FROM TERP_row_per_page ORDER BY value"></asp:SqlDataSource>

    <%-- Call Script --%>
    <script src="/terp/Theme/plugins/jquery/jquery-3.6.0.min.js"></script>
    <script src="/terp/Libs/ModalMessage.js"></script>
    <script src="../../Libs/CountEmailJS.js"></script>

    <script>
        $(function () {
            $('.select2').select2()
        })
    </script>
    <script>

         $(function () {

             $('#btnsave').click(function () {
                  $('#quickForm').validate({
                  rules: {
                                    
                                      <%= ddFormSupplier.UniqueID %>: {
                                            required: true
                                      },
                                      <%= ddFormItem.UniqueID %>: {
                                            required: true
                                      },
                    },

                  messages: {
                                  
                                      <%= ddFormSupplier.UniqueID %>: {
                                            required: "Supplier code can't be null",
                                      },
                                      <%= ddFormItem.UniqueID %>: {
                                            required: "Item code order can't be null",
                                      },
                     },
		
                    errorElement: 'span',
                    errorPlacement: function (error, element) {
                        error.addClass('invalid-feedback-mod');
                        element.closest('.filter_validation').append(error);
                    },
                    highlight: function (element, errorClass, validClass) {
                        let nextSibling = element.nextElementSibling;
                        let firstChildOfSibling = nextSibling.firstElementChild;
                        let firstEle = firstChildOfSibling.firstElementChild;
                        $(firstEle).addClass('dr-validation');
                    },
                    unhighlight: function (element, errorClass, validClass) {
                        let nextSibling = element.nextElementSibling;
                        let firstChildOfSibling = nextSibling.firstElementChild;
                        let firstEle = firstChildOfSibling.firstElementChild;
                        $(firstEle).removeClass('dr-validation');
                    }

              });
             });

            
            });
         
    </script>
</asp:Content>
