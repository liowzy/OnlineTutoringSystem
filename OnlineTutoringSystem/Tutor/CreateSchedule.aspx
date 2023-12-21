<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorSideBar.Master" AutoEventWireup="true" CodeBehind="CreateSchedule.aspx.cs" Inherits="OnlineTutoringSystem.Tutor.WebForm8" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Create Schedule</title>
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
          <h1>Schedule Management</h1>
          <nav>
            <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="Profile.aspx">Home</a></li>
              <li class="breadcrumb-item active">Schedule Managment</li>
            </ol>
          </nav>
        </div><!-- End Page Title -->

        <!-- Left Side: Schedule Form -->
<div class="row">
    <div class="col-md-6">
        <div class="card mb-4">
            <div class="card-body">
                <h3 class="card-title mb-4">Create Schedule</h3>
                    <div class="mb-3">
                        <label for="txtScheduleDate" class="form-label">Schedule Date:</label>
                        <asp:TextBox runat="server" ID="txtScheduleDate" CssClass="form-control" TextMode="Date" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtScheduleDate" Display="Dynamic" ErrorMessage="Schedule Date is required." CssClass="text-danger" ValidationGroup="CreateScheduleValidation"/>
                    </div>

                    <div class="mb-3">
                        <label for="txtStartTime" class="form-label">Start Time:</label>
                        <asp:TextBox runat="server" ID="txtStartTime" CssClass="form-control" TextMode="Time" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtStartTime" Display="Dynamic" ErrorMessage="Start Time is required." CssClass="text-danger" ValidationGroup="CreateScheduleValidation" />
                    </div>

                    <div class="mb-3">
                        <label for="txtEndTime" class="form-label">End Time:</label>
                        <asp:TextBox runat="server" ID="txtEndTime" CssClass="form-control" TextMode="Time" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEndTime" Display="Dynamic" ErrorMessage="End Time is required." CssClass="text-danger" ValidationGroup="CreateScheduleValidation"/>
                    </div>

                    <div class="mb-3">
                        <label for="txtDescription" class="form-label">Description:</label>
                        <asp:TextBox runat="server" ID="txtDescription" CssClass="form-control" TextMode="MultiLine" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDescription" Display="Dynamic" ErrorMessage="Description is required." CssClass="text-danger" ValidationGroup="CreateScheduleValidation"/>
                    </div>

                    <div class="mb-3">
                        <label for="txtGoogleMeet" class="form-label">Google Meet Link:</label>
                        <asp:TextBox runat="server" ID="txtGoogleMeet" CssClass="form-control" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtGoogleMeet" Display="Dynamic" ErrorMessage="Google Meet Link is required." CssClass="text-danger" ValidationGroup="CreateScheduleValidation"/>
                    </div>

                    <div class="mb-3">
                        <label for="ddlCourse" class="form-label">Course Name:</label>
                        <asp:DropDownList runat="server" ID="ddlCourse" CssClass="form-control" DataTextField="course_name" DataValueField="course_id" AutoPostBack="true" OnSelectedIndexChanged="ddlCourse_SelectedIndexChanged">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlCourse" Display="Dynamic" ErrorMessage="Course Name is required." CssClass="text-danger" InitialValue="" ValidationGroup="CreateScheduleValidation"/>
                           <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlCourse" 
                                    InitialValue="" ValidationGroup="ResourceValidationGroup"
                                    ErrorMessage="Please select a Course"></asp:RequiredFieldValidator>--%>
                        </div>

                    <div class="mb-3">
                        <label for="ddlResourceFile" class="form-label">Resource File:</label>
                        <asp:DropDownList runat="server" ID="ddlResourceFile" CssClass="form-control" DataTextField="file_name" DataValueField="file_id" EnableViewState="true" AutoPostBack="true">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlResourceFile" Display="Dynamic" ErrorMessage="Resource File is required." CssClass="text-danger" InitialValue="" ValidationGroup="CreateScheduleValidation"/>              
                    </div>

                   <div class="mb-3">
                        <label for="scheduleStatus">Schedule Status</label>
                        <asp:DropDownList runat="server" ID="txtScheduleStatus" CssClass="form-control">
                             <asp:ListItem Text="Active" Value="Active"></asp:ListItem>
                             <asp:ListItem Text="Inactive" Value="Inactive"></asp:ListItem>
                         </asp:DropDownList>
                    </div>

                    <asp:Button ID="btnCreateSchedule" runat="server" Text="Create Schedule" 
                        OnClientClick="if (!confirm('Are you sure you want to create this schedule?')) return false;"
                        OnClick="btnCreateSchedule_Click" CssClass="btn btn-primary" ValidationGroup="CreateScheduleValidation" />

                    <!-- Add a ValidationSummary to display a summary of errors -->
                    <asp:ValidationSummary runat="server" ID="ValidationSummary1" HeaderText="Please correct the following errors:" ShowSummary="true" DisplayMode="BulletList" CssClass="text-danger" ValidationGroup="CreateScheduleValidation" />
                </div>
            </div>
        </div>

           <!-- Right Side: Display Schedule Table -->
    <div class="col-md-6">
        <div class="card">
            <div class="card-body">
                <h3 class="card-title mb-4">Existing Schedules</h3>

                <!-- Add Label Here -->
                <asp:Label runat="server" ID="lblNoSchedule" CssClass="text-info" Visible="false">
                   <h3>No schedule has been created.</h3>
                </asp:Label>

                <div class="row justify-content-center p-3">
                    <asp:DataList ID="DataList1" runat="server" CssClass="schedule-list mx-auto">
                        <ItemTemplate>
                            <div class="col-9 mb-4 mx-auto">
                                <div class="card h-100">
                                    <div class="card-body">
                                        <h5 class="card-title"><%# Eval("schedule_subject") %></h5>
                                        <p class="card-text">
                                            <i class="bi bi-calendar"></i> <%# Eval("schedule_date", "{0:yyyy-MM-dd}") %>
                                        </p>
                                        <p class="card-text">
                                            <i class="bi bi-clock"></i> <%# Eval("schedule_startTime") %> - <%# Eval("schedule_endTime") %>
                                        </p>
                                        <p class="card-text">
                                            <i class="bi bi-info-circle"></i> <%# Eval("schedule_description") %>
                                        </p>
                                        <p class="card-text">
                                            <i class="bi bi-link-45deg"></i>
                                            <a href='<%# Eval("google_meet") %>' target="_blank">
                                                <%# Eval("google_meet") %>
                                            </a>
                                        </p>
                                       <p class="card-text">
                                            <i class="bi bi-file-earmark"></i> <%# Eval("schedule_resource") %>
                                        </p>
                                    </div>
                                    <div class="card-footer">
                                        <small class="text-muted">
                                            <i class="bi bi-clipboard-check"></i> <%# Eval("schedule_status") %>
                                        </small>
                                        <asp:Button runat="server" CssClass="btn btn-danger btn-sm float-end delete-button"
                                            Text="Delete" OnClientClick="return confirm('Are you sure you want to remove this schedule?');" 
                                            OnClick="DeleteSchedule_Click" CommandArgument='<%# Eval("schedule_id") %>'
                                            ID='Button1' />
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:DataList>
                 </div>
            </div>
        </div>
    </div>
</div>
    </main>

</asp:Content>
