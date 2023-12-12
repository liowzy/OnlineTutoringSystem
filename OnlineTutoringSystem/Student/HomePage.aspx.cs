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
    public partial class WebForm3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        //change color for card
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
        protected void btnCreateAccount_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Entry/Registration.aspx");
        }

        protected void LinkButton13_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Student/Course.aspx");
        }

        protected void LinkButton19_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Entry/Registration.aspx");
        }
        protected void ViewReviewButton_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string tutorId = btn.CommandArgument;
            Session["tutorId"] = tutorId;
            Response.Redirect("~/Student/ViewTutor/ViewTutorCourse.aspx");
        }

        protected void DataListCourses_SelectedIndexChanged(object sender, EventArgs e)
        {
            string courseId = Session["courseId"] as string;
            // Display a window alert with the session ID
            ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Session end.Please login again.');", true);

            // Use courseId as needed
            Response.Redirect("CourseOverview.aspx");
        }

        protected void selectBtn_Command(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {
                string courseId = e.CommandArgument.ToString();

                // Store the course_id in a session variable
                Session["courseId"] = courseId;

                // Redirect or perform any other actions
                Response.Redirect("CourseOverview.aspx");
            }
        }

        protected void DataListCourses2_SelectedIndexChanged(object sender, EventArgs e)
        {
            string tutorId = Session["tutorId"] as string;
            // Display a window alert with the session ID
            ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Session ID: {Session["tutorId"]}');", true);

            // Use courseId as needed
            Response.Redirect("ViewTutor/ViewTutorCourse.aspx");
        }

        protected void selectBtn2_Command(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {
                string tutorId = e.CommandArgument.ToString();

                // Store the course_id in a session variable
                Session["tutorId"] = tutorId;

                // Redirect or perform any other actions
                Response.Redirect("ViewTutor/ViewTutorCourse.aspx");
            }
        }


        public double CalculateAverageRating2(string tutorId)
        {
            // Convert courseId to int before using it in the query
            int tutorIdInt = Convert.ToInt32(tutorId);

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "SELECT AVG(review_rating) FROM Review WHERE tutor_id = @TutorId";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@TutorId", tutorIdInt);

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


        private int GetReviewCountForTutor2(int tutorId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string countQuery = "SELECT COUNT(*) FROM Review WHERE tutorId = @TutorId";
                using (SqlCommand command = new SqlCommand(countQuery, connection))
                {
                    command.Parameters.AddWithValue("@TutorId", tutorId);

                    int reviewCount = (int)command.ExecuteScalar();
                    return reviewCount;
                }
            }
        }
    }
}