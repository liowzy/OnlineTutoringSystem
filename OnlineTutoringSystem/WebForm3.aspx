<%@ Page Title="" Language="C#" MasterPageFile="~/Header.Master" AutoEventWireup="true" CodeBehind="WebForm3.aspx.cs" Inherits="OnlineTutoringSystem.WebForm3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Include necessary Bootstrap CSS if not already included -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    
    <link href="Content/css/studentMaster.css" rel="stylesheet" />

    <style>
        body {
            margin: 0;
            padding: 0;
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
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid p-2">
        <div class="row bigger-row" style="background-color: #F0F2F5;">
            <div class="col-md-5 p-5" style="display: flex; flex-direction: column; align-items: flex-start;">
                <asp:Label ID="lblTitle" runat="server" Text="Learn with Expert Anytime Anywhere" CssClass="h2 mb-3 font-weight-bold"></asp:Label>
                <asp:Label ID="lblSubtitle" runat="server" Text="Our mission is to help people find the best courses online and learn with experts anytime, anywhere." CssClass="text-muted mb-3"></asp:Label>
                <asp:Button ID="btnCreateAccount" runat="server" Text="Create Account" CssClass="btn-orange"/>
            </div>
            <div class="col-md-7 bg-image" style="background-image: url('imgs/img1.png');"> 
            </div> 
        </div>

        <%--------------------------------------------section 2 start----------------------------------%>

        <div class="row p-2 d-flex align-items-center justify-content-center">
            <!-- Browse Top Categories Section -->
            <div class="row top-category">
                <div class="col">
                    <asp:Label ID="Label2" runat="server" Text="Browse Top Categories" CssClass="h3 mb-3 font-weight-bold"></asp:Label>
                </div>
            </div>

            <!-- Item Display Section using DataList -->
            <div class="row">
                <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSource1" RepeatColumns="4">
                    <ItemTemplate>
                        <div class="col">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title"><%# Eval("cat_name") %></h5>
                                    <p class="card-text"><%# Eval("cat_sum") %> Courses</p>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:DataList>
            </div> 

        </div>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Category]"></asp:SqlDataSource>

    </div>
</asp:Content>
