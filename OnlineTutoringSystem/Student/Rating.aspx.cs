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
                    // Disable the controls to make them not editable
                    DisableReviewControls();
                    btnSubmit.Text = "Back";
                    // Load existing review data
                    LoadExistingReviewData(studentId, courseId);

                }
            }
        }
        private void LoadExistingReviewData(int studentId, int courseId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string query = "SELECT review_rating, subject_rating, teaching_rating, availability_rating, preparation_rating, profess_rating, review_comment FROM Review WHERE student_id = @StudentId AND course_id = @CourseId";

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
                            // Load and set ratings for each group
                            LoadAndSetRatingGroup("RadioButton", 11, reader["subject_rating"]);
                            LoadAndSetRatingGroup("RadioButton", 21, reader["teaching_rating"]);
                            LoadAndSetRatingGroup("RadioButton", 31, reader["availability_rating"]);
                            LoadAndSetRatingGroup("RadioButton", 41, reader["preparation_rating"]);
                            LoadAndSetRatingGroup("RadioButton", 51, reader["profess_rating"]);

                            // Populate the comment TextBox
                            tbComment.Text = reader["review_comment"].ToString();
                        }
                        else
                        {
                            // Handle the case where there's no existing review data
                        }
                    }
                }
            }

            // Disable review controls after loading existing data
            DisableReviewControls();
        }

        private void LoadAndSetRatingGroup(string radioButtonPrefix, int startNumber, object ratingValue)
        {
            if (ratingValue != DBNull.Value && ratingValue != null)
            {
                int rating = Convert.ToInt32(ratingValue);

                if (rating >= 1 && rating <= 5)
                {
                    // Calculate the corresponding radio button ID
                    int radioButtonId = startNumber + rating - 1;

                    // Find the RadioButton control using recursive search
                    RadioButton radioButton = FindRadioButtonControl(Page, $"{radioButtonPrefix}{radioButtonId}");

                    if (radioButton != null)
                    {
                        radioButton.Checked = true;
                    }
                }
                else
                {
                    // Handle the case where the database value is outside the expected range
                }
            }
            else
            {
                // Handle the case where the database value is NULL
            }
        }

        // Recursive method to find a RadioButton control by ID
        private RadioButton FindRadioButtonControl(Control root, string id)
        {
            if (root.ID == id && root is RadioButton)
            {
                return (RadioButton)root;
            }

            foreach (Control control in root.Controls)
            {
                RadioButton foundControl = FindRadioButtonControl(control, id) as RadioButton;
                if (foundControl != null)
                {
                    return foundControl;
                }
            }

            return null;
        }






        private void DisableReviewControls()
        {
            DisableReviewControls(11, "rating1", "RadioButton");
            DisableReviewControls(21, "rating2", "RadioButton");
            DisableReviewControls(31, "rating3", "RadioButton");
            DisableReviewControls(41, "rating4", "RadioButton");
            DisableReviewControls(51, "rating5", "RadioButton");

            // Disable comment TextBox
            tbComment.Enabled = false;
        }


        private void DisableReviewControls(int startNumber, string groupName, string radioButtonPrefix)
        {
            for (int i = startNumber; i < startNumber + 5; i++)
            {
                string radioButtonId = $"{radioButtonPrefix}{i}";

                // Find the RadioButton control using recursive search
                Control radioButton = FindControlRecursive(Page, radioButtonId);

                if (radioButton is RadioButton && ((RadioButton)radioButton).GroupName == groupName)
                {
                    ((RadioButton)radioButton).Enabled = false;
                }
            } 
        }

        // Recursive method to find a control by ID
        private Control FindControlRecursive(Control root, string id)
        {
            if (root.ID == id)
            {
                return root;
            }

            foreach (Control control in root.Controls)
            {
                Control foundControl = FindControlRecursive(control, id);
                if (foundControl != null)
                {
                    return foundControl;
                }
            }

            return null;
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
                int ratingGroup1 = GetSelectedRating("rating1", "RadioButton", 11, 5);
                int ratingGroup2 = GetSelectedRating("rating2", "RadioButton", 21, 5);
                int ratingGroup3 = GetSelectedRating("rating3", "RadioButton", 31, 5);
                int ratingGroup4 = GetSelectedRating("rating4", "RadioButton", 41, 5);
                int ratingGroup5 = GetSelectedRating("rating5", "RadioButton", 51, 5);
                 
                // Example: Get the comment from the TextBox
                string comment = tbComment.Text;

                // Example: Retrieve course ID from session
                int courseId = Convert.ToInt32(Session["courseId"]);

                // Example: Get tutor ID based on the course ID
                int tutorId = GetTutorIdFromCourseId(courseId);

                // Example: Get user ID from session
                int userId = Convert.ToInt32(Session["userId"]);

                // Example: Check if the user has already reviewed the course
                if (!HasStudentReviewedCourse(userId, courseId))
                {
                    addReview(ratingGroup1, ratingGroup2, ratingGroup3, ratingGroup4, ratingGroup5, comment, tutorId, courseId); 

                    // Display a success message
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertSucess", "alert('Your rating and review have been recorded successfully!');", true);
                    Response.Redirect("EnrollmentDetail.aspx");
                }
                else
                { 
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alertAlreadyRated", "alert('You can only rate 1 time!');", true);
                    Response.Redirect("EnrollmentDetail.aspx");
                }
            }
        }


        private int GetSelectedRating(string groupName, string radioButtonPrefix, int startNumber, int count)
        {
            int selectedRating = 0;

            FindRadioButtonRecursive(Page.Controls, groupName, radioButtonPrefix, startNumber, count, ref selectedRating);

            return selectedRating;
        }

        private void FindRadioButtonRecursive(ControlCollection controls, string groupName, string radioButtonPrefix, int startNumber, int count, ref int selectedRating)
        {
            foreach (Control control in controls)
            {
                if (control is RadioButton radioButton)
                {
                    int numericPart;
                    if (int.TryParse(radioButton.ID.Substring(radioButtonPrefix.Length), out numericPart))
                    {
                        if (numericPart >= startNumber && numericPart < startNumber + count && radioButton.GroupName == groupName && radioButton.Checked)
                        {
                            selectedRating = numericPart - startNumber + 1;
                            return;
                        }
                    }
                }

                // If the control has child controls, recursively search them
                if (control.Controls.Count > 0)
                {
                    FindRadioButtonRecursive(control.Controls, groupName, radioButtonPrefix, startNumber, count, ref selectedRating);
                }
            }
        }



        protected void addReview(int subjectRating, int teachingRating, int availabilityRating, int preparationRating, int professionalismRating, string comment, int tutorID, int courseID)
        {
            int studentID = (int)this.Session["userId"];
            SqlConnection con;
            string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            con = new SqlConnection(strCon);
            con.Open();
            string strInsert = "INSERT INTO Review (tutor_id, course_id, student_id, review_date, review_comment, review_rating, subject_rating, teaching_rating, availability_rating, preparation_rating, profess_rating)" +
                                "VALUES (@tutorID, @courseID, @studentID, @date, @comment, @rating, @subjectRating, @teachingRating, @availabilityRating, @preparationRating, @professionalismRating)";
            SqlCommand cmdInsert = new SqlCommand(strInsert, con);

            cmdInsert.Parameters.AddWithValue("@tutorID", tutorID);
            cmdInsert.Parameters.AddWithValue("@courseID", courseID);
            cmdInsert.Parameters.AddWithValue("@studentID", studentID);
            cmdInsert.Parameters.AddWithValue("@date", DateTime.Now);
            cmdInsert.Parameters.AddWithValue("@comment", comment);
            // Overall rating (you can choose the average of individual ratings if needed)
            int overallRating = (subjectRating + teachingRating + availabilityRating + preparationRating + professionalismRating) / 5;
            cmdInsert.Parameters.AddWithValue("@rating", overallRating);
            cmdInsert.Parameters.AddWithValue("@subjectRating", subjectRating);
            cmdInsert.Parameters.AddWithValue("@teachingRating", teachingRating);
            cmdInsert.Parameters.AddWithValue("@availabilityRating", availabilityRating);
            cmdInsert.Parameters.AddWithValue("@preparationRating", preparationRating);
            cmdInsert.Parameters.AddWithValue("@professionalismRating", professionalismRating);

            cmdInsert.ExecuteNonQuery();
            con.Close();
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