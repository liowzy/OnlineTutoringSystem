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
    public partial class WebForm10 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Retrieve course ID from session
                int courseId = Convert.ToInt32(Session["courseId"]);
                int studentId = Convert.ToInt32(Session["userId"]);

                // Display course name and tutor name
                DisplayCourseAndTutorInfo(courseId);

                // Check if the student has already reviewed this course
                if (HasStudentReviewedCourse(studentId, courseId))
                {
                    // Load existing review data
                    LoadExistingReviewData(studentId, courseId);

                    // Disable the controls to make them not editable
                    DisableReviewControls();
                }
            }
        }
        private void LoadExistingReviewData(int studentId, int courseId)
        {
            // Assuming you have a connection string in your web.config
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            // Your SQL query to retrieve existing review data
            string query = "SELECT review_rating, review_comment FROM Review WHERE student_id = @StudentId AND course_id = @CourseId";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@StudentId", studentId);
                    command.Parameters.AddWithValue("@CourseId", courseId);

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            // Populate the radio button based on existing rating
                            int existingRating = Convert.ToInt32(reader["review_rating"]);
                            SetRatingRadioButton(existingRating);

                            // Populate the comment TextBox
                            tbComment.Text = reader["review_comment"].ToString();
                        }
                    }
                }
            }
        }

        private void SetRatingRadioButton(int rating)
        {
            switch (rating)
            {
                case 1:
                    star1.Checked = true;
                    break;
                case 2:
                    star2.Checked = true;
                    break;
                case 3:
                    star3.Checked = true;
                    break;
                case 4:
                    star4.Checked = true;
                    break;
                case 5:
                    star5.Checked = true;
                    break;
                default:
                    // Handle default case if needed
                    break;
            }
        }

        private void DisableReviewControls()
        {
            // Disable radio buttons
            star1.Enabled = false;
            star2.Enabled = false;
            star3.Enabled = false;
            star4.Enabled = false;
            star5.Enabled = false;

            // Disable comment TextBox
            tbComment.Enabled = false; 
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
            Page.Validate();
            if (Page.IsValid)
            {
                // Check if any radio button is selected
                if (!star1.Checked && !star2.Checked && !star3.Checked && !star4.Checked && !star5.Checked)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertStarRequired", "alert('Star rating is required!');", true);
                    return;
                }
                // Get the selected rating
                int rating = 0; // Default value if none is selected

                if (star1.Checked)
                {
                    rating = 1;
                }
                else if (star2.Checked)
                {
                    rating = 2;
                }
                else if (star3.Checked)
                {
                    rating = 3;
                }
                else if (star4.Checked)
                {
                    rating = 4;
                }
                else if (star5.Checked)
                {
                    rating = 5;
                }

                // Get the comment from the TextBox
                string comment = tbComment.Text;

                // Retrieve course ID from session
                int courseId = Convert.ToInt32(Session["courseId"]);

                // Get tutor ID based on the course ID
                int tutorId = GetTutorIdFromCourseId(courseId);
                int userId = Convert.ToInt32(Session["userId"]);
                if (!HasStudentReviewedCourse(userId,courseId))
                { 
                    addReview(rating, comment, tutorId, courseId);

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertSucess", "alert('Your rating and review has been recorded successfully!');", true); 
                    Response.Redirect("EnrollmentDetail.aspx");
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertAlreadyRated", "alert('You can only rate 1 time!');", true); 
                    Response.Redirect("EnrollmentDetail.aspx");
                } 

            }
        }
        private bool HasStudentReviewedCourse(int studentId, int courseId)
        {
            // Assuming you have a connection string in your web.config
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            // Your SQL query to check if the student has reviewed the course
            string query = "SELECT COUNT(*) FROM Review WHERE student_id = @StudentId AND course_id = @CourseId";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@StudentId", studentId);
                    command.Parameters.AddWithValue("@CourseId", courseId);

                    // Execute the command and retrieve the review count
                    int reviewCount = Convert.ToInt32(command.ExecuteScalar());

                    // Return true if the review count is greater than 0 (review exists), otherwise false
                    return reviewCount > 0;
                }
            }
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