﻿using System;
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

        protected void editBtn_Command(object sender, CommandEventArgs e)
        {
            int courseId = Convert.ToInt32(e.CommandArgument);
            // Redirect to the edit page with the course ID in the query string
            Response.Redirect($"EditCourse.aspx?courseId={courseId}");
        }

        protected void btnDeleteModal_Click(object sender, EventArgs e)
        {
            // This is the server-side click event of the Delete button
            if (int.TryParse(hdnCourseIdModal.Value, out int courseId))
            {
                // Call a method to delete the course
                DeleteCourse(courseId);

                // Register a script to perform the redirection using JavaScript
                string redirectScript = "window.location.href = 'MyCourses.aspx';";
                ClientScript.RegisterStartupScript(this.GetType(), "RedirectScript", redirectScript, true);
            }
            else
            {
                // Handle the case where the value is not a valid integer
                // You can display an error message or take appropriate action
                // For example:
                lblMessage.Text = "Invalid course ID format.";
            }
        }


        private void DeleteCourse(int courseId)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    // Assuming the column name for the primary key is 'course_id'
                    string query = "DELETE FROM Course WHERE course_id = @courseId";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@courseId", courseId);

                        // Execute the delete operation
                        int rowsAffected = command.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            // Course deleted successfully
                            // Set a success message
                            lblMessage.Text = "Course deleted successfully.";
                        }
                        else
                        {
                            // Handle the case where no rows were affected (course not found or delete failed)
                            // Set an error message
                            lblMessage.Text = "Course not found or delete failed.";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the exception to a log file
                string logFilePath = Server.MapPath("~/App_Data/ErrorLog.txt");
                System.IO.File.AppendAllText(logFilePath, $"{DateTime.Now}: {ex.Message}\n");

                // Rethrow the exception to let it propagate (optional)
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
                lblCourseName.Text = course.CourseName;
                lblCourseCategory.Text = course.CourseCategory;
                lblCourseLevel.Text = course.CourseLevel;
                lblCourseTopic.Text = course.CourseTopic;
                lblCoursePrice.Text = course.CoursePrice.ToString();
                lblCourseLanguage.Text = course.CourseLanguage;
                lblCourseDuration.Text = course.CourseDuration;
                lblCourseDescription.Text = course.CourseDescription;
                lblCourseContent.Text = course.CourseContent;
                lblCourseTargetAudience.Text = course.CourseTargetAudience;
                lblCourseRequirements.Text = course.CourseRequirements;

                // Display the thumbnail image
                byte[] thumbnailBytes = course.CourseThumbnail;
                string thumbnailBase64 = Convert.ToBase64String(thumbnailBytes);
                imgCourseThumbnail.Src = "data:image/jpeg;base64," + thumbnailBase64;

                // Display the trailer video
                byte[] trailerBytes = course.CourseTrailer;
                string trailerBase64 = Convert.ToBase64String(trailerBytes);
                iframeCourseTrailer.Src = "data:video/mp4;base64," + trailerBase64;
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

                string query = "SELECT course_id, course_name, course_category, course_level, course_topic, course_fee, course_language, course_duration, course_desc, course_content, course_targetAudience, course_requirement, course_pic, course_video FROM Course WHERE course_id = @courseId";

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
                            course.CourseContent = reader["course_content"].ToString();
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