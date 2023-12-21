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

namespace OnlineTutoringSystem.Student.ViewTutor
{
    public partial class WebForm4 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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
         



    }
}