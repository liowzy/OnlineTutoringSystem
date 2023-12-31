<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorSideBar.Master" AutoEventWireup="true" CodeBehind="CreateNewCourse.aspx.cs" Inherits="OnlineTutoringSystem.Tutor.WebForm3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
        referrerpolicy="no-referrer" />

    <!-- Bootstrap 4 CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-XqVuQ3TK1Zl9+mzgJz4NSeVoWTV2LJ1dvhE3HbXepXuUUuAKPfuIEjaaB6EGQhx" crossorigin="anonymous"></script>

    <!-- Bootstrap 5 JS (Popper.js is required for dropdowns, tooltips, and popovers) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Bootstrap JavaScript and Popper.js -->
    <%-- <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>--%>

    <title>Create Courses</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <main id="main" class="main">

        <div class="pagetitle">
            <h1>Create New Course</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="Profile.aspx">Home</a></li>
                    <li class="breadcrumb-item active">Create New Courses</li>
                </ol>
            </nav>
        </div>
        <!-- End Page Title -->

        <section class="section create-courses">
            <asp:Label ID="lblMessage" runat="server" CssClass="error-message" Visible="false"></asp:Label>

            <div class="col-xl-8">
                <div class="card">
                    <div class="card-body pt-3">
                        <!-- Bordered Tabs -->
                        <ul class="nav nav-tabs nav-tabs-bordered nav-tabs-course">
                            <li class="nav-item flex-fill">
                                <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#course-info" data-validation-group="CourseInfoValidation">Course Info</button>
                            </li>
                            <li class="nav-item flex-fill">
                                <button class="nav-link" data-bs-toggle="tab" data-bs-target="#course-content" data-validation-group="CourseInfoValidation" disabled>Advance Info</button>
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
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCourseName" Display="Dynamic" ErrorMessage="Course Name is required." CssClass="text-danger" InitialValue="" ValidationGroup="CourseInfoValidation" />

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
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlCourseCategory" Display="Dynamic" ErrorMessage="Course Category is required." CssClass="text-danger" InitialValue="" ValidationGroup="CourseInfoValidation" />
                                    </div>

                                    <div class="form-group col-md-6">
                                        <label for="courseLevel">Course Level</label>
                                        <div class="input-group">
                                            <asp:DropDownList ID="ddlCourseLevel" runat="server" CssClass="form-control" Required="true">
                                                <asp:ListItem Text="Select level" Value="" Disabled="true" Selected="true"></asp:ListItem>
                                                <asp:ListItem Text="SPM" Value="SPM"></asp:ListItem>
                                                <asp:ListItem Text="STPM" Value="STPM"></asp:ListItem>
                                                <asp:ListItem Text="Foundation" Value="Foundation"></asp:ListItem>
                                                <asp:ListItem Text="Diploma" Value="Diploma"></asp:ListItem>
                                                <asp:ListItem Text="Degree" Value="Degree"></asp:ListItem>
                                                <asp:ListItem Text="Others" Value="Others"></asp:ListItem>
                                            </asp:DropDownList>
                                            <div class="input-group-append">
                                                <span class="input-group-text">
                                                    <i class="bi bi-bar-chart"></i>
                                                </span>
                                            </div>
                                        </div>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlCourseLevel" Display="Dynamic" ErrorMessage="Course Level is required." CssClass="text-danger" InitialValue="" ValidationGroup="CourseInfoValidation" />
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
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCourseTopic" Display="Dynamic" ErrorMessage="Crouse Topic is required." CssClass="text-danger" InitialValue="" ValidationGroup="CourseInfoValidation" />
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label for="coursePrice">Course Price (RM)</label>
                                        <div class="input-group">
                                            <div class="input-group-append">
                                                <span class="input-group-text">RM
                                                </span>
                                            </div>
                                            <asp:TextBox ID="txtCoursePrice" runat="server" CssClass="form-control" placeholder="Enter price" TextMode="SingleLine" Required="true"></asp:TextBox>
                                        </div>
                                        <asp:RegularExpressionValidator ID="regexPrice" runat="server" ControlToValidate="txtCoursePrice"
                                            ErrorMessage="Please enter a valid integer price." ValidationExpression="^\d+$"
                                            Display="Dynamic" CssClass="text-danger" ValidationGroup="CourseInfoValidation">
                                        </asp:RegularExpressionValidator>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCoursePrice" Display="Dynamic" ErrorMessage="Course Price is required." CssClass="text-danger" InitialValue="" ValidationGroup="CourseInfoValidation" />
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
                                                <asp:ListItem Text="Tamil" Value="Tamil"></asp:ListItem>
                                                <asp:ListItem Text="Chinese" Value="chinese"></asp:ListItem>
                                                <asp:ListItem Text="Malayu" Value="melayu"></asp:ListItem>
                                            </asp:DropDownList>
                                            <div class="input-group-append">
                                                <span class="input-group-text">
                                                    <i class="bi bi-globe"></i>
                                                </span>
                                            </div>
                                        </div>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlCourseLanguage" Display="Dynamic" ErrorMessage="Course Language is required." CssClass="text-danger" InitialValue="" ValidationGroup="CourseInfoValidation" />
                                    </div>

                                    <div class="form-group col-md-6">
                                        <label for="courseDuration">Course Duration</label>
                                        <div class="input-group">
                                            <asp:TextBox ID="txtCourseDuration" runat="server" CssClass="form-control" Placeholder="Enter duration" Required="true"></asp:TextBox>
                                            <div class="input-group-append">
                                                <span class="input-group-text">
                                                    <i class="bi bi-clock"></i>
                                                    <!-- Assuming there's an icon for clock -->
                                                </span>
                                            </div>
                                        </div>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCourseDuration" Display="Dynamic" ErrorMessage="Course Durations is required." CssClass="text-danger" InitialValue="" ValidationGroup="CourseInfoValidation" />
                                    </div>
                                </div>
                                <!-- Next Button -->
                                <button type="submit" class="btn btn-primary next-tab" style="background-color: #FF6636; border-color: #FF6636;" data-bs-target="#course-content" data-validation-group="CourseInfoValidation">Next</button>

                                <!-- Add a ValidationSummary to display a summary of errors -->
                                <asp:ValidationSummary runat="server" ID="ValidationSummary1" HeaderText="Please correct the following errors:" ShowSummary="true" DisplayMode="BulletList" CssClass="text-danger" ValidationGroup="CourseInfoValidation" />
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
                                            <div id="thumbnailContainer" class="empty-image-box" style="width: 140px; height: 140px; border: 1px solid #ccc; display: flex; align-items: center; justify-content: center; background-color: #f8f8f8;">
                                                <i class="bi bi-image" style="font-size: 3rem; color: #ccc;"></i>
                                            </div>
                                            <div class="input-group-append" style="width: calc(100% - 228px); flex: 0 0 auto; margin-left: 10px; display: flex; flex-direction: column; align-items: flex-start;">
                                                <!-- Description beside the button -->
                                                <p style="font-size: small; margin-bottom: 5px;">Upload your course Thumbnail here. Important guidelines: 1200x800 pixels or 12:8 Ratio. Supported format: .jpg, .jpeg, or .png</p>
                                                <!-- Button for Upload Image -->
                                                <asp:FileUpload ID="fileUploadThumbnail" runat="server" CssClass="btn btn-primary" Accept=".jpg, .jpeg, .png" Style="background-color: #FF6636; border-color: #FF6636; width: 100%; font-size: small; border-radius: 0; margin-top: 20px" onchange="showThumbnail(this)" />
                                            </div>
                                        </div>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="fileUploadThumbnail" Display="Dynamic" ErrorMessage="Course Thumbnail is required." CssClass="text-danger" InitialValue="" ValidationGroup="AdvanceInfoValidation" />
                                    </div>
                                </div>

                                <!-- Second Row -->
                                <div class="form-row">
                                    <div class="form-group col-md-12">
                                        <label for="courseDescription">Course Description</label>
                                        <asp:TextBox ID="txtCourseDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" Placeholder="Enter course description" Required="true"></asp:TextBox>
                                    </div>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCourseDescription" Display="Dynamic" ErrorMessage="Course Description is required." CssClass="text-danger" InitialValue="" ValidationGroup="AdvanceInfoValidation" />
                                </div>

                                <!-- Third Row -->
                                <div class="form-row">
                                    <div class="form-group col-md-12">
                                        <label for="teachingContent">What will you teach in these courses?</label>
                                        <asp:TextBox ID="txtCourseContent" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" Placeholder="Enter teaching content" Required="true"></asp:TextBox>
                                    </div>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCourseContent" Display="Dynamic" ErrorMessage="Teaching Content is required." CssClass="text-danger" InitialValue="" ValidationGroup="AdvanceInfoValidation" />
                                </div>

                                <!-- Fourth Row -->
                                <div class="form-row">
                                    <div class="form-group col-md-12">
                                        <label for="targetAudience">Target Audience</label>
                                        <asp:TextBox ID="txtCourseTargetAudience" runat="server" CssClass="form-control" TextMode="MultiLine" Placeholder="Enter target audience" Required="true"></asp:TextBox>
                                    </div>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCourseTargetAudience" Display="Dynamic" ErrorMessage="Target Audience is required." CssClass="text-danger" InitialValue="" ValidationGroup="AdvanceInfoValidation" />
                                </div>
                                <!-- Fifth Row -->
                                <div class="form-row">
                                    <div class="form-group col-md-12">
                                        <label for="courseRequirements">Course Requirements</label>
                                        <asp:TextBox ID="txtCourseRequirements" runat="server" CssClass="form-control" TextMode="MultiLine" Placeholder="Enter course requirement" Required="true"></asp:TextBox>
                                    </div>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCourseRequirements" Display="Dynamic" ErrorMessage="Course Requirements is required." CssClass="text-danger" InitialValue="" ValidationGroup="AdvanceInfoValidation" />
                                </div>

                                <div class="text-center">
                                    <button type="button" class="btn btn-primary prev-tab" style="background-color: #FF6636; border-color: #FF6636;" data-bs-target="#course-info">Previous</button>
                                    <asp:Button ID="Button1" runat="server" Text="Save" CssClass="btn btn-primary save-btn"
                                        Style="background-color: #FF6636; border-color: #FF6636;" OnClientClick="if (!confirm('Are you sure you want to save?')) return false;" OnClick="btnSubmit_Click" ValidationGroup="AdvanceInfoValidation" />
                                </div>

                                <!-- Add a ValidationSummary to display a summary of errors -->
                                <asp:ValidationSummary runat="server" ID="ValidationSummary2" HeaderText="Please correct the following errors:" ShowSummary="true" DisplayMode="BulletList" CssClass="text-danger" ValidationGroup="AdvanceInfoValidation" />
                            </div>

                            <!-- jQuery -->
                            <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
                            <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-XqVuQ3TK1Zl9+mzgJz4NSeVoWTV2LJ1dvhE3HbXepXuUUuAKPfuIEjaaB6EGQhx" crossorigin="anonymous"></script>

                            <!-- Bootstrap 5 JS (Popper.js is required for dropdowns, tooltips, and popovers) -->
                            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
                            <!-- Bootstrap JavaScript and Popper.js -->
                            <%-- <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>--%>

                            <script>
                                function showThumbnail(input) {
                                    var file = input.files[0];
                                    var thumbnailContainer = document.getElementById('thumbnailContainer');

                                    if (file) {
                                        var reader = new FileReader();
                                        reader.onload = function (e) {
                                            thumbnailContainer.innerHTML = '<img src="' + e.target.result + '" style="max-width: 100%; max-height: 100%;">';
                                        }
                                        reader.readAsDataURL(file);
                                    } else {
                                        thumbnailContainer.innerHTML = '<i class="bi bi-image" style="font-size: 3rem; color: #ccc;"></i>';
                                    }
                                }

                                $(document).ready(function () {
                                    // Handle "Next" button click
                                    $('.next-tab').on('click', function () {
                                        // Get the validation group from the data attribute
                                        var validationGroup = $(this).data('validation-group');

                                        // Trigger client-side validation
                                        var isValid = Page_ClientValidate(validationGroup);

                                        // If validation passed, proceed to the next tab and enable it
                                        if (isValid) {
                                            var currentTab = $('.nav-link.active');
                                            var nextTab = currentTab.parent().next().find('.nav-link');
                                            if (nextTab.length > 0) {
                                                nextTab.removeAttr('disabled').click(); // Remove 'disabled' attribute and trigger click
                                            }
                                        }
                                    });

                                    // Handle "Save" button click
                                    $('.save-btn').on('click', function () {
                                        var validationGroup = $(this).data('validation-group');

                                        if (validationGroup === 'AdvanceInfoValidation') {
                                            var isValid = Page_ClientValidate(validationGroup);

                                            if (isValid && confirm('Are you sure you want to save?')) {
                                                // Your save logic here
                                            }
                                        }
                                    });

                                    // Handle "Previous" button click
                                    $('.prev-tab').on('click', function () {
                                        var currentTab = $('.nav-link.active');
                                        var prevTab = currentTab.parent().prev().find('.nav-link');
                                        if (prevTab.length > 0) {
                                            prevTab.click(); // Use click() to trigger the click event
                                        }
                                    });
                                });
                            </script>
                        </div>
                    </div>
                </div>
        </section>
    </main>
    <!-- End #main -->
</asp:Content>
