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

        .newResourceRow {
            border-top: 2px solid #007bff; /* Add a border to separate new resource names */
            padding-top: 10px; /* Adjust padding for better spacing */
        }

        .sameResourceRow {
            /* Apply styles for rows with the same resource name if needed */
        }

        .separator {
            margin-top: 10px; /* Adjust margin for better spacing */
            margin-bottom: 10px; /* Adjust margin for better spacing */
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
                            <asp:Label ID="lblCourseName" runat="server"></asp:Label></h4>
                    </div>
                    <div class="card-body">
                        <!-- Course Image, Name, Tutor, Purchased Date -->
                        <div class="row">
                            <div class="col-md-4">
                                <asp:Image ID="imgCourse" runat="server" CssClass="img-fluid" AlternateText="Course Image" />
                            </div>
                            <div class="col-md-8">
                                <p>
                                    Tutor:
                                    <asp:Label ID="lblTutorName" runat="server"></asp:Label>
                                </p>
                                <p>
                                    Purchased Date:
                                    <asp:Label ID="lblPurchasedDate" runat="server"></asp:Label>
                                </p>
                                <!-- Rate Tutor and Course Button (Aligned to the right) -->
                                <div class="text-right">
                                    <asp:Button ID="btnRateTutorAndCourse" runat="server" class="btn btn-primary" style="background-color: #FF6636; border-color: #FF6636;" style="background-color: #FF6636; border-color: #FF6636;" Text="Rate Tutor and Course" OnClick="btnRateTutorAndCourse_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        
            
        <%--resource and file display--%>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
    SelectCommand="SELECT R.res_id, R.res_name, F.file_id, F.file_name
                   FROM Resource R
                   INNER JOIN File_Attachment F ON R.res_id = F.res_id
                   WHERE R.course_id = @CourseID
                   ORDER BY R.res_id, F.file_id">
    <SelectParameters>
        <asp:SessionParameter Name="CourseID" SessionField="courseId" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>

        
        <div class="row p-3 pt-1">
            <div class="row top-category p-3">
                <div class="col text-center">
                    <asp:Label ID="Label18" runat="server" Text="Class Material" CssClass="h3 mt-3 font-weight-bold"></asp:Label>
                </div>
            </div>
            <div class="col-md-8 offset-md-2">
                <div class="card mt-1">
                    <div class="card-body">

                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="dataList" BorderStyle="None" Width="100%"
                            DataSourceID="SqlDataSource1">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <!-- Display resource and file information -->
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <h4 class="resourceName pl-4"><%# Eval("res_name") %></h4>
                                                <p class="m-0 pl-4">File Name: <%# Eval("file_name") %></p>
                                            </div>
                                            <!-- Button to jump to another page -->
                                            <asp:Button ID="btnOpen" runat="server" Text="Open" OnClick="btnOpen_Click" CssClass="btn btn-primary btn-sm" CommandArgument='<%# Eval("file_id") %>' />
                                        </div>
                                        <hr class="separator" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>


                    </div>
                </div>
            </div>
        </div>




    </div>
</asp:Content>
