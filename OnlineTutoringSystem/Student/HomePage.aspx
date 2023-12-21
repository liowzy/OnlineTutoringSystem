<%@ Page Title="" Language="C#" MasterPageFile="~/Header.Master" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="OnlineTutoringSystem.WebForm3" %>

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
            height: 176.762px;
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
                <asp:Label ID="Label2" runat="server" Text="What Courses Avaialble Here" CssClass="h3 mb-3 font-weight-bold"></asp:Label>
            </div>
        </div>

        <!-- Item Display Section using DataList -->
         
        <div class="row justify-content-center pt-2" style="margin-left: 1.5%;">
                <asp:DataList ID="DataListCourses" runat="server" DataSourceID="SqlDataSourceCourses" RepeatColumns="4"
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
                                    <div class="row justify-content-between">
                                        <div class="col-6 text-left">
                                            <asp:LinkButton CssClass="star" ID="LinkButton1" runat="server" Enabled="False">
                                            <i class="fa fa-star" style="color: orange;">&nbsp;<%# string.Format("{0:F1}", CalculateAverageRating(Eval("course_id").ToString())) %></i>
                                            </asp:LinkButton>


                                        </div>
                                        <div class="col-6 text-right">
                                            <asp:LinkButton CssClass="selectBtn btn-orange" ID="selectBtn" runat="server" CommandName="Select" CommandArgument='<%# Eval("course_id") %>' OnCommand="selectBtn_Command">View&nbsp;<i class="fa fa-arrow-right"></i></asp:LinkButton>

                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:DataList>



                <asp:SqlDataSource ID="SqlDataSourceCourses" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                    SelectCommand="SELECT TOP 4 c.course_id, c.course_pic, c.course_name, c.course_fee, cat.cat_name, (SELECT AVG(review_rating) FROM Review WHERE course_id = c.course_id) AS AvgRating FROM Course c JOIN Category cat ON c.cat_id = cat.cat_id ORDER BY AvgRating DESC"></asp:SqlDataSource>

            </div>

        <div class="row justify-content-center p-3">
            <div class="col-auto">
                <asp:Label ID="Label13" runat="server" Text="We have more course." CssClass="m-0"></asp:Label>
            </div>
            <div class="col-auto">
                <asp:LinkButton ID="LinkButton13" runat="server" Style="color: orangered; text-decoration: none;" OnClick="LinkButton13_Click">Browse All&nbsp;<i class="fas fa-arrow-right"></i></asp:LinkButton>
            </div>
        </div>

    </div> 

    <%--------------------------------------------section 3 start----------------------------------%>
    <div class="container-fluid p-2 text-center" style="background-color: #F5F7FA;">
        <!-- Browse Top Categories Section -->
        <div class="row">
            <div class="row top-category p-3">
                <div class="col">
                    <asp:Label ID="Label18" runat="server" Text="Top Instructor Of The Month" CssClass="h3 mb-3 font-weight-bold"></asp:Label>
                </div>
            </div>
   <div class="row justify-content-center pt-2" style="margin-left: 1.5%;">
                <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSourceTutors" RepeatColumns="4"
                    RepeatDirection="Horizontal" DataKeyField="tutor_id" OnSelectedIndexChanged="DataListCourses2_SelectedIndexChanged">
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
    <i class="fa fa-star" style="color: orange;">&nbsp;<%# string.Format("{0:F1}", CalculateAverageRating2(Eval("tutor_id").ToString())) %></i>
</asp:LinkButton>


                                        </div>
                                        <div class="col-6 text-right">
                                            <asp:LinkButton CssClass="selectBtn btn-orange" ID="selectBtn" runat="server" CommandName="Select" CommandArgument='<%# Eval("tutor_id") %>' OnCommand="selectBtn2_Command">View&nbsp;<i class="fa fa-arrow-right"></i></asp:LinkButton>

                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:DataList>



                
                <asp:SqlDataSource ID="SqlDataSourceTutors" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                    SelectCommand="SELECT TOP 4 Tutor.tutor_id, Tutor.tutor_picture, Tutor.tutor_name, Tutor.tutor_expertice,ISNULL(SUM(Review.review_rating), 0) AS total_rating, ISNULL(COUNT(Review.review_rating), 0) AS review_count, CASE WHEN COUNT(Review.review_rating) > 0 THEN SUM(Review.review_rating) / COUNT(Review.review_rating) ELSE NULL END AS average_rating FROM Tutor LEFT JOIN Review ON Tutor.tutor_id = Review.tutor_id GROUP BY Tutor.tutor_id, Tutor.tutor_picture, Tutor.tutor_name, Tutor.tutor_expertice  ORDER BY average_rating DESC"></asp:SqlDataSource>
       
            </div>

            <%--<div class="row justify-content-center" style="margin-left: 5%;">
                <asp:Repeater ID="RepeaterTutors" runat="server" DataSourceID="SqlDataSourceTutors">
                    <ItemTemplate>
                        <div class="col-md-3 mb-4 mx-auto">
                            <div class="card border justify-content-center prodDiv">
                                <div class="prodPic">
                                    <img src='data:image/jpeg;base64,<%# Convert.ToBase64String((byte[])Eval("tutor_picture")) %>'
                                    class="card-img-top" style="width: 100%; height:100%; object-fit:cover;"/>
                                </div>
                                
                                 

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

            </div>--%>
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
                <div class="chatbotBtn" onclick="openChatbotWindow()">
                <i class='bx bxs-message-dots'></i>
            </div>   
    
    <script>
        function openChatbotWindow() {
            // Specify the URL of your chatbot.aspx page
            var chatbotUrl = 'chatbot.aspx';

            // Set the width and height of the new window
            var windowWidth = 400;
            var windowHeight = 600;

            // Calculate the position to center the window on the screen
            var windowLeft = (window.innerWidth - windowWidth) / 2;
            var windowTop = (window.innerHeight - windowHeight) / 2;

            // Open the new window with the specified properties
            window.open(chatbotUrl, 'ChatbotWindow', 'width=' + windowWidth + ', height=' + windowHeight + ', left=' + windowLeft + ', top=' + windowTop);
        }
    </script>
</asp:Content>
