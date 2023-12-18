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
    public partial class WebForm5 : System.Web.UI.Page
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
        protected string GetCardColor(int index)
        {
            string[] colors = { "#EBEBFF", "#E1F7E3", "#FFF2E5", "#FFF0F0", "#F5F7FA" };
            return colors[index % colors.Length];
        }
        private void ExecuteSearch(string searchTerm)
        {
            SqlDataSourceCourses.SelectCommand = "SELECT c.course_id, c.course_pic, c.course_name, c.course_fee, cat.cat_name " +
                                         "FROM Course c " +
                                         "JOIN Category cat ON c.cat_id = cat.cat_id " +
                                         "WHERE c.course_name LIKE @SearchTerm " +
                                         "ORDER BY c.course_id ASC";

            // Clear existing parameters and add the new search parameter
            SqlDataSourceCourses.SelectParameters.Clear();
            SqlDataSourceCourses.SelectParameters.Add("SearchTerm", "%" + searchTerm + "%");

            // Bind the data to the DataListCourses
            DataListCourses.DataSourceID = "SqlDataSourceCourses";
            DataListCourses.DataBind();
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

        protected void ddlSortBy_SelectedIndexChanged(object sender, EventArgs e)
        {
            string sortBy = ddlSortBy.SelectedValue;

            switch (sortBy)
            {
                case "Latest":
                    // Sort by latest added
                    SqlDataSourceCourses.SelectCommand = "SELECT c.course_id, c.course_pic, c.course_name, c.course_fee, cat.cat_name FROM Course c JOIN Category cat ON c.cat_id = cat.cat_id ORDER BY c.course_id DESC";
                    break;
                case "Oldest":
                    // Sort by oldest added
                    SqlDataSourceCourses.SelectCommand = "SELECT c.course_id, c.course_pic, c.course_name, c.course_fee, cat.cat_name FROM Course c JOIN Category cat ON c.cat_id = cat.cat_id ORDER BY c.course_id ASC";
                    break;
                case "HighPrice":
                    // Sort by highest price
                    SqlDataSourceCourses.SelectCommand = "SELECT c.course_id, c.course_pic, c.course_name, c.course_fee, cat.cat_name FROM Course c JOIN Category cat ON c.cat_id = cat.cat_id ORDER BY c.course_fee DESC";
                    break;
                case "LowPrice":
                    // Sort by lowest price
                    SqlDataSourceCourses.SelectCommand = "SELECT c.course_id, c.course_pic, c.course_name, c.course_fee, cat.cat_name FROM Course c JOIN Category cat ON c.cat_id = cat.cat_id ORDER BY c.course_fee ASC";
                    break;
                case "Rating":
                    // Sort by highest rating
                    SqlDataSourceCourses.SelectCommand = "SELECT c.course_id, c.course_pic, c.course_name," +
                        " c.course_fee, cat.cat_name, COALESCE((SELECT AVG(review_rating) FROM Review WHERE course_id = c.course_id), 0) AS " +
                        "AvgRating FROM Course c JOIN Category cat ON c.cat_id = cat.cat_id ORDER BY AvgRating DESC";

                    break;
                default:
                    // Default sorting (you can modify this as needed)
                    SqlDataSourceCourses.SelectCommand = "SELECT c.course_id, c.course_pic, c.course_name, c.course_fee, cat.cat_name FROM Course c JOIN Category cat ON c.cat_id = cat.cat_id ORDER BY c.course_id ASC";
                    break;
            }

            DataListCourses.DataBind();
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


        private int GetReviewCountForTutor(int courseId)
        { 
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

    }
}