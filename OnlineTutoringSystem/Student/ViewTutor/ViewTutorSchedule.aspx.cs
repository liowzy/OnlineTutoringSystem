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
            }
        }

        private void BindDataList()
        {
            // Check if the tutor ID is stored in the session
            if (Session["TutorId"] != null)
            {
                int tutorId = Convert.ToInt32(Session["TutorId"]);

                string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                string query = "SELECT schedule_date, schedule_startTime, schedule_endTime, " +
                               "schedule_subject, schedule_description, tutor_id " +
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
                            row["schedule_subject"] = row["schedule_subject"].ToString(); // Example: Convert to string
                            row["schedule_description"] = row["schedule_description"].ToString(); // Example: Convert to string 
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


        protected void MakeBooking_Click(object sender, EventArgs e)
        {
            // Check if the tutor ID and user ID are stored in the session
            if (Session["userId"] != null)
            {
                int userId = Convert.ToInt32(Session["userId"]);

                // Access the DataList item that contains the button
                Button button = (Button)sender;
                DataListItem item = (DataListItem)button.NamingContainer;

                // Retrieve data from the DataList item
                string date = ((Label)item.FindControl("LabelDate")).Text;
                string startTime = ((Label)item.FindControl("LabelStartTime")).Text;
                string endTime = ((Label)item.FindControl("LabelEndTime")).Text;
                string subject = ((Label)item.FindControl("LabelSubject")).Text;
                string description = ((Label)item.FindControl("LabelDescription")).Text;

                // Check for clashes with another class
                if (!IsClash(userId, date, startTime, endTime))
                {
                    // Insert the new schedule entry into the database
                    string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                    string insertQuery = "INSERT INTO Schedule (schedule_date, schedule_startTime, schedule_endTime, " +
                                         "schedule_subject, schedule_description, schedule_status, tutor_id) " +
                                         "VALUES (@Date, @StartTime, @EndTime, @Subject, @Description, 'Booked', @TutorId)";

                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        using (SqlCommand command = new SqlCommand(insertQuery, connection))
                        {
                            command.Parameters.AddWithValue("@Date", DateTime.ParseExact(date, "dd-MM-yyyy", CultureInfo.InvariantCulture));
                            command.Parameters.AddWithValue("@StartTime", TimeSpan.Parse(startTime));
                            command.Parameters.AddWithValue("@EndTime", TimeSpan.Parse(endTime));
                            command.Parameters.AddWithValue("@Subject", subject);
                            command.Parameters.AddWithValue("@Description", description);
                            command.Parameters.AddWithValue("@TutorId", userId);

                            connection.Open();
                            int rowsAffected = command.ExecuteNonQuery();

                            if (rowsAffected > 0)
                            {
                                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Booking successful!');", true);
                            }
                            else
                            {
                                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Booking failed!');", true);
                            }
                        }
                    }
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Booking failed! You have clashes with another class.');", true);
                }
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Login before making a booking.');", true);
            }
        }

        // Function to check for clashes with another class
        private bool IsClash(int tutorId, string date, string startTime, string endTime)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string clashQuery = "SELECT COUNT(*) FROM Schedule " +
                                "WHERE tutor_id = @TutorId " +
                                "AND schedule_date = @Date " +
                                "AND ((schedule_startTime <= @StartTime AND schedule_endTime > @StartTime) OR " +
                                "(schedule_startTime < @EndTime AND schedule_endTime >= @EndTime) OR " +
                                "(schedule_startTime >= @StartTime AND schedule_endTime <= @EndTime))";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(clashQuery, connection))
                {
                    command.Parameters.AddWithValue("@TutorId", tutorId);
                    command.Parameters.AddWithValue("@Date", DateTime.ParseExact(date, "dd-MM-yyyy", CultureInfo.InvariantCulture));
                    command.Parameters.AddWithValue("@StartTime", TimeSpan.Parse(startTime));
                    command.Parameters.AddWithValue("@EndTime", TimeSpan.Parse(endTime));

                    connection.Open();
                    int clashCount = (int)command.ExecuteScalar();

                    return clashCount > 0;
                }
            }
        }


    }
}