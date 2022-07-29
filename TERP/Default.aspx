<%@ Page MasterPageFile="~/TERP.Master" Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TERP.Default" %>

<asp:Content ContentPlaceHolderID="TERPContentPlaceHolder" runat="server">
    <%--Add Style css--%>
    <link href="Style/Chart/Default.min.css" rel="stylesheet" />
    <link href="Style/Chart/chartList.min.css" rel="stylesheet" />

    <%-- Filter date --%>
    <div class="option">
        <div class="row">
            <div class="col-xs-12 col-md-3">
                <div class="option-item">
                    <asp:Label ID="Default_lblOptionLabel" runat="server" Text="Time: "></asp:Label>
                    <asp:DropDownList ID="Default_DrOption" runat="server" CssClass="form-control mt-2" AutoPostBack="True" OnSelectedIndexChanged="Selection_Change">
                        <asp:ListItem Value="0" Enabled="true" Text="All"></asp:ListItem>
                        <asp:ListItem Value="1"  Text="Last 7 days"></asp:ListItem>
                        <asp:ListItem Value="2" Text="This Month"></asp:ListItem>
                        <asp:ListItem Value="3" Text="This Quarter"></asp:ListItem>
                        <asp:ListItem Value="4" Text="This Year"></asp:ListItem>
                    </asp:DropDownList>
                </div>
             </div>
        </div>
    </div>

    <!-- Small boxes (Stat box) -->
    <div class="category">
        <ul class="category__list">
            <li class="category__item category__purple">
                <div class="category__card">
                    <div class="category__header">
                        <div class="category__icon category__icon--left category__purple--left ">
                            <i class="fas fa-receipt"></i>
                        </div>
                    </div>
                    <div class="category__detail">
                        <asp:LinkButton ID="Default_linkPRApproved" runat="server" CssClass="category__link" OnClick="Default_linkPRApproved_Click">
                            <asp:Label ID="Default_txtPRApproved" runat="server" CssClass="category__text" />
                        </asp:LinkButton>
                        
                        <asp:LinkButton ID="Default_linkPRRejected" runat="server" CssClass="category__link" OnClick="Default_linkPRRejected_Click">
                            <asp:Label ID="Default_txtPRRejected" runat="server" CssClass="category__text" />
                        </asp:LinkButton>

                    </div>
                    <div class="category__title">
                        <asp:Label ID="Default_lblPRApproved" runat="server" CssClass="category__purple--typo" Text="PR Approved"/>
                        <asp:Label ID="Default_lblPRRejected" runat="server" CssClass="category__purple--typo" Text="PR Rejected"/>
                    </div>
                </div>
            </li>

            <li class="category__item category__blue">
                <div class="category__card">
                    <div class="category__header">
                        <div class="category__icon category__icon--left category__blue--left ">
                            <i class="fas fa-dolly-flatbed"></i>
                        </div>
                    </div>
                    <div class="category__detail">
                        <asp:LinkButton ID="Default_linkPOApproved" runat="server" CssClass="category__link" OnClick="Default_linkPOApproved_Click">
                            <asp:Label ID="Default_txtPOApproved" runat="server" CssClass="category__text" />
                        </asp:LinkButton>
                        
                        <asp:LinkButton ID="Default_linkPORejected" runat="server" CssClass="category__link" OnClick="Default_linkPORejected_Click">
                            <asp:Label ID="Default_txtPORejected" runat="server" CssClass="category__text" />
                        </asp:LinkButton>

                    </div>
                    <div class="category__title">
                        <asp:Label ID="Default_lblPOApproved" runat="server" CssClass="category__blue--typo" Text="PO Approved"/>
                        <asp:Label ID="Default_lblPORejected" runat="server" CssClass="category__blue--typo" Text="PO Rejected"/>
                    </div>
                </div>
            </li>

            <li class="category__item category__green">
                <div class="category__card">
                    <div class="category__header">
                        <div class="category__icon category__icon--left category__green--left ">
                            <i class="far fa-chart-bar"></i>
                        </div>
                    </div>
                    <div class="category__detail">
                        <asp:LinkButton ID="Default_linkPRUnapproved" runat="server" CssClass="category__link" OnClick="Default_linkPRUnapproved_Click">
                            <asp:Label ID="Default_txtPRUnapproved" runat="server" CssClass="category__text" />
                        </asp:LinkButton>

                        <asp:LinkButton ID="Default_linkPROnProcess" runat="server" CssClass="category__link" OnClick="Default_linkPROnProcess_Click">
                            <asp:Label ID="Default_txtPROnProcess" runat="server" CssClass="category__text" />
                        </asp:LinkButton>
                    </div>
                    <div class="category__title">
                        <asp:Label ID="Default_lblPRUnapproved" runat="server" CssClass="category__green--typo" Text="PR Unapproved"/>
                        <asp:Label ID="Default_lblPROnProcess" runat="server" CssClass="category__green--typo" Text="PR OnProcess"/>
                    </div>
                </div>
            </li>

            <li class="category__item category__orange">
                <div class="category__card">
                    <div class="category__header">
                        <div class="category__icon category__icon--left category__orange--left ">
                            <i class="fas fa-users"></i>
                        </div>
                    </div>
                    <div class="category__detail">
                        <asp:LinkButton ID="Default_linkPOUnapproved" runat="server" CssClass="category__link" OnClick="Default_linkPOUnapproved_Click">
                            <asp:Label ID="Default_txtPOUnapproved" runat="server" CssClass="category__text category__orange--total" />
                        </asp:LinkButton>

                        <asp:LinkButton ID="Default_linkPOOnProcess" runat="server" CssClass="category__link" OnClick="Default_linkPOOnProcess_Click">
                            <asp:Label ID="Default_txtPOOnProcess" runat="server" CssClass="category__text category__orange--total" />
                        </asp:LinkButton>
                    </div>
                    <div class="category__title">
                        <asp:Label ID="Default_lblPOUnapproved" runat="server" CssClass="category__orange--typo" Text="PO Unapproved"/>
                        <asp:Label ID="Default_lblPOOnProcess" runat="server" CssClass="category__orange--typo" Text="PO OnProcess"/>
                    </div>
                </div>
            </li>

        </ul>
        <asp:SqlDataSource ID="dsTemp" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>" SelectCommand="SELECT * FROM"></asp:SqlDataSource>
    </div>
    

    <%---------------Chart------------------%>
    <div class="row charts">
        <div class="col-xl-6 col-md-12">
            <div class="card card-danger charts__item">
                <div class="card-header charts__item--header">
                    <h3 id="Default_titlePOApprovalStt" class="card-title">PO Approval Status</h3>

                    <div class="card-tools">
                        <button type="button" class="btn btn-tool" data-card-widget="collapse">
                            <i class="fas fa-minus"></i>
                        </button>
                        <button type="button" class="btn btn-tool" data-card-widget="remove">
                            <i class="fas fa-times"></i>
                        </button>
                        <button type="button" class="btn btn-tool" data-toggle="modal" data-target="#pieModalChart">
                            <i class="fas fa-search-plus"></i>
                        </button>
                    </div>
                </div>
                <div class="card-body">
                    <canvas id="pieChart" style="min-height: 250px; height: 250px; max-height: 250px; max-width: 100%;"></canvas>
                    <div class="chart_content">
                        <asp:Label ID="Default_lbTotalUnApproval" runat="server" Text="Total Unapproved:" CssClass="modal-title h5"></asp:Label>
                        <asp:Label ID="Default_lbTotalUnApprovalValue" runat="server" Text="0" CssClass="modal-title h5"></asp:Label>
                    </div>
                </div>

                <%--chart Modal--%>
                <div class="modal fade bd-example-modal-lg" id="pieModalChart" tabindex="-1" role="dialog" aria-labelledby="pieModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg" style="max-width: 940px">
                        <div class="modal-content">
                            <div class="modal-header" style="background-color: #007bff; color: white">
                                <h5 class="modal-title" id="Default_pieModalLabel">PO Approval Status</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color: white">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="chart">
                                    <canvas id="pieChartModal" style="min-height: 380px; height: 250px; max-height: 400px; max-width: 100%;"></canvas>
                                    <div class="chart_content">
                                        <asp:Label ID="Default_lbTotalUnApprovalModal" runat="server" Text="Total Unapproved:" CssClass="modal-title h5"></asp:Label>
                                        <asp:Label ID="Default_lbTotalUnApprovalValueModal" runat="server" Text="0" CssClass="modal-title h5"></asp:Label>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" id="Default_btnModalClose" class="btn btn-primary" data-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-6 col-md-12">
            <div class="card card-info charts__item">
                <div class="card-header charts__item--header">
                    <h3 id="Default_titleNumberOfPO" class="card-title">Number Of Purchase Order</h3>

                    <div class="card-tools">
                        <button type="button" class="btn btn-tool" data-card-widget="collapse">
                            <i class="fas fa-minus"></i>
                        </button>
                        <button type="button" class="btn btn-tool" data-card-widget="remove">
                            <i class="fas fa-times"></i>
                        </button>
                        <button type="button" class="btn btn-tool" data-toggle="modal" data-target="#lineModalChart">
                            <i class="fas fa-search-plus"></i>
                        </button>
                    </div>
                </div>
                <div class="card-body">
                    <div class="chart">
                        <canvas id="lineChart" style="min-height: 280px; height: 250px; max-height: 250px; max-width: 100%;"></canvas>
                    </div>
                </div>

                <%--chart Modal--%>
                <div class="modal fade bd-example-modal-lg" id="lineModalChart" tabindex="-1" role="dialog" aria-labelledby="lineModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg" style="max-width: 940px">
                        <div class="modal-content">
                            <div class="modal-header" style="background-color: #007bff; color: white">
                                <h5 class="modal-title" id="Default_lineModalLabel">Number Of Purchase Order</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color: white">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="chart">
                                    <canvas id="lineChartModal" style="min-height: 300px; height: 250px; max-height: 700px; max-width: 100%;"></canvas>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" id="Default_btnModalPOClose" class="btn btn-primary" data-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-6 col-md-12">
            <div class="card card-info charts__item">
                <div class="card-header charts__item--header">
                    <h3 id="Default_titleNumberOfPOBar" class="card-title">Number Of Purchase Order Bar Chart</h3>

                    <div class="card-tools">
                        <button type="button" class="btn btn-tool" data-card-widget="collapse">
                            <i class="fas fa-minus"></i>
                        </button>
                        <button type="button" class="btn btn-tool" data-card-widget="remove">
                            <i class="fas fa-times"></i>
                        </button>
                        <button type="button" class="btn btn-tool" data-toggle="modal" data-target="#barModalChart">
                            <i class="fas fa-search-plus"></i>
                        </button>
                    </div>
                </div>
                <div class="card-body">
                    <div class="chart">
                        <canvas id="barChart" style="min-height: 280px; height: 250px; max-height: 250px; max-width: 100%;"></canvas>
                    </div>
                </div>

                <%--chart Modal--%>
                <div class="modal fade bd-example-modal-lg" id="barModalChart" tabindex="-1" role="dialog" aria-labelledby="barModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg" style="max-width: 940px">
                        <div class="modal-content">
                            <div class="modal-header" style="background-color: #007bff; color: white">
                                <h5 class="modal-title" id="Default_barModalLabel">Number Of Purchase Order Bar Chart</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color: white">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="chart">
                                    <canvas id="barChartModal" style="min-height: 300px; height: 250px; max-height: 700px; max-width: 100%;"></canvas>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <%---------------End Chart------------------%>

    <asp:SqlDataSource ID="dsModule" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT module_id,module_prefix + ': ' + module_name as module_name FROM TERP_module WHERE enable=1 ORDER BY sort">
    </asp:SqlDataSource>
    
    <script src="/TERP/Chart/pmsChart.js"></script>

    <script src="/TERP/Theme/plugins/jquery/jquery.min.js"></script>
    <script src="/TERP/Theme/plugins/jquery-ui/jquery-ui.min.js"></script>
    <script src="/TERP/Theme/plugins/chart.js/Chart.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@0.7.0"></script>
    <script src="/TERP/Libs/CountEmailJS.js"></script>
    <script src="Libs/CountEmailJS.js"></script>
</asp:Content>

