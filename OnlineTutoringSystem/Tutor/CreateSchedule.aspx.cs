using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Dynamic;
using static OnlineTutoringSystem.Tutor.WebForm7;
using System.Resources;

namespace OnlineTutoringSystem.Tutor
{
    public partial class WebForm8 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadTutorData();
                ddlCourse.SelectedIndexChanged += ddlCourse_SelectedIndexChanged;
                BindDataList();
            }

            DataList1.ItemDataBound += DataList1_ItemDataBound;
        }


        protected void ddlCourse_SelectedIndexChanged(object sender, EventArgs e)
        {
            // When the course selection changes, rebind the resource files and trigger validation
            BindCourseResource();
            Page.Validate("ResourceValidationGroup");
        }

        private void LoadTutorData()
        {
            // Get the tutor ID directly from the session
            int tutorId = GetTutorId();

            // Bind courses associated with the tutor
            BindCourseName(tutorId);

            // If you need to use the tutorId elsewhere, you can store it in a variable or property
            // Example: int currentTutorId = tutorId;

            // Note: If you don't need to use the tutorId elsewhere, you can directly use it in btnSubmit_Click
        }

        private int GetTutorId()
        {
            if (Session["userId"] != null)
            {
                return Convert.ToInt32(Session["userId"]);
            }

            // Handle the case when the user is not logged in (return a default value or handle it accordingly)
            return -1; // You can choose an appropriate default value
        }

        protected void BindCourseName(int tutorId)
        {
            YourDataAccessLayer dataAccess = new YourDataAccessLayer();
            DataTable dtCourses = dataAccess.GetCourses(tutorId);

            // Bind the actual courses
            ddlCourse.DataSource = dtCourses;
            ddlCourse.DataTextField = "course_name";
            ddlCourse.DataValueField = "course_id";
            ddlCourse.DataBind();

            // Check if it's the first load (not a postback) and there is only one course
            if (!IsPostBack && dtCourses.Rows.Count == 1)
            {
                // Set the default selection for ddlCourse
                ddlCourse.SelectedIndex = 0;

                // Trigger validation explicitly for the ResourceValidationGroup
                Page.Validate("ResourceValidationGroup");
            }
            else
            {
                // Add the default item for the case when there are multiple courses
                ListItem defaultItem = new ListItem("Please select a course", "");
                ddlCourse.Items.Insert(0, defaultItem);

                // Trigger validation explicitly for the ResourceValidationGroup
                Page.Validate("ResourceValidationGroup");
            }
        }


        protected void BindCourseResource()
        {
            try
            {
                YourDataAccessLayer dataAccess = new YourDataAccessLayer();

                // Check if ddlCourse.SelectedValue is not empty
                if (!string.IsNullOrEmpty(ddlCourse.SelectedValue))
                {
                    // Assuming ddlCourse.SelectedValue returns the courseId as a string
                    int courseId = int.Parse(ddlCourse.SelectedValue);

                    DataTable dtResourceFiles = dataAccess.GetResourceFiles(courseId);

                    if (dtResourceFiles.Rows.Count > 0)
                    {
                        ddlResourceFile.DataSource = dtResourceFiles;
                        ddlResourceFile.DataTextField = "file_name";
                        ddlResourceFile.DataValueField = "file_id";
                        ddlResourceFile.DataBind();

                        // Enable the dropdown since there are resource files
                        ddlResourceFile.Enabled = true;
                    }
                    else
                    {
                        // If there are no resource files, disable the dropdown and show a message
                        ddlResourceFile.Items.Clear();
                        ddlResourceFile.Items.Insert(0, new ListItem("No files available", ""));
                        ddlResourceFile.Enabled = false;
                    }
                }
                else
                {
                    // If no course is selected, disable the dropdown and show a message
                    ddlResourceFile.Items.Clear();
                    ddlResourceFile.Items.Insert(0, new ListItem("Choose a course first", ""));
                    ddlResourceFile.Enabled = false;
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions appropriately, e.g., log the error or show a user-friendly message
                Response.Write($"An error occurred: {ex.Message}");
            }
        }


        public class YourDataAccessLayer
        {
            // Your connection string
            private string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            public DataTable GetCourses(int tutorId)
            {
                DataTable dtCourses = new DataTable();

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "SELECT course_id, course_name FROM Course WHERE tutor_id = @TutorId";
                    using (SqlCommand cmd = new SqlCommand(query, connection))
                    {
                        cmd.Parameters.AddWithValue("@TutorId", tutorId);

                        connection.Open();
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            da.Fill(dtCourses);
                        }
                    }
                }

                return dtCourses;
            }

            public DataTable GetResourceFiles(int courseId)
            {
                DataTable dtResourceFiles = new DataTable();

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = @"SELECT fa.file_id, fa.file_name, fa.file_path 
                      FROM File_Attachment fa
                      JOIN Resource r ON fa.res_id = r.res_id
                      WHERE r.course_id = @CourseId";

                    using (SqlCommand cmd = new SqlCommand(query, connection))
                    {
                        cmd.Parameters.AddWithValue("@CourseId", courseId);

                        connection.Open();

                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            da.Fill(dtResourceFiles);
                        }
                    }
                }

                return dtResourceFiles;
            }
        }

        protected void btnCreateSchedule_Click(object sender, EventArgs e)
        {
           
            try
            {
                // Update the course details in the database
                CreateSchedule();

                // Clear the form after successful schedule creation
                ClearScheduleForm();
            }
            catch (Exception ex)
            {
                // Handle update failure if needed
                ScriptManager.RegisterStartupScript(this, GetType(), "updateAlert", "alert('Failed to update the course.');", true);

                // Log the exception to a log file or a logging framework
                LogException(ex);
            }
        }

        private void ClearScheduleForm()
        {
            // Reset the values of the form controls to their default or initial state
            txtScheduleDate.Text = string.Empty;
            txtStartTime.Text = string.Empty;
            txtEndTime.Text = string.Empty;
            txtDescription.Text = string.Empty;
            txtGoogleMeet.Text = string.Empty;
            txtScheduleStatus.SelectedIndex = 0; // Assuming the first item is the default
            ddlCourse.SelectedIndex = 0; // Assuming the first item is the default
            ddlResourceFile.SelectedIndex = 0; // Assuming the first item is the default

            // Additional controls can be cleared in a similar manner
        }

        private void CreateSchedule()
        {
            try
            {
                // Get user inputs from the form
                string scheduleDate = this.txtScheduleDate.Text;
                string startTime = this.txtStartTime.Text;
                string endTime = this.txtEndTime.Text;
                string description = this.txtDescription.Text;
                string googleMeetLink = txtGoogleMeet.Text;
                string status = this.txtScheduleStatus.SelectedValue;
                int tutorId = Convert.ToInt32(this.GetTutorId());
                int courseId = int.Parse(ddlCourse.SelectedValue);
                // Get the selected file_id from ddlResourceFile
                int fileId = int.Parse(ddlResourceFile.SelectedValue);
                string subject = ddlCourse.SelectedItem.ToString(); // Assuming subject is a string
                string fileName = ddlResourceFile.SelectedItem.ToString(); // Assuming resource is an int

                // Validate the selected date
                DateTime selectedDate = DateTime.ParseExact(scheduleDate, "yyyy-MM-dd", null);

                if (selectedDate < DateTime.Today)
                {
                    // Display an error message or take appropriate action
                    ScriptManager.RegisterStartupScript(this, GetType(), "validationAlert", "alert('Selected date should not be before today.');", true);
                    return;
                }

                // Validate the time duration (endTime - startTime)
                TimeSpan duration = TimeSpan.Parse(endTime) - TimeSpan.Parse(startTime);

                if (duration.TotalHours > 2)
                {
                    // Display an error message or take appropriate action
                    ScriptManager.RegisterStartupScript(this, GetType(), "validationAlert", "alert('The time duration should not be more than 2 hours.');", true);
                    return;
                }

                if (duration.TotalMinutes < 5)
                {
                    
                    // Display an alert message
                    ScriptManager.RegisterStartupScript(this, GetType(), "validationAlert", "alert('The time duration should not be less than 5 minutes.');", true);
                    return;
                }

                // Validate the time duration (endTime - startTime)
                TimeSpan startTimeValue = TimeSpan.Parse(startTime);
                TimeSpan endTimeValue = TimeSpan.Parse(endTime);

                if (endTimeValue < startTimeValue)
                {
                    // Display an error message or take appropriate action
                    ScriptManager.RegisterStartupScript(this, GetType(), "validationAlert", "alert('Invalid time duration. Make sure end time is not earlier than start time.');", true);
                    return;
                }

                // Validate the Google Meet link format
                if (!IsValidUrl(googleMeetLink))
                {
                    // Display an error message or take appropriate action
                    ScriptManager.RegisterStartupScript(this, GetType(), "validationAlert", "alert('Invalid Google Meet link format.');", true);
                    return;
                }

                // Connection string - Update this with your database connection details
                string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

                string insertQuery = "INSERT INTO Schedule (schedule_date, schedule_startTime, schedule_endTime, " +
                             "schedule_description, schedule_status, tutor_id, google_meet, course_id, file_id, " +
                             "schedule_subject, schedule_resource) " +
                             "VALUES (@ScheduleDate, @StartTime, @EndTime, @Description, @Status, @TutorId, @GoogleMeetLink, " +
                             "@CourseId, @FileId, @Subject, @Resource)";

                // Using statement ensures that the SqlConnection is closed and disposed when done
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    // Using statement ensures that the SqlCommand and SqlDataReader are closed and disposed when done
                    using (SqlCommand command = new SqlCommand(insertQuery, connection))
                    {
                        // Add parameters to the SqlCommand to prevent SQL injection
                        command.Parameters.AddWithValue("@ScheduleDate", scheduleDate);
                        command.Parameters.AddWithValue("@StartTime", startTime);
                        command.Parameters.AddWithValue("@EndTime", endTime);
                        command.Parameters.AddWithValue("@Description", description);
                        command.Parameters.AddWithValue("@Status", status);
                        command.Parameters.AddWithValue("@TutorId", tutorId);
                        command.Parameters.AddWithValue("@GoogleMeetLink", googleMeetLink);
                        command.Parameters.AddWithValue("@CourseId", courseId);
                        command.Parameters.AddWithValue("@FileId", fileId); // Add file_id parameter
                        command.Parameters.AddWithValue("@Subject", subject);
                        command.Parameters.AddWithValue("@Resource", fileName);

                        // Open the connection
                        connection.Open();

                        // Execute the SQL command (INSERT)
                        command.ExecuteNonQuery();
                    }
                }

                // Additional logic, such as redirecting to another page or displaying a success message
                ScriptManager.RegisterStartupScript(this, GetType(), "updateAlert", "alert('Schedule created successfully.');", true);
                BindDataList();
            }
            catch (Exception ex)
            {
                // Handle exceptions appropriately, e.g., log the error or show a user-friendly message
                // You can also redirect to an error page
                ScriptManager.RegisterStartupScript(this, GetType(), "errorAlert", $"alert('An error occurred: {ex.Message}');", true);
            }
        }

        // Function to validate URL format
        private bool IsValidUrl(string url)
        {
            Uri uriResult;
            return Uri.TryCreate(url, UriKind.Absolute, out uriResult) &&
                   (uriResult.Scheme == Uri.UriSchemeHttp || uriResult.Scheme == Uri.UriSchemeHttps);
        }

        protected void BindDataList()
        {
            // Check if the tutor ID is stored in the session
            if (Session["userId"] != null)
            {
                int tutorId = Convert.ToInt32(Session["userId"]);

                string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                string query = "SELECT schedule_id, schedule_date, schedule_startTime, schedule_endTime, " +
                                "schedule_subject, schedule_description, schedule_status, google_meet, schedule_resource ,file_id " +
                                "FROM Schedule WHERE tutor_id = @TutorId";

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@TutorId", tutorId);

                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader();

                        DataTable dataTable = new DataTable();
                        dataTable.Load(reader);

                        // Iterate through the rows and update schedule_status based on the end time
                        foreach (DataRow row in dataTable.Rows)
                        {
                            DateTime scheduleEndTime = (DateTime)row["schedule_date"] + (TimeSpan)row["schedule_endTime"];

                            if (scheduleEndTime < DateTime.Now)
                            {
                                // The schedule has expired, update status to "Inactive"
                                row["schedule_status"] = "Inactive";
                                // Update status in the database
                                int scheduleId = (int)row["schedule_id"];
                                UpdateScheduleStatusInDatabase(scheduleId, "Inactive");
                            }
                        }

                        // Convert date and time columns explicitly
                        foreach (DataRow row in dataTable.Rows)
                        {
                            // Convert time columns
                            TimeSpan startTime = (TimeSpan)row["schedule_startTime"];
                            TimeSpan endTime = (TimeSpan)row["schedule_endTime"];

                            // Format the TimeSpan as HH:mm
                            row["schedule_startTime"] = startTime.ToString("hh\\:mm");
                            row["schedule_endTime"] = endTime.ToString("hh\\:mm");

                            // Convert other columns if needed
                            row["schedule_status"] = row["schedule_status"].ToString();
                            row["schedule_subject"] = row["schedule_subject"].ToString();
                            row["schedule_description"] = row["schedule_description"].ToString();
                            row["google_meet"] = row["google_meet"].ToString();
                            row["schedule_resource"] = row["schedule_resource"].ToString();
                            row["file_id"] = row["file_id"].ToString();
                        }

                        // Bind data to the DataList
                        DataList1.DataSource = dataTable;
                        DataList1.DataBind();

                        // Show or hide the label based on whether there is schedule data
                        lblNoSchedule.Visible = dataTable.Rows.Count == 0;
                    }
                }
            }
            else
            {
                // Handle the case when no event at the session
                lblNoSchedule.Visible = true;
                lblNoSchedule.Text = "No Schedule has been created.";
            }
        }

        protected void btnOpen_Click(object sender, EventArgs e)
        {
            // Get the file_id from the clicked button
            Button btn = (Button)sender;
            string fileId = btn.CommandArgument;

            string redirectUrl = "../Student/WebForm51.aspx?file_id=" + fileId;
            Session["SelectedFileId"] = fileId;
            // Use JavaScript to open the URL in a new tab
            string script = "window.open('" + redirectUrl + "', '_blank');";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "openInNewTab", script, true);
        }

        // Function to update schedule_status in the database
        private void UpdateScheduleStatusInDatabase(int scheduleId, string newStatus)
        {
            try
            {
                // Connection string - Update this with your database connection details
                string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

                string updateQuery = "UPDATE Schedule SET schedule_status = @Status WHERE schedule_id = @ScheduleId";

                // Using statement ensures that the SqlConnection is closed and disposed when done
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    // Using statement ensures that the SqlCommand and SqlDataReader are closed and disposed when done
                    using (SqlCommand command = new SqlCommand(updateQuery, connection))
                    {
                        // Add parameters to the SqlCommand to prevent SQL injection
                        command.Parameters.AddWithValue("@Status", newStatus);
                        command.Parameters.AddWithValue("@ScheduleId", scheduleId);

                        // Open the connection
                        connection.Open();

                        // Execute the SQL command (UPDATE)
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions appropriately, e.g., log the error or show a user-friendly message
                // You can also redirect to an error page
                ScriptManager.RegisterStartupScript(this, GetType(), "errorAlert", $"alert('An error occurred: {ex.Message}');", true);
            }
        }


        protected void DataList1_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Button btnDelete = e.Item.FindControl("btnDelete") as Button;
                if (btnDelete != null)
                {
                    btnDelete.Click += DeleteSchedule_Click;
                }
            }
        }


        // Helper method to log exceptions
        private void LogException(Exception ex)
        {
            // Log the exception to a log file or a logging framework
            string logFilePath = Server.MapPath("~/App_Data/ErrorLog.txt");
            System.IO.File.AppendAllText(logFilePath, $"{DateTime.Now}: {ex.Message}\n");
        }

        protected void DeleteSchedule_Click(object sender, EventArgs e)
        {
            if (Session["userId"] != null)
            {
                try
                {
                    int userId = Convert.ToInt32(Session["userId"]);

                    // Access the button that triggered the event
                    Button button = (Button)sender;

                    // Retrieve the schedule ID from the CommandArgument
                    int scheduleId = Convert.ToInt32(button.CommandArgument);


                    DeleteSchedule(scheduleId);

                    BindDataList();
                }
                catch (FormatException ex)
                {
                    // Log or print the exception details for debugging
                    Response.Write($"Error converting Session[\"userId\"] to int: {ex.Message}");
                }
            }
            else
            {
                // Handle the case when the user ID is not in the session
                Response.Write("Please login before deleting.");
            }
        }

        private void DeleteSchedule(int scheduleId)
        {
            // Connection string from your web.config
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            // SQL query to delete a record from the Schedule table
            string deleteQuery = "DELETE FROM Schedule WHERE schedule_id = @ScheduleId";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(deleteQuery, connection))
                {
                    command.Parameters.AddWithValue("@ScheduleId", scheduleId);

                    connection.Open();
                    int rowsAffected = command.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        // Record deleted successfully
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "deleteSuccess", "alert('Schedule is deleted successfully.');", true);
                    }
                    else
                    {
                        // Record not found or deletion failed
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "deleteError", "alert('Deletion failed.');", true);
                    }
                }
            }
    }

    [Serializable]
        public class Schedule
        {
            public int ScheduleId { get; set; }
            public DateTime ScheduleDate { get; set; }
            public TimeSpan StartTime { get; set; }
            public TimeSpan EndTime { get; set; }
            public string ScheduleSubject { get; set; }
            public string Description { get; set; }
            public string Status { get; set; }
            public string GoogleMeetLink { get; set; }
            public int TutorId { get; set; }
            public int CourseId { get; set; }

            // New property for file path
            public string FilePath { get; set; }

            public string ScheduleResource { get; set; }

            // You can include other properties as needed

            // Additional properties for display purposes
            public string StartTimeFormatted => StartTime.ToString(@"hh\:mm");
            public string EndTimeFormatted => EndTime.ToString(@"hh\:mm");
        }

       
    }
}