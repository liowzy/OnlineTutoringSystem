<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorSideBar.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="OnlineTutoringSystem.Tutor.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.18.0/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Lightbox2 CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/css/lightbox.min.css">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <title>Profile</title>
   
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
      referrerpolicy="no-referrer"/>

<main id="main" class="main">
    <div class="pagetitle">
      <h1>Profile</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="../Student/HomePage.aspx">Home</a></li>
          <li class="breadcrumb-item active">Profile</li>
        </ol>
      </nav>
    </div><!-- End Page Title -->

    <section class="section profile">
      <div class="row">
        <div class="col-xl-4">

          <div class="card">
            <div class="card-body profile-card pt-4 d-flex flex-column align-items-center">

                <asp:Image ID="imgUserProfile" runat="server" CssClass="rounded-circle" AlternateText="Profile" />
                <h2 class="profile-name">
                    <asp:Label ID="lblUserName" runat="server" Text="[Loading...]" />
                </h2>
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
              <ul class="nav nav-tabs nav-tabs-bordered nav-tabs-profile">
                <li class="nav-item flex-fill">
                  <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#profile-overview">Overview</button>
                </li>
                <li class="nav-item flex-fill">
                  <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-edit">Edit Profile</button>
                </li>
                <li class="nav-item flex-fill">
                  <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-settings">Settings</button>
                </li>
                <li class="nav-item flex-fill">
                  <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-change-password">Change Password</button>
                </li>
              </ul>


              <div class="tab-content pt-2">
                  <div class="tab-pane fade show active profile-overview" id="profile-overview">
                    <h5 class="card-title">Biography</h5>
                    <p class="small fst-italic">[Add your biography here.]</p>

                    <h5 class="card-title">Profile Details</h5>

                   <div class="row">
                        <div class="col-lg-3 col-md-4 label">Full Name</div>
                        <div class="col-lg-9 col-md-8">
                            <asp:Label ID="lblFullName" runat="server" Text="[Loading...]" />
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-3 col-md-4 label">Phone Number</div>
                        <div class="col-lg-9 col-md-8">
                            <asp:Label ID="lblPhoneNumber" runat="server" Text="[Loading...]" />
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-3 col-md-4 label">Gender</div>
                        <div class="col-lg-9 col-md-8">
                            <asp:Label ID="lblGender" runat="server" Text="[Loading...]" />
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-3 col-md-4 label">Teaching Experience (Years)</div>
                        <div class="col-lg-9 col-md-8">
                            <asp:Label ID="lblTeachingExperience" runat="server" Text="[Loading...]" />
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-3 col-md-4 label">Language Proficiency</div>
                        <div class="col-lg-9 col-md-8">
                            <asp:Label ID="lblLanguageProficiency" runat="server" Text="[Loading...]" />
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-3 col-md-4 label">Location</div>
                        <div class="col-lg-9 col-md-8">
                            <asp:Label ID="lblLocation" runat="server" Text="[Loading...]" />
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-3 col-md-4 label">Tutor Expertise</div>
                        <div class="col-lg-9 col-md-8">
                            <asp:Label ID="lblTutorExpertise" runat="server" Text="[Loading...]" />
                        </div>
                  </div>
                </div>

                <div class="tab-pane fade profile-edit pt-3" id="profile-edit">
                    <div class="row mb-3">
                        <label for="profileImage" class="col-md-4 col-lg-3 col-form-label">Profile Image</label>
                        <div class="col-md-8 col-lg-9">
                            <asp:Image ID="imgProfile" runat="server" ImageUrl="assets/img/profile-img.jpg" AlternateText="Profile" />
                            <div class="pt-2">
                                <a href="#" class="btn btn-primary btn-sm" style="background-color: #FF6636; border-color: #FF6636;" title="Upload new profile image">
                                    <i class="bi bi-upload"></i>
                                </a>
                                <a href="#" class="btn btn-danger btn-sm" title="Remove my profile image">
                                    <i class="bi bi-trash"></i>
                                </a>
                            </div>
                        </div>
                    </div>

                   <div class="row mb-3">
                        <label for="username" class="col-md-4 col-lg-3 col-form-label">Username</label>
                        <div class="col-md-8 col-lg-9">
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Enter your username" />
                        </div>
                    </div>

                    <div class="row mb-3">
                            <label for="phoneNumber" class="col-md-4 col-lg-3 col-form-label">Phone Number</label>
                            <div class="col-md-8 col-lg-9">
                                <asp:TextBox ID="txtPhoneNumber" runat="server" CssClass="form-control" placeholder="Enter your phone number" />
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label for="gender" class="col-md-4 col-lg-3 col-form-label">Gender</label>
                            <div class="col-md-8 col-lg-9">
                                <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-select">
                                    <asp:ListItem Value="male">Male</asp:ListItem>
                                    <asp:ListItem Value="female">Female</asp:ListItem>
                                    <asp:ListItem Value="others">Others</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label for="teachingExperience" class="col-md-4 col-lg-3 col-form-label">Teaching Experience</label>
                            <div class="col-md-8 col-lg-9">
                                <asp:TextBox ID="txtTeachingExperience" runat="server" CssClass="form-control" placeholder="Enter the number of years" TextMode="Number" />
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label for="country" class="col-md-4 col-lg-3 col-form-label">Country</label>
                            <div class="col-md-8 col-lg-9">
                                <asp:TextBox ID="txtCountry" runat="server" CssClass="form-control" placeholder="Enter your country" />
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label for="location" class="col-md-4 col-lg-3 col-form-label">Location</label>
                            <div class="col-md-8 col-lg-9">
                                <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control" placeholder="Enter your location" />
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label for="address" class="col-md-4 col-lg-3 col-form-label">Address</label>
                            <div class="col-md-8 col-lg-9">
                                <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Enter your address" />
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label for="tutorExpertise" class="col-md-4 col-lg-3 col-form-label">Tutor Expertise</label>
                            <div class="col-md-8 col-lg-9">
                                <asp:TextBox ID="txtTutorExpertise" runat="server" CssClass="form-control" TextMode="MultiLine" placeholder="Enter your tutor expertise"></asp:TextBox>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label for="biography" class="col-md-4 col-lg-3 col-form-label">Biography</label>
                            <div class="col-md-8 col-lg-9">
                                <asp:TextBox ID="txtBiography" runat="server" CssClass="form-control" TextMode="MultiLine" placeholder="Enter your biography"></asp:TextBox>
                            </div>
                        </div>

                        <div class="text-center">
                            <asp:Button ID="btnSaveChanges" runat="server" Text="Save Changes" OnClick="btnSaveChanges_Click" CssClass="btn btn-primary" style="background-color: #FF6636; border-color: #FF6636;" />
                        </div>
                </div>

                <div class="tab-pane fade pt-3" id="profile-settings">
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

                </div>

                <div class="tab-pane fade pt-3" id="profile-change-password">
                  <!-- Change Password Form -->
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
                  </div><!-- End Change Password Form -->

                </div>

                  <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
                    <script>

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
