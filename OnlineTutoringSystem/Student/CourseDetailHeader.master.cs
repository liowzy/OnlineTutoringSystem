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

namespace OnlineTutoringSystem.Student
{
    public partial class CourseDetailHeader : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["courseId"] != null)
            {
                string courseId = Session["courseId"].ToString();
                FetchCourseDetails(courseId);
                FetchWishlistData();
            }
            else
            {

                Response.Redirect("Course.aspx");
            }
        }

        private void FetchCourseDetails(string courseId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Fetch course details
                string courseQuery = "SELECT c.*, t.tutor_name, t.tutor_picture FROM Course c JOIN Tutor t ON c.tutor_id = t.tutor_id WHERE c.course_id = @CourseId";
                using (SqlCommand command = new SqlCommand(courseQuery, connection))
                {
                    command.Parameters.AddWithValue("@CourseId", courseId);

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            // Populate course details
                            Label18.Text = reader["course_name"].ToString();
                            SubtitleLabel.Text = reader["course_desc"].ToString();
                            CourseLevelValue.Text = reader["course_level"].ToString();
                            DurationValue.Text = reader["course_duration"].ToString();
                            LanguageValue.Text = reader["course_language"].ToString();
                            CourseFeeValueRight.Text = reader["course_fee"].ToString(); // Assuming you have a Label for course fee
                            decimal courseFee = Convert.ToDecimal(reader["course_fee"]);
                            CourseFeeValueRight.Text = $"RM {courseFee:N2}"; // This will display the course fee with 2 decimal places and the RM currency symbol



                            // Populate tutor details
                            TutorNameLabel.Text = reader["tutor_name"].ToString();
                            byte[] tutorPictureBytes = (byte[])reader["tutor_picture"];
                            string tutorPictureUrl = $"data:image/jpeg;base64,{Convert.ToBase64String(tutorPictureBytes)}";
                            TutorImage.ImageUrl = tutorPictureUrl;

                            // Populate course picture
                            byte[] coursePictureBytes = (byte[])reader["course_pic"];
                            string coursePictureUrl = $"data:image/jpeg;base64,{Convert.ToBase64String(coursePictureBytes)}";
                            CourseBanner.ImageUrl = coursePictureUrl;
                        }
                    }
                }
            }
        }
        protected void FetchWishlistData()
        {
            if (Session["userID"] != null && Session["courseId"] != null)
            {
                int userId = Convert.ToInt32(Session["userID"]);
                int courseId = Convert.ToInt32(Session["courseId"]);

                // Check if the course is in the wishlist
                bool isInWishlist = IsInWishlist(userId, courseId);

                // Update button text based on whether the course is in the wishlist
                btnAddToWishlist.Text = isInWishlist ? "Remove from Wishlist" : "Add to Wishlist";
            }
        }

        private bool IsInWishlist(int userId, int courseId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Check if the course already exists in the wishlist for the given user
                string checkQuery = "SELECT COUNT(*) FROM Wishlist WHERE course_id = @CourseId AND stud_id = @UserId";
                using (SqlCommand checkCommand = new SqlCommand(checkQuery, connection))
                {
                    checkCommand.Parameters.AddWithValue("@CourseId", courseId);
                    checkCommand.Parameters.AddWithValue("@UserId", userId);

                    int existingCount = (int)checkCommand.ExecuteScalar();

                    return existingCount > 0;
                }
            }
        }

        private void RemoveFromWishlist(int userId, int courseId)
        {
            // Implement the logic to remove the course from the wishlist
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Delete the course from the wishlist
                string deleteQuery = "DELETE FROM Wishlist WHERE course_id = @CourseId AND stud_id = @UserId";
                using (SqlCommand command = new SqlCommand(deleteQuery, connection))
                {
                    command.Parameters.AddWithValue("@CourseId", courseId);
                    command.Parameters.AddWithValue("@UserId", userId);

                    // Execute the query
                    command.ExecuteNonQuery();

                    // Optionally, you can provide feedback to the user
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Course removed from wishlist successfully.');", true);
                }
            }
        }


        protected void btnOverview_Click(object sender, EventArgs e)
        {
            Response.Redirect("CourseOverview.aspx");

        }

        protected void btnReview_Click(object sender, EventArgs e)
        {
            Response.Redirect("CourseReview.aspx");

        }

        protected void btnPurchase_Click(object sender, EventArgs e)
        {
            // Check if the user is logged in (stud_id is in the session)
            if (Session["userID"] != null)
            {
                // Get the student ID from the session
                int studId = Convert.ToInt32(Session["userID"]);

                // Get the course ID from wherever it is stored (e.g., a session variable)
                if (Session["courseId"] != null)
                { 

                    Response.Redirect("CoursePurchase.aspx");
                }
                else
                {
                    // Handle the case where courseId is not available
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error: Course information not available.');", true);
                }
            }
            else
            {
                // Show an alert and do not redirect
                Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please login before purchase a course.');", true);
            }

        }
        protected void btnAddToWishlist_Click(object sender, EventArgs e)
        {
            if (Session["userID"] != null && Session["courseId"] != null)
            {
                int userId = Convert.ToInt32(Session["userID"]);
                int courseId = Convert.ToInt32(Session["courseId"]);

                if (IsInWishlist(userId, courseId))
                {
                    // The course is in the wishlist, remove it
                    RemoveFromWishlist(userId, courseId);
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Course removed to wishlist.');", true);
                }
                else
                {
                    // The course is not in the wishlist, add it
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Course added to wishlist.');", true);
                    AddToWishlist(userId, courseId);
                }

                // Update button text based on whether the course is in the wishlist
                FetchWishlistData();
            }
            else
            {
                // Show an alert and do not redirect
                Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please login before adding to wishlist.');", true);
            }
        }

        private void AddToWishlist(int userId, int courseId)
        {
            // Implement the logic to check if the course already exists in the Wishlist table
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Check if the course already exists in the wishlist for the given user
                string checkQuery = "SELECT COUNT(*) FROM Wishlist WHERE course_id = @CourseId AND stud_id = @UserId";
                using (SqlCommand checkCommand = new SqlCommand(checkQuery, connection))
                {
                    checkCommand.Parameters.AddWithValue("@CourseId", courseId);
                    checkCommand.Parameters.AddWithValue("@UserId", userId);

                    int existingCount = (int)checkCommand.ExecuteScalar();

                    if (existingCount > 0)
                    {
                        // The course already exists in the wishlist, show an alert
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Course is already in the wishlist.');", true);
                        return; // Exit the method without adding the course again
                    }
                }

                // If the course doesn't exist in the wishlist, insert a new record
                string insertQuery = "INSERT INTO Wishlist (course_id, stud_id) VALUES (@CourseId, @UserId)";
                using (SqlCommand command = new SqlCommand(insertQuery, connection))
                {
                    command.Parameters.AddWithValue("@CourseId", courseId);
                    command.Parameters.AddWithValue("@UserId", userId);

                    // Execute the query
                    command.ExecuteNonQuery();

                    // Optionally, you can provide feedback to the user
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Course added to wishlist successfully.');", true);
                }
            }
        }


    }

}