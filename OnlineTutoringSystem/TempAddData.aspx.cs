using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineTutoringSystem
{
    public partial class TempAddData : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Populate the dropdown list with categories on page load
                BindCourseCategories();
            }
        }

        protected void BindCourseCategories()
        {
            YourDataAccessLayer dataAccess = new YourDataAccessLayer();
            DataTable dtCategories = dataAccess.GetCourseCategories();

            ddlCourseCategory.DataSource = dtCategories;
            ddlCourseCategory.DataTextField = "cat_name";
            ddlCourseCategory.DataValueField = "cat_id";
            ddlCourseCategory.DataBind();
        }
        public class YourDataAccessLayer
        {
            // Your connection string
            private string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            public DataTable GetCourseCategories()
            {
                DataTable dtCategories = new DataTable();

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "SELECT cat_id, cat_name FROM Category";
                    using (SqlCommand cmd = new SqlCommand(query, connection))
                    {
                        connection.Open();
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            da.Fill(dtCategories);
                        }
                    }
                }

                return dtCategories;
            }
        }


        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                // Your connection string
                string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    // Your SQL query to insert data into the Course table
                    string query = "INSERT INTO Course (course_name, course_category, course_desc, course_level, course_fee, course_status, course_duration, course_language, course_topic, course_pic, course_video, course_overview, course_targetAudience, course_requirement, cat_id, tutor_id) " +
                                   "VALUES (@CourseName, @CourseCategory, @CourseDesc, @CourseLevel, @CourseFee, @CourseStatus, @CourseDuration, @CourseLanguage, @CourseTopic, @CoursePic, @CourseVideo, @CourseOverview, @CourseTargetAudience, @CourseRequirement, @CatID, @TutorID); SELECT SCOPE_IDENTITY();";

                    using (SqlCommand cmd = new SqlCommand(query, connection))
                    {
                        // Set parameters
                        cmd.Parameters.AddWithValue("@CourseName", txtCourseName.Value);
                        cmd.Parameters.AddWithValue("@CourseCategory", ddlCourseCategory.SelectedValue);
                        cmd.Parameters.AddWithValue("@CourseDesc", txtCourseDesc.Value);
                        cmd.Parameters.AddWithValue("@CourseRequirement", txtCourseRequirement.Value);
                        cmd.Parameters.AddWithValue("@CourseLevel", txtCourseLevel.Value);
                        cmd.Parameters.AddWithValue("@CourseOverview", txtCourseOverview.Value);
                        cmd.Parameters.AddWithValue("@CatID", Convert.ToDouble(txtCatID.Value));
                        cmd.Parameters.AddWithValue("@TutorID", Convert.ToDouble(txtTutorID.Value));
                        cmd.Parameters.AddWithValue("@CourseTargetAudience", txtCourseTargetAudience.Value);
                        cmd.Parameters.AddWithValue("@CourseFee", Convert.ToDouble(txtCourseFee.Value));
                        cmd.Parameters.AddWithValue("@CourseStatus", txtCourseStatus.Value);
                        cmd.Parameters.AddWithValue("@CourseDuration", txtCourseDuration.Value);
                        cmd.Parameters.AddWithValue("@CourseLanguage", txtCourseLanguage.Value);
                        cmd.Parameters.AddWithValue("@CourseTopic", txtCourseTopic.Value);
                        // Add other parameters accordingly

                        // Handle file uploads (if needed)
                        if (fileCoursePic.HasFile)
                        {
                            cmd.Parameters.AddWithValue("@CoursePic", fileCoursePic.FileBytes);
                        }
                        else
                        {
                            // If no file is uploaded, you may want to set a default or handle it accordingly
                            cmd.Parameters.AddWithValue("@CoursePic", DBNull.Value);
                        }

                        if (fileCourseVideo.HasFile)
                        {
                            cmd.Parameters.AddWithValue("@CourseVideo", fileCourseVideo.FileBytes);
                        }
                        else
                        {
                            // If no file is uploaded, you may want to set a default or handle it accordingly
                            cmd.Parameters.AddWithValue("@CourseVideo", DBNull.Value);
                        }

                        // Additional logic if needed

                        // Open the connection
                        connection.Open();

                        // Execute the query and get the inserted course_id
                        int courseId = Convert.ToInt32(cmd.ExecuteScalar());

                        // Close the connection
                        connection.Close();

                        // Display success message or perform other actions
                        lblMessage.Visible = true;
                        lblMessage.Text = "Course added successfully!";
                        lblMessage.CssClass = "success-message";
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions (display error message, log, etc.)
                lblMessage.Visible = true;
                lblMessage.Text = "Error: " + ex.Message;
                lblMessage.CssClass = "error-message";
            }
        }
    }
}