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
    public partial class WebForm13 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if the search term is present in the query string
                //if (Request.QueryString["searchTerm"] != null)
                //{
                //    string searchTerm = Server.UrlDecode(Request.QueryString["searchTerm"]);

                //    // Perform the search using the retrieved searchTerm
                //    ExecuteSearch(searchTerm);
                //}
            }
        } 
        //private void ExecuteSearch(string searchTerm)
        //{
        //    SqlDataSourceTutors.SelectCommand = "SELECT c.course_id, c.course_pic, c.course_name, c.course_fee, cat.cat_name " +
        //                                 "FROM Course c " +
        //                                 "JOIN Category cat ON c.cat_id = cat.cat_id " +
        //                                 "WHERE c.course_name LIKE @SearchTerm " +
        //                                 "ORDER BY c.course_id ASC";

        //    // Clear existing parameters and add the new search parameter
        //    SqlDataSourceTutors.SelectParameters.Clear();
        //    SqlDataSourceTutors.SelectParameters.Add("SearchTerm", "%" + searchTerm + "%");

        //    // Bind the data to the DataListCourses
        //    SqlDataSourceTutors.DataSourceID = "SqlDataSourceCourses";
        //    SqlDataSourceTutors.DataBind();
        //}


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