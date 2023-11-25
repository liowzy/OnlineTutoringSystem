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
                <asp:Repeater ID="RepeaterTutors" runat="server" DataSourceID="SqlDataSourceTutors">
                    <ItemTemplate>
                        <div class="col-md-3 mb-4 mx-auto">
                            <div class="card border justify-content-center">
                                <%--<img src='<%# Eval("tutor_picture") %>' alt='<%# Eval("tutor_name") %>' class="card-img-top tutor-image" />--%>
                                <img src='../imgs/T1.png' alt='asd' class="card-img-top tutor-image" />

                                <div class="card-body">
                                    <h5 class="card-title"><%# Eval("tutor_name") %></h5>
                                    <p class="card-text text-muted"><%# Eval("tutor_expertice") %></p>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                <asp:SqlDataSource ID="SqlDataSourceTutors" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                    SelectCommand="SELECT TOP 4 tutor_id, tutor_picture, tutor_name, tutor_expertice FROM Tutor ORDER BY tutor_dob DESC"></asp:SqlDataSource>
            </div>
        </div>
    </div>
</asp:Content>
