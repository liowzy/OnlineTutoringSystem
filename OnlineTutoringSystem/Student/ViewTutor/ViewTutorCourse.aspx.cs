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

namespace OnlineTutoringSystem.Student.ViewTutor
{
    public partial class WebForm5 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if the tutorId is present in the session
                if (Session["tutorId"] != null)
                {
                    int tutorId = Convert.ToInt32(Session["tutorId"]);
                    SqlDataSourceCourses.SelectParameters["TutorId"].DefaultValue = tutorId.ToString();

                    // Bind the data to the DataListCourses
                    DataListCourses.DataSourceID = "SqlDataSourceCourses";
                    DataListCourses.DataBind();
                }
                else
                {
                    // Handle the case where tutorId is not available in the session
                    // You may want to redirect or display an error message
                }
            }
        }

        protected void DataListCourses_SelectedIndexChanged(object sender, EventArgs e)
        {
            string courseId = Session["courseId"] as string;
            // Display a window alert with the session ID
            ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Session ID: {Session["courseId"]}');", true);

            // Use courseId as needed
            Response.Redirect("../CourseOverview.aspx");
        }

        protected string GetCardColor(int index)
        {
            string[] colors = { "#EBEBFF", "#E1F7E3", "#FFF2E5", "#FFF0F0", "#F5F7FA" };
            return colors[index % colors.Length];
        }

        public double CalculateAverageRating(string courseId)
        {
            // Convert courseId to int before using it in the query
            int courseIdInt = Convert.ToInt32(courseId);

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "SELECT AVG(review_rating) FROM Review WHERE course_id = @CourseId";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@CourseId", courseIdInt);

                    // ExecuteScalar returns the average rating as an object
                    object result = command.ExecuteScalar();

                    if (result != null && result != DBNull.Value)
                    {
                        return Convert.ToDouble(result);
                    }
                }
            }

            return 0.0;
        }

        protected void selectBtn_Command(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {
                string courseId = e.CommandArgument.ToString();

                // Store the course_id in a session variable
                Session["courseId"] = courseId;

                // Redirect or perform any other actions
                Response.Redirect("../CourseOverview.aspx");
            }
        }
    }
}