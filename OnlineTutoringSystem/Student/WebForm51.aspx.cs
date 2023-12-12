using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;

namespace OnlineTutoringSystem.Student
{
    public partial class WebForm51 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindPdfPaths();
            }
        }
        protected void BindPdfPaths()
        {
            List<string> pdfPaths = GetPdfPathsFromDatabase(); // Implement this method to get a collection of PDF paths
            rptFiles.DataSource = pdfPaths;
            rptFiles.DataBind();
        }
        protected List<string> GetPdfPathsFromDatabase()
        {
            List<string> pdfPaths = new List<string>();

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            { 
                    int fileId = int.Parse(Session["SelectedFileId"].ToString()); 

                string query = "SELECT file_path FROM File_Attachment WHERE file_id = @FileId";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@FileId", fileId);

                    try
                    {
                        connection.Open();
                        byte[] result = command.ExecuteScalar() as byte[];

                        if (result != null)
                        {
                            // Convert the byte array to a base64 string for embedding in the iframe
                            pdfPaths.Add(Convert.ToBase64String(result));
                        }
                    }
                    catch (Exception ex)
                    {
                        // Handle the exception, log it, or display an error message
                        // For example:
                        Console.WriteLine("Error: " + ex.Message);
                    }
                }
            }

            return pdfPaths;
        }
    }
}