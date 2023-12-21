<%@ Page Title="" Language="C#" MasterPageFile="~/Student/CourseDetailHeader.master" AutoEventWireup="true" CodeBehind="CourseOverview.aspx.cs" Inherits="OnlineTutoringSystem.Student.WebForm3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .gray-row {
            background-color: #F3FCF4; /* Light grey background for odd rows */
        }
    </style>

    <!-- Course Overview -->
    <div class="row justify-content-center">
        <div class="col-8">
            <div class="row mt-3">
                <div class="col">
                    <asp:Label ID="OverviewLabel" runat="server" Text="Course Overview" CssClass="h4 fw-bold"></asp:Label>
                </div>
            </div>
            <div class="row mt-1 pb-3 content-row">
                <div class="col">
                    <span class="bi bi-info-circle icon"></span>
                    <asp:Label ID="OverviewContent" runat="server" CssClass="text-muted"></asp:Label>
                </div>
            </div>

            <!-- Course Description -->
            <div class="row mt-3 pb-3 gray-row">
                <div class="row mt-3">
                    <div class="col">
                        <asp:Label ID="DescriptionLabel" runat="server" Text="Description" CssClass="h4 fw-bold"></asp:Label>
                    </div>
                </div>
                <div class="row mt-1 pb-3 content-row">
                    <div class="col">
                        <span class="bi bi-book icon"></span>
                        <asp:Label ID="DescriptionContent" runat="server" CssClass="text-muted"></asp:Label>
                    </div>
                </div>
            </div>
            <!-- Who is this course for? -->

            <div class="row mt-3">
                <div class="col">
                    <asp:Label ID="ForWhoLabel" runat="server" Text="Who is this course for?" CssClass="h4 fw-bold"></asp:Label>
                </div>
            </div>
            <div class="row mt-1 pb-3 content-row">
                <div class="col">
                    <span class="bi bi-person icon"></span>
                    <asp:Label ID="ForWhoContent" runat="server" CssClass="text-muted"></asp:Label>
                </div>
            </div>

            <!-- Course Requirements -->
            <div class="row mt-3 pb-3 gray-row mb-4">
                <div class="row mt-3">
                    <div class="col">
                        <asp:Label ID="RequirementsLabel" runat="server" Text="Course Requirements" CssClass="h4 fw-bold"></asp:Label>
                    </div>
                </div>
                <div class="row mt-1 pb-3 content-row">
                    <div class="col">
                        <span class="bi bi-check icon"></span>
                        <asp:Label ID="RequirementsContent" runat="server" CssClass="text-muted"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>