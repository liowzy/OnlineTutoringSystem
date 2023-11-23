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
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="row bigger-row" style="background-color: #F0F2F5;">
            <div class="col-md-5 p-5" style="display: flex; flex-direction: column; align-items: flex-start;">
                <asp:Label ID="lblTitle" runat="server" Text="Learn with Expert Anytime Anywhere" CssClass="h2 mb-3 font-weight-bold"></asp:Label>
                <asp:Label ID="lblSubtitle" runat="server" Text="Our mission is to help people find the best courses online and learn with experts anytime, anywhere." CssClass="text-muted mb-3"></asp:Label>
                <asp:Button ID="btnCreateAccount" runat="server" Text="Create Account" CssClass="btn-orange"/>
            </div>
            <div class="col-md-7 bg-image" style="background-image: url('imgs/img1.png');"> 
            </div> 
        </div>
    </div>
</asp:Content>
