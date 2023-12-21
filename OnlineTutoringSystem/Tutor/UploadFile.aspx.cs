using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace OnlineTutoringSystem.Tutor
{
    public partial class WebForm7 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                // Check if the session variable is available
                if (Session["SelectedCourseId"] != null)
                {
                    int selectedCourseId = (int)Session["SelectedCourseId"];

                    List<Resource> resources = FetchResourcesForCourse(selectedCourseId);

                    // Set the resources to ViewState
                    ViewState["Resources"] = resources;

                    BindGridView();
                }
            }
        }
        private List<Resource> FetchResourcesForCourse(int courseId)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ToString();

            // SQL query to fetch resources based on the course ID
            string query = "SELECT r.res_id, r.res_name, f.file_id, f.file_name, f.file_path " +
                           "FROM Resource r " +
                           "LEFT JOIN File_Attachment f ON r.res_id = f.res_id " +
                           "WHERE r.course_id = @CourseId";

            List<Resource> resources = new List<Resource>();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Add parameters
                    command.Parameters.AddWithValue("@CourseId", courseId);

                    // Open the connection
                    connection.Open();

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            // Create Resource object and populate it with data from the database
                            Resource resource = new Resource
                            {
                                ResId = (int)reader["res_id"],
                                ResourceName = (string)reader["res_name"],
                                FileId = reader["file_id"] != DBNull.Value ? (int)reader["file_id"] : 0,
                                FileName = reader["file_name"] != DBNull.Value ? (string)reader["file_name"] : string.Empty,
                                FilePath = reader["file_path"] != DBNull.Value ? (byte[])reader["file_path"] : null
                            };

                            // Add the resource to the list
                            resources.Add(resource);
                        }
                    }
                }
            }

            return resources;
        }
        protected void btnAddResource_Click(object sender, EventArgs e)
        {
            int selectedCourseId = (int)Session["SelectedCourseId"];
            // Retrieve data from the fields
            string resourceName = txtResourceName.Text;
            string fileName = txtFileName.Text;
            byte[] fileData = fileUpload.FileBytes;

            // Assuming you have a connection string in your web.config
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ToString();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Insert into Resource table
                string insertResourceQuery = "INSERT INTO Resource (res_name, course_id) VALUES (@ResourceName, @CourseId); SELECT SCOPE_IDENTITY();";
                SqlCommand insertResourceCommand = new SqlCommand(insertResourceQuery, connection);
                insertResourceCommand.Parameters.AddWithValue("@ResourceName", resourceName);
                insertResourceCommand.Parameters.AddWithValue("@CourseId", selectedCourseId);

                int resId;
                if (Session["SelectedResId"] != null)
                {
                    resId = (int)Session["SelectedResId"];
                    Session.Remove("SelectedResId");
                }
                else
                {
                    // Execute the insert and get the newly inserted res_id
                    resId = Convert.ToInt32(insertResourceCommand.ExecuteScalar());
                }

                // Insert into File_Attachment table
                string insertFileQuery = "INSERT INTO File_Attachment (file_name, file_path, res_id) VALUES (@FileName, @FilePath, @ResId)";
                SqlCommand insertFileCommand = new SqlCommand(insertFileQuery, connection);
                insertFileCommand.Parameters.AddWithValue("@FileName", fileName);
                insertFileCommand.Parameters.AddWithValue("@FilePath", fileData);
                insertFileCommand.Parameters.AddWithValue("@ResId", resId);

                // Execute the insert into File_Attachment
                insertFileCommand.ExecuteNonQuery();

                // Close the connection
                connection.Close();
            }

            // Refresh the GridView or perform any other necessary tasks 

            Response.Redirect("UploadFile.aspx");
        }

        private void BindGridView()
        {
            int selectedCourseId = (int)Session["SelectedCourseId"];
            List<Resource> resources = ViewState["Resources"] as List<Resource> ?? new List<Resource>();

            // Check if there are no resources
            if (resources.Count == 0)
            {
                // Add a dummy resource with [no file] text
                resources.Add(new Resource
                {
                    ResId = -1,  // Use a unique identifier for dummy resource
                    ResourceName = "[no file]",
                    FileName = "[no file]",
                    FilePath = null
                });

                // Hide the "Delete" and "Add More File" buttons
                GridViewResource.Columns[2].Visible = false;  // Assuming the index 2 corresponds to the "Actions" column

                // Display a message in a label
                lblNoResourcesMessage.Visible = true;
                lblNoResourcesMessage.Text = "Please add a resource first";
            }
            else
            {
                // Show the "Delete" and "Add More File" buttons
                GridViewResource.Columns[2].Visible = true;

                // Hide the message label
                lblNoResourcesMessage.Visible = false;
                lblNoResourcesMessage.Text = string.Empty;
            }

            ViewState["Resources"] = resources;

            // Retrieve the data from the database and set it as the DataSource
            GridViewResource.DataSource = resources;
            GridViewResource.DataBind();
            ClearFormFields();
        }


        protected void GridViewResource_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteFile")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                List<Resource> resources = ViewState["Resources"] as List<Resource>;

                if (resources != null && rowIndex >= 0 && rowIndex < resources.Count)
                {
                    int resId = resources[rowIndex].ResId;

                    // Delete the resource and file from the database
                    DeleteResourceAndFile(resId);

                    // Remove the resource from the list
                    resources.RemoveAt(rowIndex);

                    // Update ViewState and rebind GridView
                    ViewState["Resources"] = resources;
                    BindGridView();
                }
            }
            else if (e.CommandName == "AddMoreFile")
            {
                // Store the selected res_id in a session variable
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = GridViewResource.Rows[rowIndex];
                int selectedResId = Convert.ToInt32(GridViewResource.DataKeys[rowIndex].Value);
                Session["SelectedResId"] = selectedResId;
            }
        }

        private void DeleteResourceAndFile(int resId)
        {
            // Implement the logic to delete the resource and file from the database
            // Use the provided resId to identify the resource to delete
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ToString();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Delete from File_Attachment table
                string deleteFileQuery = "DELETE FROM File_Attachment WHERE res_id = @ResId";
                SqlCommand deleteFileCommand = new SqlCommand(deleteFileQuery, connection);
                deleteFileCommand.Parameters.AddWithValue("@ResId", resId);
                deleteFileCommand.ExecuteNonQuery();

                // Delete from Resource table
                string deleteResourceQuery = "DELETE FROM Resource WHERE res_id = @ResId";
                SqlCommand deleteResourceCommand = new SqlCommand(deleteResourceQuery, connection);
                deleteResourceCommand.Parameters.AddWithValue("@ResId", resId);
                deleteResourceCommand.ExecuteNonQuery();

                // Close the connection
                connection.Close();
            }
        }


        protected void btnAddMore_Click(object sender, EventArgs e)
        {
            int rowIndex = Convert.ToInt32(((Button)sender).CommandArgument);

            // Access the GridView row
            GridViewRow row = GridViewResource.Rows[rowIndex];

            // Check if the control is found before accessing it
            Label lblResourceName = row.FindControl("lblResourceName") as Label;
            if (lblResourceName != null)
            {
                string resourceName = lblResourceName.Text;
                txtResourceName.Text = resourceName;
                txtResourceName.Enabled = false;
            }
        }

        private void ClearFormFields()
        {
            // Clear form fields after adding a resource
            // Clear and enable the input fields outside of the GridView
            txtResourceName.Text = string.Empty;
            txtResourceName.Enabled = true;

            txtFileName.Text = string.Empty;

            fileUpload.Attributes.Clear();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
           
            Response.Redirect("ResourceManagement.aspx");
        }

        [Serializable]
        public class Resource
        {
            public int ResId { get; set; }
            public string ResourceName { get; set; }
            public string FileName { get; set; }
            public byte[] FileData { get; set; }
            public int FileId { get; set; }
            public byte[] FilePath { get; set; }
        }


    }
}