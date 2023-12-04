using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI.WebControls;

namespace OnlineTutoringSystem
{
    public partial class AddResourceFile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
         

        private int InsertResource(string resourceName, int courseId)
        {
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("INSERT INTO Resource (res_name, course_id) VALUES (@ResourceName, @CourseId); SELECT SCOPE_IDENTITY();", connection))
                {
                    cmd.Parameters.AddWithValue("@ResourceName", resourceName);
                    cmd.Parameters.AddWithValue("@CourseId", courseId);

                    // ExecuteScalar to get the newly inserted resource ID
                    return Convert.ToInt32(cmd.ExecuteScalar());
                }
            }
        }

        private byte[] GetFileContent(HttpPostedFile postedFile)
        {
            using (BinaryReader reader = new BinaryReader(postedFile.InputStream))
            {
                return reader.ReadBytes(postedFile.ContentLength);
            }
        }

        private void InsertFileAttachment(string fileName, byte[] fileContent, int resourceId)
        {
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                connection.Open();
                using (SqlCommand cmd = new SqlCommand("INSERT INTO File_Attachment (file_name, file_path, res_id) VALUES (@FileName, @FileContent, @ResourceId);", connection))
                {
                    cmd.Parameters.AddWithValue("@FileName", fileName);
                    cmd.Parameters.AddWithValue("@FileContent", fileContent);
                    cmd.Parameters.AddWithValue("@ResourceId", resourceId);

                    cmd.ExecuteNonQuery();
                }
            }
        }

        protected void Submit_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtResourceName.Text) && fileUpload.HasFile && !string.IsNullOrEmpty(txtCourseId.Text))
            {
                try
                {
                    // Get the input values
                    string resourceName = txtResourceName.Text;
                    int courseId = Convert.ToInt32(txtCourseId.Text);

                    // Save the file content as binary data
                    byte[] fileContent = GetFileContent(fileUpload.PostedFile);

                    // Insert into the Resource table and get the resource ID
                    int resourceId = InsertResource(resourceName, courseId);

                    // Insert into the File_Attachment table using the obtained resource ID
                    InsertFileAttachment(fileUpload.FileName, fileContent, resourceId);

                    // Display success message or redirect to another page
                    Response.Write("Resource and file attachment added successfully!");
                }
                catch (Exception ex)
                {
                    // Handle exceptions (e.g., display an error message)
                    // You may want to log the exception for debugging purposes
                    Response.Write("An error occurred: " + ex.Message);
                }
            }
            else
            {
                Response.Write("Please fill in all the required fields.");
            }
        }
    }
} 
