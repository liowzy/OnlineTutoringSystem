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

            // Resource Information
            List<ResourceData> resources = new List<ResourceData>();

            // Assuming you have a way to dynamically determine the number of resource input fields, adjust this part accordingly
            int resourceCount = Request.Form.AllKeys.Count(key => key.StartsWith("txtResourceName"));
            for (int i = 1; i <= resourceCount; i++)
            {
                string resourceName = Request.Form["txtResourceName" + i];
                string fileName = Request.Form["txtFileName" + i];
                byte[] fileData = Request.Files["fileUpload" + i]?.InputStream.ToByteArray() ?? new byte[0]; // Adjust based on your file upload control naming

                resources.Add(new ResourceData { ResourceName = resourceName, FileName = fileName, FileData = fileData });
            }


            // Call a method to insert data into the database
            InsertCourseData(courseName, courseCategory, catId, courseLevel, courseTopic, coursePrice,
                courseLanguage, courseDuration, courseDescription, teachingContent,
                targetAudience, courseRequirements, courseThumbnail, courseTrailer,
                resources, tutorId);
        }

        private void InsertCourseData(string courseName, string courseCategory, int catId, string courseLevel, string courseTopic,
      decimal coursePrice, string courseLanguage, string courseDuration, string courseDescription,
      string teachingContent, string targetAudience, string courseRequirements, byte[] courseThumbnail,
      byte[] courseTrailer, List<ResourceData> resources, int tutorId)
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
                    }

                    List<int> resourceIds = new List<int>();

                    // Insert into Resource table
                    foreach (var resource in resources)
                    {
                        string resourceQuery = "INSERT INTO Resource (res_name, course_id) VALUES (@ResourceName, @CourseId); SELECT SCOPE_IDENTITY();";

                        using (SqlCommand command = new SqlCommand(resourceQuery, connection))
                        {
                            command.Parameters.AddWithValue("@ResourceName", resource.ResourceName);
                            command.Parameters.AddWithValue("@CourseId", newCourseId);

                            int resourceId = Convert.ToInt32(command.ExecuteScalar());
                            resourceIds.Add(resourceId);

                            // Insert into File_Attachment table
                            if (resource.FileData != null)
                            {
                                string fileAttachmentQuery = "INSERT INTO File_Attachment (file_name, file_path, res_id) " +
                                    "VALUES (@FileName, @FilePath, @ResourceId)";

                                using (SqlCommand fileCommand = new SqlCommand(fileAttachmentQuery, connection))
                                {
                                    fileCommand.Parameters.AddWithValue("@FileName", resource.FileName);
                                    fileCommand.Parameters.AddWithValue("@FilePath", resource.FileData);
                                    fileCommand.Parameters.AddWithValue("@ResourceId", resourceId);

                                    fileCommand.ExecuteNonQuery();
                                }
                            }
                        }
                    }
                    // Display a success message or redirect to another page
                    lblMessage.Text = "File uploaded successfully!";
                    lblMessage.Visible = true;
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Error adding course: " + ex.Message);
                    // You might want to log the exception details to a log file or another logging mechanism.
                }
            }
        }

        //protected void btnSubmit_Click2(object sender, EventArgs e)
        //{
        //    string vfileName = Path.GetFileName(fileUpload.PostedFile.FileName);
        //    string contentType = fileUpload.PostedFile.ContentType;
        //    using (Stream fs = fileUpload.PostedFile.InputStream)
        //    {
        //        using (BinaryReader br = new BinaryReader(fs))
        //        {
        //            byte[] bytes = br.ReadBytes((Int32)fs.Length);
        //            string connectionString = WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        //            using (SqlConnection connection = new SqlConnection(connectionString))
        //            {
        //                string query = "INSERT INTO File_Attachment VALUES (@Name, @Data, @CourseId)";
        //                using (SqlCommand cmd = new SqlCommand(connectionString))
        //                {
        //                    cmd.Connection = connection;
        //                    cmd.Parameters.AddWithValue("@Name", vfileName);
        //                    cmd.Parameters.AddWithValue("@Data", bytes);
        //                    cmd.Parameters.AddWithValue("@CourseId", 408);
        //                    connection.Open();
        //                    cmd.ExecuteNonQuery();
        //                    connection.Close();
        //                }
        //            }
        //        }
        //    }
        //    Response.Redirect(Request.Url.AbsoluteUri);
        //}
    }
}
