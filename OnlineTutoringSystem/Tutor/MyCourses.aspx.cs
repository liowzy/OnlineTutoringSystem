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
using static System.Windows.Forms.VisualStyles.VisualStyleElement.Rebar;

namespace OnlineTutoringSystem.Tutor
{
    public partial class WebForm4 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Load tutor data and get the tutorId
                int tutorId = LoadTutorData();

                // Check if the search term is present in the query string
                if (Request.QueryString["searchTerm"] != null)
                {
                    string searchTerm = Server.UrlDecode(Request.QueryString["searchTerm"]);

                    // Perform the search using the retrieved searchTerm and the tutor's ID
                    ExecuteSearch(searchTerm, tutorId);
                }
                // Check if the category is present in the query string
                else if (Request.QueryString["category"] != null)
                {
                    string selectedCategory = Server.UrlDecode(Request.QueryString["category"]);

                    // Perform the category filter using the retrieved category
                    ExecuteCategory(selectedCategory, tutorId);
                }
                // Check if the rating is present in the query string
                else if (Request.QueryString["rating"] != null)
                {
                    string rating = Server.UrlDecode(Request.QueryString["rating"]);

                    // Perform the rating filter using the retrieved rating
                    ExecuteRating(rating, tutorId);
                }

                // Populate the course category dropdown on page load
                PopulateCourseCategoryDropdown();
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


        private void PopulateCourseCategoryDropdown()
        {
            YourDataAccessLayer dataAccess = new YourDataAccessLayer();
            DataTable dtCategories = dataAccess.GetCourseCategories();


            // Create a new row for "All Categories"
            DataRow allCategoriesRow = dtCategories.NewRow();
            allCategoriesRow["cat_id"] = DBNull.Value; // Assuming cat_id is nullable
            allCategoriesRow["cat_name"] = "All Categories";

            // Add the "All Categories" row to the DataTable
            dtCategories.Rows.InsertAt(allCategoriesRow, 0);

            // Bind the data to ddlCourseCategory
            ddlCourseCategory.DataSource = dtCategories;
            ddlCourseCategory.DataTextField = "cat_name";
            ddlCourseCategory.DataValueField = "cat_id";
            ddlCourseCategory.DataBind();
        }


        public class YourDataAccessLayer
        {
            // Your connection string
            private string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            public DataTable GetCourseCategories()
            {
                DataTable dtCategories = new DataTable();

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "SELECT cat_id, cat_name FROM Category";
                    using (SqlCommand cmd = new SqlCommand(query, connection))
                    {
                        connection.Open();
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            da.Fill(dtCategories);
                        }
                    }
                }

                return dtCategories;
            }
        }

        protected void ButtonSearch_Click(object sender, EventArgs e)
        {
            string searchTerm = txtSearch.Text.Trim();
            int tutorId = GetTutorId(); // Retrieve the tutor ID
            ExecuteSearch(searchTerm, tutorId);
        }
        private void ExecuteSearch(string searchTerm, int tutorId)
        {
            SqlDataSourceCourses.SelectCommand = "SELECT c.course_id, c.course_pic, c.course_name, c.course_fee, cat.cat_name " +
                                         "FROM Course c " +
                                         "JOIN Category cat ON c.cat_id = cat.cat_id " +
                                         "WHERE c.course_name LIKE @SearchTerm AND c.tutor_id = @TutorId " +
                                         "ORDER BY c.course_id ASC";

            // Clear existing parameters and add the new search parameter
            SqlDataSourceCourses.SelectParameters.Clear();
            SqlDataSourceCourses.SelectParameters.Add("SearchTerm", "%" + searchTerm + "%");
            SqlDataSourceCourses.SelectParameters.Add("TutorId", tutorId.ToString());

            // Bind the data to the DataListCourses
            DataListCourses.DataSourceID = "SqlDataSourceCourses";
            DataListCourses.DataBind();
        }

        protected void ddlCourseCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedCategory = ddlCourseCategory.SelectedValue;
            int tutorId = GetTutorId(); // Retrieve the tutor ID

            // Check if "All Categories" is selected
            if (selectedCategory == "")
            {
                // Clear the category filter
                SqlDataSourceCourses.SelectCommand = "SELECT c.course_id, c.course_pic, c.course_name, c.course_fee, cat.cat_name " +
                                           "FROM Course c " +
                                           "JOIN Category cat ON c.cat_id = cat.cat_id " +
                                           "WHERE c.tutor_id = @TutorId " +
                                           "ORDER BY course_id ASC";

                // Clear existing parameters
                SqlDataSourceCourses.SelectParameters.Clear();
                SqlDataSourceCourses.SelectParameters.Add("TutorId", tutorId.ToString());
            }
            else
            {
                ExecuteCategory(selectedCategory, tutorId);
            }

            // Bind the data to the DataListCourses
            DataListCourses.DataSourceID = "SqlDataSourceCourses";
            DataListCourses.DataBind();
        }

        private void ExecuteCategory(string category, int tutorId)
        {
            // Set the selected value of the category dropdown list
            ddlCourseCategory.SelectedValue = category;

            // Set the category filter in the SQL query
            SqlDataSourceCourses.SelectCommand = "SELECT c.course_id, c.course_pic, c.course_name, c.course_fee, cat.cat_name " +
                                       "FROM Course c " +
                                       "JOIN Category cat ON c.cat_id = cat.cat_id " +
                                       "WHERE cat.cat_id = @CategoryId AND c.tutor_id = @TutorId " +
                                       "ORDER BY course_id ASC";

            // Clear existing parameters and add the new category parameter
            SqlDataSourceCourses.SelectParameters.Clear();
            SqlDataSourceCourses.SelectParameters.Add("CategoryId", DbType.Int32, category);
            SqlDataSourceCourses.SelectParameters.Add("TutorId", tutorId.ToString());
        }

        protected void ddlRating_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedRating = ddlRating.SelectedValue; // Use SelectedValue for DropDownList
            int tutorId = GetTutorId(); // Retrieve the tutor ID

            // Check if "All Ratings" is selected or if the selected rating is non-numeric
            if (selectedRating == "" || !int.TryParse(selectedRating, out int numericRating))
            {
                // Clear the rating filter
                SqlDataSourceCourses.SelectCommand = "SELECT c.course_id, c.course_pic, c.course_name, c.course_fee, cat.cat_name " +
                                           "FROM Course c " +
                                           "JOIN Category cat ON c.cat_id = cat.cat_id " +
                                           "WHERE c.tutor_id = @TutorId " +
                                           "ORDER BY course_id ASC";

                // Clear existing parameters
                SqlDataSourceCourses.SelectParameters.Clear();
                SqlDataSourceCourses.SelectParameters.Add("TutorId", tutorId.ToString());
            }
            else
            {
                ExecuteRating(selectedRating, tutorId);
            }

            // Bind the data to the DataListCourses
            DataListCourses.DataSourceID = "SqlDataSourceCourses";
            DataListCourses.DataBind(); // AutoPostBack should handle this automatically
        }

        private void ExecuteRating(string rating, int tutorId)
        {
            if (double.TryParse(rating, out double ratingValue))
            {
                // Set the rating filter in the SQL query
                SqlDataSourceCourses.SelectCommand = "SELECT c.course_id, c.course_pic, c.course_name, c.course_fee, cat.cat_name " +
                                                     "FROM Course c " +
                                                     "JOIN Category cat ON c.cat_id = cat.cat_id " +
                                                     "WHERE c.course_id IN (SELECT course_id FROM Review WHERE tutor_id = @TutorId AND review_rating = @Rating) " +
                                                     "ORDER BY course_id ASC";

                // Clear existing parameters and add the new parameters
                SqlDataSourceCourses.SelectParameters.Clear();

                // Add the Rating parameter
                SqlDataSourceCourses.SelectParameters.Add("Rating", DbType.Double, ratingValue.ToString());

                // Add the tutorId parameter
                SqlDataSourceCourses.SelectParameters.Add("TutorId", tutorId.ToString());
            }
        }

        protected void DataListCourses_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                // Find the ddlCourseCategory DropDownList within the current item
                DropDownList ddlCourseCategory = e.Item.FindControl("ddlCourseCategory") as DropDownList;

                // Check if the control is found
                if (ddlCourseCategory != null)
                {
                    YourDataAccessLayer dataAccess = new YourDataAccessLayer();
                    DataTable dtCategories = dataAccess.GetCourseCategories();

                    // Bind the data to ddlCourseCategory
                    ddlCourseCategory.DataSource = dtCategories;
                    ddlCourseCategory.DataTextField = "cat_name";
                    ddlCourseCategory.DataValueField = "cat_id";
                    ddlCourseCategory.DataBind();
                }

                // Find the txtSearch TextBox within the current item
                TextBox txtSearch = e.Item.FindControl("txtSearch") as TextBox;

                // Check if the control is found
                if (txtSearch != null)
                {
                    // Perform actions with txtSearch if needed
                    // For example, you can set its properties or attach events
                    txtSearch.Attributes["placeholder"] = "Search your course";
                }

                // Find the ddlRating DropDownList within the current item
                DropDownList ddlRating = e.Item.FindControl("ddlRating") as DropDownList;

                // Check if the control is found
                if (ddlRating != null)
                {
                    // Perform actions with ddlRating if needed
                    // For example, you can set its default value or attach events
                    ddlRating.Items.FindByValue("All Ratings").Selected = true; // Set default value
                }
            }
        }


        protected string GetCardColor(int index)
        {
            string[] colors = { "#EBEBFF", "#E1F7E3", "#FFF2E5", "#FFF0F0", "#F5F7FA" };
            return colors[index % colors.Length];
        }

        protected void DataListCourses_SelectedIndexChanged(object sender, EventArgs e)
        {
            string courseId = Session["courseId"] as string;
            // Display a window alert with the session ID
            ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Session ID: {Session["courseId"]}');", true);

            // Use courseId as needed
            Response.Redirect("CourseDetail.aspx");
        }

        protected void selectBtn_Command(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {
                // Retrieve the course_id from the CommandArgument
                int courseId = Convert.ToInt32(e.CommandArgument);

                Session["courseId"] = courseId;
                // Redirect to the course details page, passing the courseId as a query parameter
                Response.Redirect($"CourseDetail.aspx?courseId={courseId}");
            }
        }


        public double CalculateAverageRating(string courseId)
        {
            // Convert courseId to int before using it in the query
            int courseIdInt = Convert.ToInt32(courseId);

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "SELECT AVG(review_rating) FROM Review WHERE course_id = @CourseId";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@CourseId", courseIdInt);

                    // ExecuteScalar returns the average rating as an object
                    object result = command.ExecuteScalar();

                    if (result != null && result != DBNull.Value)
                    {
                        return Convert.ToDouble(result);
                    }
                }
            }

            return 0.0;
        }
    }
}