using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq; 
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Net.NetworkInformation;
using System.Security.Cryptography;

namespace OnlineTutoringSystem
{
    public partial class WebForm10 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Retrieve course ID from session
                int courseId = Convert.ToInt32(Session["courseId"]);

                // Display course name and tutor name
                DisplayCourseAndTutorInfo(courseId);
            }
        }

        private void DisplayCourseAndTutorInfo(int courseId)
        {
            // Fetch course and tutor information from the database based on the course ID
            string query = "SELECT c.course_name, t.tutor_name FROM Course c INNER JOIN Tutor t ON c.tutor_id = t.tutor_id WHERE c.course_id = @CourseId";

            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@CourseId", courseId);

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            // Display course name
                            lblCourseName.Text = reader["course_name"].ToString();

                            // Display tutor name
                            lblTutorName.Text = reader["tutor_name"].ToString();
                        }
                    }
                }
            }
        } 


        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // Check if any radio button is selected
            if (!star1.Checked && !star2.Checked && !star3.Checked && !star4.Checked && !star5.Checked)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Star rating is required!');", true);
                return;
            }
            // Get the selected rating
            int rating = Convert.ToInt32(Request.Form["rating"]);

            // Get the comment from the TextBox
            string comment = tbComment.Text;

            // Retrieve course ID from session
            int courseId = Convert.ToInt32(Session["courseId"]);

            // Get tutor ID based on the course ID
            int tutorId = GetTutorIdFromCourseId(courseId);

            // Call the addReview function to insert the review into the database
            addReview(rating, comment, tutorId, courseId);

            Response.Redirect(Request.UrlReferrer.ToString());
        }

        private int GetTutorIdByCourseId(int courseId)
        {
            int tutorId = 0;

            // Assuming you have a connection string in your web.config
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            // Your SQL query to retrieve tutor_id based on course_id
            string query = "SELECT tutor_id FROM Course WHERE course_id = @CourseId";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@CourseId", courseId);

                    // Execute the command and retrieve the tutor_id
                    object result = command.ExecuteScalar();

                    if (result != null)
                    {
                        tutorId = Convert.ToInt32(result);
                    }
                }
            }

            return tutorId;
        }


        protected void addReview(int rating, string comment, int tutorID, int courseID)
        {
            int studentID = (int)this.Session["userId"]; 
                SqlConnection con;
                string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                con = new SqlConnection(strCon);
                con.Open();
                string strInsert = "Insert Into Review(tutor_id, course_id, student_id, review_date, review_comment, review_rating)" +
                                    "Values (@tutorID, @courseID, @studentID, @date, @comment, @rating)";
                SqlCommand cmdInsert = new SqlCommand(strInsert, con);

                cmdInsert.Parameters.AddWithValue("@tutorID", tutorID);
                cmdInsert.Parameters.AddWithValue("@courseID", courseID);
                cmdInsert.Parameters.AddWithValue("@studentID", studentID);
                cmdInsert.Parameters.AddWithValue("@date", DateTime.Now);
                cmdInsert.Parameters.AddWithValue("@comment", comment);
                cmdInsert.Parameters.AddWithValue("@rating", rating);
                cmdInsert.ExecuteNonQuery();
                con.Close(); 
        } 

        private int GetTutorIdFromCourseId(int courseId)
        {
            int tutorId = 0; // Default value, modify as needed

            // Fetch tutor ID from the database based on the course ID
            string query = "SELECT tutor_id FROM Course WHERE course_id = @CourseId";

            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@CourseId", courseId);

                    var result = command.ExecuteScalar();

                    if (result != null)
                    {
                        tutorId = Convert.ToInt32(result);
                    }
                }
            }

            return tutorId;
        } 
    }
}