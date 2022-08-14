<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TERP.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>TERP System</title>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Google Font: Source Sans Pro -->
    <%--<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback" />--%>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,300;0,400;0,500;0,700;1,400&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="/TERP/Theme/plugins/fontawesome-free/css/all.min.css" />
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" />
    <!-- Tempusdominus Bootstrap 4 -->
    <link rel="stylesheet" href="/TERP/Theme/plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css" />
    <!-- iCheck -->
    <link rel="stylesheet" href="/TERP/Theme/plugins/icheck-bootstrap/icheck-bootstrap.min.css" />
    <!-- JQVMap -->
    <link rel="stylesheet" href="/TERP/Theme/plugins/jqvmap/jqvmap.min.css" />
    <!-- Theme style -->
    <%--<link rel="stylesheet" href="/TERP/Theme/dist/css/adminlte.min.css" />--%>
    <link rel="stylesheet" href="/TERP/Theme/dist/css/adminlte.css" />
    <!-- overlayScrollbars -->
    <link rel="stylesheet" href="/TERP/Theme/plugins/overlayScrollbars/css/OverlayScrollbars.min.css" />
    <!-- Daterange picker -->
    <link rel="stylesheet" href="/TERP/Theme/plugins/daterangepicker/daterangepicker.css" />
    <!-- summernote -->
    <link rel="stylesheet" href="/TERP/Theme/plugins/summernote/summernote-bs4.min.css" />

    <link rel="stylesheet" href="/TERP/Theme/plugins/bootstrap/js/bootstrap.min.js" />
    <!-- Toastr -->
    <link rel="stylesheet" href="/TERP/Theme/plugins/toastr/toastr.css" />
    <link href="/TERP/Style/LoginForm/styleLogin.css" rel="stylesheet" />
</head>

<!-- jQuery -->
<script src="/TERP/Theme/plugins/jquery/jquery.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="/TERP/Theme/plugins/jquery-ui/jquery-ui.min.js"></script>

<script src="/TERP/Theme/plugins/jquery-validation/jquery.validate.min.js"></script>
<script src="/TERP/Theme/plugins/jquery-validation/additional-methods.min.js"></script>
<!-- Toastr -->
<script src="/TERP/Theme/plugins/toastr/toastr.min.js"></script>

<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
    $.widget.bridge('uibutton', $.ui.button)
</script>

<!-- Bootstrap 4 -->
<script src="/TERP/Theme/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- ChartJS -->
<script src="/TERP/Theme/plugins/chart.js/Chart.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-adapter-date-fns/dist/chartjs-adapter-date-fns.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@0.7.0"></script>
<%-- <script src="Theme/plugins/chartjs-plugin-annotation-0.5.7/chartjs-plugin-annotation.min.js"></script>--%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/chartjs-plugin-annotation/0.5.7/chartjs-plugin-annotation.min.js"></script>
<!-- Sparkline -->
<script src="/TERP/Theme/plugins/sparklines/sparkline.js"></script>
<!-- JQVMap -->
<script src="/TERP/Theme/plugins/jqvmap/jquery.vmap.min.js"></script>
<script src="/TERP/Theme/plugins/jqvmap/maps/jquery.vmap.usa.js"></script>
<!-- jQuery Knob Chart -->
<script src="/TERP/Theme/plugins/jquery-knob/jquery.knob.min.js"></script>
<!-- daterangepicker -->
<script src="/TERP/Theme/plugins/moment/moment.min.js"></script>
<script src="/TERP/Theme/plugins/daterangepicker/daterangepicker.js"></script>
<!-- Tempusdominus Bootstrap 4 -->
<script src="/TERP/Theme/plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
<!-- Summernote -->
<script src="/TERP/Theme/plugins/summernote/summernote-bs4.min.js"></script>
<!-- overlayScrollbars -->
<script src="/TERP/Theme/plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
<!-- AdminLTE App -->
<script src="/TERP/Theme/dist/js/adminlte.js"></script>
<!-- AdminLTE for demo purposes -->
<%--<script src="/TERP/Theme/dist/js/demo.js"></script>--%>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<%--<script src="/TERP/Theme/dist/js/pages/dashboard.js"></script>--%>

<%--<script src="/TERP/Theme/plugins/jquery/jquery.min.js"></script>--%>
<%--<script src="/TERP/Theme/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>--%>
<script src="/TERP/Theme/plugins/toastr/toastr.min.js"></script>
<script src="/TERP/Libs/Message.js"></script>
<script src="/TERP/Libs/ModalMessage.js"></script>

<body>

    <form id="form2" runat="server">
        <div class="container container-login">
            <div class="row justify-content-center">
                <div class="col-md-12 col-lg-10">
                    <div class="wrap d-md-flex">
                        <div class="text-wrap p-4 p-lg-5 text-center d-flex align-items-center order-md-last">
                            <div class="text w-100">
                                <img src="Images/logo-ThinkNext.png" class="img_logo" />
                                <%--<h2>Welcome to login</h2>--%>
                                <p>
                                    <asp:Label runat="server" CssClass="label" ID="lblMessage" for="name" Text="Sign in with QR Code"></asp:Label>
                                </p>
                                <img src="Images/qr.png" />
                            </div>
                        </div>
                        <div class="login-wrap p-4 p-lg-5">
                            <div class="d-flex">
                                <div class="w-100">
                                    <h3 class="mb-4 text-center">
                                        <asp:Label runat="server" ID="lblTitle" for="name" Text="Sign In"></asp:Label>
                                    </h3>
                                </div>
                            </div>
                            <div class="signin-form">
                                <div class="form-group mb-3">
                                    <asp:Label runat="server" CssClass="label" ID="lblModule" for="name" Text="Module"></asp:Label>
                                    <asp:DropDownList runat="server" CssClass="form-control" placeholder="Module" DataSourceID="dsModule" DataTextField="module_name" DataValueField="module_id"></asp:DropDownList>
                                    <%--<input type="text" class="form-control" placeholder="Username">--%>
                                </div>
                                <div class="form-group mb-3">
                                    <asp:Label runat="server" CssClass="label" ID="lblUserName" for="name" Text="Username"></asp:Label>
                                    <asp:TextBox ID="txtCardID" runat="server" CssClass="form-control" placeholder="Username"></asp:TextBox>
                                    <%--<input type="text" class="form-control" placeholder="Username">--%>
                                </div>
                                <div class="form-group mb-3">
                                    <asp:Label runat="server" CssClass="label" ID="lblPassword" for="password" Text="Password"></asp:Label>
                                    <asp:TextBox ID="txtPass" runat="server" CssClass="form-control" TextMode="Password" placeholder="Password"></asp:TextBox>
                                    <%--<input type="password" class="form-control" placeholder="Password">--%>
                                </div>
                                <p>&nbsp;</p>
                                <div class="form-group">
                                    <asp:Button ID="btLogin" runat="server" Text="Login" CssClass="form-control btn btn-login px-3" OnClick="btLogin_Click" />
                                    <%--<button type="submit" class="form-control btn btn-primary submit px-3">Sign In</button>--%>
                                </div>
                            </div>
                            <!-- Modal -->
                            <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h4 class="modal-title">Error !!</h4>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <asp:Label ID="lblModalBody" runat="server" Text=""></asp:Label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <asp:SqlDataSource ID="dsTemp" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>" OnSelecting="dsTemp_Selecting"></asp:SqlDataSource>
                    </div>
                </div>
            </div>
        </div>
        <!-- jQuery -->
        <script src="/TERP/Theme/plugins/jquery/jquery.min.js"></script>
        <script src="/TERP/Theme/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="/TERP/Theme/plugins/toastr/toastr.min.js"></script>
        <%--<script src="/TERP/Libs/ModalMessage.js"></script>--%>
        <script src="/TERP/Libs/Message.js"></script>

        <asp:SqlDataSource ID="dsModule" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
            SelectCommand="SELECT module_id, module_prefix + ': ' + module_name as module_name FROM TERP_module WHERE enable=1 ORDER by [sort]"
            OnSelecting="dsTemp_Selecting"></asp:SqlDataSource>
    </form>
</body>
</html>


