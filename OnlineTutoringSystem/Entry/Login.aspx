<%@ Page Title="" Language="C#" MasterPageFile="~/SignUp.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="OnlineTutoringSystem.WebForm2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.18.0/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Lightbox2 CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/css/lightbox.min.css">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Boostrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.18.0/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Include Lightbox2 CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/css/lightbox.min.css">
    <link href="../Content/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">

    <!-- Add Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"
        integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="
        crossorigin="anonymous"
        referrerpolicy="no-referrer" />
    <%--font awesome--%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha256-Wl7pF/WKUaSGvdQdVZ5oIqD8IqHki/MkAu7ZR2jK9gY=" crossorigin="anonymous">

    <style>
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            overflow: hidden;
        }

        .signForm {
            padding: 10%;
        }

        .formTitle {
            font-size: 1.8vw;
            font-weight: bold;
            text-align: center; /* Center horizontally */
            vertical-align: middle; /* Center vertically */
            padding: 6%;
            padding-bottom: 0;
        }

        .inputField {
            padding-top: 5%;
            padding-left: 25%;
        }

        .btn-orange {
            background-color: #FF6636; /* Orange background color */
            color: #fff;
            font-size: 1.1vw;
            border: none;
            margin-top: 9%;
            margin-right: 20%;
            padding: 1% 5% 1% 5%;
        }

            .btn-orange:hover {
                background-color: #FF8C00;
                color: #fff;
            }

        .auto-style1 {
            height: 36px;
        }

        .leftSide {
            padding-left: 25%;
        }
    </style>


    <div class="container-fluid">
        <div class="row">
            <%--bg div--%>
            <div class="col-md-5" style="padding: 0;">
                <div class=" d-flex align-items-center ">
                    <img src="../imgs/bg2.png" class="img-fluid h-50 w-100" alt="Background Image">
                </div>
            </div>

            <%--sign in form div--%>
            <div class="col-md-7">
                <div class="p-3">
                    <!-- Your content goes here -->
                    <div class="container">
                        <div class="row">
                            <div class="col-md-12 formTitle">
                                Sign in to your account
                            </div>
                        </div>
                        <div class="row inputField">
                            <div class="col-md-12">
                                <asp:Label ID="Label5" runat="server" BorderStyle="None" Text="Email"></asp:Label>
                            </div>
                        </div>
                        <div class="row leftSide">
                            <div class="col-md-9">
                                <asp:TextBox ID="tbFirstN" runat="server" Placeholder="Email address" CssClass="form-control" />
                            </div>
                        </div>
                        <div class="row inputField">
                            <div class="col-md-12">
                                <asp:Label ID="Label4" runat="server" BorderStyle="None" Text="Password"></asp:Label>
                            </div>
                        </div>
                        <div class="row leftSide">
                            <div class="col-md-9">
                                <div class="input-group">
                                    <asp:TextBox ID="tbUserN" runat="server" TextMode="Password" CssClass="form-control" placeholder="Password"></asp:TextBox>
                                    <button type="button" class="btn btn-outline-secondary" id="toggleNewPassword" onclick="togglePassword('<%= tbUserN.ClientID %>')">
                                        <i class="bi bi-eye"></i>
                                    </button>
                                </div>
                            </div>
                            <!-- Forgot Password link -->
                            <div class="col-md-12 forgotPassword">
                                <asp:HyperLink ID="hlForgotPassword" runat="server" NavigateUrl="ForgetPassword.aspx" Text="Forgot Password?" />
                            </div>
                        </div>
                        <div class="col-md-12 d-flex justify-content-end">
                            <asp:Button ID="btnCreate" runat="server" class="btn btn-primary" style="background-color: #FF6636; border-color: #FF6636;" Text="Sign In" OnClick="btnCreate_Click" />
                        </div>
                    </div>
                    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
                    <script>
                        function togglePassword(inputId) {
                            const passwordInput = document.getElementById(inputId);
                            const toggleButton = document.getElementById(`toggle${inputId}`);
                            if (passwordInput.type === 'password') {
                                passwordInput.type = 'text';
                                toggleButton.innerHTML = '<i class="bi bi-eye-slash"></i>';
                            } else {
                                passwordInput.type = 'password';
                                toggleButton.innerHTML = '<i class="bi bi-eye"></i>';
                            }
                        }


                    </script>
                </div>
            </div>
        </div>
        </div>
</asp:Content>
