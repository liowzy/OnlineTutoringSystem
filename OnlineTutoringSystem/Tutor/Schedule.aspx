<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorSideBar.Master" AutoEventWireup="true" CodeBehind="Schedule.aspx.cs" Inherits="OnlineTutoringSystem.Tutor.WebForm2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  
 <link rel="stylesheet" href="assets/css/calander.css" />

    <link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"
      integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="
      crossorigin="anonymous"
      referrerpolicy="no-referrer"/>

    <style>
        #main {
        margin-top: 60px;
    }
    </style>

<main id="main" class="main">
    <div class="pagetitle">
      <h1>Schedule</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="../Student/HomePage.aspx">Home</a></li>
          <li class="breadcrumb-item active">Schedule</li>
        </ol>
      </nav>
    </div><!-- End Page Title -->

     <asp:Label ID="lblMessage" runat="server" CssClass="error-message" Visible="false"></asp:Label>

<div class="container">
          <div class="left">
            <div class="calendar">
              <div class="month">
                <i class="fas fa-angle-left prev"></i>
                <div class="date">december 2015</div>
                <i class="fas fa-angle-right next"></i>
              </div>
              <div class="weekdays">
                <div>Sun</div>
                <div>Mon</div>
                <div>Tue</div>
                <div>Wed</div>
                <div>Thu</div>
                <div>Fri</div>
                <div>Sat</div>
              </div>
              <div class="days"></div>
              <div class="goto-today">
                <div class="goto">
                  <input type="text" placeholder="mm/yyyy" class="date-input" />
                  <button class="goto-btn">Go</button>
                </div>
                <button class="today-btn">Today</button>
              </div>
            </div>
          </div>

        <div class="right">
            <div class="today-date">
              <div class="event-day">wed</div>
              <div class="event-date">12th december 2022</div>
            </div>
        
            <div class="events"></div>
                <div class="add-event-wrapper">
                      <div class="add-event-header">
                        <div class="title">Add Event</div>
                        <i class="fas fa-times close"></i>
                      </div>
                      <div class="add-event-body">
                        <div class="add-event-input">
                          <input type="text" placeholder="Event Name" class="event-name" />

                        </div>
                        <div class="add-event-input">
                          <input type="text" placeholder="Event Time From" class="event-time-from" />
                        </div>
                        <div class="add-event-input">
                          <input type="text" placeholder="Event Time To" class="event-time-to" />
                        </div>
                        <div class="add-event-input">
                          <input type="date" placeholder="Schedule Date" class="schedule-date" />
                        </div>
                        <div class="add-event-input">
                          <input type="text" placeholder="Schedule Description" class="schedule-description" />
                        </div>
                        <div class="add-event-input">
                          <input type="text" placeholder="Schedule Status" class="schedule-status" />
                        </div>
                      </div>
                      <div class="add-event-footer">
                        <button class="add-event-btn">Add Event</button>
                      </div>
                    </div>
               </div>
                  <button class="add-event">
                    <i class="fas fa-plus"></i>
                  </button>
</div>

    <script src="calander.js"></script>
</main><!-- End #main -->

</asp:Content>
