<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorSideBar.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="OnlineTutoringSystem.Tutor.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <title>Profile</title>
    <link href="Content/css/signUpMaster.css" rel="stylesheet" />
    <!-- Boostrap -->
   
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.18.0/font/bootstrap-icons.css" rel="stylesheet">
     <!-- Include Lightbox2 CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/css/lightbox.min.css">
    <link href="~/Content/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">

     <!-- Add Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

    <!-- Add Bootstrap JS (Popper.js is required for dropdowns, tooltips, and popovers) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

    <main id="main" class="main">

    <div class="pagetitle">
      <h1>Profile</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="CreateNewCourse.aspx">Home</a></li>
          <li class="breadcrumb-item active">Profile</li>
        </ol>
      </nav>
    </div><!-- End Page Title -->

    <section class="section profile">
      <div class="row">
        <div class="col-xl-4">

          <div class="card">
              <div class="card-body profile-card pt-4 d-flex flex-column align-items-center">

                <img src="assets/img/profile-img.jpg" alt="Profile" class="rounded-circle">
                <h2 class="profile-name">Kevin Anderson</h2>
                <h3 class="profile-role">Web Designer</h3>
                <div class="social-links mt-2">
                  <a href="#" class="twitter orange-icon"><i class="bi bi-twitter"></i></a>
                  <a href="#" class="facebook orange-icon"><i class="bi bi-facebook"></i></a>
                  <a href="#" class="instagram orange-icon"><i class="bi bi-instagram"></i></a>
                  <a href="#" class="linkedin orange-icon"><i class="bi bi-linkedin"></i></a>
                </div>
              </div>
        </div>

        </div>

        <div class="col-xl-8">

          <div class="card">
            <div class="card-body pt-3">
              <!-- Bordered Tabs -->
              <ul class="nav nav-tabs nav-tabs-bordered">

                <li class="nav-item">
                  <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#profile-overview">Overview</button>
                </li>

                <li class="nav-item">
                  <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-edit">Edit Profile</button>
                </li>

                <li class="nav-item">
                  <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-settings">Settings</button>
                </li>

                <li class="nav-item">
                  <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-change-password">Change Password</button>
                </li>

              </ul>
              <div class="tab-content pt-2">

               <div class="tab-pane fade show active profile-overview" id="profile-overview">
    <h5 class="card-title">Biography</h5>
    <p class="small fst-italic">[Add your biography here.]</p>

    <h5 class="card-title">Profile Details</h5>

    <div class="row">
      <div class="col-lg-3 col-md-4 label">User Name</div>
      <div class="col-lg-9 col-md-8">[Add your user name]</div>
    </div>

    <div class="row">
      <div class="col-lg-3 col-md-4 label">Full Name</div>
      <div class="col-lg-9 col-md-8">[Add your full name]</div>
    </div>

    <div class="row">
      <div class="col-lg-3 col-md-4 label">Phone Number</div>
      <div class="col-lg-9 col-md-8">[Add your phone number]</div>
    </div>

    <div class="row">
      <div class="col-lg-3 col-md-4 label">Gender</div>
      <div class="col-lg-9 col-md-8">[Add your gender]</div>
    </div>

    <div class="row">
      <div class="col-lg-3 col-md-4 label">Teaching Experience (Years)</div>
      <div class="col-lg-9 col-md-8">[Add your teaching experience]</div>
    </div>

    <div class="row">
      <div class="col-lg-3 col-md-4 label">Language Proficiency</div>
      <div class="col-lg-9 col-md-8">[Add your language proficiency]</div>
    </div>

    <div class="row">
      <div class="col-lg-3 col-md-4 label">Location</div>
      <div class="col-lg-9 col-md-8">[Add your location]</div>
    </div>

    <div class="row">
      <div class="col-lg-3 col-md-4 label">Tutor Expertise</div>
      <div class="col-lg-9 col-md-8">[Add your tutor expertise]</div>
    </div>

                </div>

                <div class="tab-pane fade profile-edit pt-3" id="profile-edit">

                  <!-- Profile Edit Form -->
    <form>
        <div class="row mb-3">
            <label for="profileImage" class="col-md-4 col-lg-3 col-form-label">Profile Image</label>
            <div class="col-md-8 col-lg-9">
                <img src="assets/img/profile-img.jpg" alt="Profile">
                <div class="pt-2">
                    <a href="#" class="btn btn-primary btn-sm" style="background-color: #FF6636; border-color: #FF6636;" title="Upload new profile image"><i
                            class="bi bi-upload"></i></a>
                    <a href="#" class="btn btn-danger btn-sm" title="Remove my profile image"><i
                            class="bi bi-trash"></i></a>
                </div>
            </div>
        </div>

        <div class="row mb-3">
            <label for="username" class="col-md-4 col-lg-3 col-form-label">Username</label>
            <div class="col-md-8 col-lg-9">
                <input name="username" type="text" class="form-control" id="username" placeholder="Enter your username">
            </div>
        </div>

        <div class="row mb-3">
            <label for="phoneNumber" class="col-md-4 col-lg-3 col-form-label">Phone Number</label>
            <div class="col-md-8 col-lg-9">
                <input name="phoneNumber" type="text" class="form-control" id="phoneNumber"
                    placeholder="Enter your phone number">
            </div>
        </div>

        <div class="row mb-3">
            <label for="gender" class="col-md-4 col-lg-3 col-form-label">Gender</label>
            <div class="col-md-8 col-lg-9">
                <select name="gender" class="form-select" id="gender">
                    <option value="male">Male</option>
                    <option value="female">Female</option>
                    <option value="others">Others</option>
                </select>
            </div>
        </div>

        <div class="row mb-3">
            <label for="teachingExperience" class="col-md-4 col-lg-3 col-form-label">Teaching Experience</label>
            <div class="col-md-8 col-lg-9">
                <input name="teachingExperience" type="number" class="form-control" id="teachingExperience"
                    placeholder="Enter the number of years" min="0">
            </div>
        </div>

        <div class="row mb-3">
            <label for="country" class="col-md-4 col-lg-3 col-form-label">Country</label>
            <div class="col-md-8 col-lg-9">
                <input name="country" type="text" class="form-control" id="country" placeholder="Enter your country">
            </div>
        </div>

        <div class="row mb-3">
            <label for="location" class="col-md-4 col-lg-3 col-form-label">Location</label>
            <div class="col-md-8 col-lg-9">
                <input name="location" type="text" class="form-control" id="location" placeholder="Enter your location">
            </div>
        </div>

        <div class="row mb-3">
            <label for="address" class="col-md-4 col-lg-3 col-form-label">Address</label>
            <div class="col-md-8 col-lg-9">
                <input name="address" type="text" class="form-control" id="address" placeholder="Enter your address">
            </div>
        </div>

        <div class="row mb-3">
            <label for="tutorExpertise" class="col-md-4 col-lg-3 col-form-label">Tutor Expertise</label>
            <div class="col-md-8 col-lg-9">
                <textarea name="tutorExpertise" class="form-control" id="tutorExpertise"
                    placeholder="Enter your tutor expertise"></textarea>
            </div>
        </div>

        <div class="row mb-3">
            <label for="biography" class="col-md-4 col-lg-3 col-form-label">Biography</label>
            <div class="col-md-8 col-lg-9">
                <textarea name="biography" class="form-control" id="biography"
                    placeholder="Enter your biography"></textarea>
            </div>
        </div>

            <div class="text-center">
                <button type="submit" class="btn btn-primary" style="background-color: #FF6636; border-color: #FF6636;">Save Changes</button>
            </div>
                  </form><!-- End Profile Edit Form -->

                </div>

                <div class="tab-pane fade pt-3" id="profile-settings">

                  <!-- Settings Form -->
                  <form>

                    <div class="row mb-3">
                  <label for="whatsapp" class="col-md-4 col-lg-3 col-form-label">WhatsApp</label>
                  <div class="col-md-8 col-lg-9">
                    <div class="input-group">
                      <span class="input-group-text">
                        <i class="bi bi-whatsapp"></i>
                      </span>
                      <input name="whatsapp" type="text" class="form-control" id="whatsapp" placeholder="Enter your WhatsApp link">
                    </div>
                  </div>
                </div>

                <div class="row mb-3">
                  <label for="personalWebsite" class="col-md-4 col-lg-3 col-form-label">Personal Website</label>
                  <div class="col-md-8 col-lg-9">
                    <div class="input-group">
                      <span class="input-group-text">
                        <i class="bi bi-globe"></i>
                      </span>
                      <input name="personalWebsite" type="text" class="form-control" id="personalWebsite" placeholder="Enter your website or portfolio URL">
                    </div>
                  </div>
                </div>

                <div class="row mb-3">
                  <label class="col-md-4 col-lg-3 col-form-label">Facebook</label>
                  <div class="col-md-8 col-lg-9">
                    <div class="input-group">
                      <span class="input-group-text">
                        <i class="bi bi-facebook"></i>
                      </span>
                      <input name="facebook" type="text" class="form-control" placeholder="Enter your Facebook link">
                    </div>
                  </div>
                </div>

                <div class="row mb-3">
                  <label class="col-md-4 col-lg-3 col-form-label">Instagram</label>
                  <div class="col-md-8 col-lg-9">
                    <div class="input-group">
                      <span class="input-group-text">
                        <i class="bi bi-instagram"></i>
                      </span>
                      <input name="instagram" type="text" class="form-control" placeholder="Enter your Instagram link">
                    </div>
                  </div>
                </div>

                <div class="text-start">
                  <button type="submit" class="btn btn-primary" style="background-color: #FF6636; border-color: #FF6636;">Save Changes</button>
                </div>
                </form><!-- End Social Profile Form -->

                </div>

                <div class="tab-pane fade pt-3" id="profile-change-password">
                  <!-- Change Password Form -->
                  <form>

                  <div class="row mb-3">
                    <label for="currentPassword" class="col-md-4 col-lg-3 col-form-label">Current Password</label>
                    <div class="col-md-8 col-lg-9">
                      <div class="input-group">
                        <input name="password" type="password" class="form-control" id="currentPassword" placeholder="Enter your current password">
                        <button class="btn btn-outline-secondary" type="button" id="toggleCurrentPassword" onclick="togglePassword('currentPassword')">
                          <i class="bi bi-eye"></i>
                        </button>
                      </div>
                    </div>
                  </div>

                  <div class="row mb-3">
                    <label for="newPassword" class="col-md-4 col-lg-3 col-form-label">New Password</label>
                    <div class="col-md-8 col-lg-9">
                      <div class="input-group">
                        <input name="newpassword" type="password" class="form-control" id="newPassword" placeholder="Enter your new password">
                        <button class="btn btn-outline-secondary" type="button" id="toggleNewPassword" onclick="togglePassword('newPassword')">
                          <i class="bi bi-eye"></i>
                        </button>
                      </div>
                    </div>
                  </div>

                  <div class="row mb-3">
                    <label for="renewPassword" class="col-md-4 col-lg-3 col-form-label">Re-enter New Password</label>
                    <div class="col-md-8 col-lg-9">
                      <div class="input-group">
                        <input name="renewpassword" type="password" class="form-control" id="renewPassword" placeholder="Re-enter your new password">
                        <button class="btn btn-outline-secondary" type="button" id="toggleRenewPassword" onclick="togglePassword('renewPassword')">
                          <i class="bi bi-eye"></i>
                        </button>
                      </div>
                    </div>
                  </div>

                  <div class="text-center">
                    <button type="submit" style="background-color: #FF6636; border-color: #FF6636;" class="btn btn-primary">Change Password</button>
                  </div>
                </form><!-- End Change Password Form -->

                </div>
                  <script>
                      // Wait for the document to be ready before executing the code
                      $(document).ready(function () {
                          // Initialize Bootstrap tabs
                          var tab = new bootstrap.Tab(document.querySelector('.nav-link.active'));
                          tab.show();

                          // Handle tab switch
                          $('.nav-link').on('click', function (e) {
                              $(this).tab('show'); // Show the clicked tab
                          });
                      });

                      function togglePassword(inputId) {
                          const passwordInput = document.getElementById(inputId);
                          const toggleButton = document.getElementById(`toggle${inputId}`);
                          if (passwordInput.type === 'password') {
                              passwordInput.type = 'text';
                              toggleButton.innerHTML = '<i class="bi bi-eye-slash"></i>';
                          } else {
                              passwordInput.type = 'password';
                              toggleButton.innerHTML = '<i class="bi bi-eye"></i>';
                          }
                      }
                  </script>
              </div><!-- End Bordered Tabs -->

            </div>
          </div>

        </div>
      </div>
    </section>

  </main><!-- End #main -->
</asp:Content>
