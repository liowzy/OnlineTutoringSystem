using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Configuration;
using System.Web.UI.WebControls;

namespace OnlineTutoringSystem
{
    public partial class WebForm8 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["course_id"] != null)
            {
                int courseId = Convert.ToInt32(Session["course_id"]);

                // Load data into the ParentDataList
                LoadParentData(courseId);
            }
            else
            {
                // Handle the case when course_id is not available in the session
                // You might want to redirect the user or display an error message
            }
        }

        private void LoadParentData(int courseId)
        {
            // Connection string from Web.config
            string connectionString = WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            // SQL query to retrieve data based on course_id
            string query = "SELECT * FROM Resource WHERE course_id = @CourseId";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter(query, connection))
                {
                    // Add parameters
                    adapter.SelectCommand.Parameters.AddWithValue("@CourseId", courseId);

                    DataTable dt = new DataTable();
                    adapter.Fill(dt);

                    // Bind data to ParentDataList
                    ParentDataList.DataSource = dt;
                    ParentDataList.DataBind();
                }
            }
        }


        protected void ParentDataList_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView drv = e.Item.DataItem as DataRowView;

                if (drv != null)
                {
                    // Get the res_id for the current resource
                    int resId = Convert.ToInt32(drv["res_id"]);

                    // Retrieve files for the current resource
                    DataTable filesTable = GetFilesForResId(resId);

                    // Find the ChildDataList in the current DataListItem
                    DataList childDataList = e.Item.FindControl("ChildDataList") as DataList;

                    // Bind files to ChildDataList
                    childDataList.DataSource = filesTable;
                    childDataList.DataBind();
                }
            }
        }

        private DataTable GetFilesForResId(int resId)
        {
            // Connection string from Web.config
            string connectionString = WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            // SQL query to retrieve files for the given res_id
            string query = "SELECT file_id, file_name, file_path, res_id FROM File_Attachment WHERE res_id = @ResId";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Add parameters
                    command.Parameters.AddWithValue("@ResId", resId);

                    // Create a DataTable to store the result
                    DataTable filesTable = new DataTable();

                    // Open the connection and execute the query
                    connection.Open();

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        // Load the result into the DataTable
                        filesTable.Load(reader);
                    }

                    return filesTable;
                }
            }
        }

        protected void btnRateTutorAndCourse_Click(object sender, EventArgs e)
        { 
            Response.Redirect("Rating.aspx");
        }
    }
}
