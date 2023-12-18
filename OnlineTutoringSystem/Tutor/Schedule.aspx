<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorSideBar.Master" AutoEventWireup="true" CodeBehind="Schedule.aspx.cs" Inherits="OnlineTutoringSystem.Tutor.WebForm2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  
 <link rel="stylesheet" href="assets/css/calander.css" />

    <!-- Add these links to your HTML -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

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
                    <asp:TextBox runat="server" ID="txtDateInput" CssClass="date-input" placeholder="mm/yyyy"></asp:TextBox>
                    <asp:Button runat="server" ID="btnGoto" CssClass="goto-btn" Text="Go" OnClientClick="return false;" />
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

           <!-- Add this modal to your HTML -->
                <div class="modal fade" id="addEventModal" tabindex="-1" role="dialog" aria-labelledby="addEventModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                               <h5 class="modal-title" id="addEventModalLabel">Add Event</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <!-- Your form fields go here -->
                                <div class="form-group">
                                    <label for="eventTitle">Event Name</label>
                                    <asp:TextBox runat="server" ID="txtEventTitle" CssClass="form-control" placeholder="Event Name"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label for="eventTimeFrom">Event Time From</label>
                                    <asp:TextBox runat="server" ID="txtEventTimeFrom" CssClass="form-control" placeholder="Event Time From"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label for="eventTimeTo">Event Time To</label>
                                    <asp:TextBox runat="server" ID="txtEventTimeTo" CssClass="form-control" placeholder="Event Time To"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label for="scheduleDate">Schedule Date</label>
                                    <asp:TextBox runat="server" ID="txtScheduleDate" CssClass="form-control" placeholder="Schedule Date" type="date"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label for="scheduleDescription">Schedule Description</label>
                                    <asp:TextBox runat="server" ID="txtScheduleDescription" CssClass="form-control" placeholder="Schedule Description"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label for="scheduleStatus">Schedule Status</label>
                                    <asp:TextBox runat="server" ID="txtScheduleStatus" CssClass="form-control" placeholder="Schedule Status"></asp:TextBox>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <asp:Button runat="server" ID="addEventBtn" Text="Add Event" CssClass="btn btn-primary" OnClientClick="addEvent();" OnClick="addEventBtn_Click" />
                            </div>
                        </div>
                    </div>
                </div>
           
                 <!-- Replace your existing add-event button with this -->
                <button type="button" class="add-event" data-toggle="modal" data-target="#addEventModal">
                    <i class="fas fa-plus"></i>
                </button>
            </div>
    </div>
    <script src="calander.js"></script>
    <script type="text/javascript">
        const calendar = document.querySelector(".calendar"),
            date = document.querySelector(".date"),
            daysContainer = document.querySelector(".days"),
            prev = document.querySelector(".prev"),
            next = document.querySelector(".next"),
            todayBtn = document.querySelector(".today-btn"),
            gotoBtn = document.querySelector(".goto-btn"),
            dateInput = document.querySelector(".date-input"),
            eventDay = document.querySelector(".event-day"),
            eventDate = document.querySelector(".event-date"),
            eventsContainer = document.querySelector(".events");

        let today = new Date();
        let activeDay;
        let month = today.getMonth();
        let year = today.getFullYear();

        const months = [
            "January",
            "February",
            "March",
            "April",
            "May",
            "June",
            "July",
            "August",
            "September",
            "October",
            "November",
            "December",
        ];

        const eventsArr = [];
        getEvents();
        console.log(eventsArr);

        //function to add days in days with class day and prev-date next-date on previous month and next month days and active on today
        function initCalendar() {
            const firstDay = new Date(year, month, 1);
            const lastDay = new Date(year, month + 1, 0);
            const prevLastDay = new Date(year, month, 0);
            const prevDays = prevLastDay.getDate();
            const lastDate = lastDay.getDate();
            const day = firstDay.getDay();
            const nextDays = 7 - lastDay.getDay() - 1;

            date.innerHTML = months[month] + " " + year;

            let days = "";

            for (let x = day; x > 0; x--) {
                days += `<div class="day prev-date">${prevDays - x + 1}</div>`;
            }

            for (let i = 1; i <= lastDate; i++) {
                //check if event is present on that day
                let event = false;
                eventsArr.forEach((eventObj) => {
                    if (
                        eventObj.day === i &&
                        eventObj.month === month + 1 &&
                        eventObj.year === year
                    ) {
                        event = true;
                    }
                });
                if (
                    i === new Date().getDate() &&
                    year === new Date().getFullYear() &&
                    month === new Date().getMonth()
                ) {
                    activeDay = i;
                    getActiveDay(i);
                    updateEvents(i);
                    if (event) {
                        days += `<div class="day today active event">${i}</div>`;
                    } else {
                        days += `<div class="day today active">${i}</div>`;
                    }
                } else {
                    if (event) {
                        days += `<div class="day event">${i}</div>`;
                    } else {
                        days += `<div class="day ">${i}</div>`;
                    }
                }
            }

            for (let j = 1; j <= nextDays; j++) {
                days += `<div class="day next-date">${j}</div>`;
            }
            daysContainer.innerHTML = days;
            addListner();
        }

        //function to add month and year on prev and next button
        function prevMonth() {
            month--;
            if (month < 0) {
                month = 11;
                year--;
            }
            initCalendar();
        }

        function nextMonth() {
            month++;
            if (month > 11) {
                month = 0;
                year++;
            }
            initCalendar();
        }

        prev.addEventListener("click", prevMonth);
        next.addEventListener("click", nextMonth);

        initCalendar();

        //function to add active on day
        function addListner() {
            const days = document.querySelectorAll(".day");
            days.forEach((day) => {
                day.addEventListener("click", (e) => {
                    getActiveDay(e.target.innerHTML);
                    updateEvents(Number(e.target.innerHTML));
                    activeDay = Number(e.target.innerHTML);
                    //remove active
                    days.forEach((day) => {
                        day.classList.remove("active");
                    });
                    //if clicked prev-date or next-date switch to that month
                    if (e.target.classList.contains("prev-date")) {
                        prevMonth();
                        //add active to clicked day afte month is change
                        setTimeout(() => {
                            //add active where no prev-date or next-date
                            const days = document.querySelectorAll(".day");
                            days.forEach((day) => {
                                if (
                                    !day.classList.contains("prev-date") &&
                                    day.innerHTML === e.target.innerHTML
                                ) {
                                    day.classList.add("active");
                                }
                            });
                        }, 100);
                    } else if (e.target.classList.contains("next-date")) {
                        nextMonth();
                        //add active to clicked day afte month is changed
                        setTimeout(() => {
                            const days = document.querySelectorAll(".day");
                            days.forEach((day) => {
                                if (
                                    !day.classList.contains("next-date") &&
                                    day.innerHTML === e.target.innerHTML
                                ) {
                                    day.classList.add("active");
                                }
                            });
                        }, 100);
                    } else {
                        e.target.classList.add("active");
                    }
                });
            });
        }

        function convertTime(time) {
            //convert time to 24 hour format
            let timeArr = time.split(":");
            let timeHour = timeArr[0];
            let timeMin = timeArr[1];
            let timeFormat = timeHour >= 12 ? "PM" : "AM";
            timeHour = timeHour % 12 || 12;
            time = timeHour + ":" + timeMin + " " + timeFormat;
            return time;
        }


        function addEvent() {
            // Your logic for handling the form submission and adding events
            // Close the modal when done
            $('#addEventModal').modal('hide');
            return false; // Ensure the postback is not triggered
            }

        // Corrected selector to use ID, not class
        var addEventFrom = document.querySelector("#<%= txtEventTimeFrom.ClientID %>");

        // Allow only time in eventtime from and to
        addEventFrom.addEventListener("input", function (e) {
            addEventFrom.value = addEventFrom.value.replace(/[^0-9:]/g, "");
            if (addEventFrom.value.length === 2 && addEventFrom.value.indexOf(":") === -1) {
                addEventFrom.value += ":";
            }
            if (addEventFrom.value.length > 5) {
                addEventFrom.value = addEventFrom.value.slice(0, 5);
            }
        });

        // Corrected selector to use ID, not class
        var txtEventTimeTo = document.querySelector("#<%= txtEventTimeTo.ClientID %>");

        // Allow only time in eventtime from and to
        txtEventTimeTo.addEventListener("input", function (e) {
            txtEventTimeTo.value = txtEventTimeTo.value.replace(/[^0-9:]/g, "");
            if (txtEventTimeTo.value.length === 2 && txtEventTimeTo.value.indexOf(":") === -1) {
                txtEventTimeTo.value += ":";
            }
            if (txtEventTimeTo.value.length > 5) {
                txtEventTimeTo.value = txtEventTimeTo.value.slice(0, 5);
            }
        });

        // Get references to ASP.NET controls
        var dateInput = document.querySelector("#<%= txtDateInput.ClientID %>"),
                    gotoBtn = document.querySelector("#<%= btnGoto.ClientID %>");

                dateInput.addEventListener("input", function (e) {
                    dateInput.value = dateInput.value.replace(/[^0-9/]/g, "");
                    if (dateInput.value.length === 2) {
                        dateInput.value += "/";
                    }
                    if (dateInput.value.length > 7) {
                        dateInput.value = dateInput.value.slice(0, 7);
                    }
                    if (e.inputType === "deleteContentBackward") {
                        if (dateInput.value.length === 3) {
                            dateInput.value = dateInput.value.slice(0, 2);
                        }
                    }
                });


                gotoBtn.addEventListener("click", gotoDate);

                function gotoDate() {
                    console.log("here");
                    const dateArr = dateInput.value.split("/");
                    if (dateArr.length === 2) {
                        if (dateArr[0] > 0 && dateArr[0] < 13 && dateArr[1].length === 4) {
                            month = dateArr[0] - 1;
                            year = dateArr[1];
                            initCalendar();
                            return;
                        }
                    }
                    alert("Invalid Date");
                }
    </script>
</main><!-- End #main -->

</asp:Content>
