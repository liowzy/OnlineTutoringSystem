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
    public partial class WebForm3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            { 
                string courseId = Session["courseId"]?.ToString();

                if (!string.IsNullOrEmpty(courseId))
                {
                    FetchCourseOverview(courseId);
                }
                else
                {
                    Response.Redirect("Course.aspx");
                }
            }
        }

        private void FetchCourseOverview(string courseId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Fetch course overview data from the database
                string overviewQuery = "SELECT course_overview, course_desc, course_targetAudience, course_requirement FROM Course WHERE course_id = @CourseId";

                using (SqlCommand command = new SqlCommand(overviewQuery, connection))
                {
                    command.Parameters.AddWithValue("@CourseId", courseId);

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            // Populate labels with data from the database
                            OverviewContent.Text = reader["course_overview"].ToString();
                            DescriptionContent.Text = reader["course_desc"].ToString();
                            ForWhoContent.Text = reader["course_targetAudience"].ToString();
                            RequirementsContent.Text = reader["course_requirement"].ToString();
                        }
                        else
                        { 
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Error: Course information not available.');", true);
                        }
                    }
                }
            }
        }
    }
}