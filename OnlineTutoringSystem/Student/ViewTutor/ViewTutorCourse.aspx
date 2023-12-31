﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Student/TutorDetailHeader.master" AutoEventWireup="true" CodeBehind="ViewTutorCourse.aspx.cs" Inherits="OnlineTutoringSystem.Student.ViewTutor.WebForm5" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
        
        .cnameheight{
            height: 4rem;
        }

        .tpicheight{
            height: 12.3rem;
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

    <div class="container mt-2">
       <asp:Label ID="Label1" runat="server" CssClass="h2" Text="Tutor Course"></asp:Label> 
        <hr />
        <div class="row justify-content-center" style="margin-left: 1.5%;"> 
            <asp:Label ID="Checkwl" runat="server" Text="No course" CssClass="h4 font-weight-bold text-muted" Visible="False"></asp:Label>
            
            <asp:DataList ID="DataListCourses" runat="server" DataSourceID="SqlDataSourceCourses" RepeatColumns="2"
                RepeatDirection="Horizontal" DataKeyField="course_id" OnSelectedIndexChanged="DataListCourses_SelectedIndexChanged">
                <ItemTemplate>
                    <div class="col mb-4 mx-auto">
                        <div style="width: 280px;">
                            <img src='data:image/jpeg;base64,<%# Convert.ToBase64String((byte[])Eval("course_pic")) %>'
                                alt='<%# Eval("course_name") %>' class="img-fluid" style="width: 100%; height: 12rem; object-fit: cover;" />

                            <!-- Second Row: Category and Price -->
                            <div class=" row card-body justify-content-between pb-0">
                                <div class="col text-left" style="font-size: 0.85rem;">
                                    <div class="col">
                                        <asp:Label ID="lblCategory" runat="server" Text='<%# Eval("cat_name") %>' CssClass="mb-2 fw-bold text-uppercase ml-1 p-2" Style='<%# "background-color: " + GetCardColor(Container.ItemIndex) %>' />
                                    </div>

                                </div>
                                <div class="col orangetxt" style="font-size: 1rem;">
                                    <asp:Label ID="lblFee" runat="server" Text='<%# "RM " + Eval("course_fee") %>' CssClass="card-text mb-2 fw-bold" />

                                </div>

                            </div>

                            <!-- Third Row: Name -->
                            <div class="card-body cnameheight text-left pb-0">
                                <asp:Label ID="lblCourseName" runat="server" CssClass="card-title fw-bold" Text='<%# Eval("course_name") %>' Style="font-size: 1.1rem;"></asp:Label>
                            </div>

                            <!-- 4th Row: Star -->
                            <div class="card-footer">
                                <divs class="row justify-content-between">
                                    <div class="col-6 text-left">
                                        <asp:LinkButton CssClass="star" ID="LinkButton1" runat="server" Enabled="False">
    <i class="fa fa-star" style="color: orange;">&nbsp;<%# string.Format("{0:F1}", CalculateAverageRating(Eval("course_id").ToString())) %></i>
                                        </asp:LinkButton>


                                    </div>
                                    <div class="col-6 text-right">
                                        <asp:LinkButton class="btn btn-primary" style="background-color: #FF6636; border-color: #FF6636;" ID="selectBtn" runat="server" CommandName="Select" CommandArgument='<%# Eval("course_id") %>' OnCommand="selectBtn_Command">View&nbsp;<i class="fa fa-arrow-right"></i></asp:LinkButton>

                                    </div>
                                </divs>

                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:DataList>



            <asp:SqlDataSource ID="SqlDataSourceCourses" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                SelectCommand="SELECT c.course_id, c.course_pic, c.course_name, c.course_fee, cat.cat_name
                   FROM Course c
                   JOIN Category cat ON c.cat_id = cat.cat_id
                   WHERE c.tutor_id = @TutorId
                   ORDER BY c.course_id ASC">
                <SelectParameters>
                    <asp:SessionParameter Name="TutorId" SessionField="tutorId" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>


        </div>
    </div>
</asp:Content>
