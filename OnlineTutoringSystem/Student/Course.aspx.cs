using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineTutoringSystem
{
    public partial class WebForm5 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                // Check if the search term is present in the query string
                if (Request.QueryString["searchTerm"] != null)
                {
                    string searchTerm = Server.UrlDecode(Request.QueryString["searchTerm"]);

                    // Perform the search using the retrieved searchTerm
                    ExecuteSearch(searchTerm);
                }
            }
        }
        protected string GetCardColor(int index)
        {
            string[] colors = { "#EBEBFF", "#E1F7E3", "#FFF2E5", "#FFF0F0", "#F5F7FA" };
            return colors[index % colors.Length];
        }
        private void ExecuteSearch(string searchTerm)
        {
            SqlDataSourceCourses.SelectCommand = "SELECT c.course_id, c.course_pic, c.course_name, c.course_fee, cat.cat_name " +
                                         "FROM Course c " +
                                         "JOIN Category cat ON c.cat_id = cat.cat_id " +
                                         "WHERE c.course_name LIKE @SearchTerm " +
                                         "ORDER BY c.course_id ASC";

            // Clear existing parameters and add the new search parameter
            SqlDataSourceCourses.SelectParameters.Clear();
            SqlDataSourceCourses.SelectParameters.Add("SearchTerm", "%" + searchTerm + "%");

            // Bind the data to the DataListCourses
            DataListCourses.DataSourceID = "SqlDataSourceCourses";
            DataListCourses.DataBind();
        }


    }
}