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

namespace OnlineTutoringSystem
{
    public partial class WebForm12 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Get the file ID from the query string or another source
                if (int.TryParse(Request.QueryString["fileId"], out int fileId))
                {
                    // Retrieve file data from the database based on the file ID
                    byte[] fileData = GetFileDataFromDatabase(fileId);

                    if (fileData != null)
                    {
                        // Set response headers for file download
                        Response.Clear();
                        Response.ContentType = "application/pdf";
                        Response.AddHeader("content-disposition", "attachment;filename=download.pdf");
                        Response.BinaryWrite(fileData);
                        Response.End();
                    }
                    else
                    {
                        // Handle the case where the file data is not found
                        Response.Write("File not found");
                        Response.End();
                    }
                }
                else
                {
                    // Handle the case where the file ID is not a valid integer
                    Response.Write("Invalid file ID");
                    Response.End();
                }
            }
        }

        private byte[] GetFileDataFromDatabase(int fileId)
        {
            // Implement code to retrieve file data from the database based on the file ID
            // Use your database access logic here
            // Example: SELECT file_path FROM File_Attachment WHERE file_id = @FileId

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            // Replace this with your database logic
            byte[] fileData = null;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = "SELECT file_path FROM File_Attachment WHERE file_id = @FileId";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@FileId", fileId);
                    fileData = command.ExecuteScalar() as byte[];
                }
            }

            return fileData;
        }

    }
}