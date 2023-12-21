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
using System.Globalization;

namespace OnlineTutoringSystem.Student.ViewTutor
{
    public partial class WebForm51 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDataList();
                if (DataList1.Items.Count == 0)
                {
                    Checkwl.Visible = true;
                }
                else
                {
                    Checkwl.Visible = false;
                }
            }
        }

        private void BindDataList()
        {
            // Check if the tutor ID is stored in the session
            if (Session["TutorId"] != null)
            {
                int tutorId = Convert.ToInt32(Session["TutorId"]);

                string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                string query = "SELECT schedule_id, schedule_date, schedule_startTime, schedule_endTime, " +
               "schedule_subject, schedule_description, tutor_id " +
               "FROM Schedule " +
               "WHERE tutor_id = @TutorId AND schedule_status = 'Active'";



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
                            row["schedule_subject"] = row["schedule_subject"].ToString(); // Example: Convert to string 
                        }
                         

                        // Bind data to the DataList
                        DataList1.DataSource = dataTable;
                        DataList1.DataBind();
                    }
                }
            }
            else
            {
                // Handle the case when the tutor ID is not in the session
                Response.Write("Tutor ID not found in the session.");
            }
        }

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



    }
}