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

            }
        }
         
            private byte[] HexStringToByteArray(string hexString)
        {
            // Convert a hex string to a byte array
            return Enumerable.Range(0, hexString.Length)
                             .Where(x => x % 2 == 0)
                             .Select(x => Convert.ToByte(hexString.Substring(x, 2), 16))
                             .ToArray();
        } 

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblResourceName = (Label)e.Row.FindControl("lblResourceName");
                string currentResourceName = DataBinder.Eval(e.Row.DataItem, "res_name").ToString();

                if (lblResourceName != null && !string.IsNullOrEmpty(currentResourceName))
                {
                    // Check if the resource name has changed since the last row
                    if (lblResourceName.Text != currentResourceName)
                    {
                        lblResourceName.Text = currentResourceName;
                        lblResourceName.Visible = true;
                        e.Row.CssClass = "newResourceRow";  
                    }
                    else
                    { 
                        e.Row.CssClass = "sameResourceRow";  
                    }
                }
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
                    string query = "SELECT pc.purchase_id, pc.purchase_date, c.course_name," +
                        " t.tutor_name, c.course_pic, r.res_id, r.res_name, f.file_id, f.file_name, f.file_path " +
                        "FROM PurchasedCourse pc INNER JOIN Course c ON pc.course_id = c.course_id INNER JOIN Tutor t" +
                        " ON c.tutor_id = t.tutor_id LEFT JOIN Resource r ON c.course_id = r.course_id LEFT JOIN File_Attachment f " +
                        "ON r.res_id = f.res_id WHERE c.course_id = @courseId";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@courseId", courseId);

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                // Process course information
                                lblCourseName.Text = reader["course_name"].ToString();
                                lblTutorName.Text = reader["tutor_name"].ToString();
                                lblPurchasedDate.Text = Convert.ToDateTime(reader["purchase_date"]).ToString("dd-MM-yyyy");

                                if (reader["course_pic"] != DBNull.Value)
                                {
                                    byte[] imageData = (byte[])reader["course_pic"];
                                    string base64String = Convert.ToBase64String(imageData);
                                    imgCourse.ImageUrl = "data:image/png;base64," + base64String;
                                }

                                // Process resource information
                                if (reader["res_id"] != DBNull.Value)
                                {
                                    int resourceId = Convert.ToInt32(reader["res_id"]);
                                    string resourceName = reader["res_name"].ToString(); 
                                }

                                // Process file information
                                if (reader["file_id"] != DBNull.Value)
                                {
                                    int fileId = Convert.ToInt32(reader["file_id"]);
                                    string fileName = reader["file_name"].ToString();
                                    string filePath = reader["file_path"].ToString(); 
                                }
                            }
                        }
                    }
                }
            }
            else
            {
                // Handle the case where courseId is not found in the session
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Please login again.", true);
            }
        }

         

        protected void btnRateTutorAndCourse_Click(object sender, EventArgs e)
        { 
            Response.Redirect("Rating.aspx");
        }

        protected void btnOpen_Click(object sender, EventArgs e)
        {
            // Get the file_id from the clicked button
            Button btn = (Button)sender;
            string fileId = btn.CommandArgument;

            Session["SelectedFileId"] = fileId;
            // Redirect to WebForm51.aspx with the file_id as a query parameter
            Response.Redirect("WebForm51.aspx");
        }
    }
}
