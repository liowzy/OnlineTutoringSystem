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