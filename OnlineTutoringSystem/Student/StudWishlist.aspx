<%@ Page Title="" Language="C#" MasterPageFile="~/Student/StudDashboard.master" AutoEventWireup="true" CodeBehind="StudWishlist.aspx.cs" Inherits="OnlineTutoringSystem.Student.WebForm2" %>

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

    <div class="container-fluid p-4 text-center d-flex justify-content-center">
        <div class="col-md-8 bg-white p-4">
            <!-- Wishlist Section -->
            <div class="row">
                <div class="row top-category mb-3">
                    <div class="col">
                        <asp:Label ID="Label18" runat="server" Text="Wishlist" CssClass="h3 font-weight-bold"></asp:Label>
                    </div>
                </div>
            </div>  
            <div class="row justify-content-center"">
                        <asp:Label ID="Checkwl" runat="server" Text="Your wishlist is empty" CssClass="h4 font-weight-bold text-muted" Visible="False"></asp:Label>
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
                                <div class="card-body text-left pb-0">
                                    <asp:Label ID="lblCourseName" runat="server" CssClass="card-title fw-bold" Text='<%# Eval("course_name") %>' Style="font-size: 1.1rem;"></asp:Label>
                                </div>

                                <!-- 4th Row: Star -->
                                <div class="card-footer">
                                    <div class="row justify-content-between">

                                        <div class="col-6 text-left">
                                            <asp:LinkButton CssClass="star" ID="star1" runat="server" Enabled="False"><i class="fa fa-star" style="color: orange;">&nbsp;5.0</i></asp:LinkButton>

                                        </div>
                                        <div class="col-6 text-right">
                                            <asp:LinkButton class="btn btn-primary" style="background-color: #FF6636; border-color: #FF6636;" ID="selectBtn" runat="server" CommandName="Select" CommandArgument='<%# Eval("course_id") %>' OnCommand="selectBtn_Command">View&nbsp;<i class="fa fa-arrow-right"></i></asp:LinkButton>

                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:DataList>

                 <asp:SqlDataSource ID="SqlDataSourceCourses" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
    SelectCommand="SELECT c.course_id, c.course_pic, c.course_name, c.course_fee, cat.cat_name
                   FROM Course c
                   JOIN Category cat ON c.cat_id = cat.cat_id
                   JOIN Wishlist w ON c.course_id = w.course_id
                   WHERE w.stud_id = @StudId
                   ORDER BY c.course_id ASC">
    <SelectParameters>
        <asp:SessionParameter Name="StudId" SessionField="userID" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>

            </div>
        </div>
    </div>
</asp:Content>
