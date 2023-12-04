using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace OnlineTutoringSystem.Tutor
{

    public class FileData
    {
        public string FileName { get; set; }
        public string FilePath { get; set; }
        // Add other properties as needed
    }

    public class ResourceData
        {
            public int ResourceId { get; set; }
            public string ResourceName { get; set; }
            // Add other properties as needed
        }


    public partial class WebForm3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Populate the dropdown list with categories on page load
                BindCourseCategories();

                //// Call a method to get resource data and bind it to the GridView
                //BindResourceData();

                LoadTutorData();
            }
        }

        protected void btnAddResource_Click(object sender, EventArgs e)
        {
            string script = "$('#editResourceModal').modal('show');";
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", script, true);
        }



        private List<ResourceData> GetResourceData()
        {
            // Implement a method to retrieve resource data from the database
            // Return a list of objects containing resource information
            // Example: List<ResourceData> resourceDataList = YourDataAccessLayer.GetResourceData();
            // ResourceData is a custom class representing the structure of your resource data
            // You need to replace it with the actual class and structure used in your application.
            throw new NotImplementedException();
        }

        private void LoadTutorData()
        {
            // Get the tutor ID directly from the session
            int tutorId = GetTutorId();

            // If you need to use the tutorId elsewhere, you can store it in a variable or property
            // Example: int currentTutorId = tutorId;

            // Note: If you don't need to use the tutorId elsewhere, you can directly use it in btnSubmit_Click
        }

        private int GetTutorId()
        {
            if (Session["userId"] != null)
            {
                return Convert.ToInt32(Session["userId"]);
            }

            // Handle the case when the user is not logged in (return a default value or handle it accordingly)
            return -1; // You can choose an appropriate default value
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

        private int InsertResource(SqlConnection connection, int courseId)
        {
            string resourceQuery = "INSERT INTO Resource (res_name, course_id) VALUES (@ResourceName, @CourseID); SELECT SCOPE_IDENTITY();";

            using (SqlCommand resourceCmd = new SqlCommand(resourceQuery, connection))
            {
                //// Set parameters for the Resource
                //resourceCmd.Parameters.AddWithValue("@ResourceName", txtResourceName.Text);
                //resourceCmd.Parameters.AddWithValue("@CourseID", courseId);

                // Execute the query and get the inserted resource_id
                return Convert.ToInt32(resourceCmd.ExecuteScalar());
            }
        }

        private void InsertFileAttachment(SqlConnection connection, int resourceId)
        {
            string fileQuery = "INSERT INTO File_Attachment (file_name, file_path, res_id) VALUES (@FileName, @FilePath, @ResourceID);";

            using (SqlCommand fileCmd = new SqlCommand(fileQuery, connection))
            {
                //// Assuming you have the file information
                //fileCmd.Parameters.AddWithValue("@FileName", fileUpload.HasFile);
                //fileCmd.Parameters.AddWithValue("@FilePath", "path/to/uploaded/file");
                //fileCmd.Parameters.AddWithValue("@ResourceID", resourceId);

                fileCmd.ExecuteNonQuery();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                // Get the tutor_id from the session
                int tutorId = GetTutorId();

                // Check if the user is logged in
                if (tutorId != -1)
                {
                    // Your connection string
                    string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        // Your SQL query to insert data into the Course table
                        string query = "INSERT INTO Course (course_name, course_category, course_desc, course_level, course_fee, course_duration, course_language, course_topic, course_pic, course_video, course_content, course_targetAudience, course_requirement, cat_id, tutor_id) " +
                                       "VALUES (@CourseName, @CourseCategory, @CourseDesc, @CourseLevel, @CourseFee, @CourseDuration, @CourseLanguage, @CourseTopic, @CoursePic, @CourseVideo, @CourseContent, @CourseTargetAudience, @CourseRequirement, @CatID, @TutorID); SELECT SCOPE_IDENTITY();";

                        using (SqlCommand cmd = new SqlCommand(query, connection))
                        {
                            // Set parameters
                            cmd.Parameters.AddWithValue("@CourseName", txtCourseName.Text);
                            cmd.Parameters.AddWithValue("@CourseCategory", ddlCourseCategory.SelectedItem.ToString());
                            cmd.Parameters.AddWithValue("@CourseDesc", txtCourseDescription.Text);
                            cmd.Parameters.AddWithValue("@CourseRequirement", txtCourseRequirements.Text);
                            cmd.Parameters.AddWithValue("@CourseLevel", ddlCourseLevel.SelectedValue);
                            cmd.Parameters.AddWithValue("@CourseContent", txtCourseContent.Text);
                            cmd.Parameters.AddWithValue("@CourseTargetAudience", txtCourseTargetAudience.Text);
                            cmd.Parameters.AddWithValue("@CourseFee", Convert.ToDouble(txtCoursePrice.Text));
                            cmd.Parameters.AddWithValue("@CourseDuration", txtCourseDuration.Text);
                            cmd.Parameters.AddWithValue("@CourseLanguage", ddlCourseLanguage.SelectedValue);
                            cmd.Parameters.AddWithValue("@CourseTopic", txtCourseTopic.Text);

                            // Set the tutor_id parameter
                            cmd.Parameters.AddWithValue("@TutorID", tutorId);
                            cmd.Parameters.AddWithValue("@CatID", ddlCourseCategory.SelectedValue);

                            // Handle file uploads (if needed)
                            if (fileUploadThumbnail.HasFile)
                            {
                                cmd.Parameters.AddWithValue("@CoursePic", fileUploadThumbnail.FileBytes);
                            }
                            else
                            {
                                // If no file is uploaded, you may want to set a default or handle it accordingly
                                cmd.Parameters.AddWithValue("@CoursePic", DBNull.Value);
                            }

                            if (fileUploadTrailer.HasFile)
                            {
                                cmd.Parameters.AddWithValue("@CourseVideo", fileUploadTrailer.FileBytes);
                            }
                            else
                            {
                                // If no file is uploaded, you may want to set a default or handle it accordingly
                                cmd.Parameters.AddWithValue("@CourseVideo", DBNull.Value);
                            }

                            // Open the connection
                            connection.Open();

                            // Execute the query and get the inserted course_id
                            int courseId = Convert.ToInt32(cmd.ExecuteScalar());

                            //// Insert resource and get resourceId
                            //int resourceId = InsertResource(connection, courseId);

                            //// Insert file attachment
                            //InsertFileAttachment(connection, resourceId);

                            // Close the connection
                            connection.Close();

                            // Display success message or perform other actions
                            lblMessage.Visible = true;
                            lblMessage.Text = "Course and Resource added successfully!";
                            lblMessage.CssClass = "success-message";
                        }
                    }
                }
                else
                {
                    // Redirect to the login page or handle the case when the user is not logged in
                    Response.Redirect("Login.aspx");
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