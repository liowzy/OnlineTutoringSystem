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
                    <asp:ImageButton ID="btnWhatsApp" runat="server" ImageUrl="../imgs/wa.png" OnClick="ContactMeButton_Click" Width="40px" Height="40px" />
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
                  <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-change-password">Change Password</button>
                </li>
              </ul>


              <div class="tab-content pt-2">
                  <div class="tab-pane fade show active profile-overview" id="profile-overview">
                    <h5 class="card-title">Biography</h5>
                      <asp:Label ID="lblDes" runat="server" Text="[Add your biography here.]" />
                 

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
                         <div class="col-lg-3 col-md-4 label">Date Of Birthday</div>
                         <div class="col-lg-9 col-md-8">
                             <asp:Label ID="lblDob" runat="server" BorderStyle="None" Text="Date of Birth"></asp:Label>
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
                            <asp:Label ID="lblTutorExpertice" runat="server" Text="[Loading...]" />
                        </div>
                  </div>
                </div>
          

                 <%--//edit tutor profile--%>
                <div class="tab-pane fade profile-edit pt-3" id="profile-edit">
                    <div class="row mb-3">
                        <label for="profileImage" class="col-md-4 col-lg-3 col-form-label">Profile Image</label>
                        <div class="col-md-8 col-lg-9">
                            <div id="profileImageContainer" class="empty-image-box" style="width: 130px; height: 130px; border: 1px solid #ccc; display: flex; align-items: center; justify-content: center; background-color: #f8f8f8;">
                                <asp:Image ID="imgUserProfile_2" runat="server" CssClass="img-fluid" AlternateText="Profile Picture" Style="width: 100%; height: 100%;" />
                            </div>
                            <asp:FileUpload ID="btnFileUpload" runat="server" CssClass="p-2" onchange="showProfileImage(this)" />
                        </div>
                    </div>

                    <div class="row mb-3">
                     <label for="fullname" class="col-md-4 col-lg-3 col-form-label">Full Name</label>
                     <div class="col-md-8 col-lg-9">
                         <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter your full name" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtName" Display="Dynamic" ErrorMessage="Full Name is required." CssClass="text-danger" InitialValue="" ValidationGroup="ProfileInfoValidation" />
                        </div>
                     </div>
                     

                   <div class="row mb-3">
                        <label for="username" class="col-md-4 col-lg-3 col-form-label">Username</label>
                        <div class="col-md-8 col-lg-9">
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Enter your username" />
                               <asp:RequiredFieldValidator runat="server" ControlToValidate="txtUsername" Display="Dynamic" ErrorMessage="Username is required." CssClass="text-danger" InitialValue="" ValidationGroup="ProfileInfoValidation" />
                            </div>
                        </div>
                      

                    <div class="row mb-3">
                            <label for="phoneNumber" class="col-md-4 col-lg-3 col-form-label">Phone Number</label>
                            <div class="col-md-8 col-lg-9">
                                <asp:TextBox ID="txtPhoneNumber" runat="server" CssClass="form-control" placeholder="Enter your phone number" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPhoneNumber" Display="Dynamic" ErrorMessage="Phone Number is required." CssClass="text-danger" InitialValue="" ValidationGroup="ProfileInfoValidation" />
                                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtPhoneNumber" Display="Dynamic" ErrorMessage="Invalid phone number format." ValidationExpression="^\d{10}$" CssClass="text-danger" ValidationGroup="ProfileInfoValidation" />
                           </div>
                    </div>

                        <div class="row mb-3">
                            <label for="gender" class="col-md-4 col-lg-3 col-form-label">Gender</label>
                            <div class="col-md-8 col-lg-9">
                                <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-select">
                                    <asp:ListItem Value="male">Male</asp:ListItem>
                                    <asp:ListItem Value="female">Female</asp:ListItem>
                                    <asp:ListItem Value="others">Others</asp:ListItem>
                                </asp:DropDownList>    <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlGender" Display="Dynamic" ErrorMessage="Gender is required." CssClass="text-danger" InitialValue="" ValidationGroup="ProfileInfoValidation" />
                             </div>
                        </div>
                           

                    <div class="row mb-3">
                        <label for="DateOfBirth" class="col-md-4 col-lg-3 col-form-label">Date Of Birth</label>
                        <div class="col-md-8 col-lg-9">
                            <asp:TextBox ID="txtDob" runat="server" CssClass="form-control" placeholder="Enter the date of birth" TextMode="Date" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDob" Display="Dynamic" ErrorMessage="Date Of Birt is required." CssClass="text-danger" InitialValue="" ValidationGroup="ProfileInfoValidation" />
                        </div>
                       </div>

                        <div class="row mb-3">
                            <label for="teachingExperience" class="col-md-4 col-lg-3 col-form-label">Teaching Experience</label>
                            <div class="col-md-8 col-lg-9">
                                <asp:TextBox ID="txtTeachingExperience" runat="server" CssClass="form-control" placeholder="Enter the number of years" TextMode="Number" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtTeachingExperience" Display="Dynamic" ErrorMessage="Teaching Experience is required." CssClass="text-danger" InitialValue="" ValidationGroup="ProfileInfoValidation" />
                            </div>
                        </div>


                        <div class="row mb-3">
                            <label for="location" class="col-md-4 col-lg-3 col-form-label">Location</label>
                            <div class="col-md-8 col-lg-9">
                                <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control" placeholder="Enter your location" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLocation" Display="Dynamic" ErrorMessage="Location is required." CssClass="text-danger" InitialValue="" ValidationGroup="ProfileInfoValidation" />
</div>
                            </div>
                           

                        <div class="row mb-3">
                            <label for="tutorExpertice" class="col-md-4 col-lg-3 col-form-label">Tutor Expertise</label>
                            <div class="col-md-8 col-lg-9">
                                <asp:TextBox ID="txtTutorExpertice" runat="server" CssClass="form-control" TextMode="MultiLine" placeholder="Enter your tutor expertise"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtTutorExpertice" Display="Dynamic" ErrorMessage="Tutor Expertise is required." CssClass="text-danger" InitialValue="" ValidationGroup="ProfileInfoValidation" />
</div>
                            </div>
                           

                        <div class="row mb-3">
                            <label for="tutorLanPro" class="col-md-4 col-lg-3 col-form-label">Language Proficiency</label>
                            <div class="col-md-8 col-lg-9">
                                <asp:TextBox ID="txtLangPro" runat="server" CssClass="form-control" TextMode="MultiLine" placeholder="Enter your Language Proficiency"></asp:TextBox>
                               <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLangPro" Display="Dynamic" ErrorMessage="Language Proficiency is required." CssClass="text-danger" InitialValue="" ValidationGroup="ProfileInfoValidation" />
</div>
                                </div>
                           

                        <div class="row mb-3">
                            <label for="biography" class="col-md-4 col-lg-3 col-form-label">Biography</label>
                            <div class="col-md-8 col-lg-9">
                                <asp:TextBox ID="txtBiography" runat="server" CssClass="form-control" TextMode="MultiLine" placeholder="Enter your biography"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtBiography" Display="Dynamic" ErrorMessage="Biography is required." CssClass="text-danger" InitialValue="" ValidationGroup="ProfileInfoValidation" />
</div>
                            </div>
                           

                        <div class="text-center">
                            <asp:Button ID="btnUpdateTutorProfile" runat="server" Text="Save Changes" OnClick="btnUpdateTutorProfile_Click" CssClass="btn btn-primary" style="background-color: #FF6636; border-color: #FF6636;" ValidationGroup="ProfileInfoValidation" />
                    </div>
                      <!-- Add a ValidationSummary to display a summary of errors -->
                    <asp:ValidationSummary runat="server" ID="ValidationSummary1" HeaderText="Please correct the following errors:" ShowSummary="true" DisplayMode="BulletList" CssClass="text-danger" ValidationGroup="ProfileInfoValidation" />
                </div>

                <div class="tab-pane fade pt-3" id="profile-change-password">
                      <!-- Change Password Form -->
                      <div class="row mb-3">
                        <label for="currentPassword" class="col-md-4 col-lg-3 col-form-label">Current Password</label>
                        <div class="col-md-8 col-lg-9">
                          <div class="input-group">
                            <asp:TextBox ID="lblCurrentPass" runat="server" TextMode="Password" CssClass="form-control" placeholder="Enter your current password"></asp:TextBox>
                           <button type="button" class="btn btn-outline-secondary" id="toggleCurrentPassword" onclick="togglePassword('<%= lblCurrentPass.ClientID %>')">
                               <i class="bi bi-eye"></i>
                           </button>
                          </div>
                        </div>
                      </div>

                      <div class="row mb-3">
                        <label for="newPassword" class="col-md-4 col-lg-3 col-form-label">New Password</label>
                        <div class="col-md-8 col-lg-9">
                          <div class="input-group">
                            <asp:TextBox ID="lblNewPass" runat="server" TextMode="Password" CssClass="form-control" placeholder="Enter your new password"></asp:TextBox>
                            <button type="button" class="btn btn-outline-secondary" id="toggleNewPassword" onclick="togglePassword('<%= lblNewPass.ClientID %>')">
                               <i class="bi bi-eye"></i>
                           </button>
                          </div>
                        </div>
                      </div>

                      <div class="row mb-3">
                        <label for="renewPassword" class="col-md-4 col-lg-3 col-form-label">Re-enter New Password</label>
                        <div class="col-md-8 col-lg-9">
                          <div class="input-group">
                            <asp:TextBox ID="lblReNewPass" runat="server" TextMode="Password" CssClass="form-control" placeholder="Re-enter your new password"></asp:TextBox>
                            <button type="button" class="btn btn-outline-secondary" id="toggleRenewPassword" onclick="togglePassword('<%= lblReNewPass.ClientID %>')">
                               <i class="bi bi-eye"></i>
                           </button>
                          </div>
                        </div>
                      </div>

                        <div class="text-center">
                            <asp:Button ID="btnChangePassword" runat="server" Text="Change Password" OnClick="btnChangePassword_Click" CssClass="btn btn-primary" Style="background-color: #FF6636; border-color: #FF6636;" />
                        </div><!-- End Change Password Form -->
                </div>
              </div><!-- End Bordered Tabs -->

            </div>
          </div>
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

               function showProfileImage(input) {
                   var file = input.files[0];
                   var profileImageContainer = document.getElementById('profileImageContainer');
                   var imgUserProfile_2 = document.getElementById('<%= imgUserProfile_2.ClientID %>');
                 

                  if (file) {
                      var reader = new FileReader();
                      reader.onload = function (e) {
                          imgUserProfile_2.src = e.target.result;
                          emptyProfileIcon.style.display = 'none'; // Hide the empty icon
                      }
                      reader.readAsDataURL(file);
                  } else {
                      imgUserProfile_2.src = ''; // Clear the profile image source
                    
                  }
              }
           </script>
    </section>
  </main><!-- End #main -->
</asp:Content>
