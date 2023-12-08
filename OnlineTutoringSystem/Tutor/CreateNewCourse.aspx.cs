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
            string resourceName = txtresourceName.Text;
            string fileName = txtfileName.Text;
            byte[] fileData = fileUpload.HasFile ? fileUpload.FileBytes : null;

            // Call a method to insert data into the database
            InsertCourseData(courseName, courseCategory, catId, courseLevel, courseTopic, coursePrice,
                courseLanguage, courseDuration, courseDescription, teachingContent,
                targetAudience, courseRequirements, courseThumbnail, courseTrailer,
                resourceName, fileName, fileData, tutorId);
        }

        private void InsertCourseData(string courseName, string courseCategory, int catId, string courseLevel, string courseTopic,
            decimal coursePrice, string courseLanguage, string courseDuration, string courseDescription,
            string teachingContent, string targetAudience, string courseRequirements, byte[] courseThumbnail,
            byte[] courseTrailer, string resourceName, string fileName, byte[] fileData, int tutorId)
        {
            // Use your connection string
            string connectionString = WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

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
                    command.ExecuteNonQuery();

                    newCourseId = Convert.ToInt32(command.ExecuteScalar());
                }

                // Insert into Resource table
                string resourceQuery = "INSERT INTO Resource (res_name, course_id) VALUES (@ResourceName, @CourseId); SELECT SCOPE_IDENTITY()";

                using (SqlCommand command = new SqlCommand(resourceQuery, connection))
                {
                    // Add parameter
                    command.Parameters.AddWithValue("@ResourceName", resourceName);
                    command.Parameters.AddWithValue("@CourseId", newCourseId);

                    // Get the resource ID
                    int resourceId = Convert.ToInt32(command.ExecuteScalar());

                    // Insert into File_Attachment table
                    //string vfileName = Path.GetFileName(fileUpload.PostedFile.FileName);
                    //string contentType = fileUpload.PostedFile.ContentType;
                    //using (Stream fs = fileUpload.PostedFile.InputStream)
                    //{
                    //    using (BinaryReader br = new BinaryReader(fs))
                    //    {
                    //        byte[] bytes = br.ReadBytes((Int32)fs.Length);
                    //        string query = "INSERT INTO File_Attachment (file_name, file_path, res_id) VALUES (@Name, @Data, @ResourceId)";
                    //        using (SqlCommand cmd = new SqlCommand(query, connection))
                    //        {
                    //            cmd.Parameters.AddWithValue("@Name", fileName);
                    //            cmd.Parameters.AddWithValue("@Data", bytes);
                    //            cmd.Parameters.AddWithValue("@ResourceId", resourceId);
                    //            cmd.ExecuteNonQuery();
                    //        }

                    //    }
                    //}

                    //------------------------------------------V1
                    //string fileAttachmentQuery = "INSERT INTO File_Attachment (file_name, file_path, res_id) " +
                    //    "VALUES (@FileName, @FilePath, @ResourceId)";

                    //using (SqlCommand fileCommand = new SqlCommand(fileAttachmentQuery, connection))
                    //{
                    //    // Add parameters
                    //    fileCommand.Parameters.AddWithValue("@FileName", fileName);
                    //    fileCommand.Parameters.AddWithValue("@FilePath", fileData); 
                    //    fileCommand.Parameters.AddWithValue("@ResourceId", resourceId);

                    //    // Execute the command
                    //    fileCommand.ExecuteNonQuery();
                    //}

                    //----------------------V3
                    if (fileUpload.HasFile)
                    {
                        // Get the file content
                        byte[] fileContent = fileUpload.FileBytes;

                        // Update database columns
                        // Assuming you have a connection string and SQL command prepared 
                        using (SqlConnection fileCommand = new SqlConnection(connectionString))
                        {

                            // Assuming you have a SQL command prepared with parameters
                            string sql = "INSERT INTO File_Attachment (file_name, file_path, res_id) VALUES (@FileName, @FilePath, @ResId)";
                            using (SqlCommand fileCommand2 = new SqlCommand(sql, connection))
                            {
                                fileCommand2.Parameters.AddWithValue("@FileName", fileUpload.FileName);
                                fileCommand2.Parameters.AddWithValue("@FilePath", fileContent);
                                fileCommand2.Parameters.AddWithValue("@ResId", resourceId);

                                fileCommand2.ExecuteNonQuery();
                            }
                        }

                        // Display a success message or redirect to another page
                        lblMessage.Text = "File uploaded successfully!";
                        lblMessage.Visible = true;
                    }
                    else
                    {
                        // Handle the case where no file is uploaded
                        lblMessage.Text = "Please select a file to upload.";
                        lblMessage.Visible = true;
                    }
                }
            }
        }

        protected void btnSubmit_Click2(object sender, EventArgs e)
        {
            string vfileName = Path.GetFileName(fileUpload.PostedFile.FileName);
            string contentType = fileUpload.PostedFile.ContentType;
            using (Stream fs = fileUpload.PostedFile.InputStream)
            {
                using (BinaryReader br = new BinaryReader(fs))
                {
                    byte[] bytes = br.ReadBytes((Int32)fs.Length);
                    string connectionString = WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        string query = "INSERT INTO File_Attachment VALUES (@Name, @Data, @CourseId)";
                        using (SqlCommand cmd = new SqlCommand(connectionString))
                        {
                            cmd.Connection = connection;
                            cmd.Parameters.AddWithValue("@Name", vfileName);
                            cmd.Parameters.AddWithValue("@Data", bytes);
                            cmd.Parameters.AddWithValue("@CourseId", 408);
                            connection.Open();
                            cmd.ExecuteNonQuery();
                            connection.Close();
                        }
                    }
                }
            }
            Response.Redirect(Request.Url.AbsoluteUri);
        }


        //private int InsertResource(SqlConnection connection, int courseId)
        //{
        //    string resourceQuery = "INSERT INTO Resource (res_name, course_id) VALUES (@ResourceName, @CourseID); SELECT SCOPE_IDENTITY();";

        //    using (SqlCommand resourceCmd = new SqlCommand(resourceQuery, connection))
        //    {
        //        //// Set parameters for the Resource
        //        //resourceCmd.Parameters.AddWithValue("@ResourceName", txtResourceName.Text);
        //        //resourceCmd.Parameters.AddWithValue("@CourseID", courseId);

        //        // Execute the query and get the inserted resource_id
        //        return Convert.ToInt32(resourceCmd.ExecuteScalar());
        //    }
        //}

        //private void InsertFileAttachment(SqlConnection connection, int resourceId)
        //{
        //    string fileQuery = "INSERT INTO File_Attachment (file_name, file_path, res_id) VALUES (@FileName, @FilePath, @ResourceID);";

        //    using (SqlCommand fileCmd = new SqlCommand(fileQuery, connection))
        //    {
        //        //// Assuming you have the file information
        //        //fileCmd.Parameters.AddWithValue("@FileName", fileUpload.HasFile);
        //        //fileCmd.Parameters.AddWithValue("@FilePath", "path/to/uploaded/file");
        //        //fileCmd.Parameters.AddWithValue("@ResourceID", resourceId);

        //        fileCmd.ExecuteNonQuery();
        //    }
        //}

        //private int InsertResource(SqlConnection connection, int courseId, string resourceName)
        //{
        //    // Your SQL query to insert data into the Resource table
        //    string resourceQuery = "INSERT INTO Resource (res_name, course_id) VALUES (@ResourceName, @CourseID); SELECT SCOPE_IDENTITY();";

        //    using (SqlCommand resourceCmd = new SqlCommand(resourceQuery, connection))
        //    {
        //        // Set parameters
        //        resourceCmd.Parameters.AddWithValue("@ResourceName", resourceName);
        //        resourceCmd.Parameters.AddWithValue("@CourseID", courseId);

        //        // Execute the query and get the inserted res_id
        //        int resourceId = Convert.ToInt32(resourceCmd.ExecuteScalar());

        //        return resourceId;
        //    }
        //}

        //private void InsertFileAttachment(SqlConnection connection, int resourceId, string fileName, string filePath)
        //{
        //    // Your SQL query to insert data into the File_Attachment table
        //    string fileQuery = "INSERT INTO File_Attachment (file_name, file_path, res_id) VALUES (@FileName, @FilePath, @ResourceID);";

        //    using (SqlCommand fileCmd = new SqlCommand(fileQuery, connection))
        //    {
        //        // Set parameters
        //        fileCmd.Parameters.AddWithValue("@FileName", fileName);
        //        fileCmd.Parameters.AddWithValue("@FilePath", filePath);
        //        fileCmd.Parameters.AddWithValue("@ResourceID", resourceId);

        //        // Execute the query
        //        fileCmd.ExecuteNonQuery();
        //    }
        //}


        //protected void btnSubmit_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        // Get the tutor_id from the session
        //        int tutorId = GetTutorId();

        //        // Check if the user is logged in
        //        if (tutorId != -1)
        //        {
        //            // Your connection string
        //            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        //            using (SqlConnection connection = new SqlConnection(connectionString))
        //            {
        //                // Your SQL query to insert data into the Course table
        //                string query = "INSERT INTO Course (course_name, course_category, course_desc, course_level, course_fee, course_duration, course_language, course_topic, course_pic, course_video, course_overview, course_targetAudience, course_requirement, cat_id, tutor_id) " +
        //                                "VALUES (@CourseName, @CourseCategory, @CourseDesc, @CourseLevel, @CourseFee, @CourseDuration, @CourseLanguage, @CourseTopic, @CoursePic, @CourseVideo, @CourseContent, @CourseTargetAudience, @CourseRequirement, @CatID, @TutorID); SELECT SCOPE_IDENTITY();";

        //                using (SqlCommand cmd = new SqlCommand(query, connection))
        //                {
        //                    // Set parameters
        //                    cmd.Parameters.AddWithValue("@CourseName", txtCourseName.Text);
        //                    cmd.Parameters.AddWithValue("@CourseCategory", ddlCourseCategory.SelectedItem.ToString());
        //                    cmd.Parameters.AddWithValue("@CourseDesc", txtCourseDescription.Text);
        //                    cmd.Parameters.AddWithValue("@CourseRequirement", txtCourseRequirements.Text);
        //                    cmd.Parameters.AddWithValue("@CourseLevel", ddlCourseLevel.SelectedValue);
        //                    cmd.Parameters.AddWithValue("@CourseContent", txtCourseContent.Text);
        //                    cmd.Parameters.AddWithValue("@CourseTargetAudience", txtCourseTargetAudience.Text);
        //                    cmd.Parameters.AddWithValue("@CourseFee", Convert.ToDouble(txtCoursePrice.Text));
        //                    cmd.Parameters.AddWithValue("@CourseDuration", txtCourseDuration.Text);
        //                    cmd.Parameters.AddWithValue("@CourseLanguage", ddlCourseLanguage.SelectedValue);
        //                    cmd.Parameters.AddWithValue("@CourseTopic", txtCourseTopic.Text);
        //                    cmd.Parameters.AddWithValue("@TutorID", tutorId);
        //                    cmd.Parameters.AddWithValue("@CatID", ddlCourseCategory.SelectedValue);

        //                    // Handle file uploads (if needed)
        //                    if (fileUploadThumbnail.HasFile)
        //                    {
        //                        cmd.Parameters.AddWithValue("@CoursePic", fileUploadThumbnail.FileBytes);
        //                    }
        //                    else
        //                    {
        //                        // If no file is uploaded, you may want to set a default or handle it accordingly
        //                        cmd.Parameters.AddWithValue("@CoursePic", DBNull.Value);
        //                    }
        //                    if (fileUploadTrailer.HasFile)
        //                    {
        //                        cmd.Parameters.AddWithValue("@CourseVideo", fileUploadTrailer.FileBytes);
        //                    }
        //                    else
        //                    {
        //                        // If no file is uploaded, you may want to set a default or handle it accordingly
        //                        cmd.Parameters.AddWithValue("@CourseVideo", DBNull.Value);
        //                    }

        //                    // Open the connection
        //                    connection.Open();

        //                    // Execute the query and get the inserted course_id
        //                    int courseId = Convert.ToInt32(cmd.ExecuteScalar());

        //                    // Insert resource and get resourceId 
        //                    int resourceId = InsertResource(connection, courseId, txtCourseName.Text);


        //                    // Insert file attachment
        //                    InsertFileAttachment(connection, resourceId, fileName.Text, );

        //                    // Close the connection
        //                    connection.Close();

        //                    // Display success message or perform other actions
        //                    lblMessage.Visible = true;
        //                    lblMessage.Text = "Course and Resource added successfully!";
        //                    lblMessage.CssClass = "success-message";
        //                }
        //            }
        //        }
        //        else
        //        {
        //            // Redirect to the login page or handle the case when the user is not logged in
        //            Response.Redirect("../Entry/Login.aspx");
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        // Handle exceptions (display error message, log, etc.)
        //        lblMessage.Visible = true;
        //        lblMessage.Text = "Error: " + ex.Message;
        //        lblMessage.CssClass = "error-message";
        //    }
        //}
    }
}