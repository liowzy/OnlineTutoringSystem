<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorSideBar.Master" AutoEventWireup="true" CodeBehind="CreateNewCourse.aspx.cs" Inherits="OnlineTutoringSystem.Tutor.WebForm3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <title>Create Courses</title>

        <link href="~/Content/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">

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

    <!-- Bootstrap 4 CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">


  <main id="main" class="main">

  <div class="pagetitle">
    <h1>Create New Course</h1>
    <nav>
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="../Student/HomePage.aspx">Home</a></li>
        <li class="breadcrumb-item active">Create New Courses</li>
      </ol>
    </nav>
  </div><!-- End Page Title -->

  <section class="section create-courses">
      <asp:Label ID="lblMessage" runat="server" CssClass="error-message" Visible="false"></asp:Label>

    <div class="col-xl-8">
        <div class="card">
            <div class="card-body pt-3">
                <!-- Bordered Tabs -->
                <ul class="nav nav-tabs nav-tabs-bordered">
                    <li class="nav-item flex-fill">
                        <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#course-info">Course
                            Info</button>
                    </li>
                    <li class="nav-item flex-fill">
                        <button class="nav-link" data-bs-toggle="tab" data-bs-target="#course-content">Content</button>
                    </li>
                    <li class="nav-item flex-fill">
                        <button class="nav-link" data-bs-toggle="tab" data-bs-target="#review-publish">Review &
                            Publish</button>
                    </li>
                </ul>

                <div class="tab-content pt-2">
                  <div class="tab-pane fade show active course-info" id="course-info">
                    <!-- Course Info Form -->
                    <h5 class="card-title">Course Information</h5>

                    <!-- Form Fields -->
                        <!-- First Row -->
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="courseName">Course Name</label>
                                <asp:TextBox ID="txtCourseName" runat="server" CssClass="form-control" placeholder="Enter course name" Required="true"></asp:TextBox>
                            </div>
                        </div>

                        <!-- Second Row -->
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="courseCategory">Course Category</label>
                                <div class="input-group">
                                    <asp:DropDownList ID="ddlCourseCategory" runat="server" CssClass="form-control" Required="true">
                                        <asp:ListItem Text="Select category" Value="" Disabled="true" Selected="true"></asp:ListItem>
                                        <asp:ListItem Text="Web Development" Value="web-development"></asp:ListItem>
                                        <asp:ListItem Text="Data Science" Value="data-science"></asp:ListItem>
                                    </asp:DropDownList>
                                    <div class="input-group-append">
                                        <span class="input-group-text">
                                            <i class="bi bi-tag"></i>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="courseLevel">Course Level</label>
                                <div class="input-group">
                                    <asp:DropDownList ID="ddlCourseLevel" runat="server" CssClass="form-control" Required="true">
                                        <asp:ListItem Text="Select level" Value="" Disabled="true" Selected="true"></asp:ListItem>
                                        <asp:ListItem Text="Beginner" Value="beginner"></asp:ListItem>
                                        <asp:ListItem Text="Intermediate" Value="intermediate"></asp:ListItem>
                                    </asp:DropDownList>
                                    <div class="input-group-append">
                                        <span class="input-group-text">
                                            <i class="bi bi-bar-chart"></i>
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
                                    <asp:TextBox ID="txtCourseTopic" runat="server" CssClass="form-control" placeholder="Enter course name" Required="true"></asp:TextBox>
                                    <div class="input-group-append">
                                        <span class="input-group-text">
                                            <i class="bi bi-bookmark"></i>
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
                                    <asp:TextBox ID="txtCoursePrice" runat="server" CssClass="form-control" placeholder="Enter price" Required="true"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <!-- Fourth Row -->
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="courseLanguage">Course Language</label>
                                <div class="input-group">
                                    <asp:DropDownList ID="ddlCourseLanguage" runat="server" CssClass="form-control" Required="true">
                                        <asp:ListItem Text="Select language" Value="" Disabled="true" Selected="true"></asp:ListItem>
                                        <asp:ListItem Text="English" Value="english"></asp:ListItem>
                                        <asp:ListItem Text="Spanish" Value="spanish"></asp:ListItem>
                                    </asp:DropDownList>
                                    <div class="input-group-append">
                                        <span class="input-group-text">
                                            <i class="bi bi-globe"></i>
                                        </span>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group col-md-6">
                                <label for="courseDuration">Course Duration</label>
                                <div class="input-group">
                                    <asp:TextBox ID="txtCourseDuration" runat="server" CssClass="form-control" Placeholder="Enter duration" Required="true"></asp:TextBox>
                                    <div class="input-group-append">
                                        <span class="input-group-text">
                                            <i class="bi bi-clock"></i> <!-- Assuming there's an icon for clock -->
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                                       <!-- Next Button -->
                        <button type="button" class="btn btn-primary next-tab" style="background-color: #FF6636; border-color: #FF6636;"data-bs-target="#course-content">Next</button>
                    </div>

                    <div class="tab-pane fade course-content pt-3" id="course-content">
                        <!-- Advance Information Form -->
                        <h5 class="card-title">Advance Information</h5>

                        <!-- Form Fields -->
                        <!-- First Row -->
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="courseThumbnail">Course Thumbnail</label>
                                <div class="input-group">
                                    <!-- Image box with empty image icon -->
                                    <div class="empty-image-box" style="width: 140px; height: 140px; border: 1px solid #ccc; display: flex; align-items: center; justify-content: center; background-color: #f8f8f8;">
                                        <i class="bi bi-image" style="font-size: 3rem; color: #ccc;"></i>
                                    </div>
                                    <div class="input-group-append" style="width: calc(100% - 228px); flex: 0 0 auto; margin-left: 10px; display: flex; flex-direction: column; align-items: flex-start;">
                                        <!-- Description beside the button -->
                                        <p style="font-size: small; margin-bottom: 5px;">Upload your course Thumbnail here. Important guidelines: 1200x800 pixels or 12:8 Ratio. Supported format: .jpg, .jpeg, or .png</p>
                                        <!-- Button for Upload Image -->
                                        <asp:FileUpload ID="fileUploadThumbnail" runat="server" CssClass="btn btn-primary" Accept=".jpg, .jpeg, .png" Style="background-color: #FF6636; border-color: #FF6636; width: 50%; font-size: small; border-radius: 0; margin-top:20px" />
                                    </div>
                                </div>
                            </div>
                            <!-- Second column for the Course Trailer -->
                            <div class="form-group col-md-6">
                                <label for="courseTrailer">Course Trailer</label>
                                <div class="input-group">
                                    <!-- Video box with empty video icon -->
                                    <div class="empty-video-box" style="width: 140px; height: 140px; border: 1px solid #ccc; display: flex; align-items: center; justify-content: center; background-color: #f8f8f8;">
                                        <i class="bi bi-play" style="font-size: 3rem; color: #ccc;"></i>
                                    </div>
                                    <div class="input-group-append" style="width: calc(100% - 228px); flex: 0 0 auto; margin-left: 10px; display: flex; flex-direction: column; align-items: flex-start;">
                                        <!-- Description beside the button -->
                                        <p style="font-size: small; margin-bottom: 5px;">Students who watch a well-made promo video are 5X more likely to enroll in your course. We've seen that statistic go up to 10X for exceptionally awesome videos.</p>
                                        <!-- Button for Upload Video -->
                                        <asp:FileUpload ID="fileUploadTrailer" runat="server" CssClass="btn btn-primary" Style="background-color: #FF6636; border-color: #FF6636; width: 50%; font-size: small; border-radius: 0; margin-top:20px" />
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Second Row -->
                        <div class="form-row">
                            <div class="form-group col-md-12">
                                <label for="courseDescription">Course Description</label>
                                <asp:TextBox ID="txtCourseDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" Placeholder="Enter course description" Required="true"></asp:TextBox>
                            </div>
                        </div>

                        <!-- Third Row -->
                        <div class="form-row">
                            <div class="form-group col-md-12">
                                <label for="teachingContent">What will you teach in these courses?</label>
                                <asp:TextBox ID="txtCourseContent" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" Placeholder="Enter teaching content" Required="true"></asp:TextBox>
                            </div>
                        </div>

                        <!-- Fourth Row -->
                        <div class="form-row">
                            <div class="form-group col-md-12">
                                <label for="targetAudience">Target Audience</label>
                                <asp:TextBox ID="txtCourseTargetAudience" runat="server" CssClass="form-control" TextMode="MultiLine" Placeholder="Enter target audience" Required="true"></asp:TextBox>
                            </div>
                        </div>
                        <!-- Fifth Row -->
                        <div class="form-row">
                            <div class="form-group col-md-12">
                                <label for="courseRequirements">Course Requirements</label>
                                <asp:TextBox ID="txtCourseRequirements" runat="server" CssClass="form-control" TextMode="MultiLine" Placeholder="Enter course requirement" Required="true"></asp:TextBox>
                            </div>
                        </div>

                         <div class="text-center">
                             <button  type="button" class="btn btn-primary prev-tab" style="background-color: #FF6636; border-color: #FF6636;"data-bs-target="#course-info">Previous</button>
                            <button type="button" class="btn btn-primary next-tab" style="background-color: #FF6636; border-color: #FF6636;"data-bs-target="#course-content">Next</button>
                         </div>
                    </div>

                        <div class="tab-pane fade pt-3" id="review-publish">
                            <!-- Review and Publish Form -->
                            <h5 class="card-title">Course Resource</h5>

                            <!-- List of Resources -->
                            <div class="resource-list">
                                <!-- Resource 01 -->
                                <div class="resource-box">
                                    <!-- First Row -->
                                    <div class="row resource-header mb-3">
                                        <div class="col-md-6">
                                            <h5>Resource List</h5>
                                        </div>
                                        <div class="col-md-6 text-end">
                                    <!-- Content dropdown -->
                                    <div class="input-group ms-auto"> <!-- Added ms-auto class here -->
                                        <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="background-color: lightgrey; border-color: lightgrey; font-size:15px; height:50%;">
                                            Add Resource
                                        </button>
                                        <div class="dropdown-menu">
                                            <a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#videoModal">Video</a>
                                            <a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#fileModal">Attach File</a>
                                        </div>
                                    </div>
                                </div>
                            </div>

                                    <!-- Second Row (Table) -->
                                    <div class="table-responsive">
                                        <asp:GridView runat="server" ID="gvResources" CssClass="table" AutoGenerateColumns="false">
                                            <Columns>
                                                <asp:BoundField DataField="Name" HeaderText="Name" />
                                                <asp:BoundField DataField="ResourceType" HeaderText="Resource Type" />
                                                <asp:BoundField DataField="ResourceAttached" HeaderText="Resource Attached" />
                                                <asp:TemplateField HeaderText="Edit">
                                                    <ItemTemplate>
                                                        <button type="button" class="btn btn-icon" data-bs-toggle="modal" data-bs-target="#editResourceModal">
                                                            <i class="bi bi-pencil"></i>
                                                        </button>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Trash">
                                                    <ItemTemplate>
                                                        <button type="button" class="btn btn-icon" data-bs-toggle="modal" data-bs-target="#deleteResourceModal">
                                                            <i class="bi bi-trash"></i>
                                                        </button>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </div>
                            </div>

                        <!-- Modals  -->
                        <!-- Edit Resource Modal -->
                       <div class="modal fade" id="editResourceModal" tabindex="-1" aria-labelledby="editResourceModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="editResourceModalLabel">Edit Resource Name</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <label for="editResourceName">Name:</label>
                                    <input type="text" class="form-control" id="editResourceName" placeholder="Write your section name here....">
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                    <button type="button" class="btn btn-primary">Save</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Delete Resource Modal -->
                    <div class="modal fade" id="deleteResourceModal" tabindex="-1" aria-labelledby="deleteResourceModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="deleteResourceModalLabel">Deleting Alert</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <p>Do you sure you want to remove current resources?</p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                                    <button type="button" class="btn btn-danger">Yes</button>
                                </div>
                            </div>
                        </div>
                    </div>

                   <!-- Video Modal -->
                    <div class="modal fade" id="videoModal" tabindex="-1" aria-labelledby="videoModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="videoModalLabel">Lecture Video</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <!-- Resource Name Input -->
                                    <label for="resourceNameInputVideo">Resource Name:</label>
                                    <input type="text" class="form-control" id="resourceNameInputVideo" placeholder="Enter Resource Name">

                                    <div class="row mt-3">
                                        <div class="col">
                                            <label for="uploadVideoFile">Upload Video (File Type):</label>
                                            <input type="file" class="form-control" id="uploadVideoFile">
                                            <small class="form-text text-muted">Note: All files should be at least 720p and less than 4.0GB.</small>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                    <button type="button" class="btn btn-primary">Save</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- File Modal -->
                    <div class="modal fade" id="fileModal" tabindex="-1" aria-labelledby="fileModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="fileModalLabel">Attach File</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <!-- Resource Name Input -->
                                    <label for="resourceNameInputFile">Resource Name:</label>
                                    <input type="text" class="form-control" id="resourceNameInputFile" placeholder="Enter Resource Name">

                                    <div class="row mt-3">
                                        <div class="col">
                                            <label for="attachFile">Attach File:</label>
                                            <input type="file" class="form-control" id="attachFile" ondrop="handleDrop(event)" ondragover="handleDragOver(event)">
                                            <small class="form-text text-muted">Note: Add your notes about the attached file.</small>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                    <button type="button" class="btn btn-primary" onclick="saveFile()">Save</button>
                                </div>
                            </div>
                        </div>
                    </div>

                     <div class="text-center">
                         <button  type="button" class="btn btn-primary prev-tab" style="background-color: #FF6636; border-color: #FF6636;"data-bs-target="#course-info">Previous</button>
                        <button type="button" class="btn btn-primary save-btn" style="background-color: #FF6636; border-color: #FF6636;"data-bs-target="#course-content">Save</button>
                             </div>
                    </div>
                </div>

                 <!-- jQuery -->
                 <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

                 <!-- Bootstrap 5 JS (Popper.js is required for dropdowns, tooltips, and popovers) -->
                 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
         <script>
             $(document).ready(function () {
                 // Initialize Bootstrap tabs
                 $('.nav-tabs').each(function () {
                     var tabs = new bootstrap.Tab(this.querySelector('.nav-link.active'));
                     tabs.show();
                 });

                 // Handle "Next" button click
                 $('.next-tab').on('click', function () {
                     var currentTab = $('.nav-link.active');
                     var nextTab = currentTab.parent().next().find('.nav-link');
                     if (nextTab.length > 0) {
                         nextTab.tab('show');
                     }
                 });

                 // Handle "Previous" button click
                 $('.prev-tab').on('click', function () {
                     var currentTab = $('.nav-link.active');
                     var prevTab = currentTab.parent().prev().find('.nav-link');
                     if (prevTab.length > 0) {
                         prevTab.tab('show');
                     }
                 });

                 // Handle "Save" button click
                 $('.save-btn').on('click', function () {
                     // Implement the save functionality here
                     alert('Course saved!');
                 });
             });

             // Initialize the modals when the document is ready
             document.addEventListener('DOMContentLoaded', function () {
                 // Video Modal
                 var videoModal = new bootstrap.Modal(document.getElementById('videoModal'), {
                     keyboard: false
                 });

                 // File Modal
                 var fileModal = new bootstrap.Modal(document.getElementById('fileModal'), {
                     keyboard: false
                 });

                 // Event listener for changing the resource type dropdown
                 document.getElementById('resourceTypeSelect').addEventListener('change', function () {
                     if (this.value === 'video') {
                         // Show the video modal when 'Video' is selected
                         videoModal.show();
                     } else if (this.value === 'file') {
                         // Show the file modal when 'File' is selected
                         fileModal.show();
                     }
                     // Add similar logic for other resource types
                 });
             });
         </script>
        </div>
    </div>
</section>


</main><!-- End #main -->
</asp:Content>
