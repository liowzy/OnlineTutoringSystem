<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorSideBar.Master" AutoEventWireup="true" CodeBehind="CreateCourse.aspx.cs" Inherits="OnlineTutoringSystem.Tutor.WebForm3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <title>Create Courses</title>

<link href="Content/css/signUpMaster.css" rel="stylesheet" />

<!-- Bootstrap 4 CSS -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

<!-- Bootstrap Icons CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.18.0/font/bootstrap-icons.css" rel="stylesheet">

<!-- Include Lightbox2 CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/css/lightbox.min.css">

<!-- Bootstrap 5 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<!-- Bootstrap 5 JS (Popper.js is required for dropdowns, tooltips, and popovers) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>


      <main id="main" class="main">

  <div class="pagetitle">
    <h1>Create New Course</h1>
    <nav>
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="Profile.aspx">Home</a></li>
        <li class="breadcrumb-item active">Create New Courses</li>
      </ol>
    </nav>
  </div><!-- End Page Title -->

  <section class="section create-courses">

    <div class="col-xl-8">

        <div class="card">
            <div class="card-body pt-3">
                <!-- Bordered Tabs -->
                <ul class="nav nav-tabs nav-tabs-bordered">

                    <li class="nav-item">
                        <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#course-info">Course
                            Info</button>
                    </li>

                    <li class="nav-item">
                        <button class="nav-link" data-bs-toggle="tab" data-bs-target="#course-content">Content</button>
                    </li>

                    <li class="nav-item">
                        <button class="nav-link" data-bs-toggle="tab" data-bs-target="#course-settings">Settings</button>
                    </li>

                    <li class="nav-item">
                        <button class="nav-link" data-bs-toggle="tab" data-bs-target="#review-publish">Review &
                            Publish</button>
                    </li>

                </ul>
                <div class="tab-content pt-2">

                  <div class="tab-pane fade show active course-info" id="course-info">
                    <!-- Course Info Form -->
                    <h5 class="card-title">Course Information</h5>

                    <!-- Form Fields -->
                    <form>
                        <!-- First Row -->
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="courseName">Course Name</label>
                                <input type="text" class="form-control" id="courseName" placeholder="Enter course name" required>
                            </div>
                        </div>

                        <!-- Second Row -->
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="courseCategory">Course Category</label>
                                <div class="input-group">
                                    <select class="form-control" id="courseCategory" required>
                                        <option value="" disabled selected>Select category</option>
                                        <option value="web-development">Web Development</option>
                                        <option value="data-science">Data Science</option>
                                        <!-- Add more options as needed -->
                                    </select>
                                    <div class="input-group-append">
                                        <span class="input-group-text">
                                            <i class="bi bi-tag"></i> <!-- Bootstrap Icons: Tag icon -->
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="courseLevel">Course Level</label>
                                <div class="input-group">
                                    <select class="form-control" id="courseLevel" required>
                                        <option value="" disabled selected>Select level</option>
                                        <option value="beginner">Beginner</option>
                                        <option value="intermediate">Intermediate</option>
                                        <!-- Add more options as needed -->
                                    </select>
                                    <div class="input-group-append">
                                        <span class="input-group-text">
                                            <i class="bi bi-bar-chart"></i> <!-- Bootstrap Icons: Bar chart icon -->
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Third Row -->
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="courseTopic">Course Topic</label>
                                <div class="input-group">
                                    <select class="form-control" id="courseTopic" required>
                                        <option value="" disabled selected>Select topic</option>
                                        <option value="javascript">JavaScript</option>
                                        <option value="python">Python</option>
                                        <!-- Add more options as needed -->
                                    </select>
                                    <div class="input-group-append">
                                        <span class="input-group-text">
                                            <i class="bi bi-bookmark"></i> <!-- Bootstrap Icons: Bookmark icon -->
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="coursePrice">Course Price (RM)</label>
                                <div class="input-group">
                                     <div class="input-group-append">
                                         <span class="input-group-text">
                                             RM
                                         </span>
                                     </div>
                                    <input type="number" class="form-control" id="coursePrice" placeholder="Enter price" required>
                                </div>
                            </div>
                        </div>

                        <!-- Fourth Row -->
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="courseLanguage">Course Language</label>
                                <div class="input-group">
                                    <select class="form-control" id="courseLanguage" required>
                                        <option value="" disabled selected>Select language</option>
                                        <option value="english">English</option>
                                        <option value="spanish">Spanish</option>
                                        <!-- Add more options as needed -->
                                    </select>
                                    <div class="input-group-append">
                                        <span class="input-group-text">
                                            <i class="bi bi-globe"></i> <!-- Bootstrap Icons: Globe icon -->
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="courseDuration">Course Duration</label>
                                <div class="input-group">
                                    <select class="form-control" id="courseDuration" required>
                                        <option value="" disabled selected>Select duration</option>
                                        <option value="1-week">1 Week</option>
                                        <option value="2-weeks">2 Weeks</option>
                                        <option value="1-month">1 Month</option>
                                        <!-- Add more options as needed -->
                                    </select>
                                    <div class="input-group-append">
                                        <span class="input-group-text">
                                            <i class="bi bi-calendar"></i> <!-- Bootstrap Icons: Calendar icon -->
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Next Button -->
                        <button type="button" class="btn btn-primary next-tab" style="background-color: #FF6636; border-color: #FF6636;" data-bs-target="#course-content">Next</button>
                    </form>
                </div>

                    <div class="tab-pane fade course-content pt-3" id="course-content">
                       <!-- Advance Information Form -->
                    <h5 class="card-title">Advance Information</h5>

                    <!-- Form Fields -->
                    <form>
                        <!-- First Row -->
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="courseThumbnail">Course Thumbnail</label>
                                <div class="input-group">
                                    <!-- Left empty image box (You can customize the appearance as needed) -->
                                    <div class="empty-image-box"></div>
                                    <div class="input-group-append">
                                        <label class="btn btn-primary" style="background-color: #FF6636; border-color: #FF6636;">
                                            <input type="file" style="display: none;"> Upload Image
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="courseTrailer">Course Trailer</label>
                                <div class="input-group">
                                    <!-- Left empty video box (You can customize the appearance as needed) -->
                                    <div class="empty-video-box"></div>
                                    <div class="input-group-append">
                                        <label class="btn btn-primary" style="background-color: #FF6636; border-color: #FF6636;">
                                            <input type="file" style="display: none;"> Upload Video
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Second Row -->
                        <div class="form-row">
                            <div class="form-group col-md-12">
                                <label for="courseDescription">Course Description</label>
                                <textarea class="form-control" id="courseDescription" rows="4" placeholder="Enter course description" required></textarea>
                            </div>
                        </div>

                        <!-- Third Row -->
                        <div class="form-row">
                            <div class="form-group col-md-12">
                                <label for="teachingContent">What will you teach in these courses?</label>
                                <textarea class="form-control" id="teachingContent" rows="4" placeholder="Enter teaching content" required></textarea>
                            </div>
                        </div>

                        <!-- Fourth Row -->
                        <div class="form-row">
                            <div class="form-group col-md-12">
                                <label for="targetAudience">Target Audience</label>
                               <textarea class="form-control" id="targetAudience" placeholder="Enter target audience" required></textarea>
                            </div>
                        </div>
                        <!-- Fifth Row -->
                        <div class="form-row">
                            <div class="form-group col-md-12">
                                <label for="courseRequirements">Course Requirements</label>
                               <textarea class="form-control" id="courseRequirements" placeholder="Enter course requirement" required></textarea>
                            </div>
                        </div>

                        <div class="text-center">
                            <button  type="button" class="btn btn-primary prev-tab" style="background-color: #FF6636; border-color: #FF6636;"data-bs-target="#course-info">Previous</button>
                           <button type="button" class="btn btn-primary next-tab" style="background-color: #FF6636; border-color: #FF6636;"data-bs-target="#course-content">Next</button>
                        </div>
                    </div>

                    <div class="tab-pane fade course-settings pt-3" id="course-settings">
                        <!-- Course Settings Form -->
                        <h5 class="card-title">Course Settings</h5>
                        <!-- Add your form fields for course settings here -->

                        <div class="text-center">
                            <button  type="button" class="btn btn-primary prev-tab" style="background-color: #FF6636; border-color: #FF6636;"data-bs-target="#course-content">Previous</button>
                           <button type="button" class="btn btn-primary next-tab" style="background-color: #FF6636; border-color: #FF6636;"data-bs-target="#course-content">Next</button>
                        </div>
                    </div>

                    <div class="tab-pane fade pt-3" id="review-publish">
                        <!-- Review and Publish Form -->
                        <h5 class="card-title">Review and Publish</h5>
                        <!-- Add your form fields for review and publish here -->

                        <div class="text-center">
                            <button  type="button" class="btn btn-primary prev-tab" style="background-color: #FF6636; border-color: #FF6636;"data-bs-target="#course-settings">Previous</button>
                            <button  type="button" class="btn btn-primary save-btn" style="background-color: #FF6636; border-color: #FF6636;">Save</button>
                        </div>
                    </div>
                </div>
            </div>
         <script>
            $(document).ready(function () {
                // Initialize Bootstrap tabs
                var tab = new bootstrap.Tab(document.querySelector('.nav-link.active'));
                tab.show();

                // Handle tab switch
                $('.nav-link').on('click', function (e) {
                    e.preventDefault();
                    var targetTab = $(this).attr('data-bs-target');
                    $('.nav-link').removeClass('active');
                    $(this).addClass('active');
                    $('.tab-pane').removeClass('show active');
                    $(targetTab).addClass('show active');
                });

                // Handle "Next" button click
                $('.next-tab').on('click', function () {
                    var currentTab = $('.nav-link.active');
                    var nextTab = currentTab.parent().next().find('.nav-link');
                    if (nextTab.length > 0) {
                        nextTab.click();
                    }
                });

                // Handle "Previous" button click
                $('.prev-tab').on('click', function () {
                    var currentTab = $('.nav-link.active');
                    var prevTab = currentTab.parent().prev().find('.nav-link');
                    if (prevTab.length > 0) {
                        prevTab.click();
                    }
                });

                // Handle "Save" button click
                $('.save-btn').on('click', function () {
                    // Implement the save functionality here
                    alert('Course saved!');
                });
            });
         </script>
        </div>
    </div>
</section>


</main><!-- End #main -->
</asp:Content>
