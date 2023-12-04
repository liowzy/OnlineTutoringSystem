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
    public partial class StudDashboard : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userID"] != null)
            {
                string userType = Session["userType"].ToString();
                int userId = Convert.ToInt32(Session["userID"]);

                var userData = GetUserNameAndProfilePicture(userId, userType);

                // If a profile picture is found, set the ImageUrl
                if (userData.Item2 != null)
                {
                    imgUserProfile.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String(userData.Item2);
                }

                // If a user name is found, set the label
                if (!string.IsNullOrEmpty(userData.Item1))
                {
                    Label12.Text = userData.Item1;
                }
            }

        }


        private Tuple<string, byte[]> GetUserNameAndProfilePicture(int userID, string userType)
        {
            // Your database logic to retrieve the user's name and profile picture based on the user ID and type
            // Replace this with your actual database query or data access method
            string userName = null;
            byte[] profilePicture = null;

            string connectionString = WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Check both Student and Tutor tables based on user type
                string query = "";
                if (userType == "student")
                {
                    query = "SELECT stud_name, stud_picture FROM Student WHERE stud_id = @userID";
                }
                else if (userType == "tutor")
                {
                    query = "SELECT tutor_name, tutor_picture FROM Tutor WHERE tutor_id = @userID";
                }

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@userID", userID);
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            userName = reader.GetString(0); // Assuming the name column is the first one in the SELECT statement
                            profilePicture = (byte[])reader["stud_picture"]; // Update this with the correct column name for the profile picture
                        }
                    }
                }
            }

            return new Tuple<string, byte[]>(userName, profilePicture);
        }
        public void UpdateUserInfo(int userID, string userType)
        {
            var userData = GetUserNameAndProfilePicture(userID, userType);

            // If a profile picture is found, set the ImageUrl
            if (userData.Item2 != null)
            {
                imgUserProfile.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String(userData.Item2);
            }

            // If a user name is found, set the label
            if (!string.IsNullOrEmpty(userData.Item1))
            {
                Label12.Text = userData.Item1;
            }
        }


        protected void btnSettings_Click(object sender, EventArgs e)
        {
            Response.Redirect("StudAccount.aspx");

        }

        protected void btnWishlist_Click(object sender, EventArgs e)
        {
            Response.Redirect("StudWishlist.aspx");

        }
    }
}