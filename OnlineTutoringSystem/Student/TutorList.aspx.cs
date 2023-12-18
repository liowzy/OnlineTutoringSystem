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
using static System.Windows.Forms.VisualStyles.VisualStyleElement.StartPanel;
using System.Security.Cryptography;
using System.Windows.Forms;

namespace OnlineTutoringSystem
{
    public partial class WebForm13 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if the search term is present in the query string
                if (Request.QueryString["searchTerm"] != null)
                {
                    string searchTerm = Server.UrlDecode(Request.QueryString["searchTerm"]);

                    // Perform the search using the retrieved searchTerm
                    ExecuteSearch(searchTerm);
                }
            }
        }
        private void ExecuteSearch(string searchTerm)
        {
            SqlDataSourceTutors.SelectCommand = "SELECT tutor_id, tutor_picture, tutor_name, tutor_expertice FROM Tutor " +
                "WHERE tutor_name LIKE @SearchTerm ORDER BY tutor_id ASC";

            // Clear existing parameters and add the new search parameter
            SqlDataSourceTutors.SelectParameters.Clear();
            SqlDataSourceTutors.SelectParameters.Add("SearchTerm", "%" + searchTerm + "%");

            // Bind the data to the DataListCourses
            DataListCourses.DataSourceID = "SqlDataSourceTutors";
            DataListCourses.DataBind();
        }


        protected void DataListCourses_SelectedIndexChanged(object sender, EventArgs e)
        {
            string tutorId = Session["tutorId"] as string;
            // Display a window alert with the session ID
            ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Session ID: {Session["tutorId"]}');", true);

            // Use courseId as needed
            Response.Redirect("ViewTutor/ViewTutorCourse.aspx");
        }

        protected void selectBtn_Command(object sender, CommandEventArgs e)
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
        protected void ddlSortBy_SelectedIndexChanged(object sender, EventArgs e)
        {
            string sortBy = ddlSortBy.SelectedValue;

            switch (sortBy)
            {
                case "Latest":
                    // Sort by latest added
                    SqlDataSourceTutors.SelectCommand = "SELECT tutor_id, tutor_picture, tutor_name, tutor_expertice FROM Tutor ORDER BY tutor_id DESC";
                    break;
                case "Oldest":
                    // Sort by oldest added
                    SqlDataSourceTutors.SelectCommand = "SELECT tutor_id, tutor_picture, tutor_name, tutor_expertice FROM Tutor ORDER BY tutor_id ASC";
                    break;
                case "Rating":
                    // Sort by highest rating
                    SqlDataSourceTutors.SelectCommand = "SELECT t.tutor_id, t.tutor_picture, t.tutor_name, t.tutor_expertice, " +
                        "COALESCE(AVG(r.review_rating), 0) AS average_rating FROM Tutor t LEFT JOIN Review r ON t.tutor_id = r.tutor_id " +
                        "GROUP BY t.tutor_id, t.tutor_picture, t.tutor_name, t.tutor_expertice ORDER BY average_rating DESC";
                    break;
                default: 
                    SqlDataSourceTutors.SelectCommand = "SELECT tutor_id, tutor_picture, tutor_name, tutor_expertice FROM Tutor ORDER BY tutor_id ASC";
                    break;
            }

            DataListCourses.DataBind();
        }

        public double CalculateAverageRating(string tutorId)
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


        private int GetReviewCountForTutor(int tutorId)
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