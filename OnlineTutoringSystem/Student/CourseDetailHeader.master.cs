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
using System.Data.Common;

namespace OnlineTutoringSystem.Student
{
    public partial class CourseDetailHeader : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["courseId"] != null)
            {
                string courseId = Session["courseId"].ToString();
                int userId = Convert.ToInt32(Session["userId"]);
                FetchCourseDetails(courseId);

                LabelNoSchedule.Visible = DataList1.Items.Count == 0;
                if (IsCoursePurchased(userId,int.Parse(courseId)))
                { 
                    btnPurchase.Enabled = false;
                    btnPurchase.Text = "Enrolled";
                }
                FetchWishlistData();
            }
            else
            {

                Response.Redirect("Course.aspx");
            }
        }

        private void FetchCourseDetails(string courseId)
        {
            int courseId2 = Convert.ToInt32(Session["courseId"]);
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
             
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Fetch course details
                string courseQuery = "" +
                    "SELECT c.*,t.tutor_name,t.tutor_picture, t.chat_link,r.review_rating FROM Course c JOIN Tutor t " +
                    "ON c.tutor_id = t.tutor_id LEFT JOIN Review r ON c.course_id = r.course_id WHERE c.course_id = @CourseId";
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

                            if (reader["review_rating"] != DBNull.Value)
                            {
                                double averageRating = CalculateAverageRating(reader, courseId2);
                                LabelRating.Text = $"Rating: {averageRating:F1} / 5";
                                string starIcons = GenerateStarIcons((int)Math.Round(averageRating));
                                StarIconsContainer.InnerHtml = starIcons;
                            }
                            else
                            {
                                // Handle the case where there is no review rating
                                LabelRating.Text = "Rating : N/A";
                                StarIconsContainer.InnerHtml = string.Empty;
                            }
                        }
                    }
                }
            }
        }

        private double CalculateAverageRating(SqlDataReader reader, int courseId)
        {
            // Convert courseId to int before using it in the query
            int courseIdInt = Convert.ToInt32(courseId);

            if (reader["review_rating"] != DBNull.Value)
            {
                int sumOfRatings = Convert.ToInt32(reader["review_rating"]);
                int reviewCount = GetReviewCountForTutor(courseId);

                if (reviewCount > 0)
                {
                    return (double)sumOfRatings / reviewCount;
                }
            }

            return 0.0;
        }

        private int GetReviewCountForTutor(int courseId)
        {
            // Perform a query to get the review count for the specified tutor
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string countQuery = "SELECT COUNT(*) FROM Review WHERE course_id = @CourseId";
                using (SqlCommand command = new SqlCommand(countQuery, connection))
                {
                    command.Parameters.AddWithValue("@CourseId", courseId);

                    int reviewCount = (int)command.ExecuteScalar();
                    return reviewCount;
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
                    int courseId = Convert.ToInt32(Session["courseId"]);

                    // Check if the course is already purchased
                    if (IsCoursePurchased(studId, courseId))
                    {
                        // The course is already purchased, show an alert or take appropriate action
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Course already purchased.');", true);
                    }
                    else
                    {
                        // The course is not purchased, redirect to the payment page
                        Response.Redirect("MakePayment.aspx");
                    }
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

        private bool IsCoursePurchased(int userId, int courseId)
        {
            // Implement the logic to check if the course is purchased
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Check if the course is in the PurchasedCourse table for the given user
                string checkQuery = "SELECT COUNT(*) FROM PurchasedCourse WHERE course_id = @CourseId AND stud_id = @UserId";
                using (SqlCommand checkCommand = new SqlCommand(checkQuery, connection))
                {
                    checkCommand.Parameters.AddWithValue("@CourseId", courseId);
                    checkCommand.Parameters.AddWithValue("@UserId", userId);

                    int existingCount = (int)checkCommand.ExecuteScalar();

                    return existingCount > 0;
                }
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

        protected void btnWhatsApp_Click(object sender, ImageClickEventArgs e)
        {
            string courseId = Session["courseId"].ToString();

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Fetch chat_link based on course_id
                string chatLinkQuery = "SELECT t.chat_link FROM Course c JOIN Tutor t ON c.tutor_id = t.tutor_id WHERE c.course_id = @CourseId";
                using (SqlCommand command = new SqlCommand(chatLinkQuery, connection))
                {
                    command.Parameters.AddWithValue("@CourseId", courseId);

                    string chatLink = command.ExecuteScalar()?.ToString();

                    // Open a new window to navigate to the chat link
                    if (!string.IsNullOrEmpty(chatLink))
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "openWindow", $"window.open('{chatLink}', '_blank');", true);
                    }
                }
            }
        }

        protected void TutorImage_Click(object sender, ImageClickEventArgs e)
        {
            string courseId = Session["courseId"].ToString();
            int tutorId;

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Fetch tutor_id based on course_id
                string tutorIdQuery = "SELECT tutor_id FROM Course WHERE course_id = @CourseId";
                using (SqlCommand command = new SqlCommand(tutorIdQuery, connection))
                {
                    command.Parameters.AddWithValue("@CourseId", courseId);

                    // ExecuteScalar returns the first column of the first row
                    var result = command.ExecuteScalar();

                    if (result != null && int.TryParse(result.ToString(), out tutorId))
                    { 
                        Session["tutorId"] = tutorId;
                    }
                }
            }

            Response.Redirect("ViewTutor/ViewTutorCourse.aspx");

        }

        private string GenerateStarIcons(int rating)
        {
            StringBuilder starIconsBuilder = new StringBuilder();

            for (int i = 0; i < rating; i++)
            {
                starIconsBuilder.Append("<i class='fa fa-star text-warning'></i>");
            }

            return starIconsBuilder.ToString();
        }

    }

}