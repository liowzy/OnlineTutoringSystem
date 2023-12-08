using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.IO;
using EllipticCurve.Utils;

namespace OnlineTutoringSystem
{
    public partial class WebForm8 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int courseId = int.Parse(Session["courseId"].ToString());
                LoadPurchasedCourseData();
                //LoadData(); 
                DataTable resourceData = GetResourceData(courseId);
                DataTable fileData = GetFileData(courseId);

                // Merge the resource and file data into a single DataTable
                //DataTable combinedData = MergeDataTables(resourceData, fileData);
                //CombinedDataList.DataSource = combinedData;
                //CombinedDataList.DataBind();


            }
        }


        private DataTable GetResourceData(int courseId)
        { 
            DataTable resourceData = new DataTable();
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("SELECT * FROM Resource WHERE course_id = @CourseID", connection))
                {
                    command.Parameters.AddWithValue("@CourseID", courseId);
                    using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                    {
                        adapter.Fill(resourceData);
                    }
                }
            }

            return resourceData;
        }

        private DataTable GetFileData(int courseId)
        { 
            DataTable fileData = new DataTable();
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("SELECT * FROM File_Attachment WHERE res_id IN (SELECT res_id FROM Resource WHERE course_id = @CourseID)", connection))
                {
                    command.Parameters.AddWithValue("@CourseID", courseId);
                    using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                    {
                        adapter.Fill(fileData);
                    }
                }
            }

            return fileData;
        }

        private DataTable MergeDataTables(DataTable resourceData, DataTable fileData)
        {
            DataTable mergedData = new DataTable();
            mergedData.Columns.Add("res_name", typeof(string));
            mergedData.Columns.Add("file_name", typeof(string));
            mergedData.Columns.Add("file_path", typeof(string));

            foreach (DataRow resourceRow in resourceData.Rows)
            {
                DataRow mergedRow = mergedData.NewRow();
                mergedRow["res_name"] = resourceRow["res_name"];

                // Find files associated with the current resource
                DataRow[] fileRows = fileData.Select($"res_id = {resourceRow["res_id"]}");
                foreach (DataRow fileRow in fileRows)
                {
                    mergedRow["file_name"] = fileRow["file_name"];
                    mergedRow["file_path"] = fileRow["file_path"];
                    mergedData.Rows.Add(mergedRow.ItemArray);
                }
            }

            return mergedData;
        }

        //protected void CombinedDataList_ItemCommand(object source, DataListCommandEventArgs e)
        //{
        //    if (e.CommandName == "DownloadFile")
        //    {
        //        string filePath = e.CommandArgument.ToString();
        //        DownloadFile(filePath);
        //    }
        //}

        //private void DownloadFile(string filePath)
        //{
        //    // Replace this with the actual path to your file directory on the server
        //    string fileDirectory = Server.MapPath("~/Files/");

        //    // Combine the directory and file path
        //    string fullFilePath = Path.Combine(fileDirectory, filePath);

        //    // Check if the file exists
        //    if (File.Exists(fullFilePath))
        //    {
        //        // Set the content type and headers for the response
        //        Response.ContentType = "application/octet-stream";
        //        Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(fullFilePath));
        //        Response.TransmitFile(fullFilePath);
        //        Response.End();
        //    }
        //    else
        //    {
        //        // File not found, handle the error (display a message or redirect, for example)
        //        Response.Write("File not found!");
        //    }
        //}



        private void LoadPurchasedCourseData()
        {
            if (Session["courseId"] != null)
            {
                int courseId = Convert.ToInt32(Session["courseId"]);
                string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    string query = "SELECT pc.purchase_id, pc.purchase_date, c.course_name, t.tutor_name, c.course_pic " +
                               "FROM PurchasedCourse pc " +
                               "INNER JOIN Course c ON pc.course_id = c.course_id " +
                               "INNER JOIN Tutor t ON c.tutor_id = t.tutor_id " +
                               "WHERE c.course_id = @courseId";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@courseId", courseId);

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                lblCourseName.Text = reader["course_name"].ToString();
                                lblTutorName.Text = reader["tutor_name"].ToString();
                                lblPurchasedDate.Text = Convert.ToDateTime(reader["purchase_date"]).ToString("dd-MM-yyyy");
                                 
                                if (reader["course_pic"] != DBNull.Value)
                                {
                                    byte[] imageData = (byte[])reader["course_pic"];
                                    string base64String = Convert.ToBase64String(imageData);
                                    imgCourse.ImageUrl = "data:image/png;base64," + base64String;
                                }
                            }
                        }
                    }
                }
            }
            else
            {
                // Handle the case where courseId is not found in the session
            }
        }

         

        protected void btnRateTutorAndCourse_Click(object sender, EventArgs e)
        { 
            Response.Redirect("Rating.aspx");
        }

        //protected void lnkDownload_Click(object sender, EventArgs e)
        //{
        //    LinkButton lnkDownload = (LinkButton)sender;
        //    int fileId = Convert.ToInt32(lnkDownload.CommandArgument);

        //    byte[] fileData;
        //    string fileName;

        //    string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        //    using (SqlConnection connection = new SqlConnection(connectionString))
        //    {
        //        connection.Open();

        //        using (SqlCommand command = new SqlCommand("SELECT file_name, file_data FROM File_Attachment WHERE file_id = @FileId", connection))
        //        {
        //            command.Parameters.AddWithValue("@FileId", fileId);

        //            using (SqlDataReader reader = command.ExecuteReader())
        //            {
        //                if (reader.Read())
        //                {
        //                    fileName = reader["file_name"].ToString();
        //                    fileData = (byte[])reader["file_data"];
        //                }
        //                else
        //                {
        //                    // Handle the case where the file with the specified ID is not found
        //                    Response.Write("File not found in the database!");
        //                    return;
        //                }
        //            }
        //        }
        //    }

        //    // Send the file to the client browser for download
        //    Response.ContentType = "application/octet-stream";
        //    Response.AppendHeader("Content-Disposition", "attachment; filename=" + fileName);
        //    Response.BinaryWrite(fileData);
        //    Response.End();
        //}


        //file retrive
        //private void LoadData()
        //{
        //    // Assuming you have a method to get your data, replace this with your actual logic
        //    List<Resource> resources = GetData();

        //    ParentDataList.DataSource = resources;
        //    ParentDataList.DataBind();
        //}

        //// Replace this with your actual data retrieval logic
        //private List<Resource> GetData()
        //{
        //    List<Resource> resources = new List<Resource>();

        //    string connectionString = ConfigurationManager.ConnectionStrings["YourConnectionString"].ConnectionString;
        //    using (SqlConnection connection = new SqlConnection(connectionString))
        //    {
        //        connection.Open();
        //        string query = "SELECT res.res_id, res.res_name, fa.file_name, fa.file_path " +
        //                       "FROM Resource res " +
        //                       "LEFT JOIN File_Attachment fa ON res.res_id = fa.res_id " +
        //                       "ORDER BY res.res_id, fa.file_id";

        //        using (SqlCommand command = new SqlCommand(query, connection))
        //        {
        //            using (SqlDataReader reader = command.ExecuteReader())
        //            {
        //                Resource currentResource = null;
        //                while (reader.Read())
        //                {
        //                    int resourceId = Convert.ToInt32(reader["res_id"]);
        //                    string resourceName = reader["res_name"].ToString();

        //                    if (currentResource == null || currentResource.ResId != resourceId)
        //                    {
        //                        currentResource = new Resource
        //                        {
        //                            ResId = resourceId,
        //                            ResName = resourceName,
        //                            Files = new List<FileData>()
        //                        };

        //                        resources.Add(currentResource);
        //                    }

        //                    if (reader["file_name"] != DBNull.Value)
        //                    {
        //                        currentResource.Files.Add(new FileData
        //                        {
        //                            FileName = reader["file_name"].ToString(),
        //                            FilePath = reader["file_path"].ToString()
        //                        });
        //                    }
        //                }
        //            }
        //        }
        //    }

        //    return resources;
        //}
    }
}
