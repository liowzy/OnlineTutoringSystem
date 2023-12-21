using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineTutoringSystem.Tutor
{
    public partial class WebForm6 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int tutorId = LoadTutorData(); // Assuming you have a method to get the tutor ID

                // Bind the GridView with data
                GridViewCourseDetails.DataBind();

                // Check if there are rows in the GridView
                if (GridViewCourseDetails.Rows.Count == 0)
                {
                    lblNoCourse.Visible = true;
                }
                else
                {
                    lblNoCourse.Visible = false;
                }
            }
        }

        private int LoadTutorData()
        {
            // Get the tutor ID directly from the session
            int tutorId = GetTutorId();

            // If you need to use the tutorId elsewhere, you can store it in a variable or property
            // Example: int currentTutorId = tutorId;

            // Note: If you don't need to use the tutorId elsewhere, you can directly use it in ExecuteSearch and ExecuteCategory
            return tutorId;
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

        protected void Unnamed_Click(object sender, EventArgs e)
        {
            GridViewRow row = (GridViewRow)((Button)sender).NamingContainer;
            if (row.RowIndex >= 0 && row.RowIndex < GridViewCourseDetails.Rows.Count)
            {
                // Get the course_id from the data keys
                int courseId = Convert.ToInt32(GridViewCourseDetails.DataKeys[row.RowIndex].Values["course_id"]);

                // Set the course_id in the session
                Session["SelectedCourseId"] = courseId;
                Response.Redirect("UploadFile.aspx");
            }
        }
    }
}