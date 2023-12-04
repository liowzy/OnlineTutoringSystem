<%@ Page Title="" Language="C#" MasterPageFile="~/Header.Master" AutoEventWireup="true" CodeBehind="EnrollmentDetail.aspx.cs" Inherits="OnlineTutoringSystem.WebForm8" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.18.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="../Content/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <!-- Bootstrap JS (Popper.js and Bootstrap JS) -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>

    <!-- Lightbox2 CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/css/lightbox.min.css">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

    <link rel="stylesheet" href="../Content/css/studentMaster.css" />
    <link rel="stylesheet" href="../Content/fontawesome-free-5.15.4-web/css/all.min.css">
    <script>
        function toggleCollapse(childDataListId) {
            $('#' + childDataListId).collapse('toggle');
        }
    </script>
    <style>
        body {
            margin: 0;
            padding: 0;
            overflow-x: hidden;
        }

        .btn-or {
            border-top: 2px solid transparent; /* Set transparent border by default */
        }

            .btn-or:hover {
                border-bottom-color: orange; /* Set the color on hover */
            }


        .custom-shadow {
            box-shadow: 0 0 10px rgba(255, 255, 255, 0.8); /* Adjust the color and opacity as needed */
        }

        .accordion-button {
            color: #fff;
            background-color: #007bff;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row mt-5 p-3">
            <div class="col-md-8 offset-md-2">
                <!-- Course Details -->
                <div class="card">
                    <div class="card-header">
                        <h4 class="card-title">
                            <asp:Label ID="lblCourseName" runat="server" ></asp:Label></h4>
                    </div>
                    <div class="card-body">
                        <!-- Course Image, Name, Tutor, Purchased Date -->
                        <div class="row">
                            <div class="col-md-4">
                                <asp:Image ID="imgCourse" runat="server" CssClass="img-fluid" AlternateText="Course Image" />
                            </div>
                            <div class="col-md-8">
                                <p>Tutor:
                                    <asp:Label ID="lblTutorName" runat="server"  ></asp:Label></p>
                                <p>Purchased Date:
                                    <asp:Label ID="lblPurchasedDate" runat="server"  ></asp:Label></p>
                                <!-- Rate Tutor and Course Button (Aligned to the right) -->
                                <div class="text-right">
<asp:Button ID="btnRateTutorAndCourse" runat="server" CssClass="btn btn-primary" Text="Rate Tutor and Course" OnClick="btnRateTutorAndCourse_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <%--resource and file display--%>

        <div class="row mt-5 p-3">
            <div class="col-md-8 offset-md-2">
                <asp:DataList CssClass="dataList" ID="ParentDataList" runat="server" CellSpacing="5">
                    <ItemTemplate>
                        <div class="itemTemplate">
                            <!-- Display resource information here -->
                            <h4><%# Eval("res_name") %></h4>
                            <asp:Button CssClass="expandBtn btn btn-link" ID="ExpandButton" runat="server" Text="More" data-bs-toggle="collapse" data-bs-target='<%# "#childCollapse_" + Container.ItemIndex %>'></asp:Button>

                            <!-- Display file information here -->
                            <div id='<%# "childCollapse_" + Container.ItemIndex %>' class="collapse">
                                <asp:DataList ID="ChildDataList" runat="server">
                                    <ItemTemplate>
                                        <p>File Name: <%# Eval("file_name") %></p>
                                        <p>File Path: <%# Eval("file_path") %></p>
                                    </ItemTemplate>
                                </asp:DataList>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:DataList>
            </div>
        </div>
    </div> 
</asp:Content>
