<%@ Page Title="" Language="C#" MasterPageFile="~/Header.Master" AutoEventWireup="true" CodeBehind="Rating.aspx.cs" Inherits="OnlineTutoringSystem.WebForm10" %>

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
            padding: 1% 5% 1% 5%;
        }

            .btn-orange:hover {
                text-decoration: none;
                background-color: #FF8C00;
                color: #fff;
            }

        .star {
            font-size: 2.1vw;
            color: rgb(255, 210, 49);
        }

        .textBox {
            width: 90%;
            font-family: 'Lucida Sans';
            font-size: 1.2vw;
            margin-bottom: 15px;
            padding: 5px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
        <div class="col-md-8 offset-md-2">
            <!-- Title Row -->
            <div class="row p-3 text-center">
                <div class="col-md-12 text-center">
                    <h2>Rate Tutor and Course</h2>
                </div>
            </div>

            <!-- Course and Tutor Info Row -->
            <div class="row p-3">
                <div class="col-md-12">
                    <div class="mb-3">
                        <asp:Label ID="lblCourseLabel" runat="server" Text="Course Name: " CssClass="label"></asp:Label>
                        <asp:Label ID="lblCourseName" runat="server" CssClass="infoLabel"></asp:Label>
                    </div>
                    <div>
                        <asp:Label ID="lblTutorLabel" runat="server" Text="Tutor Name: " CssClass="label"></asp:Label>
                        <asp:Label ID="lblTutorName" runat="server" CssClass="infoLabel"></asp:Label>
                    </div>
                </div>
            </div>
            <div class="row p-3">
                <div class="col-md-12 text-left">
                    <asp:Label ID="Label8" runat="server" Text="YOUR RATING: " />
                    <br />
                    <!-- Star Rating Row -->
                    <div class="mb-3">
                        <div class="form-check form-check-inline">
                            <asp:RadioButton CssClass="star" ID="star1" runat="server" GroupName="rating" value="1" />
                            <label class="form-check-label" for="star1">1<i class="bi bi-star" style="color: rgb(255, 210, 49); font-size: 1.5rem;"></i></label>
                            &nbsp;&nbsp;
    
    <asp:RadioButton CssClass="star" ID="star2" runat="server" GroupName="rating" value="2" />
                            <label class="form-check-label" for="star2">2<i class="bi bi-star" style="color: rgb(255, 210, 49); font-size: 1.5rem;"></i></label>
                            &nbsp;&nbsp;
    
    <asp:RadioButton CssClass="star" ID="star3" runat="server" GroupName="rating" value="3" />
                            <label class="form-check-label" for="star3">3<i class="bi bi-star" style="color: rgb(255, 210, 49); font-size: 1.5rem;"></i></label>
                            &nbsp;&nbsp;
    
    <asp:RadioButton CssClass="star" ID="star4" runat="server" GroupName="rating" value="4" />
                            <label class="form-check-label" for="star4">4<i class="bi bi-star" style="color: rgb(255, 210, 49); font-size: 1.5rem;"></i></label>
                            &nbsp;&nbsp;
    
    <asp:RadioButton CssClass="star" ID="star5" runat="server" GroupName="rating" value="5" />
                            <label class="form-check-label" for="star5">5<i class="bi bi-star" style="color: rgb(255, 210, 49); font-size: 1.5rem;"></i></label>
                        </div>
                    </div>
                    <!-- Rating Input Row -->
                    <div class="mb-3">
                        <asp:Label ID="Label1" runat="server" Text="YOUR COMMENT: " />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Comment is required!" ControlToValidate="tbComment" ForeColor="Red" Display="Dynamic">*</asp:RequiredFieldValidator>
                        <br />
                        <asp:TextBox ID="tbComment" CssClass="textBox" runat="server" TextMode="MultiLine" Rows="3"></asp:TextBox>
                    </div>
                    <asp:Button ID="btnSubmit" runat="server" CssClass="btn-orange" Text="Submit" OnClick="btnSubmit_Click" ValidationGroup="Rating" />
                    <asp:ValidationSummary ID="ValidationSummary2" runat="server" ForeColor="Red" HeaderText="The following problems have been encountered" ShowMessageBox="True" ShowSummary="False" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
