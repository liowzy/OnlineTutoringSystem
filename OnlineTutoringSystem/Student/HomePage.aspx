﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Header.Master" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="OnlineTutoringSystem.WebForm3" %>

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
        body {
            margin: 0;
            padding: 0;
            overflow-x: hidden; 
        }

        .bg-image {
            background-size: cover;
            background-position: center center;
            background-repeat: no-repeat;
        }

        .bigger-row {
            height: 400px;
        }

        .card {
            width: 200px; /* Set the desired width for the card */
        }

        .container {
            margin: 0;
        }

        .prodDiv {
            width: 198.400px;
            height: 286.762px;
        }

        .prodDivBody { 
            height: 56px;
        }

        .prodPic {
            width: 198.400px;
            height: 198.762px;
        }
        
        .btn-orange {
            text-decoration: none;
            background-color: #FF6636; /* Orange background color */
            color: #fff;
            font-size: 1vw;
            border: none;  
        }

            .btn-orange:hover {
                text-decoration: none;
                background-color: #FF8C00;
                color: #fff;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid p-2">
        <div class="row bigger-row" style="background-color: #F0F2F5;">
            <div class="col-md-5 p-5" style="display: flex; flex-direction: column; align-items: flex-start;">
                <asp:Label ID="lblTitle" runat="server" Text="Learn with Expert Anytime Anywhere" CssClass="h2 mb-3 font-weight-bold"></asp:Label>
                <asp:Label ID="lblSubtitle" runat="server" Text="Our mission is to help people find the best courses online and learn with experts anytime, anywhere." CssClass="text-muted mb-3"></asp:Label>
                <asp:Button ID="btnCreateAccount" runat="server" Text="Create Account" CssClass="btn-orange" OnClick="btnCreateAccount_Click" />
            </div>
            <div class="col-md-7 bg-image" style="background-image: url('../imgs/img1.png');">
            </div>
        </div>
    </div>

    <%--------------------------------------------section 2 start----------------------------------%>

    <div class="container-fluid p-2 text-center">
        <!-- Browse Top Categories Section -->
        <div class="row top-category p-3">
            <div class="col">
                <asp:Label ID="Label2" runat="server" Text="Browse Top Categories" CssClass="h3 mb-3 font-weight-bold"></asp:Label>
            </div>
        </div>

        <!-- Item Display Section using DataList -->
        <div class="row justify-content-center" style="margin-left: 8%;">
            <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSource1" RepeatColumns="4">
                <ItemTemplate>
                    <div class="col p-2 mx-auto">
                        <div class="card justify-content-center text-left" style="background-color: <%# GetCardColor(Container.ItemIndex) %>;">
                            <div class="card-body">
                                <p class="card-title h5"><%# Eval("cat_name") %></p>
                                <p class="card-text h6 text-muted"><%# Eval("cat_sum") %> Courses</p>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:DataList>
        </div>
        <div class="row justify-content-center p-3">
            <div class="col-auto">
                <asp:Label ID="Label13" runat="server" Text="We have more category & subcategory." CssClass="m-0"></asp:Label>
            </div>
            <div class="col-auto">
                <asp:LinkButton ID="LinkButton13" runat="server" Style="color: orangered; text-decoration: none;" OnClick="LinkButton13_Click">Browse All&nbsp;<i class="fas fa-arrow-right"></i></asp:LinkButton>
            </div>
        </div>

    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT TOP 12 *
FROM [Category]
ORDER BY cat_sum DESC;
"></asp:SqlDataSource>

    <%--------------------------------------------section 3 start----------------------------------%>
    <div class="container-fluid p-2 text-center" style="background-color: #F5F7FA;">
        <!-- Browse Top Categories Section -->
        <div class="row">
            <div class="row top-category p-3">
                <div class="col">
                    <asp:Label ID="Label18" runat="server" Text="Top instructor of the month" CssClass="h3 mb-3 font-weight-bold"></asp:Label>
                </div>
            </div>

            <div class="row justify-content-center" style="margin-left: 5%;">
                <asp:Repeater ID="RepeaterTutors" runat="server" DataSourceID="SqlDataSourceTutors">
                    <ItemTemplate>
                        <div class="col-md-3 mb-4 mx-auto">
                            <div class="card border justify-content-center prodDiv">
                                <img src='data:image/jpeg;base64,<%# Convert.ToBase64String((byte[])Eval("tutor_picture")) %>'
                                    class="card-img-top prodPic" />

                                <%--<img src='../imgs/T1.png' alt='asd' class="card-img-top tutor-image" />--%>

                                <div class="card-body prodDivBody">
                                    <h5 class="card-title"><%# Eval("tutor_name") %></h5>
                                    <p class="card-text text-muted"><%# Eval("tutor_expertice") %></p>
                                </div>
                <asp:Button ID="ViewReviewButton" runat="server" Text="View" CssClass="btn btn-orange w-100 p-2" OnClick="ViewReviewButton_Click" CommandArgument='<%# Eval("tutor_id") %>' /> 
                            </div> 
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <asp:SqlDataSource ID="SqlDataSourceTutors" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
    SelectCommand="
        SELECT TOP 4 
            Tutor.tutor_id, 
            Tutor.tutor_picture, 
            Tutor.tutor_name, 
            Tutor.tutor_expertice,
            ISNULL(SUM(Review.review_rating), 0) AS total_rating,
            ISNULL(COUNT(Review.review_rating), 0) AS review_count,
            CASE 
                WHEN COUNT(Review.review_rating) > 0 THEN SUM(Review.review_rating) / COUNT(Review.review_rating)
                ELSE NULL 
            END AS average_rating 
        FROM 
            Tutor 
        LEFT JOIN 
            Review ON Tutor.tutor_id = Review.tutor_id 
        GROUP BY 
            Tutor.tutor_id, 
            Tutor.tutor_picture, 
            Tutor.tutor_name, 
            Tutor.tutor_expertice 
        ORDER BY 
            average_rating DESC">
</asp:SqlDataSource>

            </div>
            <div class="row justify-content-center p-3">
                <div class="col-auto">
                    <asp:Label ID="Label19" runat="server" Text="Thousands of students waiting for a instructor. Start teaching & earning now!" CssClass="m-0"></asp:Label>
                </div>
                <div class="col-auto">
                    <asp:LinkButton ID="LinkButton19" runat="server" Style="color: orangered; text-decoration: none;" OnClick="LinkButton19_Click">Become Instructor &nbsp;<i class="fas fa-arrow-right"></i></asp:LinkButton>
                </div>
            </div>
        </div>
    </div>

    
            <div class="chatbotBtn"><a href="chatbot.aspx"><i class='bx bxs-message-dots'></i></a></div>
</asp:Content>
