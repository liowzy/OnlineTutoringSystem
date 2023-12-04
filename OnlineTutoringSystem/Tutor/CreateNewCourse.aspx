<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorSideBar.Master" AutoEventWireup="true" CodeBehind="CreateNewCourse.aspx.cs" Inherits="OnlineTutoringSystem.Tutor.WebForm3" %>
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

<!-- Bootstrap 4 CSS -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">


        <title>Create Courses</title>

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
                <ul class="nav nav-tabs nav-tabs-bordered nav-tabs-course">
                    <li class="nav-item flex-fill">
                        <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#course-info">Course Info</button>
                    </li>
                    <li class="nav-item flex-fill">
                        <button class="nav-link" data-bs-toggle="tab" data-bs-target="#course-content">Content</button>
                    </li>
                    <li class="nav-item flex-fill">
                        <button class="nav-link" data-bs-toggle="tab" data-bs-target="#review-publish">Review & Publish</button>
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
                                    <asp:DropDownList ID="ddlCourseCategory" runat="server" CssClass="form-control" DataTextField="cat_name" DataValueField="cat_id" AutoPostBack="true">
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
                            <button type="button" class="btn btn-primary next-tab" style="background-color: #FF6636; border-color: #FF6636;"data-bs-target="#review-publish">Next</button>
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
                                        <h6>Resource List</h6>
                                    </div>
                                    <div class="col-md-6 text-end">
                                        <div >
                                            <asp:Button ID="btnAddResource" runat="server" CssClass="btn btn-outline-secondary" Text="Add Resource" OnClick="btnAddResource_Click" />
                                        </div>
                                    </div>
                                </div>

                                <!-- Second Row (Table) -->
                                <div class="table-responsive">
                                    <table class="table" id="resourceTable">
                                        <thead>
                                            <tr>
                                                <th>Name</th>
                                                <th>Resource Type</th>
                                                <th>Resource Attached</th>
                                                <th>Edit</th>
                                                <th>Trash</th>
                                            </tr>
                                        </thead>
                                        <tbody>    
                                    </table>
                                </div>
                            </div>
                        </div>

                        <!-- Modals  -->
                            <!-- Edit Resource Modal -->
                            <div class="modal fade" id="editResourceModal" tabindex="-1">
                                <div class="modal-dialog modal-dialog-centered">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Edit Resource Name</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <label>Resource Name :</label>
                                            <asp:TextBox ID="editResourceName" class="form-control" placeholder="Write your section name here...." runat="server"/>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                            <button type="button" class="btn btn-primary" onclick="saveFiles()">Save</button>
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

                             <!-- View File Modal -->
                            <div class="modal fade" id="viewFileModal" tabindex="-1" aria-labelledby="viewFileModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="viewFileModalLabel">View Files</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <!-- Resource Name Display -->
                                            <h6>Resource Name:</h6>
                                            <p id="resourceNameDisplay"></p>

                                            <!-- File Table -->
                                            <table class="table">
                                                <thead>
                                                    <tr>
                                                        <th>File</th>
                                                        <th>File Path</th>
                                                    </tr>
                                                </thead>
                                                <tbody id="fileInfoContainer">
                                                    <!-- File Information Will Be Added Here -->
                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Add File Modal -->
                            <div class="modal fade" id="addFileModal" tabindex="-1" aria-labelledby="addFileModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="addFileModalLabel">Add Files</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <!-- Resource Name Input -->
                                            <label for="txtResourceName">Resource Name:</label>
                                            <input type="text" class="form-control" id="txtResourceName" placeholder="Enter Resource Name">

                                            <!-- Loop through files and generate file input fields -->
                                            <div id="fileInputsContainer">
                                                <!-- File Input Fields Will Be Added Here -->
                                            </div>

                                            <button type="button" class="btn btn-secondary mt-3" onclick="addFileInput()">Add Another File</button>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                            <button type="button" class="btn btn-primary" onclick="saveFiles()">Save</button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                         <div class="text-center">
                             <button  type="button" class="btn btn-primary prev-tab" style="background-color: #FF6636; border-color: #FF6636;"data-bs-target="#course-info">Previous</button>
                            <button type="button" class="btn btn-primary save-btn" style="background-color: #FF6636; border-color: #FF6636;" runat="server" onserverclick="btnSubmit_Click">Save</button>
                         </div>
                    </div>
                </div>
        

                 <!-- jQuery -->
                 <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-XqVuQ3TK1Zl9+mzgJz4NSeVoWTV2LJ1dvhE3HbXepXuUUuAKPfuIEjaaB6EGQhx" crossorigin="anonymous"></script>

                 <!-- Bootstrap 5 JS (Popper.js is required for dropdowns, tooltips, and popovers) -->
                 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
                <!-- Bootstrap JavaScript and Popper.js -->
               <%-- <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>--%>
      
        <script>
             $(document).ready(function () {
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
             });

              // Add a new resource row to the table
                function addResourceRow(resourceName, resourceType, files) {
                    var table = document.getElementById('resourceTable').getElementsByTagName('tbody')[0];
                    var newRow = table.insertRow(table.rows.length);

                    // Add cells to the row
                    var cell1 = newRow.insertCell(0);
                    var cell2 = newRow.insertCell(1);
                    var cell3 = newRow.insertCell(2);
                    var cell4 = newRow.insertCell(3);

                    // Fill cells with data
                    cell1.innerHTML = resourceName;
                    // Add a button to view files and attach files
                    cell2.innerHTML = `<button type="button" class="btn btn-link" onclick="viewFiles(${table.rows.length - 1})">View Files</button>`;
                    cell3.innerHTML = '<button type="button" class="btn btn-icon" data-bs-toggle="modal" data-bs-target="#editResourceModal"><i class="bi bi-pencil"></i></button>';
                    cell4.innerHTML = '<button type="button" class="btn btn-icon" data-bs-toggle="modal" data-bs-target="#deleteResourceModal"><i class="bi bi-trash"></i></button>';

                    // Store files in a data attribute for later use
                    newRow.setAttribute('data-files', JSON.stringify(files));
                }

                // View files for a resource
                function viewFiles(rowIdx) {
                    var files = JSON.parse(document.getElementById('resourceTable').rows[rowIdx].getAttribute('data-files'));

                    // Implement logic to display files (e.g., open a modal)
                    console.log(files);
                }

                // Save the resources (call this function when the Save button is clicked)
                function saveResources() {
                    // Implement your logic to gather and save resource data
                }

                // Function to display file information in the view file modal
                function viewFiles(resourceId, resourceName, files) {
                    // Set resource name in the modal
                    document.getElementById('resourceNameDisplay').innerText = resourceName;

                    var fileInfoContainer = document.getElementById('fileInfoContainer');
                    fileInfoContainer.innerHTML = ''; // Clear previous content

                    // Loop through files and display file information in the table
                    for (var i = 0; i < files.length; i++) {
                        var fileRow = document.createElement('tr');

                        var fileNameCell = document.createElement('td');
                        fileNameCell.innerText = files[i].fileName; // Update this based on your file object structure
                        fileRow.appendChild(fileNameCell);

                        var filePathCell = document.createElement('td');
                        filePathCell.innerText = files[i].filePath; // Update this based on your file object structure
                        fileRow.appendChild(filePathCell);

                        fileInfoContainer.appendChild(fileRow);
                    }

                    // Show the view file modal
                    $('#viewFileModal').modal('show');
                }
         </script>
        </div>
    </div>
 </div>
</section>


</main><!-- End #main -->
</asp:Content>
