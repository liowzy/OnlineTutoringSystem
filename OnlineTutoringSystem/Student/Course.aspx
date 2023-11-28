<%@ Page Title="" Language="C#" MasterPageFile="~/Header.Master" AutoEventWireup="true" CodeBehind="Course.aspx.cs" Inherits="OnlineTutoringSystem.WebForm5" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.18.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="../Content/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">

    <!-- Lightbox2 CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/css/lightbox.min.css">

    <link rel="stylesheet"  href="../Content/css/studentMaster.css"/>
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

        .card {
            width: 200px; /* Set the desired width for the card */
        }
        .container {
    margin: 0;
}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server"> 
     

    <%--------------------------------------------Best selling course----------------------------------%>
    <div class="container-fluid p-2 text-center" style="background-color: #F5F7FA;">
        <!-- Browse Top Categories Section -->
        <div class="row">
            <div class="row top-category p-3">
                <div class="col">
                    <asp:Label ID="Label18" runat="server" Text="Best selling courses of the month" CssClass="h3 mb-3 font-weight-bold"></asp:Label>
                </div>
            </div>

             <div class="row justify-content-center pt-2" style="margin-left:5%;">
            <asp:Repeater ID="RepeaterCourses" runat="server" DataSourceID="SqlDataSourceCourses">
                <ItemTemplate>
                    <div class="col-md-3 mb-4 mx-auto">
                        <div class="card border justify-content-center style="width: 10%; height: 25%;">
                            <!-- First Row: Image -->
                            <div class="card-img-top tutor-image">
                    <img src='data:image/jpeg;base64,<%# Convert.ToBase64String((byte[])Eval("course_pic")) %>' alt='<%# Eval("course_name") %>' class="img-fluid" style="width: 100%; height: 100%; object-fit: cover;"/>
                </div>

                            <!-- Second Row: Category and Price -->
                            <div class=" row card-body justify-content-between"> 
                                <div class="col-8 text-left">
                            <asp:Label ID="lblCategory" runat="server" Text='<%# Eval("cat_name") %>' CssClass="card-text text-muted mb-2" />

                                </div>
                                <div class="col-4">
                                <asp:Label ID="lblFee" runat="server" Text='<%# Eval("course_fee") %>' CssClass="card-text text-muted mb-2" /> 

                                </div>

                            </div>

                            <!-- Third Row: Name -->
                            <div class="card-footer text-left ">
                                <h6 class="card-title"><%# Eval("course_name") %></h6>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater> 

<asp:SqlDataSource ID="SqlDataSourceCourses" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
    SelectCommand="SELECT TOP 4 c.course_id, c.course_pic, c.course_name, c.course_fee, cat.cat_name
FROM Course c
JOIN Category cat ON c.cat_id = cat.cat_id
ORDER BY c.course_id DESC
"></asp:SqlDataSource>

            </div> 
        </div>
    </div>

     <%--------------------------------------------Popular Tutor course----------------------------------%>
    <div class="container-fluid p-2 text-center" style="background-color: #F5F7FA;">
        <!-- Browse Top Categories Section -->
        <div class="row">
            <div class="row top-category p-3">
                <div class="col">
                    <asp:Label ID="Label1" runat="server" Text="Popular instructor of the month" CssClass="h3 mb-3 font-weight-bold"></asp:Label>
                </div>
            </div>

             <div class="row justify-content-center pt-2" style="margin-left:5%;">
            <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource1">
                <ItemTemplate>
                    <div class="col-md-3 mb-4 mx-auto">
                        <div class="card border justify-content-center style="width: 10%; height: 25%;">
                            <!-- First Row: Image -->
                            <div class="card-img-top tutor-image">
                    <img src='data:image/jpeg;base64,<%# Convert.ToBase64String((byte[])Eval("tutor_picture")) %>' alt='<%# Eval("tutor_name") %>' class="img-fluid" style="width: 100%; height: 100%; object-fit: cover;"/>
                </div>

                            <!-- Second Row: Category and Price -->
                            <div class=" row card-body text-left">                                 
                            <asp:Label ID="lblCategory" runat="server" Text='<%# Eval("tutor_name") %>' CssClass="card-text text-muted mb-2" />                                 

                            </div>

                            <!-- Third Row: Name -->
                            <div class="card-footer text-left ">
                                <h6 class="card-title"><%# Eval("tutor_expertice") %></h6>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater> 

<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
    SelectCommand="SELECT TOP 4 tutor_picture, tutor_name, tutor_expertice
FROM [Tutor]
ORDER BY tutor_id DESC;
"></asp:SqlDataSource>

            </div> 
        </div>
    </div>
</asp:Content>
