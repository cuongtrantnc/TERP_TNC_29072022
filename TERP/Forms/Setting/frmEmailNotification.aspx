<%@ Page MasterPageFile="~/TERP.Master" Language="C#" AutoEventWireup="true" CodeBehind="frmEmailNotification.aspx.cs" Inherits="TERP.Forms.Setting.frmEmailNotification" %>

<asp:Content ContentPlaceHolderID="TERPContentPlaceHolder" runat="server">
    <link href="../../Style/Browse/BrowseStyle.css" rel="stylesheet" />

    <style>
        :root {
            --fontsize: 0.85 rem;
        }

        .mail-option {
            display: flex;
            justify-content: space-between;
        }

        .mail-box {
            width: 100%;
            display: flex;
            align-items: center;
        }

        .left {
            width: 350px;
            height: 400px;
            overflow-y: scroll;
            overflow-x: hidden;
            position: relative;
        }

        .menu-option {
            position: sticky;
            top: 0;
            left: 0;
            width: 350px;
            background-color: white;
            display: flex;
            justify-content: center;
            align-items: center;
        }

            .menu-option input {
                background-color: white;
                border: none;
                padding: 0;
                width: calc(50% - 5px);
                height: 30px;
                border-bottom: 1px solid black;
            }

                .menu-option input:hover {
                    background-color: rgba(199, 198, 199, 0.18);
                }

                .menu-option input:first-child {
                    border-right: 1px solid black;
                }

        #style::-webkit-scrollbar-track {
            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.1);
            background-color: #F5F5F5;
            border-radius: 10px;
        }

        #style::-webkit-scrollbar {
            width: 5px;
            background-color: #F5F5F5;
        }

        #style::-webkit-scrollbar-thumb {
            border-radius: 10px;
            background-color: #FFF;
            background-image: -webkit-gradient(linear, 40% 0%, 75% 84%, from(rgba(67, 245, 39, 1)), to(rgba(67, 245, 39, 1)), color-stop(.6,#54DE5D))
        }

        .right {
            flex: 1;
            padding: 4px 20px;
            position: relative;
            width: 100%;
            height: 400px;
        }

        .mail-list {
            list-style: none;
            padding: 0;
            margin: 0;
            margin-top: -5px;
        }

        .mail-item {
            padding: 5px;
        }

            .mail-item p {
                margin: 0;
                border-bottom: 1px solid black;
                padding: 5px;
                overflow: hidden;
            }

            .mail-item input {
                width: 100%;
                height: 35px;
                text-align: left;
                padding: 5px;
                border-top: none;
                border-left: none;
                border-right: none;
                background-color: transparent;
                /*border-bottom: 1px solid black;*/
                border-bottom: none;
                font-size: var(--fontsize);
            }

        .mail-time {
            display: block;
            text-align: right;
            font-size: 13px;
            margin-bottom: 30px;
        }

        .mail-content {
            font-size: 19px;
            font-weight: 500;
        }

        .mail {
            display: flex;
            align-items: center;
            justify-content: center;
            border-bottom: 1px solid black;
        }

            .mail:hover input,
            .mail:hover span {
                font-weight: 700;
            }

            .mail > span {
                width: 120px;
                display: block;
                padding: 7px;
                text-align: end;
            }

        .default-content {
            position: absolute;
            width: 300px;
            height: 60px;
            top: 50%;
            left: 50%;
            transform: translate(-50%,-50%);
            text-align: center;
        }

            .default-content i {
                font-size: 35px;
                color: rgba(193,189,189,1);
            }

            .default-content p {
                font-size: 14px;
            }

        .viewed {
            background-color: rgba(217,217,217,0.8) !important;
        }

        .active {
            border-left: 3px solid rgba(67, 245, 39, 1) !important;
            background-color: rgba(67, 245, 39, 0.2) !important;
        }

            .active input,
            .active span {
                font-weight: 700;
            }

        .option-active {
            border-top: 3px solid rgba(67, 245, 39, 1) !important;
            font-weight: 500;
        }

        .disabled {
            display: none;
        }

        .mail-status {
            display: flex;
            justify-content: flex-start;
            align-items: center;
            padding-left: 5px;
        }

            .mail-status select {
                margin-left: 6px;
                width: 75px;
                height: 30px;
                padding: 0 !important;
                font-size: var(--fontsize);
            }

        .status-box {
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
        }

            .status-box span {
                position: absolute;
                top: -3px;
                left: 11px;
                background-color: white;
            }

        .year-option {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            padding-right: 5px;
        }


            .year-option select {
                margin-left: 6px;
                width: 65px;
                height: 30px;
                padding: 0 !important;
                font-size: var(--fontsize);
            }

        .year-box {
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
        }

            .year-box span {
                position: absolute;
                top: -3px;
                left: 11px;
                background-color: white;
            }
    </style>

    <div>
        <div style="width: 100%" class="title-padding">
            <asp:Label ID="mailBoxTitle" runat="server" Text="Inbox" Font-Bold="True" CssClass="h4"></asp:Label>
        </div>

        <div class="card card-success card-outline card-outline-tabs">
            <div class="card-body">
                <%--mail-box--%>
                <div class="mail-box">

                    <div class="left" id="style">
                        <div class="mail-option">
                            <div class="mail-status">
                                <asp:Label ID="lbStatus" runat="server" Text="Status" CssClass="my-2 form-label form-text"></asp:Label>
                                <div class="status-box">
                                    <asp:DropDownList ID="ddStatus" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddStatus_SelectedIndexChanged" AutoPostBack="true">
                                        <asp:ListItem Text="" Value=""></asp:ListItem>
                                        <asp:ListItem Text="Unseen" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Seen" Value="1"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:Label ID="lblDisplayStatus" runat="server" Text="" CssClass="my-2 form-label form-text"></asp:Label>
                                </div>
                            </div>
                            <div class="year-option">
                                <asp:Label ID="lblYear" runat="server" Text="Year" CssClass="my-2 form-label form-text"></asp:Label>
                                <div class="year-box">
                                    <asp:DropDownList ID="ddYear" runat="server" CssClass="form-control" AppendDataBoundItems="true" data-live-search="true" DataSourceID="dsYear" DataTextField="notiyear" DataValueField="notiyear" AutoPostBack="True" OnSelectedIndexChanged="ddYear_SelectedIndexChanged">
                                        <asp:ListItem Text="" Value="" />
                                    </asp:DropDownList>
                                    <asp:Label ID="lblDisplayYear" runat="server" Text="" CssClass="my-2 form-label form-text"></asp:Label>
                                </div>
                            </div>
                        </div>
                        <div class="menu-option">
                            <asp:Button ID="btnRequest" runat="server" Text="Notifications" OnClick="btnRequest_Click" />
                            <asp:Button ID="btnTask" runat="server" Text="Tasks" OnClick="btnTask_Click" />
                        </div>
                        <ul class="mail-list">

                            <li class="mail-item">
                                <asp:Panel ID="pnRender" runat="server"></asp:Panel>
                            </li>

                        </ul>
                    </div>

                    <div class="right">
                        <asp:Label ID="lbTimeOfMail" runat="server" Text="" CssClass="mail-time" Enabled="false"></asp:Label>
                        <asp:Label ID="lbContent" runat="server" Text="" CssClass="mail-content" Enabled="false"></asp:Label>
                        <div class="default-content">
                            <i class="fas fa-mail-bulk"></i>
                            <p>Click on each email to preview messages</p>
                        </div>
                    </div>

                </div>
                <%--end mail-box--%>
            </div>
        </div>


    </div>

    <asp:SqlDataSource ID="dsTemp" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>" OnSelecting="dsTemp_Selecting"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsYear" runat="server" ConnectionString="<%$ ConnectionStrings:TERPConnectionString %>"
        SelectCommand="SELECT DISTINCT notiyear FROM (SELECT Year(noti_date) AS notiyear FROM TERP_email_notification WHERE user_id=@userID) AS a ORDER BY notiyear DESC" OnSelecting="dsTemp_Selecting">
        <SelectParameters>
            <asp:Parameter Name="userID" Type="String" DefaultValue="" />
        </SelectParameters>

    </asp:SqlDataSource>

    <script src="../../Libs/CountEmailJS.js"></script>
    <script src="../../Libs/emailNotification.js"></script>
    <script type="text/javascript">

      <%-- $(document).ready(function () {
            $("#<%=ddYear.ClientID %>").change(function() {
                 localStorage.setItem('ddSelectedItem', this.value);
            });
            if (localStorage.getItem('ddSelectedItem')) {
                $("#<%=ddYear.ClientID %>").val(localStorage.getItem('ddSelectedItem'));
            }
           
       });--%>

        function HandleMailItem(params) {
            let id = "#TERPContentPlaceHolder_" + "mail" + params;
            let activedEle = document.querySelector(id);
            let defaultContentEle = document.querySelector(".default-content");
            let allEle = document.querySelectorAll(".active");

            if (allEle.length > 0) {
                for (let i = 0; i <= allEle.length; i++) {
                    allEle[i].classList.remove("active");
                }
            }
            activedEle.classList.add("active");
            defaultContentEle.classList.add("disabled");
        }

    </script>

</asp:Content>

<%--SELECT DISTINCT notiyear FROM (SELECT Year(noti_date) AS notiyear FROM TERP_email_notification WHERE user_id='201220') AS a ORDER BY notiyear DESC--%>