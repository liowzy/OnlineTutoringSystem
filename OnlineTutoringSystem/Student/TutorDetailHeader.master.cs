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

namespace OnlineTutoringSystem.Student
{
    public partial class TutorDetailHeader : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["tutorId"] != null)
            {
                int tutorId = Convert.ToInt32(Request.QueryString["tutorId"]);
                FetchTutorDetails(tutorId);
            }
            else
            {
                int tutorId = Convert.ToInt32(Session["tutorId"]);

                FetchTutorDetails(tutorId);
            } 
        }

        private void FetchTutorDetails(int tutorId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            string query = @"
        SELECT 
            T.*,
            R.review_rating
        FROM 
            Tutor T
        LEFT JOIN 
            Review R ON T.tutor_id = R.tutor_id
        WHERE 
            T.tutor_id = @TutorId";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@TutorId", tutorId);

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            // Populate tutor details on the page
                            PopulateTutorDetails(reader, tutorId);
                        }
                    }
                }
            }
        }

        private void PopulateTutorDetails(SqlDataReader reader, int tutorId)
        {
            byte[] tutorPictureBytes = (byte[])reader["tutor_picture"];
            string base64String = Convert.ToBase64String(tutorPictureBytes, 0, tutorPictureBytes.Length);
            TutorImage.ImageUrl = "data:image/png;base64," + base64String;

            // Tutor Name
            TutorNameLabel.Text = reader["tutor_name"].ToString();

            // Tutor Expertise
            TutorExpertiseLabel.Text = reader["tutor_expertice"].ToString();

            // Tutor Rating
            if (reader["review_rating"] != DBNull.Value)
            {
                double averageRating = CalculateAverageRating(reader, tutorId);
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

            DescriptionValue.Text = GetNullableString(reader["tutor_description"]);
            LocationValue.Text = GetNullableString(reader["tutor_location"]); 
            TeachingExperienceValue.Text = GetNullableString(reader["tutor_teachingExperience"]);
        }
        private string GetNullableString(object value)
        {
            // Check if the value is DBNull.Value or null
            if (value == DBNull.Value || value == null)
            {
                return "N/A";
            }

            // Convert the value to string
            return value.ToString();
        }


        private double CalculateAverageRating(SqlDataReader reader, int tutorId)
        {
            if (reader["review_rating"] != DBNull.Value)
            {
                int sumOfRatings = Convert.ToInt32(reader["review_rating"]);
                int reviewCount = GetReviewCountForTutor(tutorId);

                if (reviewCount > 0)
                {
                    return (double)sumOfRatings / reviewCount;
                }
            }

            return 0.0;
        }

        private int GetReviewCountForTutor(int tutorId)
        {
            // Perform a query to get the review count for the specified tutor
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string countQuery = "SELECT COUNT(*) FROM Review WHERE tutor_id = @TutorId";
                using (SqlCommand command = new SqlCommand(countQuery, connection))
                {
                    command.Parameters.AddWithValue("@TutorId", tutorId);

                    int reviewCount = (int)command.ExecuteScalar();
                    return reviewCount;
                }
            }
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

        protected void ContactMeButton_Click(object sender, ImageClickEventArgs e)
        {
            string tutorId = Session["tutorId"].ToString();

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Fetch chat_link based on tutor_id
                string chatLinkQuery = "SELECT chat_link FROM Tutor WHERE tutor_id = @TutorId";
                using (SqlCommand command = new SqlCommand(chatLinkQuery, connection))
                {
                    command.Parameters.AddWithValue("@TutorId", tutorId);

                    string chatLink = command.ExecuteScalar()?.ToString();

                    // Open a new window to navigate to the chat link
                    if (!string.IsNullOrEmpty(chatLink))
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "openWindow", $"window.open('{chatLink}', '_blank');", true);
                    }
                }
            }

        }

        protected void btnCourse_Click(object sender, EventArgs e)
        {

            Response.Redirect("~/Student/ViewTutor/ViewTutorCourse.aspx");
        }

        protected void btnReview_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Student/ViewTutor/ViewTutorReview.aspx");

        }

        protected void btnSchedule_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Student/ViewTutor/ViewTutorSchedule.aspx");

        }
    }
}