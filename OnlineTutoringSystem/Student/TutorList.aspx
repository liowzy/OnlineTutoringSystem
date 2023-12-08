﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Header.Master" AutoEventWireup="true" CodeBehind="TutorList.aspx.cs" Inherits="OnlineTutoringSystem.WebForm13" %>
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
            font-family: 'Lucida Sans'
        }

        .bg-image {
            background-size: cover;
            background-position: center center;
            background-repeat: no-repeat;
        }

        .bigger-row {
            height: 400px;
        }

        /*.card {
            height: 17rem;   
        }*/

        .card .card-img-top {
            height: 17rem;
            width: 100%;
            object-fit: cover;
        }

        .container {
            margin: 0;
        }

        .orangetxt {
            color: orangered;
        }

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


    <%-------------------------------------------course----------------------------------%>
    <div class="container-fluid p-2 text-center pb-0"> 
        <div class="row">
            <div class="row top-category p-3">
                <div class="col">
                    <asp:Label ID="Label18" runat="server" Text="Tutors" CssClass="h3 mb-3 font-weight-bold"></asp:Label>
                </div>
            </div>

            <div class="row justify-content-center pt-2" style="margin-left: 1.5%;">
                <asp:DataList ID="DataListCourses" runat="server" DataSourceID="SqlDataSourceTutors" RepeatColumns="4"
                    RepeatDirection="Horizontal" DataKeyField="tutor_id" OnSelectedIndexChanged="DataListCourses_SelectedIndexChanged">
                    <ItemTemplate>
                        <div class="col mb-4 mx-auto">
                            <div style="width: 280px;">
                                <img src='data:image/jpeg;base64,<%# Convert.ToBase64String((byte[])Eval("tutor_picture")) %>'
                                    alt='<%# Eval("tutor_name") %>' class="img-fluid" style="width: 100%; height: 12rem; object-fit: cover;" />

                                <!-- Second Row: Category and Price -->
                                <div class=" row card-body justify-content-center pb-0"> 
                                    <div class="col orangetxt" style="font-size: 1rem;">
                                        <asp:Label ID="lblFee" runat="server" Text='<%# Eval("tutor_expertice") %>' CssClass="card-text mb-2 fw-bold" />

                                    </div>

                                </div>

                                <!-- Third Row: Name -->
                                <div class="card-body text-center pb-0">
                                    <asp:Label ID="lblCourseName" runat="server" CssClass="card-title fw-bold" Text='<%# Eval("tutor_name") %>' Style="font-size: 1.1rem;"></asp:Label>
                                </div>

                                <!-- 4th Row: Star -->
                                <div class="card-footer">
                                    <div class="row justify-content-between">
                                        <div class="col-6 text-left">
                                            <asp:LinkButton CssClass="star" ID="LinkButton1" runat="server" Enabled="False">
    <i class="fa fa-star" style="color: orange;">&nbsp;<%# string.Format("{0:F1}", CalculateAverageRating(Eval("tutor_id").ToString())) %></i>
</asp:LinkButton>


                                        </div>
                                        <div class="col-6 text-right">
                                            <asp:LinkButton CssClass="selectBtn btn-orange" ID="selectBtn" runat="server" CommandName="Select" CommandArgument='<%# Eval("tutor_id") %>' OnCommand="selectBtn_Command">View&nbsp;<i class="fa fa-arrow-right"></i></asp:LinkButton>

                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:DataList>



                
                <asp:SqlDataSource ID="SqlDataSourceTutors" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                    SelectCommand="SELECT tutor_id, tutor_picture, tutor_name, tutor_expertice FROM Tutor ORDER BY tutor_id ASC"></asp:SqlDataSource>

            </div>
        </div>
    </div> 
    
            <div class="chatbotBtn"><a href="chatbot.aspx"><i class='bx bxs-message-dots'></i></a></div>
</asp:Content>

