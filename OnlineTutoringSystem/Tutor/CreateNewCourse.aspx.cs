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
using System.IO;
using System.Resources;

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
        public string FileName { get; set; }
        public byte[] FileData { get; set; }
        // Add other properties as needed
    }

    public static class StreamExtensions
    {
        public static byte[] ToByteArray(this Stream stream)
        {
            using (MemoryStream memoryStream = new MemoryStream())
            {
                stream.CopyTo(memoryStream);
                return memoryStream.ToArray();
            }
        }
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

            // Handle the case when the user is not logged in
            // You might want to throw an exception, return null, or handle it in another way
            throw new Exception("User is not logged in");
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
                // Course Information
                string courseName = txtCourseName.Text;
                string courseCategory = ddlCourseCategory.SelectedItem.ToString();
                int catId = int.Parse(ddlCourseCategory.SelectedValue);
                string courseLevel = ddlCourseLevel.SelectedValue.ToString();
                string courseTopic = txtCourseTopic.Text;
                decimal coursePrice = Convert.ToDecimal(txtCoursePrice.Text);
                string courseLanguage = ddlCourseLanguage.SelectedValue.ToString();
                string courseDuration = txtCourseDuration.Text;
                int tutorId = GetTutorId(); ;

                // Advance Information
                string courseDescription = txtCourseDescription.Text;
                string teachingContent = txtCourseContent.Text;
                string targetAudience = txtCourseTargetAudience.Text;
                string courseRequirements = txtCourseRequirements.Text;

                // Course Thumbnail and Trailer
                byte[] courseThumbnail = fileUploadThumbnail.HasFile ? fileUploadThumbnail.FileBytes : null;
                byte[] courseTrailer = fileUploadTrailer.HasFile ? fileUploadTrailer.FileBytes : null;


                // Call a method to insert data into the database
                InsertCourseData(courseName, courseCategory, catId, courseLevel, courseTopic, coursePrice,
                    courseLanguage, courseDuration, courseDescription, teachingContent,
                    targetAudience, courseRequirements, courseThumbnail, courseTrailer, tutorId);

                // Optionally, you can show a success message
                ScriptManager.RegisterStartupScript(this, GetType(), "CreateAlert", "alert('Course created successfully.');", true);
            }
            catch (Exception ex)
            {
                // Handle update failure if needed
                ScriptManager.RegisterStartupScript(this, GetType(), "CreateAlert", "alert('Failed to create the course.');", true);

                // Log the exception to a log file or a logging framework
                LogException(ex);
            }
        }

        // Helper method to log exceptions
        private void LogException(Exception ex)
        {
            // Log the exception to a log file or a logging framework
            string logFilePath = Server.MapPath("~/App_Data/ErrorLog.txt");
            System.IO.File.AppendAllText(logFilePath, $"{DateTime.Now}: {ex.Message}\n");
        }

        private void InsertCourseData(string courseName, string courseCategory, int catId, string courseLevel, string courseTopic,
      decimal coursePrice, string courseLanguage, string courseDuration, string courseDescription,
      string teachingContent, string targetAudience, string courseRequirements, byte[] courseThumbnail,
      byte[] courseTrailer, int tutorId)
        {
            // Use your connection string
            string connectionString = WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                try
                {
                    // Insert into Course table
                    string courseQuery = "INSERT INTO Course (course_name, course_category, cat_id, course_level, course_topic, " +
                     "course_fee, course_language, course_duration, course_desc, course_content, " +
                     "course_targetAudience, course_requirement, course_pic, course_video, tutor_id) " +
                     "VALUES (@CourseName, @CourseCategory, @CatId, @CourseLevel, @CourseTopic, " +
                     "@CoursePrice, @CourseLanguage, @CourseDuration, @CourseDescription, @TeachingContent, " +
                     "@TargetAudience, @CourseRequirements, @CourseThumbnail, @CourseTrailer, @TutorId)" +
                        "SELECT SCOPE_IDENTITY();";


                    int newCourseId;

                    using (SqlCommand command = new SqlCommand(courseQuery, connection))
                    {
                        // Add parameters
                        command.Parameters.AddWithValue("@CourseName", courseName);
                        command.Parameters.AddWithValue("@CourseCategory", courseCategory);
                        command.Parameters.AddWithValue("@CatId", catId);
                        command.Parameters.AddWithValue("@CourseLevel", courseLevel);
                        command.Parameters.AddWithValue("@CourseTopic", courseTopic);
                        command.Parameters.AddWithValue("@CoursePrice", coursePrice);
                        command.Parameters.AddWithValue("@CourseLanguage", courseLanguage);
                        command.Parameters.AddWithValue("@CourseDuration", courseDuration);
                        command.Parameters.AddWithValue("@CourseDescription", courseDescription);
                        command.Parameters.AddWithValue("@TeachingContent", teachingContent);
                        command.Parameters.AddWithValue("@TargetAudience", targetAudience);
                        command.Parameters.AddWithValue("@CourseRequirements", courseRequirements);
                        command.Parameters.AddWithValue("@CourseThumbnail", courseThumbnail);
                        command.Parameters.AddWithValue("@CourseTrailer", courseTrailer);
                        command.Parameters.AddWithValue("@TutorId", tutorId);

                        // Execute the command
                        newCourseId = Convert.ToInt32(command.ExecuteScalar());

                        // Add parameters only if the corresponding file is uploaded
                        if (fileUploadThumbnail.HasFile)
                        {
                            // If a file is uploaded, read it into a byte array
                            int thumbnailLength = fileUploadThumbnail.PostedFile.ContentLength;
                            byte[] thumbnailBytes = new byte[thumbnailLength];
                            fileUploadThumbnail.PostedFile.InputStream.Read(thumbnailBytes, 0, thumbnailLength);
                            command.Parameters.AddWithValue("@CourseThumbnail", thumbnailBytes);
                        }

                        if (fileUploadTrailer.HasFile)
                        {
                            // If a file is uploaded, read it into a byte array
                            int trailerLength = fileUploadTrailer.PostedFile.ContentLength;
                            byte[] trailerBytes = new byte[trailerLength];
                            fileUploadTrailer.PostedFile.InputStream.Read(trailerBytes, 0, trailerLength);
                            command.Parameters.AddWithValue("@CourseTrailer", trailerBytes);
                        }
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Error adding course: " + ex.Message);
                    // You might want to log the exception details to a log file or another logging mechanism.
                }
            }
        }
    }
}