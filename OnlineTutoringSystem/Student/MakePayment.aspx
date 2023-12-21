<%@ Page Title="Payment" Language="C#" MasterPageFile="~/Header.Master" AutoEventWireup="true" CodeBehind="MakePayment.aspx.cs" Inherits="OnlineTutoringSystem.WebForm6" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

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
        .btn-orange {
            text-decoration: none;
            background-color: #FF6636; /* Orange background color */
            color: #fff;
            font-size: 1.1vw;
            border: none;
            margin-top: 9%;
            margin-right: 20%;
            padding: 1% 5% 1% 5%;
        }

            .btn-orange:hover {
                text-decoration: none;
                background-color: #FF8C00;
                color: #fff;
            }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid pb-0">
        <div class="container mt-5">
            <div class="row justify-content-center p-3">
                <div class="row text-center p-3">
                    <div class="col">
                        <asp:Label ID="Label18" runat="server" Text="Make Payment" CssClass="h3 mb-3 font-weight-bold"></asp:Label>
                    </div>
                </div>
                <div class="col-md-8">
                    <div class="card borde shadow">
                        <asp:Image ID="CourseBanner" runat="server" CssClass="img-fluid"
                            AlternateText="Course Image" Width="100%" Height="320px" />
                        <div class="card-body">
                            <!-- Course Information -->
                            <div class="mb-3">
                                <label for="courseName" class="form-label fw-bold h5">Course Name:</label>
                                <asp:Label ID="lblCourseName" runat="server" CssClass="form-control" Text="Course XYZ"></asp:Label>
                            </div>

                            <div class="mb-3">
                                <label for="courseFee" class="form-label fw-bold h5">Course Fee:</label>
                                <asp:Label ID="lblCourseFee" runat="server" CssClass="form-control" Text="RM 100.00"></asp:Label>
                            </div>

                            <!-- Add other course-related information here -->

                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card border shadow">
                        <div class="card-body">
                            <!-- Credit Card Information -->
                            <div class="mb-3">
                                <label for="cardNumber" class="form-label fw-bold h5">Credit Card Number:</label>
                                <asp:RequiredFieldValidator ID="reqcardno" runat="server" ControlToValidate="txtCardNumber" ErrorMessage="Card number is required" ValidationGroup="PaymentValidation" ForeColor="Red">*</asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="must have 16 digits" ForeColor="Red" ValidationGroup="PaymentValidation" ValidationExpression="^\d{16}$" ControlToValidate="txtCardNumber">*</asp:RegularExpressionValidator>
                                <asp:TextBox ID="txtCardNumber" runat="server" CssClass="form-control" placeholder="1207723079122321" MaxLength="16"></asp:TextBox>
                            </div>

                            <div class="mb-3">
                                <label for="cardHolderName" class="form-label fw-bold h5">Cardholder Name:</label><asp:RequiredFieldValidator ID="reqname" runat="server" ValidationGroup="PaymentValidation" ErrorMessage="Name is required" ControlToValidate="txtCardHolderName" ForeColor="Red">*</asp:RequiredFieldValidator>
                                <asp:TextBox ID="txtCardHolderName" runat="server" CssClass="form-control" placeholder="Enter cardholder name"></asp:TextBox>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="expirationDate" class="form-label fw-bold h5">Expiry Date:</label><asp:RequiredFieldValidator ID="reqexp" runat="server" ValidationGroup="PaymentValidation" ErrorMessage="Expiration is required" ForeColor="Red" ControlToValidate="txtExpirationDate">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="Expiration format: MM/YY" ValidationGroup="PaymentValidation" ValidationExpression="^(0[1-9]|1[0-2])\/[0-9]{2}$" ControlToValidate="txtExpirationDate" ForeColor="Red">*</asp:RegularExpressionValidator><br />
                                    <asp:TextBox ID="txtExpirationDate" runat="server" CssClass="form-control" placeholder="MM/YY" MaxLength="5"></asp:TextBox> 
                                </div>

                                <div class="col-md-6 mb-3">
                                    <label for="cvv" class="form-label fw-bold h5">CVV:</label>
                                    <asp:RequiredFieldValidator ID="reqcvv" runat="server" ErrorMessage="CVV is required" ControlToValidate="txtCVV" ForeColor="Red" ValidationGroup="PaymentValidation">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="CVV is only 3 digits" ValidationGroup="PaymentValidation" ForeColor="Red" ValidationExpression="^\d{3}$" ControlToValidate="txtCVV">*</asp:RegularExpressionValidator>
                                    <asp:TextBox ID="txtCVV" runat="server" CssClass="form-control" placeholder="Enter CVV" MaxLength="3"></asp:TextBox>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="totalToPay" class="form-label fw-bold h5">Total</label>
                                <asp:Label ID="lblTotalToPay" runat="server" CssClass="form-control" Text="RM 100.00" ReadOnly="True"></asp:Label>
                            </div>
                            <!-- Payment Button -->
                            <asp:Button ID="btnMakePayment" runat="server" Text="Make Payment" class="btn btn-primary" style="background-color: #FF6636; border-color: #FF6636;" ValidationGroup="PaymentValidation" OnClick="btnMakePayment_Click" />

                            <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="PaymentValidation" runat="server" ForeColor="Red" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
