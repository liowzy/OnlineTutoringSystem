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
            <div class="row p-5">
                <div class="col-4">
                    <%--change profile pic--%>
                    <div id="profilePictureContainer" class="position-relative mx-auto">
                        <img src="../imgs/T1.png" alt="Profile Picture" id="profilePicture" class="img-fluid" style="width: 35vh; height: 35vh; cursor: pointer;" />
                        <input type="file" id="fileInput" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; opacity: 0; cursor: pointer;" />
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
                            <asp:TextBox ID="tbEmail" runat="server" Placeholder="Email address" CssClass="form-control" ReadOnly="True" />
                        </div>
                    </div>
                    <div class="row inputField">
                        <div class="col-md-12 text-left">
                            <asp:Label ID="Label11" runat="server" BorderStyle="None" Text="Gender"></asp:Label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-select">
                                <asp:ListItem Value="Male">Male</asp:ListItem>
                                <asp:ListItem Value="Female">Female</asp:ListItem>
                            </asp:DropDownList>
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
                        <asp:Button ID="btnCreate" runat="server" CssClass="btn-orange" Style="margin: 0;" Text="Save Changes" />
                    </div>
                </div>
            </div>
        </div>
    </div> 


    <script>
        // JavaScript to handle file input change
        document.getElementById('fileInput').addEventListener('change', function (event) {
            var input = event.target;
            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    document.getElementById('profilePicture').src = e.target.result;
                };

                reader.readAsDataURL(input.files[0]);
            }
        });

        // JavaScript to trigger file input when the image is clicked
        document.getElementById('profilePicture').addEventListener('click', function () {
            document.getElementById('fileInput').click();
        });
    </script>


    <%--Password setting section--%>
    <div class="container-fluid p-4 text-center d-flex justify-content-center" style="background-color: #F5F7FA;">
        <div class="col-md-8 p-4" style="background-color: #F5F7FA;">
            <!-- Password Setting Section -->
            <div class="row">
                <div class="row top-category">
                    <div class="col">
                        <asp:Label ID="Label2" runat="server" Text="Change Password" CssClass="h3 mb-3 font-weight-bold"></asp:Label>
                    </div>
                </div>
            </div>
            <%--Picture and Password Col--%>
            <div class="row p-5">
                <div class="row inputField">
                    <div class="col-md-12 text-left">
                        <asp:Label ID="Label73" runat="server" BorderStyle="None" Text="Current Password"></asp:Label>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <asp:TextBox ID="TextBox32" runat="server" Placeholder="Password" CssClass="form-control" TextMode="Password" />
                    </div>
                </div>
                <div class="row inputField">
                    <div class="col-md-12 text-left">
                        <asp:Label ID="Label62" runat="server" BorderStyle="None" Text="New Password"></asp:Label>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <asp:TextBox ID="TextBox14" runat="server" Placeholder="Password" CssClass="form-control" TextMode="Password" />
                    </div>
                </div>
                <div class="row inputField">
                    <div class="col-md-12 text-left">
                        <asp:Label ID="Label52" runat="server" BorderStyle="None" Text="Comfirm Password"></asp:Label>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <asp:TextBox ID="TextBox23" runat="server" Placeholder="Confirm new password" CssClass="form-control" TextMode="Password" />
                    </div>
                </div>

                <div class="row inputField">
                    <div class="col-md-4">
                    </div>
                    <div class="col-md-8 m-0 d-flex justify-content-end">
                        <asp:Button ID="Button66" runat="server" CssClass="btn-orange" Style="margin: 0;" Text="Save Changes" />
                    </div>
                </div>
            </div>
        </div>
</asp:Content>
