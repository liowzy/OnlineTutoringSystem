using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;


namespace OnlineTutoringSystem
{
    public partial class addschedule : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void submitBtn_Click(object sender, EventArgs e)
        {
            try
            {
                // Get user inputs from the form
                string scheduleDate = this.scheduleDate.Text;
                string startTime = this.startTime.Text;
                string endTime = this.endTime.Text;
                string subject = this.subject.Text;
                string description = this.description.Text;
                string status = this.status.SelectedValue.ToString();
                int tutorId = Convert.ToInt32(this.tutorId.Text);

                // Validate the selected date
                DateTime selectedDate = DateTime.ParseExact(scheduleDate, "yyyy-MM-dd", null);

                if (selectedDate < DateTime.Today)
                {
                    // Display an error message or take appropriate action
                    Response.Write("Selected date should not be before today.");
                    return;
                }

                // Validate the time duration (endTime - startTime)
                TimeSpan duration = TimeSpan.Parse(endTime) - TimeSpan.Parse(startTime);

                if (duration.TotalHours > 2)
                {
                    // Display an error message or take appropriate action
                    Response.Write("The time duration should not be more than 2 hours.");
                    return;
                }


                // Connection string - Update this with your database connection details
                string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

                // SQL query to insert data into the Schedule table
                string insertQuery = "INSERT INTO Schedule (schedule_date, schedule_startTime, schedule_endTime, " +
                                     "schedule_subject, schedule_description, schedule_status, tutor_id) " +
                                     "VALUES (@ScheduleDate, @StartTime, @EndTime, @Subject, @Description, @Status, @TutorId)";

                // Using statement ensures that the SqlConnection is closed and disposed when done
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    // Using statement ensures that the SqlCommand and SqlDataReader are closed and disposed when done
                    using (SqlCommand command = new SqlCommand(insertQuery, connection))
                    {
                        // Add parameters to the SqlCommand to prevent SQL injection
                        command.Parameters.AddWithValue("@ScheduleDate", DateTime.ParseExact(scheduleDate, "yyyy-MM-dd", null));
                        command.Parameters.AddWithValue("@StartTime", TimeSpan.Parse(startTime));
                        command.Parameters.AddWithValue("@EndTime", TimeSpan.Parse(endTime));
                        command.Parameters.AddWithValue("@Subject", subject);
                        command.Parameters.AddWithValue("@Description", description);
                        command.Parameters.AddWithValue("@Status", status);
                        command.Parameters.AddWithValue("@TutorId", tutorId);

                        // Open the connection
                        connection.Open();

                        // Execute the SQL command (INSERT)
                        command.ExecuteNonQuery();
                    }
                }

                // Additional logic, such as redirecting to another page or displaying a success message
            }
            catch (Exception ex)
            {
                // Handle exceptions appropriately, e.g., log the error or show a user-friendly message
                // You can also redirect to an error page
                Response.Write($"An error occurred: {ex.Message}");
            }

            Response.Write("OK.");
        }
    }
}