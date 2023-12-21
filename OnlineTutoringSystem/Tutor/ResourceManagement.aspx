<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorSideBar.Master" AutoEventWireup="true" CodeBehind="ResourceManagement.aspx.cs" Inherits="OnlineTutoringSystem.Tutor.WebForm6" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Course File Details</title>
    <!-- Bootstrap CSS link -->

    <!-- Boostrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.18.0/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Include Lightbox2 CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/css/lightbox.min.css">
    <link href="~/Content/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">

    <!-- Add Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"
        integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="
        crossorigin="anonymous"
        referrerpolicy="no-referrer" />
    <!-- Bootstrap JS and Popper.js -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
        integrity="sha384-XqVuQ3TK1Zl9+mzgJz4NSeVoWTV2LJ1dvhE3HbXepXuUUuAKPfuIEjaaB6EGQhx"
        crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <main id="main" class="main">
        <div class="pagetitle">
            <h1>File Resource Management</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="../Student/HomePage.aspx">Home</a></li>
                    <li class="breadcrumb-item active">File Resource Management</li>
                </ol>
            </nav>
        </div>
        <!-- End Page Title -->

        <section class="section profile">
            <div class="row">
                <div class="col-xl-8">
                    <h3 class="mb-4">Course File Details</h3>

                    <!-- SqlDataSource to retrieve data -->
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
    SelectCommand="SELECT c.course_id, c.course_name AS CourseName, 
                   COUNT(f.file_id) AS TotalFileCount, 
                   COUNT(r.res_id) AS SumOfResId
                   FROM Course c
                   LEFT JOIN Resource r ON c.course_id = r.course_id
                   LEFT JOIN File_Attachment f ON r.res_id = f.res_id
                   WHERE c.tutor_id = @TutorId
                   GROUP BY c.course_id, c.course_name">
    <SelectParameters>
        <asp:SessionParameter Name="TutorId" SessionField="userId" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>

                    <asp:Label runat="server" ID="lblNoCourse" CssClass="text-info" Visible="false">
                        <h1 style="margin-top:30px">No Course Has Been Created.</h1>
                        <h3 style="color:darkred; margin-top:20px">### Please Create A Course Before File Management ###</h3>
                    </asp:Label>


                    <!-- GridView to display data -->
                    <asp:GridView ID="GridViewCourseDetails" runat="server" AutoGenerateColumns="False" CssClass="table table-striped"
                        DataSourceID="SqlDataSource1" DataKeyNames="course_id" Width="100%">
                        <Columns>
                            <asp:BoundField DataField="CourseName" HeaderText="Course Name" SortExpression="CourseName" />
                            <asp:TemplateField HeaderText="Total Resource Created">
                                <ItemTemplate>
                                    <%# Eval("SumOfResId") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            
                            <asp:BoundField DataField="TotalFileCount" HeaderText="Total File Uploaded" SortExpression="TotalFileCount" />
                            <asp:TemplateField HeaderText="Manage Files">
                                <ItemTemplate>
                                    <asp:Button runat="server" Text="Manage Files" CssClass="btn btn-primary" OnClick="Unnamed_Click"/>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </section>
    </main>
    <!-- End #main -->
</asp:Content>
