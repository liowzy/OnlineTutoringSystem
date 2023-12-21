<%@ Page Title="" Language="C#" MasterPageFile="~/Student/StudDashboard.master" AutoEventWireup="true" CodeBehind="StudAccount.aspx.cs" Inherits="OnlineTutoringSystem.Student.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.18.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="../Content/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">

    <!-- Lightbox2 CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/css/lightbox.min.css">

    <link rel="stylesheet" href="../Content/css/studentMaster.css" />
    <link rel="stylesheet" href="../Content/fontawesome-free-5.15.4-web/css/all.min.css">

    <style>
        .btn-or {
            border-top: 2px solid transparent; /* Set transparent border by default */
        }

            .btn-or:hover {
                border-bottom-color: orange; /* Set the color on hover */
            }

        .inputField {
            padding-top: 3%;
        }
        .auto-style1 {
            position: relative;
            width: 100%;
            -ms-flex-preferred-size: 0;
            flex-basis: 0;
            -ms-flex-positive: 1;
            flex-grow: 1;
            max-width: 100%;
            flex: 1 0 0%;
            left: 0px;
            top: 0px;
            height: 30px;
            padding-left: 15px;
            padding-right: 15px;
        }
    </style>
    <div class="container-fluid p-4 text-center d-flex justify-content-center">
        <div class="col-md-8 bg-white p-4">
            <!-- Browse Account Setting Section -->
            <div class="row">
                <div class="row top-category">
                    <div class="col">
                        <asp:Label ID="Label18" runat="server" Text="Account Settings" CssClass="h3 mb-3 font-weight-bold"></asp:Label>
                    </div>
                </div>
            </div>
            <%--Picture and Password Col--%>
            <div class="row p-5 d-flex justify-content-center text-center">
                <div class="col-4 ">
                    <%--change profile pic--%>
                    <div id="profilePictureContainer" class="position-relative mx-auto">
                        <asp:Image ID="imgUserProfile" runat="server" CssClass="img-fluid" AlternateText="Profile Picture" Style="width: 35vh; height: 35vh; cursor: pointer;" />
                        <asp:FileUpload ID="btnFileUpload" runat="server" CssClass="p-2" />
                    </div>

                </div>
                <div class="col-8 p-5 pt-0">
                    <div class="row inputField">
                        <div class="col-md-12 text-left">
                            <asp:Label ID="Label5" runat="server" BorderStyle="None" Text="Full Name"></asp:Label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <asp:TextBox ID="tbFirstN" runat="server" Placeholder="First Name" CssClass="form-control" />
                        </div>
                        <div class="col-md-6">
                            <asp:TextBox ID="tbLastN" runat="server" Placeholder="Last Name" CssClass="form-control" />
                        </div>
                    </div>
                    <div class="row inputField">
                        <div class="col-md-12 text-left">
                            <asp:Label ID="Label4" runat="server" BorderStyle="None" Text="Username"></asp:Label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <asp:TextBox ID="tbUserN" runat="server" Placeholder="Username" CssClass="form-control" />
                        </div>
                    </div>
                    <div class="row inputField">
                        <div class="col-md-12 text-left">
                            <asp:Label ID="Label3" runat="server" BorderStyle="None" Text="Email"></asp:Label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <asp:TextBox ID="tbEmail" runat="server" Placeholder="Email address" CssClass="form-control" />
                        </div>
                    </div> 
                    <div class="row inputField">
                        <div class="col-md-6 text-left">
                            <asp:Label ID="Label6" runat="server" BorderStyle="None" Text="Gender"></asp:Label>
                        </div>
                        <div class="col-md-6 text-left">
                            <asp:Label ID="Label12" runat="server" BorderStyle="None" Text="Date of Birth"></asp:Label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-select">
                                <asp:ListItem Value="Male">Male</asp:ListItem>
                                <asp:ListItem Value="Female">Female</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-6">
                            <asp:TextBox ID="tbDateOfBirth" runat="server" Placeholder="Date of Birth" CssClass="form-control" TextMode="Date" />
                        </div>
                    </div>
                    <div class="row inputField">
                        <div class="col-md-12 text-left">
                            <asp:Label ID="Label1" runat="server" BorderStyle="None" Text="Phone Number"></asp:Label>
                        </div>
                    </div>
                    <div class="row text-left">
                        <div class="col-md-12">
                            <asp:TextBox ID="TextBox19" runat="server" Placeholder="0126587458" CssClass="form-control" MaxLength="11" TextMode="Phone" />
                        </div>
                    </div>
                    <asp:RegularExpressionValidator ID="RegexValidator" runat="server" ControlToValidate="TextBox19"
                        ValidationExpression="^\d{10,11}$" ErrorMessage="Please enter a 10-11 digit numeric value." Display="Dynamic" ForeColor="Red">
                    </asp:RegularExpressionValidator>

                </div>
                <div class="row">
                    <div class="col-md-4">
                    </div>
                    <div class="col-md-8 m-0 d-flex justify-content-end">
                        <asp:Button ID="btnCreate" runat="server" CssClass="btn-orange" Style="margin: 0;" Text="Save Changes"  OnClick="btnCreate_Click1"/>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <%--Password setting section--%>
    <div class="container-fluid p-4 text-center d-flex justify-content-center" style="background-color: #F5F7FA;">
        <div class="col-md-8 p-4" style="background-color: #F5F7FA;">
            <!-- Password Setting Section -->
            <div class="row">
                <div class="row top-category">
                    <div class="auto-style1">
                        <asp:Label ID="Label2" runat="server" Text="Change Password" CssClass="h3 mb-3 font-weight-bold"></asp:Label>
                    </div>
                </div>
            </div>
            <%--Password Col--%>
            <div class="row p-5">
                <div class="row inputField">
                    <div class="col-md-12 text-left">
                        <asp:Label ID="Label73" runat="server" BorderStyle="None" Text="Current Password"></asp:Label>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="input-group">
                        <asp:TextBox ID="TextBox32" runat="server" Placeholder="Password" CssClass="form-control" TextMode="Password" />
                                    <button type="button" class="btn btn-outline-secondary" id="toggleNCurPassword" onclick="togglePassword('<%= TextBox32.ClientID %>')">
                                        <i class="bi bi-eye"></i>
                                    </button>
                                </div>
                    </div>
                </div>
                <div class="row inputField">
                    <div class="col-md-12 text-left">
                        <asp:Label ID="Label62" runat="server" BorderStyle="None" Text="New Password"></asp:Label>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="input-group">
                        <asp:TextBox ID="TextBox14" runat="server" Placeholder="Password" CssClass="form-control" TextMode="Password" />
                                    <button type="button" class="btn btn-outline-secondary" id="toggleNewPassword" onclick="togglePassword('<%= TextBox14.ClientID %>')">
                                        <i class="bi bi-eye"></i>
                                    </button>
                                </div>
                    </div>
                </div>
                <div class="row inputField">
                    <div class="col-md-12 text-left">
                        <asp:Label ID="Label52" runat="server" BorderStyle="None" Text="Comfirm Password"></asp:Label>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="input-group">
                        <asp:TextBox ID="TextBox23" runat="server" Placeholder="Confirm new password" CssClass="form-control" TextMode="Password" />
                                    <button type="button" class="btn btn-outline-secondary" id="toggleConPassword" onclick="togglePassword('<%= TextBox23.ClientID %>')">
                                        <i class="bi bi-eye"></i>
                                    </button>
                                </div>
                    </div>
                </div>

                <div class="row inputField">
                    <div class="col-md-4">
                    </div>
                    <div class="col-md-8 m-0 d-flex justify-content-end">
                        <asp:Button ID="Button66" runat="server" CssClass="btn-orange" Style="margin: 0;" Text="Save Changes" OnClick="Button66_Click" />
                    </div>
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
</asp:Content>
