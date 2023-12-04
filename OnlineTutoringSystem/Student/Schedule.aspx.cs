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
            }
        }

        private void BindDataList()
        {
            // Check if the tutor ID is stored in the session
            if (Session["userId"] != null)
            {
                int tutorId = Convert.ToInt32(Session["userId"]);

                string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                string query = "SELECT schedule_id,schedule_date, schedule_startTime, schedule_endTime, " +
                               "schedule_subject, schedule_description,schedule_status, tutor_id " +
                               "FROM Schedule " +
                               "WHERE tutor_id = @TutorId";

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@TutorId", tutorId);

                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader();

                        DataTable dataTable = new DataTable();
                        dataTable.Load(reader);

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
                Response.Write("Please login again. Session end.");
            }
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
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "deleteSuccess", "alert('Booking is deleted successfully.');", true);
                    }
                    else
                    {
                        // Record not found or deletion failed
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "deleteError", "alert('Deletion failed.');", true);
                    }
                }
            }
        }
    }
}