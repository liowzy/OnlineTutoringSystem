<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorSideBar.Master" AutoEventWireup="true" CodeBehind="CourseDetail.aspx.cs" Inherits="OnlineTutoringSystem.Tutor.WebForm5" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

                    <link href="../Content/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">

                     <!-- Bootstrap CSS -->
                    <link href="../Content/boostrap-5.3.2-dist/css/bootstrap.min.css" rel="stylesheet">

                    <!-- Bootstrap JS (Popper.js and Bootstrap JS) -->
                    <script src="../Content/boostrap-5.3.2-dist/js/bootstrap.bundle.min.js"></script>

                    <!-- Bootstrap Icons CSS -->
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.18.0/font/bootstrap-icons.css" rel="stylesheet">

                    <!-- Include Lightbox2 CSS -->
                    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/css/lightbox.min.css">

                    <!-- Bootstrap 5 CSS -->
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">

                    <link rel="stylesheet"
                      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"
                      integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="
                      crossorigin="anonymous"
                      referrerpolicy="no-referrer"/>

                    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
                    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
                    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
                    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

    <style>
        .editBtn {
            text-decoration: none;
            background-color: #FFC107; /* Yellow background color for edit button */
            color: #212529; /* Text color */
            font-size: 1.1vw;
            border: none;
            margin-right: 5px; /* Adjust margin as needed */
            padding: 1% 5% 1% 5%;
        }

        .deleteBtn {
            text-decoration: none;
            background-color: #DC3545; /* Red background color for delete button */
            color: #fff; /* Text color */
            font-size: 1.1vw;
            border: none;
            padding: 1% 5% 1% 5%;
        }

        /* Add these styles to your existing styles */
    .image-container {
        border: 1px solid #ccc; /* Border style */
        padding: 10px; /* Add padding */
        max-width: 100%; /* Ensure the image doesn't overflow its container */
    }

    .img-thumbnail {
        width: 100%; /* Make the image fill its container */
        height: auto; /* Maintain aspect ratio */
        max-height: 200px; /* Set a max height */
    }

    .video-container {
        border: 1px solid #ccc; /* Border style */
        padding: 10px; /* Add padding */
        position: relative;
        overflow: hidden;
        max-width: 100%; /* Ensure the video doesn't overflow its container */
    }

    .embed-responsive-item {
        width: 100%; /* Make the video fill its container */
        height: 100%; /* Make the video fill its container */
    }
    </style>
         
<main id="main" class="main">
    <div class="pagetitle">
        <h1>View/Edit Course</h1>
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="../Student/HomePage.aspx">Home</a></li>
                <li class="breadcrumb-item active"><a href="MyCourses.aspx">My Courses</a></li>
                <li class="breadcrumb-item active">View Course</li>
            </ol>
        </nav>
    </div><!-- End Page Title -->

    <section class="section view-edit-course">
        <asp:Label ID="lblMessage" runat="server" CssClass="error-message" Visible="false"></asp:Label>

        <div class="col-xl-8">
            <div class="card">
                <div class="card-body pt-3">

                    <!-- Fourth Row -->
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="courseThumbnail">Course Thumbnail</label>
                            <div class="image-container">
                                <img id="imgCourseThumbnail" runat="server" class="img-thumbnail" alt="Course Thumbnail" />
                            </div>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="courseTrailer">Course Trailer</label>
                            <div class="video-container">
                                <iframe id="iframeCourseTrailer" runat="server" class="embed-responsive-item" allowfullscreen=""></iframe>
                            </div>
                        </div>
                    </div>

                    <h5 class="card-title">Course Information</h5>

                    <!-- Form Fields -->
                    <!-- Display-only Fields -->
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="courseName">Course Name</label>
                            <asp:Label ID="lblCourseName" runat="server" CssClass="form-control" Text=""></asp:Label>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="courseCategory">Course Category</label>
                            <asp:Label ID="lblCourseCategory" runat="server" CssClass="form-control" Text=""></asp:Label>
                        </div>
                    </div>

                    <div class="form-row">
                    <div class="form-group col-md-6">
                        <label for="courseLevel">Course Level</label>
                        <asp:Label ID="lblCourseLevel" runat="server" CssClass="form-control" Text=""></asp:Label>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="courseTopic">Course Topic</label>
                        <asp:Label ID="lblCourseTopic" runat="server" CssClass="form-control" Text=""></asp:Label>
                    </div>
                </div>

                <!-- Second Row -->
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label for="coursePrice">Course Price (RM)</label>
                        <asp:Label ID="lblCoursePrice" runat="server" CssClass="form-control" Text=""></asp:Label>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="courseLanguage">Course Language</label>
                        <asp:Label ID="lblCourseLanguage" runat="server" CssClass="form-control" Text=""></asp:Label>
                    </div>
                </div>

                <!-- Third Row -->
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label for="courseDuration">Course Duration</label>
                        <asp:Label ID="lblCourseDuration" runat="server" CssClass="form-control" Text=""></asp:Label>
                    </div>
                </div>

                 <h5 class="card-title">Advance Information</h5>

                <!-- Fifth Row -->
                <div class="form-row">
                    <div class="form-group col-md-12">
                        <label for="courseDescription">Course Description</label>
                        <asp:Label ID="lblCourseDescription" runat="server" CssClass="form-control" Text="" TextMode="MultiLine" Rows="4"></asp:Label>
                    </div>
                </div>

                <!-- Sixth Row -->
                <div class="form-row">
                    <div class="form-group col-md-12">
                        <label for="teachingContent">What will you teach in these courses?</label>
                        <asp:Label ID="lblCourseContent" runat="server" CssClass="form-control" Text="" TextMode="MultiLine" Rows="4"></asp:Label>
                    </div>
                </div>

                <!-- Seventh Row -->
                <div class="form-row">
                    <div class="form-group col-md-12">
                        <label for="targetAudience">Target Audience</label>
                        <asp:Label ID="lblCourseTargetAudience" runat="server" CssClass="form-control" Text="" TextMode="MultiLine" Rows="4"></asp:Label>
                    </div>
                </div>

                <!-- Eighth Row -->
                <div class="form-row">
                    <div class="form-group col-md-12">
                        <label for="courseRequirements">Course Requirements</label>
                        <asp:Label ID="lblCourseRequirements" runat="server" CssClass="form-control" Text="" TextMode="MultiLine" Rows="4"></asp:Label>
                    </div>
                </div>

                    <!-- Hidden field to store course ID -->
                    <asp:HiddenField ID="hdnCourseId" runat="server" />
                    
                    <!-- Display Delete Button -->
                    <div class="col-6 text-right">
                        <!-- Edit and Delete Buttons -->
                        <asp:LinkButton CssClass="editBtn btn-warning" ID="editBtn" runat="server" CommandName="Edit" CommandArgument='<%# Eval("course_id") %>' OnCommand="editBtn_Command">Edit</asp:LinkButton>
                       <asp:Button ID="deleteBtn" runat="server" CssClass="deleteBtn btn btn-danger"
                        OnClientClick="if (!confirm('Are you sure you want to delete this course?')) return false;"
                        OnClick="deleteBtn_Click"
                        CommandArgument='<%# Eval("course_id") %>'
                        UseSubmitBehavior="false"
                        Text="Delete" CausesValidation="false" />
                    </div>

                </div>
            </div>
        </div>
    </section>
</main>


</asp:Content>