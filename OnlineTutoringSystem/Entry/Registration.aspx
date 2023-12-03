<%@ Page Title="" Language="C#" MasterPageFile="~/SignUp.Master" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="OnlineTutoringSystem.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--font awesome--%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha256-Wl7pF/WKUaSGvdQdVZ5oIqD8IqHki/MkAu7ZR2jK9gY=" crossorigin="anonymous">

    <style>
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
        }

        .signForm {
            padding: 10% 16%;
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
            padding-top: 3%;
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
    </style>

    <div class="container-fluid">
        <div class="row">
            <%--bg div--%>
            <div class="col-md-5" style="padding: 0;">
                <div class=" d-flex align-items-center ">
                    <img src="../imgs/bg1.png" class="img-fluid h-50 w-100" alt="Background Image">
                </div>
            </div>

            <%--sign up form div--%>
            <div class="col-md-7">
                <div class="p-3">
                    <!-- Your content goes here -->
                    <div class="container">
                        <div class="row">
                            <div class="col-md-12 formTitle">
                                Create your account
                            </div>
                        </div>
                        <div class="row inputField">
                            <div class="col-md-12">
                                <asp:Label ID="Label5" runat="server" BorderStyle="None" Text="Full Name"></asp:Label>
                   <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="tbLastN" ErrorMessage="Field is required" Display="Dynamic" ForeColor="Red">*</asp:RequiredFieldValidator>
                   <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="tbFirstN" ErrorMessage="Field is required" Display="Dynamic" ForeColor="Red">*</asp:RequiredFieldValidator>

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
                            <div class="col-md-6">
                                <asp:Label ID="Label10" runat="server" BorderStyle="None" Text="Gender"></asp:Label>
                   <asp:RequiredFieldValidator ID="RequiredFieldValidator33" runat="server" ControlToValidate="RadioButtonListGender" ErrorMessage="Field is required" Display="Dynamic" ForeColor="Red">*</asp:RequiredFieldValidator>

                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <asp:RadioButtonList ID="RadioButtonListGender" runat="server" CssClass="form-control" RepeatDirection="Horizontal">
                                    <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                                    <asp:ListItem Text="Female" Value="Female"></asp:ListItem> 
                                </asp:RadioButtonList> 
                            </div>
                        </div>
                        <div class="row inputField">
                            <div class="col-md-6">
                                <asp:Label ID="Label7" runat="server" BorderStyle="None" Text="Date of Birth"></asp:Label>
                   <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbDob" ErrorMessage="Field is required" Display="Dynamic" ForeColor="Red">*</asp:RequiredFieldValidator>

                            </div>
                            <div class="col-md-6">
                                <asp:Label ID="Label8" runat="server" BorderStyle="None" Text="Phone Number"></asp:Label>
                   <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="tbPhone" ErrorMessage="Field is required" Display="Dynamic" ForeColor="Red">*</asp:RequiredFieldValidator>

                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <asp:TextBox ID="tbDob" runat="server" CssClass="form-control" TextMode="Date" />
                            </div>
                            <div class="col-md-6">
                                <asp:TextBox ID="tbPhone" runat="server" Placeholder="0123456789" CssClass="form-control" />
                            </div>
                        </div>
                        <div class="row inputField">
                            <div class="col-md-12">
                                <asp:Label ID="Label4" runat="server" BorderStyle="None" Text="Username"></asp:Label>
                   <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="tbUserN" ErrorMessage="Field is required" Display="Dynamic" ForeColor="Red">*</asp:RequiredFieldValidator>

                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <asp:TextBox ID="tbUserN" runat="server" Placeholder="Username" CssClass="form-control" />
                            </div>
                        </div>
                        <div class="row inputField">
                            <div class="col-md-12">
                                <asp:Label ID="Label3" runat="server" BorderStyle="None" Text="Email"></asp:Label>
                   <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="tbEmail" ErrorMessage="Field is required" Display="Dynamic" ForeColor="Red">*</asp:RequiredFieldValidator>

                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <asp:TextBox ID="tbEmail" runat="server" Placeholder="Email address" CssClass="form-control" />
                            </div>
                        </div>

                        <div class="row inputField">
                            <div class="col-md-6">
                                <asp:Label ID="Label1" runat="server" BorderStyle="None" Text="Password"></asp:Label>
                   <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="tbPw" ErrorMessage="Field is required" Display="Dynamic" ForeColor="Red">*</asp:RequiredFieldValidator>

                            </div>
                            <div class="col-md-6">
                                <asp:Label ID="Label2" runat="server" BorderStyle="None" Text="Confirm Password"></asp:Label>
                   <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="TextBox2" ErrorMessage="Field is required" Display="Dynamic" ForeColor="Red">*</asp:RequiredFieldValidator>

                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <asp:TextBox ID="tbPw" runat="server" Placeholder="Create Password" CssClass="form-control" TextMode="Password" />
                            </div>
                            <div class="col-md-6">
                                <asp:TextBox ID="TextBox2" runat="server" Placeholder="Confirm Password" CssClass="form-control" TextMode="Password" />
                                <asp:CompareValidator ID="CompareValidator1" runat="server"
                                    ControlToCompare="tbPw" ErrorMessage="Passwords do not match." Display="Dynamic" CssClass="text-danger" ControlToValidate="TextBox2" />
                            </div>
                        </div>
                        <div class="row inputField">
                            <div class="col-md-12">
                                <asp:Label ID="Label9" runat="server" BorderStyle="None" Text="Profile Picture" CssClass="form-label"></asp:Label>
                   <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="FileUpload1" ErrorMessage="Field is required" Display="Dynamic" ForeColor="Red">*</asp:RequiredFieldValidator>

                                <asp:FileUpload ID="FileUpload1" runat="server" CssClass="form-control" />
                            </div>
                        </div>
                        <div class="row inputField">
                            <div class="col-md-12">
                                <asp:Label ID="Label6" runat="server" BorderStyle="None" Text="Sign Up As : Student / Tutor"></asp:Label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <asp:DropDownList ID="DropDownList11" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="Student">Become A Student</asp:ListItem>
                                    <asp:ListItem Value="Tutor">Become A Tutor</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                            </div>
                            <div class="col-md-6 d-flex justify-content-end">
                                <asp:Button ID="btnCreate" runat="server" CssClass="btn-orange" Text="Create Account" OnClick="btnCreate_Click" />
                            </div>
                        </div> 
                    </div>

                </div>
            </div>
        </div>
    </div>
</asp:Content>
