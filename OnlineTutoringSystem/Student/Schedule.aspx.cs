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
using System.Globalization;
using System.Text.RegularExpressions;

namespace OnlineTutoringSystem
{
    public partial class WebForm11 : System.Web.UI.Page
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
            // Check if the student ID is stored in the session
            if (Session["userId"] != null)
            {
                int studentId = Convert.ToInt32(Session["userId"]);

                string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                string query = "SELECT S.schedule_id, S.schedule_date, S.schedule_startTime, S.schedule_endTime, " +
               "S.schedule_subject, S.schedule_description, S.schedule_status, S.google_meet, S.file_id " +
               "FROM Schedule S " +
               "INNER JOIN PurchasedCourse P ON P.course_id = S.course_id " +
               "WHERE P.stud_id = @StudentId AND S.schedule_status = 'Active' ORDER BY S.schedule_date";




                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@StudentId", studentId);

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
                            if (row["schedule_status"].ToString().Equals("Active", StringComparison.OrdinalIgnoreCase))
                            {
                                // Convert time columns
                                TimeSpan startTime = (TimeSpan)row["schedule_startTime"];
                            TimeSpan endTime = (TimeSpan)row["schedule_endTime"];

                            // Format the TimeSpan as HH:mm
                            row["schedule_startTime"] = startTime.ToString("hh\\:mm");
                            row["schedule_endTime"] = endTime.ToString("hh\\:mm");

                             
                            row["google_meet"] = row["google_meet"].ToString();
                            row["file_id"] = row["file_id"].ToString();
                            row["schedule_subject"] = row["schedule_subject"].ToString();
                            row["schedule_description"] = row["schedule_description"].ToString();
                            }
                        }
                        dataTable = dataTable.Select("schedule_status = 'Active'").CopyToDataTable();

                        // Bind data to the DataList
                        DataList1.DataSource = dataTable;
                        DataList1.DataBind();
                    }
                }
            }
            else
            {
                // Handle the case when the student ID is not in the session
                Response.Write("Please login again. Session end.");
            }
        }

        protected void btnOpen_Click(object sender, EventArgs e)
        {
            // Get the file_id from the clicked button
            Button btn = (Button)sender;
            string fileId = btn.CommandArgument;

            string redirectUrl = "WebForm51.aspx?file_id=" + fileId;
            Session["SelectedFileId"] = fileId;
            // Use JavaScript to open the URL in a new tab
            string script = "window.open('" + redirectUrl + "', '_blank');";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "openInNewTab", script, true);
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