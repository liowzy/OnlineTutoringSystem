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

          <!-- Form Fields -->
            <div class="form-row">
               <!-- Course Thumbnail -->
                <div class="form-group col-md-6">
                    <label for="fileUploadThumbnail">Course Thumbnail</label>
                    <div class="image-container" id="courseThumbnailContainer" style="width: 100%; height: 230px; border: 1px solid #ccc; display: flex; align-items: center; justify-content: center; background-color: #f8f8f8;">
                        <asp:Image ID="imgCourseThumbnail" runat="server" CssClass="img-thumbnail" AlternateText="Course Thumbnail" style="width: 100%; height: 230px; border: 1px solid #ccc; display: flex; align-items: center; justify-content: center; background-color: #f8f8f8;" />
                    </div>
                    <asp:FileUpload ID="fileUploadThumbnail" runat="server" CssClass="btn btn-primary" Accept=".jpg, .jpeg, .png" onchange="showThumbnail(this)" Style="background-color: #FF6636; border-color: #FF6636; width: 100%; font-size: small; border-radius: 0; margin-top: 20px" Visible="false" />
                </div>

                <!-- Course Trailer -->
                <div class="form-group col-md-6">
                    <label for="fileUploadTrailer">Course Trailer</label>
                    <div class="video-container" id="courseTrailerContainer" style="width: 100%; height: 230px; border: 1px solid #ccc; display: flex; align-items: center; justify-content: center; background-color: #f8f8f8;">
                        <iframe id="iframeCourseTrailer" typeof="video/mp4" runat="server" class="video-container" allowfullscreen="" style="width: 100%; height: 230px; border: 1px solid #ccc; display: flex; align-items: center; justify-content: center; background-color: #f8f8f8;"></iframe>
                    </div>
                    <asp:FileUpload ID="fileUploadTrailer" runat="server" CssClass="btn btn-primary" onchange="showVideo(this)" Style="background-color: #FF6636; border-color: #FF6636; width: 100%; font-size: small; border-radius: 0; margin-top: 20px" ReadOnly="true" Visible="false" />
                </div>
            </div>

                    <h5 class="card-title">Course Information</h5>

                    <!-- Form Fields -->
                    <!-- Display-only Fields -->
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="courseName">Course Name</label>
                            <asp:TextBox ID="txtCourseName" runat="server" CssClass="form-control" Text="" ReadOnly="true"></asp:TextBox>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="courseCategory">Course Category</label>
                            <asp:TextBox ID="txtCourseCategory" runat="server" CssClass="form-control" Text="" ReadOnly="true"></asp:TextBox>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="courseLevel">Course Level</label>
                            <asp:TextBox ID="txtCourseLevel" runat="server" CssClass="form-control" Text="" ReadOnly="true"></asp:TextBox>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="courseTopic">Course Topic</label>
                            <asp:TextBox ID="txtCourseTopic" runat="server" CssClass="form-control" Text="" ReadOnly="true"></asp:TextBox>
                        </div>
                    </div>

                    <!-- Second Row -->
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="coursePrice">Course Price (RM)</label>
                            <asp:TextBox ID="txtCoursePrice" runat="server" CssClass="form-control" Text="" ReadOnly="true"></asp:TextBox>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="courseLanguage">Course Language</label>
                            <asp:TextBox ID="txtCourseLanguage" runat="server" CssClass="form-control" Text="" ReadOnly="true"></asp:TextBox>
                        </div>
                    </div>

                    <!-- Third Row -->
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="courseDuration">Course Duration</label>
                            <asp:TextBox ID="txtCourseDuration" runat="server" CssClass="form-control" Text="" ReadOnly="true"></asp:TextBox>
                        </div>
                    </div>

                    <h5 class="card-title">Advance Information</h5>

                    <!-- Fifth Row -->
                    <div class="form-row">
                        <div class="form-group col-md-12">
                            <label for="courseDescription">Course Description</label>
                            <asp:TextBox ID="txtCourseDescription" runat="server" CssClass="form-control" Text="" TextMode="MultiLine" Rows="4" ReadOnly="true"></asp:TextBox>
                        </div>
                    </div>

                    <!-- Sixth Row -->
                    <div class="form-row">
                        <div class="form-group col-md-12">
                            <label for="teachingContent">What will you teach in these courses?</label>
                            <asp:TextBox ID="txtCourseContent" runat="server" CssClass="form-control" Text="" TextMode="MultiLine" Rows="4" ReadOnly="true"></asp:TextBox>
                        </div>
                    </div>

                    <!-- Seventh Row -->
                    <div class="form-row">
                        <div class="form-group col-md-12">
                            <label for="targetAudience">Target Audience</label>
                            <asp:TextBox ID="txtCourseTargetAudience" runat="server" CssClass="form-control" Text="" TextMode="MultiLine" Rows="4" ReadOnly="true"></asp:TextBox>
                        </div>
                    </div>

                    <!-- Eighth Row -->
                    <div class="form-row">
                        <div class="form-group col-md-12">
                            <label for="courseRequirements">Course Requirements</label>
                            <asp:TextBox ID="txtCourseRequirements" runat="server" CssClass="form-control" Text="" TextMode="MultiLine" Rows="4" ReadOnly="true"></asp:TextBox>
                        </div>
                    </div>

                    <!-- Hidden field to store course ID -->
                    <asp:HiddenField ID="hdnCourseId" runat="server" />
                    
                    <!-- Display Delete Button -->
                    <div class="col-6 text-right">
                         <!-- Edit and Delete Buttons -->
                        <asp:Button ID="btnEdit" runat="server" CssClass="btn btn-primary"  style="background-color: #FF6636; border-color: #FF6636;" Text="Edit" OnClick="btnEdit_Click" />
                        <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-primary"   style="background-color: #FF6636; border-color: #FF6636;" Text="Update" 
                       OnClientClick="if (!confirm('Are you sure you want to update this course?')) return false;"
                       OnClick="btnUpdate_Click" Visible="false" CausesValidation="false"  />
                        <asp:Button ID="btnCancel" runat="server" CssClass=" btn btn-primary btn-danger" Text="Cancel" OnClick="btnCancel_Click" Visible="false" />
                       <asp:Button ID="deleteBtn" runat="server" CssClass=" btn btn-primary btn-danger"
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

 <script>
     function showThumbnail(input) {
         var file = input.files[0];
         var courseThumbnailContainer = document.getElementById('courseThumbnailContainer');
         var imgCourseThumbnail = document.getElementById('<%= imgCourseThumbnail.ClientID %>');

        if (file) {
            var reader = new FileReader();
            reader.onload = function (e) {
                courseThumbnailContainer.innerHTML = '<img src="' + e.target.result + '" style="max-width: 100%; max-height: 100%;">';
            }
            reader.readAsDataURL(file);
        } else {
            courseThumbnailContainer.innerHTML = '<i class="bi bi-image" style="font-size: 3rem; color: #ccc;"></i>';
        }
    }

    function showVideo(input) {
        var file = input.files[0];
        var courseTrailerContainer = document.getElementById('courseTrailerContainer');
             var iframeCourseTrailer = document.getElementById('<%= iframeCourseTrailer.ClientID %>');

             if (file) {
                 var reader = new FileReader();
                 reader.onload = function (e) {
                     courseTrailerContainer.innerHTML = '<video width="100%" height="100%" controls><source src="' + e.target.result + '" type="video/mp4">Your browser does not support the video tag.</video>';
                 }
                 reader.readAsDataURL(file);
             } else {
                 courseTrailerContainer.innerHTML = '<i class="bi bi-play" style="font-size: 3rem; color: #ccc;"></i>';
             }
         }
 </script>
</main>


</asp:Content>