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
        <div class="col-md-8 offset-md-2 border shadow mb-2">
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
                    <asp:Label ID="Label8" runat="server" Text="Subject Knowledge: " />
                    <br />
                    <!-- Star Rating Row -->
                    <div class="mb-3">
                        <div class="form-check form-check-inline">
                            <asp:RadioButton CssClass="star" ID="RadioButton11" runat="server" GroupName="rating1" value="1" />
                            <label class="form-check-label" for="star1">1<i class="bi bi-star" style="color: rgb(255, 210, 49); font-size: 1.5rem;"></i></label>
                            &nbsp;&nbsp;
    
    <asp:RadioButton CssClass="star" ID="RadioButton12" runat="server" GroupName="rating1" value="2" />
                            <label class="form-check-label" for="star2">2<i class="bi bi-star" style="color: rgb(255, 210, 49); font-size: 1.5rem;"></i></label>
                            &nbsp;&nbsp;
    
    <asp:RadioButton CssClass="star" ID="RadioButton13" runat="server" GroupName="rating1" value="3" />
                            <label class="form-check-label" for="star3">3<i class="bi bi-star" style="color: rgb(255, 210, 49); font-size: 1.5rem;"></i></label>
                            &nbsp;&nbsp;
    
    <asp:RadioButton CssClass="star" ID="RadioButton14" runat="server" GroupName="rating1" value="4" />
                            <label class="form-check-label" for="star4">4<i class="bi bi-star" style="color: rgb(255, 210, 49); font-size: 1.5rem;"></i></label>
                            &nbsp;&nbsp;
    
    <asp:RadioButton CssClass="star" ID="RadioButton15" runat="server" GroupName="rating1" value="5" />
                            <label class="form-check-label" for="star5">5<i class="bi bi-star" style="color: rgb(255, 210, 49); font-size: 1.5rem;"></i></label>
                        </div>
                    </div>
                </div>

                <%----------------------------------------------------Teaching style--%>
                <div class="col-md-12 text-left">
                    <asp:Label ID="Label2" runat="server" Text="Teaching Style: " />
                    <br />
                    <!-- Star Rating Row -->
                    <div class="mb-3">
                        <div class="form-check form-check-inline">
                            <asp:RadioButton CssClass="star" ID="RadioButton21" runat="server" GroupName="rating2" value="1" />
                            <label class="form-check-label" for="star1">1<i class="bi bi-star" style="color: rgb(255, 210, 49); font-size: 1.5rem;"></i></label>
                            &nbsp;&nbsp;
    
    <asp:RadioButton CssClass="star" ID="RadioButton22" runat="server" GroupName="rating2" value="2" />
                            <label class="form-check-label" for="star2">2<i class="bi bi-star" style="color: rgb(255, 210, 49); font-size: 1.5rem;"></i></label>
                            &nbsp;&nbsp;
    
    <asp:RadioButton CssClass="star" ID="RadioButton23" runat="server" GroupName="rating2" value="3" />
                            <label class="form-check-label" for="star3">3<i class="bi bi-star" style="color: rgb(255, 210, 49); font-size: 1.5rem;"></i></label>
                            &nbsp;&nbsp;
    
    <asp:RadioButton CssClass="star" ID="RadioButton24" runat="server" GroupName="rating2" value="4" />
                            <label class="form-check-label" for="star4">4<i class="bi bi-star" style="color: rgb(255, 210, 49); font-size: 1.5rem;"></i></label>
                            &nbsp;&nbsp;
    
    <asp:RadioButton CssClass="star" ID="RadioButton25" runat="server" GroupName="rating2" value="5" />
                            <label class="form-check-label" for="star5">5<i class="bi bi-star" style="color: rgb(255, 210, 49); font-size: 1.5rem;"></i></label>
                        </div>
                    </div>
                </div>
                <%----------------------------------------------------Availability--%>
                <div class="col-md-12 text-left">
                    <asp:Label ID="Label3" runat="server" Text="Availability: " />
                    <br />
                    <!-- Star Rating Row -->
                    <div class="mb-3">
                        <div class="form-check form-check-inline">
                            <asp:RadioButton CssClass="star" ID="RadioButton31" runat="server" GroupName="rating3" value="1" />
                            <label class="form-check-label" for="star1">1<i class="bi bi-star" style="color: rgb(255, 210, 49); font-size: 1.5rem;"></i></label>
                            &nbsp;&nbsp;
    
    <asp:RadioButton CssClass="star" ID="RadioButton32" runat="server" GroupName="rating3" value="2" />
                            <label class="form-check-label" for="star2">2<i class="bi bi-star" style="color: rgb(255, 210, 49); font-size: 1.5rem;"></i></label>
                            &nbsp;&nbsp;
    
    <asp:RadioButton CssClass="star" ID="RadioButton33" runat="server" GroupName="rating3" value="3" />
                            <label class="form-check-label" for="star3">3<i class="bi bi-star" style="color: rgb(255, 210, 49); font-size: 1.5rem;"></i></label>
                            &nbsp;&nbsp;
    
    <asp:RadioButton CssClass="star" ID="RadioButton34" runat="server" GroupName="rating3" value="4" />
                            <label class="form-check-label" for="star4">4<i class="bi bi-star" style="color: rgb(255, 210, 49); font-size: 1.5rem;"></i></label>
                            &nbsp;&nbsp;
    
    <asp:RadioButton CssClass="star" ID="RadioButton35" runat="server" GroupName="rating3" value="5" />
                            <label class="form-check-label" for="star5">5<i class="bi bi-star" style="color: rgb(255, 210, 49); font-size: 1.5rem;"></i></label>
                        </div>
                    </div>
                </div>
                <%----------------------------------------------------Preparation and Organization--%>
                <div class="col-md-12 text-left">
                    <asp:Label ID="Label4" runat="server" Text="Preparation and Organization: " />
                    <br />
                    <!-- Star Rating Row -->
                    <div class="mb-3">
                        <div class="form-check form-check-inline">
                            <asp:RadioButton CssClass="star" ID="RadioButton41" runat="server" GroupName="rating4" value="1" />
                            <label class="form-check-label" for="star1">1<i class="bi bi-star" style="color: rgb(255, 210, 49); font-size: 1.5rem;"></i></label>
                            &nbsp;&nbsp;
    
    <asp:RadioButton CssClass="star" ID="RadioButton42" runat="server" GroupName="rating4" value="2" />
                            <label class="form-check-label" for="star2">2<i class="bi bi-star" style="color: rgb(255, 210, 49); font-size: 1.5rem;"></i></label>
                            &nbsp;&nbsp;
    
    <asp:RadioButton CssClass="star" ID="RadioButton43" runat="server" GroupName="rating4" value="3" />
                            <label class="form-check-label" for="star3">3<i class="bi bi-star" style="color: rgb(255, 210, 49); font-size: 1.5rem;"></i></label>
                            &nbsp;&nbsp;
    
    <asp:RadioButton CssClass="star" ID="RadioButton44" runat="server" GroupName="rating4" value="4" />
                            <label class="form-check-label" for="star4">4<i class="bi bi-star" style="color: rgb(255, 210, 49); font-size: 1.5rem;"></i></label>
                            &nbsp;&nbsp;
    
    <asp:RadioButton CssClass="star" ID="RadioButton45" runat="server" GroupName="rating4" value="5" />
                            <label class="form-check-label" for="star5">5<i class="bi bi-star" style="color: rgb(255, 210, 49); font-size: 1.5rem;"></i></label>
                        </div>
                    </div>
                </div>
                 <%----------------------------------------------------Professionalism--%>
                <div class="col-md-12 text-left">
                    <asp:Label ID="Label5" runat="server" Text="Professionalism: " />
                    <br />
                    <!-- Star Rating Row -->
                    <div class="mb-3">
                        <div class="form-check form-check-inline">
                            <asp:RadioButton CssClass="star" ID="RadioButton51" runat="server" GroupName="rating5" value="1" />
                            <label class="form-check-label" for="star1">1<i class="bi bi-star" style="color: rgb(255, 210, 49); font-size: 1.5rem;"></i></label>
                            &nbsp;&nbsp;
    
    <asp:RadioButton CssClass="star" ID="RadioButton52" runat="server" GroupName="rating5" value="2" />
                            <label class="form-check-label" for="star2">2<i class="bi bi-star" style="color: rgb(255, 210, 49); font-size: 1.5rem;"></i></label>
                            &nbsp;&nbsp;
    
    <asp:RadioButton CssClass="star" ID="RadioButton53" runat="server" GroupName="rating5" value="3" />
                            <label class="form-check-label" for="star3">3<i class="bi bi-star" style="color: rgb(255, 210, 49); font-size: 1.5rem;"></i></label>
                            &nbsp;&nbsp;
    
    <asp:RadioButton CssClass="star" ID="RadioButton54" runat="server" GroupName="rating5" value="4" />
                            <label class="form-check-label" for="star4">4<i class="bi bi-star" style="color: rgb(255, 210, 49); font-size: 1.5rem;"></i></label>
                            &nbsp;&nbsp;
    
    <asp:RadioButton CssClass="star" ID="RadioButton55" runat="server" GroupName="rating5" value="5" />
                            <label class="form-check-label" for="star5">5<i class="bi bi-star" style="color: rgb(255, 210, 49); font-size: 1.5rem;"></i></label>
                        </div>
                    </div>
                </div>
                <!------------------------------------------------- Rating Input Row -->
                <div class="mb-3">
                    <asp:Label ID="Label1" runat="server" Text="YOUR COMMENT: " />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="rating4" runat="server" ErrorMessage="Comment is required!" ControlToValidate="tbComment" ForeColor="Red" Display="Dynamic">*</asp:RequiredFieldValidator>
                    <br />
                    <asp:TextBox ID="tbComment" CssClass="textBox" runat="server" ValidationGroup="rating1" TextMode="MultiLine" Rows="3"></asp:TextBox>
                </div>
                <asp:Button ID="btnSubmit" runat="server" CssClass="btn-orange" Text="Submit" OnClick="btnSubmit_Click" ValidationGroup="rating1,rating2,rating3,rating,4,rating5" />
                <asp:ValidationSummary ID="ValidationSummary2" runat="server" ForeColor="Red" ValidationGroup="rating1,rating2,rating3,rating,4,rating5" HeaderText="The following problems have been encountered" ShowMessageBox="True" ShowSummary="False" />
            </div>
        </div>
    </div> 
</asp:Content>
