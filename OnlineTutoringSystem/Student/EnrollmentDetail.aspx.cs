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

namespace OnlineTutoringSystem
{
    public partial class WebForm8 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPurchasedCourseData();
                //LoadData();
            }
        }

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
