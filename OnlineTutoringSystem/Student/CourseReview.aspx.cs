using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineTutoringSystem.Student
{
    public partial class WebForm4 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["courseId"] != null)
            {
                int courseId = int.Parse(Session["courseId"].ToString());
                if (SqlDataSourceReviews.Select(DataSourceSelectArguments.Empty) == null || SqlDataSourceReviews.Select(DataSourceSelectArguments.Empty).GetEnumerator().MoveNext() == false)
                {
                    // No reviews, make the Checkwl label visible
                    Checkwl.Visible = true;
                }
                else
                {
                    // Reviews exist, make the Checkwl label invisible
                    Checkwl.Visible = false;
                }
            }
            else
            {
                Response.Redirect("../HomePage.aspx");
            }
        }
    }
}