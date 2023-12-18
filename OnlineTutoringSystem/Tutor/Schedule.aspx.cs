using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.UI.WebControls;

namespace OnlineTutoringSystem.Tutor
{
    // Assuming you have a class representing an Event
    public class Event
    {
        public int ScheduleId { get; set; }
        public DateTime ScheduleDate { get; set; }
        public DateTime ScheduleStartTime { get; set; }
        public DateTime ScheduleEndTime { get; set; }
        public string ScheduleSubject { get; set; }
        public string ScheduleDescription { get; set; }
        public string ScheduleStatus { get; set; }
        public int TutorId { get; set; }
    }

    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //// Load events from the database
                //LoadEvents();

                LoadTutorData();
            }
        }

        private void LoadTutorData()
        {
            // Get the tutor ID directly from the session
            int tutorId = GetTutorId();

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

        protected void LoadEvents()
        {
            try
            {
                // Get the tutor_id from the session
                int tutorId = GetTutorId();

                // Check if the user is logged in
                if (tutorId != -1)
                {
                    string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        string query = "SELECT * FROM Schedule WHERE tutor_id = @tutorId";
                        SqlCommand command = new SqlCommand(query, connection);

                        // Use the hardcoded tutor ID for testing
                        command.Parameters.AddWithValue("@tutorId", tutorId);

                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader();

                        List<Event> events = new List<Event>();

                        while (reader.Read())
                        {
                            // Assuming Event is a class with properties matching the database columns
                            Event newEvent = new Event
                            {
                                ScheduleId = Convert.ToInt32(reader["schedule_id"]),
                                ScheduleDate = Convert.ToDateTime(reader["schedule_date"]),
                                ScheduleStartTime = Convert.ToDateTime(reader["schedule_startTime"]),
                                ScheduleEndTime = Convert.ToDateTime(reader["schedule_endTime"]),
                                ScheduleSubject = reader["schedule_subject"].ToString(),
                                ScheduleDescription = reader["schedule_description"].ToString(),
                                ScheduleStatus = reader["schedule_status"].ToString(),
                                TutorId = Convert.ToInt32(reader["tutor_id"])
                            };

                            events.Add(newEvent);
                        }

                        // Bind events to your UI (you need to have the appropriate controls for display)
                        // For example, you can use a GridView or a Repeater
                        // gridView.DataSource = events;
                        // gridView.DataBind();

                        reader.Close();
                    }
                }
                else
                {
                    // Redirect to the login page or handle the case when the user is not logged in
                    Response.Redirect("Login.aspx");
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions (display error message, log, etc.)
                lblMessage.Visible = true;
                lblMessage.Text = "Error: " + ex.Message;
                lblMessage.CssClass = "error-message";
            }
        }

        protected void addEventBtn_Click(object sender, EventArgs e)
        {
            // Event Information
            string evtTitle = txtEventTitle.Text;
            string evtTimeFrom = txtEventTimeFrom.Text;  // Corrected typo
            string evtTimeTo = txtEventTimeTo.Text;
            string scheduleDte = txtScheduleDate.Text;
            string scheduleDesc = txtScheduleDescription.Text;
            string scheduleStat = txtScheduleStatus.Text;
            int tutorID = GetTutorId();

            // Create a new Event object
            Event newEvent = new Event
            {
                ScheduleDate = DateTime.ParseExact(txtScheduleDate.Text, "yyyy-MM-dd", null),
                ScheduleStartTime = DateTime.ParseExact(evtTimeFrom, "HH:mm", null),
                ScheduleEndTime = DateTime.ParseExact(evtTimeTo, "HH:mm", null),
                ScheduleSubject = evtTitle,
                ScheduleDescription = scheduleDesc,
                ScheduleStatus = scheduleStat,
                TutorId = GetTutorId(),
            };

            AddEventToDatabase(newEvent);

            ClientScript.RegisterStartupScript(this.GetType(), "eventSubmit", "eventSubmit()", true);

        }

        protected static void AddEventToDatabase(Event newEvent)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"INSERT INTO Schedule 
                        (schedule_date, schedule_startTime, schedule_endTime, 
                        schedule_subject, schedule_description, schedule_status, tutor_id)
                        VALUES 
                        (@scheduleDate, @startTime, @endTime, @subject, @description, @status, @tutorId)";

                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@scheduleDate", newEvent.ScheduleDate);
                command.Parameters.AddWithValue("@startTime", newEvent.ScheduleStartTime);
                command.Parameters.AddWithValue("@endTime", newEvent.ScheduleEndTime);
                command.Parameters.AddWithValue("@subject", newEvent.ScheduleSubject);
                command.Parameters.AddWithValue("@description", newEvent.ScheduleDescription);
                command.Parameters.AddWithValue("@status", newEvent.ScheduleStatus);
                command.Parameters.AddWithValue("@tutorId", newEvent.TutorId);

                connection.Open();
                command.ExecuteNonQuery();
            }
        }

        [WebMethod]
        public static string DeleteEvent(int scheduleId)
        {
            try
            {
                // Delete the event from the database using scheduleId
                DeleteEventFromDatabase(scheduleId);

                return "Event deleted successfully";
            }
            catch (Exception ex)
            {
                return "Error deleting event: " + ex.Message;
            }
        }

        // Add a new method for deleting events
        protected static void DeleteEventFromDatabase(int scheduleId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM Schedule WHERE schedule_id = @scheduleId";

                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@scheduleId", scheduleId);

                connection.Open();
                command.ExecuteNonQuery();
            }
        }
    }
}
