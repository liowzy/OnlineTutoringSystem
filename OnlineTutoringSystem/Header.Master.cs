using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineTutoringSystem
{
    public partial class Header : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userID"] != null)
            {
                int userID = Convert.ToInt32(Session["userID"]);
                string userType = Session["userType"].ToString();

                // Assuming you have a method to get the profile picture based on the session user
                byte[] profilePicture = GetUserProfilePicture(userID, userType);

                // If a profile picture is found, set the ImageUrl
                if (profilePicture != null)
                {
                    imgUserProfile.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String(profilePicture);
                }
            }
        }

        private byte[] GetUserProfilePicture(int userID, string userType)
        {
            // Your database logic to retrieve the profile picture based on the username and user type
            // Replace this with your actual database query or data access method
            byte[] profilePicture = null;

            string connectionString = WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Check both Student and Tutor tables based on user type
                string query = "";
                if (userType == "student")
                {
                    query = "SELECT stud_picture FROM Student WHERE stud_id = @userID";
                }
                else if (userType == "tutor")
                {
                    query = "SELECT tutor_picture FROM Tutor WHERE tutor_id = @userID";
                }

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@userID", userID);
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            // Use the correct column name based on the user type
                            if (userType == "student")
                            {
                                profilePicture = (byte[])reader["stud_picture"];
                            }
                            else if (userType == "tutor")
                            {
                                profilePicture = (byte[])reader["tutor_picture"];
                            }
                        }
                    }
                }
            }

            return profilePicture;
        }


        protected void btnSignIn_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Entry/Login.aspx");
        }

        protected void btnCreateAccount_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Entry/Registration.aspx");
        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Entry/Logout.aspx");

        }

        protected void lnkSettings_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Student/StudAccount.aspx");

        }

        protected void lnkHeart_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Student/StudWishlist.aspx");

        }

        protected void btnDashboard_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Tutor/Profile.aspx");

        }

        protected void ButtonSearch_Click(object sender, EventArgs e)
        {

            string searchTerm = txtSearch.Text.Trim();

            // Redirect to Course.aspx with the search term as a query parameter
            Response.Redirect($"~/Student/Course.aspx?searchTerm={Server.UrlEncode(searchTerm)}");
        }

        // to change the profile pic after edit in account setting
        public void UpdateUserInfo(int userID, string userType)
        {
            // Assuming you have a method to get the profile picture based on the session user
            byte[] profilePicture = GetUserProfilePicture(userID, userType);

            // If a profile picture is found, set the ImageUrl
            if (profilePicture != null)
            {
                imgUserProfile.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String(profilePicture);
            }
        }
    }
}