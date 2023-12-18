using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace OnlineTutoringSystem.Tutor

{
    public class CourseInfo
    {
        public int CourseId { get; set; }
        public string CourseName { get; set; }
        public string CourseCategory { get; set; }
        public string CourseLevel { get; set; }
        public string CourseTopic { get; set; }
        public float CoursePrice { get; set; }
        public string CourseLanguage { get; set; }
        public string CourseDuration { get; set; }
        public string CourseDescription { get; set; }
        public string CourseContent { get; set; }
        public string CourseTargetAudience { get; set; }
        public string CourseRequirements { get; set; }
        public byte[] CourseThumbnail { get; set; }
        public byte[] CourseTrailer { get; set; }
    }

    public partial class WebForm5 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string tempcourseId = Session["courseId"]?.ToString();
                LoadTutorData();

                // Check if the course ID is provided in the query string
                if (Request.QueryString["courseId"] != null)
                {
                    int courseId = Convert.ToInt32(Request.QueryString["courseId"]);
                    LoadCourseData(courseId);
                }
                else
                {
                    // Handle the case when course ID is not provided in the query string
                    // You may redirect or display an error message
                }
            }
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            // Set ReadOnly property to false for all TextBox controls
            SetTextBoxesEditable(true);

            // Toggle to edit mode
            ToggleEditMode(true);
        }

        private void SetTextBoxesEditable(bool editable)
        {
            // Enable or disable the TextBox controls based on the mode
            txtCourseName.ReadOnly = !editable;
            txtCourseCategory.ReadOnly = !editable;
            txtCourseContent.ReadOnly = !editable;
            txtCourseDescription.ReadOnly = !editable;
            txtCourseDuration.ReadOnly = !editable;
            txtCourseLanguage.ReadOnly = !editable;
            txtCourseLevel.ReadOnly = !editable;
            txtCoursePrice.ReadOnly = !editable;
            txtCourseRequirements.ReadOnly = !editable;
            txtCourseTargetAudience.ReadOnly = !editable;
            txtCourseTopic.ReadOnly = !editable;
        }

        private void ToggleEditMode(bool enableEdit)
        {
            // Show or hide the buttons based on the mode
            btnEdit.Visible = !enableEdit;
            deleteBtn.Visible = !enableEdit;
            btnUpdate.Visible = enableEdit;
            btnCancel.Visible = enableEdit;

            SetTextBoxesEditable(enableEdit);

            // Show or hide the FileUpload controls based on the mode
            fileUploadTrailer.Visible = enableEdit;
            fileUploadThumbnail.Visible = enableEdit;

            // If not in edit mode, clear the content of the FileUpload controls
            if (!enableEdit)
            {
                fileUploadTrailer.Attributes.Clear();
                fileUploadThumbnail.Attributes.Clear();
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            // Get the course ID from the query string
            int courseId = Convert.ToInt32(Request.QueryString["courseId"]);

            // Toggle back to read-only mode without saving changes
            ToggleEditMode(false);

            // Reload the original course data
            LoadCourseData(courseId);
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            Button updateButton = (Button)sender;
            int courseId = Convert.ToInt32(Request.QueryString["courseId"]);

            try
            {
                // Update the course details in the database
                UpdateCourse(courseId);

                // Toggle back to read-only mode after updating
                ToggleEditMode(false);

                // Reload the updated course data
                LoadCourseData(courseId);

                // Optionally, you can show a success message
                ScriptManager.RegisterStartupScript(this, GetType(), "updateAlert", "alert('Course updated successfully.');", true);
            }
            catch (Exception ex)
            {
                // Handle update failure if needed
                ScriptManager.RegisterStartupScript(this, GetType(), "updateAlert", "alert('Failed to update the course.');", true);

                // Log the exception to a log file or a logging framework
                LogException(ex);
            }
        }

        // Updated UpdateCourse method with exception handling
        private void UpdateCourse(int courseId)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    string query = @"
                    UPDATE Course
                    SET
                        course_name = @CourseName,
                        course_category = @CourseCategory,
                        course_level = @CourseLevel,
                        course_topic = @CourseTopic,
                        course_fee = @CoursePrice,
                        course_language = @CourseLanguage,
                        course_duration = @CourseDuration,
                        course_desc = @CourseDescription,
                        course_content = @CourseContent,
                        course_targetAudience = @CourseTargetAudience,
                        course_requirement = @CourseRequirements";

                    // Add parameters only if the corresponding file is uploaded
                    if (fileUploadThumbnail.HasFile)
                    {
                        query += ", course_pic = @CourseThumbnail";
                    }

                    if (fileUploadTrailer.HasFile)
                    {
                        query += ", course_video = @CourseTrailer";
                    }

                    query += " WHERE course_id = @CourseId";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@CourseId", courseId);
                        command.Parameters.AddWithValue("@CourseName", txtCourseName.Text);
                        command.Parameters.AddWithValue("@CourseCategory", txtCourseCategory.Text);
                        command.Parameters.AddWithValue("@CourseLevel", txtCourseLevel.Text);
                        command.Parameters.AddWithValue("@CourseTopic", txtCourseTopic.Text);
                        command.Parameters.AddWithValue("@CoursePrice", Convert.ToSingle(txtCoursePrice.Text));
                        command.Parameters.AddWithValue("@CourseLanguage", txtCourseLanguage.Text);
                        command.Parameters.AddWithValue("@CourseDuration", txtCourseDuration.Text);
                        command.Parameters.AddWithValue("@CourseDescription", txtCourseDescription.Text);
                        command.Parameters.AddWithValue("@CourseContent", txtCourseContent.Text);
                        command.Parameters.AddWithValue("@CourseTargetAudience", txtCourseTargetAudience.Text);
                        command.Parameters.AddWithValue("@CourseRequirements", txtCourseRequirements.Text);

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

                        int rowsAffected = command.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            // The update was successful
                        }
                        else
                        {
                            // The update failed
                            throw new Exception("Update failed. No rows affected.");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the exception to a log file or a logging framework
                LogException(ex);

                // Rethrow the exception to let it propagate
                throw;
            }
        }

        // Helper method to log exceptions
        private void LogException(Exception ex)
        {
            // Log the exception to a log file or a logging framework
            string logFilePath = Server.MapPath("~/App_Data/ErrorLog.txt");
            System.IO.File.AppendAllText(logFilePath, $"{DateTime.Now}: {ex.Message}\n");
        }

        protected void deleteBtn_Click(object sender, EventArgs e)
        {
            // Get the course ID from the button's data attribute
            Button deleteButton = (Button)sender;
            int courseId = Convert.ToInt32(Request.QueryString["courseId"]);
            int tempcourseId = int.Parse(Session["courseId"].ToString());
           
            // You can perform the delete operation here using the courseId 
            bool deletionSuccess = DeleteCourse(tempcourseId);

            if (deletionSuccess)
            {
                // Show a client-side alert if the deletion was successful
                ScriptManager.RegisterStartupScript(this, GetType(), "deleteAlert", "alert('Course deleted successfully.'); console.log('Redirection attempted'); window.location.href = 'MyCourses.aspx';", true);
            }
            else
            {
                // Handle deletion failure if needed
                ScriptManager.RegisterStartupScript(this, GetType(), "deleteAlert", "alert('Failed to delete the course.');", true);
            }
        }

        private bool DeleteCourse(int courseId)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    using (SqlTransaction transaction = connection.BeginTransaction())
                    {
                        try
                        {
                            string query = "DELETE FROM Course WHERE course_id = @CourseId";

                            using (SqlCommand command = new SqlCommand(query, connection, transaction))
                            {
                                command.Parameters.AddWithValue("@CourseId", courseId);

                                int rowsAffected = command.ExecuteNonQuery();

                                if (rowsAffected > 0)
                                {
                                    // Commit the transaction if the delete is successful
                                    transaction.Commit();

                                    // Return true to indicate success
                                    return true;
                                }
                                else
                                {
                                    // Rollback the transaction if no rows were affected
                                    transaction.Rollback();

                                    // Return false to indicate failure
                                    return false;
                                }
                            }
                        }
                        catch (Exception ex)
                        {
                            // Log the exception to a log file or a logging framework
                            string logFilePath = Server.MapPath("~/App_Data/ErrorLog.txt");
                            System.IO.File.AppendAllText(logFilePath, $"{DateTime.Now}: {ex.Message}\n");

                            // Rollback the transaction in case of an exception
                            transaction.Rollback();

                            // Rethrow the exception to let it propagate
                            return false;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the exception to a log file or a logging framework
                string logFilePath = Server.MapPath("~/App_Data/ErrorLog.txt");
                System.IO.File.AppendAllText(logFilePath, $"{DateTime.Now}: {ex.Message}\n");

                // Rethrow the exception to let it propagate
                throw;
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

            // Handle the case when the user is not logged in (return a default value or handle it accordingly)
            return -1; // You can choose an appropriate default value
        }

        private void LoadCourseData(int courseId)
        {
            CourseInfo course = GetCourseInformation(courseId);

            if (course != null)
            {
                // Display course information
                txtCourseName.Text = course.CourseName;
                txtCourseCategory.Text = course.CourseCategory;
                txtCourseLevel.Text = course.CourseLevel;
                txtCourseTopic.Text = course.CourseTopic;
                txtCoursePrice.Text = course.CoursePrice.ToString();
                txtCourseLanguage.Text = course.CourseLanguage;
                txtCourseDuration.Text = course.CourseDuration;
                txtCourseDescription.Text = course.CourseDescription;
                txtCourseContent.Text = course.CourseContent;
                txtCourseTargetAudience.Text = course.CourseTargetAudience;
                txtCourseRequirements.Text = course.CourseRequirements;

               // Display the thumbnail image
                byte[] thumbnailBytes = course.CourseThumbnail;
                string thumbnailBase64 = Convert.ToBase64String(thumbnailBytes);
                imgCourseThumbnail.ImageUrl = "data:image/jpeg;base64," + thumbnailBase64;

                // Display the trailer video
                byte[] trailerBytes = course.CourseTrailer;
                string trailerBase64 = Convert.ToBase64String(trailerBytes)
                           .Replace("\r\n", string.Empty)
                           .Replace(" ", string.Empty);
                iframeCourseTrailer.Attributes["src"] = "data:video/mp4;base64," + trailerBase64;
            }
            else
            {
                // Handle the case where course information is not found
                // You may redirect or display an error message
            }
        }

        private CourseInfo GetCourseInformation(int courseId)
        {
            CourseInfo course = new CourseInfo();

            string connectionString = WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "SELECT course_id, course_name, course_category, course_level, course_topic, course_fee, course_language, course_duration, course_desc, course_overview, course_targetAudience, course_requirement, course_pic, course_video FROM Course WHERE course_id = @courseId";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@courseId", courseId);
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            course.CourseId = (int)reader["course_id"];
                            course.CourseName = reader["course_name"].ToString();
                            course.CourseCategory = reader["course_category"].ToString();
                            course.CourseLevel = reader["course_level"].ToString();
                            course.CourseTopic = reader["course_topic"].ToString();
                            // Handle DBNull for course_fee
                            if (reader["course_fee"] != DBNull.Value)
                            {
                                course.CoursePrice = Convert.ToSingle(reader["course_fee"]);
                            }
                            course.CourseLanguage = reader["course_language"].ToString();
                            course.CourseDuration = reader["course_duration"].ToString();
                            course.CourseDescription = reader["course_desc"].ToString();
                            course.CourseContent = reader["course_overview"].ToString();
                            course.CourseTargetAudience = reader["course_targetAudience"].ToString();
                            course.CourseRequirements = reader["course_requirement"].ToString();
                            course.CourseThumbnail = (byte[])reader["course_pic"];
                            course.CourseTrailer = (byte[])reader["course_video"];
                        }
                    }
                }
            }

            return course;
        }
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
}