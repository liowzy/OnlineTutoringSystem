using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace OnlineTutoringSystem.Student
{
    public class UserInfo
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string UserName { get; set; }
        public string Email { get; set; }
        public string Gender { get; set; }
        public string PhoneNumber { get; set; }
        public byte[] ProfilePicture { get; set; }
        public DateTime DateOfBirth { get; set; } // Add this line for Date of Birth 
    }


    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
              
                    LoadUserData(); 
             

        }

        private void LoadUserData()
        { 
            UserInfo user = GetUserInformation(Session["userID"].ToString()); 

            if (user != null)
            {
                // Split full name into first name and last name
                string[] names = user.FirstName.Split(' ');

                // Set the first name and last name
                tbFirstN.Text = names.Length > 0 ? names[0] : string.Empty; // First name
                tbLastN.Text = names.Length > 1 ? names[1] : string.Empty; // Last name

                tbUserN.Text = user.UserName;
                tbEmail.Text = user.Email;
                DropDownList1.SelectedValue = user.Gender;
                TextBox19.Text = user.PhoneNumber;
                tbDateOfBirth.Text = user.DateOfBirth.ToString("yyyy-MM-dd"); // Set the Date of Birth

                // Set the profile picture
                imgUserProfile.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String(user.ProfilePicture);
            }
            else
            {
                // Handle the case where user information is not found (e.g., redirect to login page)
                Response.Redirect("~/Login.aspx");
            }
        }

        private UserInfo GetUserInformation(string userId)
        {
            UserInfo user = new UserInfo();

            string connectionString = WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "SELECT stud_name, stud_username, stud_email, stud_gender, stud_phoneNo, stud_picture, stud_dob FROM Student WHERE stud_id = @userId";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@userId", userId);
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            user.FirstName = reader["stud_name"].ToString();
                            user.UserName = reader["stud_username"].ToString();
                            user.Email = reader["stud_email"].ToString();
                            user.Gender = reader["stud_gender"].ToString();
                            user.PhoneNumber = reader["stud_phoneNo"].ToString();
                            user.ProfilePicture = (byte[])reader["stud_picture"];
                            user.DateOfBirth = (DateTime)reader["stud_dob"];  
                        }
                    }
                }
            }

            return user;
        }

        protected void btnCreate_Click1(object sender, EventArgs e)
        {
            bool success = UpdateUserData();

            if (success)
            {
                // Update the profile picture after successfully updating user data
                UserInfo user = GetUserInformation(Session["userID"].ToString());
                imgUserProfile.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String(user.ProfilePicture);

                // Show success alert
                string script = "alert('Changes saved successfully.');";
                ClientScript.RegisterStartupScript(this.GetType(), "SuccessAlert", script, true);

                var dashboardMasterPage = this.Master as StudDashboard;
                var headerMasterPage = this.Master.Master as Header;

                // Update user information on the master pages
                UpdateMasterPageUserInfo(dashboardMasterPage);
                UpdateMasterPageUserInfo(headerMasterPage);
            }
            else
            {
                // Show error alert
                string script = "alert('Failed to save changes. Please try again.');";
                ClientScript.RegisterStartupScript(this.GetType(), "ErrorAlert", script, true);
            }
        }

        private void UpdateMasterPageUserInfo(dynamic masterPage)
        {
            if (masterPage != null)
            {
                // Call the method to update user information
                masterPage.UpdateUserInfo(Convert.ToInt32(Session["userID"]), Session["userType"].ToString());
            }
        }

        private bool UpdateUserData()
        { 
                // Get the user ID from the session
                int userId = Convert.ToInt32(Session["userID"]);

                // Get the updated user information from the textboxes and other controls
                string firstName = tbFirstN.Text;
                string lastName = tbLastN.Text;
                string username = tbUserN.Text;
                string email = tbEmail.Text;
                string gender = DropDownList1.SelectedValue;
                string phoneNumber = TextBox19.Text;
                string dob = tbDateOfBirth.Text;

                string connectionString = WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand())
                { 
                    command.Connection = connection;

                        if (btnFileUpload.HasFile)
                        {
                            // If a file is uploaded, read it into a byte array
                            int imagefilelenth = btnFileUpload.PostedFile.ContentLength;
                            byte[] profilePicture = new byte[imagefilelenth];
                            HttpPostedFile img = btnFileUpload.PostedFile;
                            img.InputStream.Read(profilePicture, 0, imagefilelenth);

                            // Update the query with the profile picture
                            command.CommandText = "UPDATE Student SET stud_name = @fullName, stud_username = @username, stud_email = @email, stud_gender = @gender, stud_dob = @dob, stud_phoneNo = @phoneNumber, stud_picture = @profilePicture WHERE stud_id = @userId";
                            command.Parameters.AddWithValue("@profilePicture", profilePicture);
                            UserInfo user = GetUserInformation(userId.ToString()); 
                            user.ProfilePicture = profilePicture;
                    }
                        else
                        {
                            // If no file is uploaded, update without changing the profile picture
                            command.CommandText = "UPDATE Student SET stud_name = @fullName, stud_username = @username, stud_email = @email, stud_gender = @gender,stud_dob = @dob, stud_phoneNo = @phoneNumber WHERE stud_id = @userId";
                        }

                        // Common parameters for both cases
                        command.Parameters.AddWithValue("@fullName", $"{firstName} {lastName}");
                        command.Parameters.AddWithValue("@username", username);
                        command.Parameters.AddWithValue("@email", email);
                        command.Parameters.AddWithValue("@gender", gender);
                        command.Parameters.AddWithValue("@dob", dob);
                        command.Parameters.AddWithValue("@phoneNumber", phoneNumber);
                        command.Parameters.AddWithValue("@userId", userId);

                        int rowsAffected = command.ExecuteNonQuery();

                        return rowsAffected > 0;
                    }
                } 
        }

        protected void Button66_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["userID"]);

            UserInfo user = new UserInfo();
            // Get the current, new, and confirmed passwords from the textboxes
            string currentPassword = TextBox32.Text;
            string newPassword = TextBox14.Text;
            string confirmNewPassword = TextBox23.Text;

            // Validate that the new password and confirm new password match
            if (newPassword != confirmNewPassword)
            { 
                ClientScript.RegisterStartupScript(this.GetType(), "MismatchAlert", "alert('New password and confirm password do not match.');", true);
                return;
            }

            // Validate the current password against the one stored in the database
            if (!ValidateCurrentPassword(userId, currentPassword))
            {
                // Display an error message indicating that the current password is incorrect
                ClientScript.RegisterStartupScript(this.GetType(), "InvalidPasswordAlert", "alert('Current password is incorrect.');", true);
                return;
            }

            // If validation is successful, update the password in the database
            bool success = UpdatePassword(userId, newPassword);

            if (success)
            {
                // Update the profile picture after successfully updating user data
                imgUserProfile.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String(user.ProfilePicture);
                ClientScript.RegisterStartupScript(this.GetType(), "SuccessAlert", "alert('Password changed successfully.');", true);
            }
            else
            {
                // Display an error message
                ClientScript.RegisterStartupScript(this.GetType(), "ErrorAlert", "alert('Failed to change password. Please try again.');", true);
            }
        }

        private bool ValidateCurrentPassword(int userId, string currentPassword)
        {
            // Your logic to check if the current password matches the one stored in the database
            // Replace this with your actual database query or data access method

            // For demonstration purposes, let's assume a simple check (replace this with your actual logic)
            string connectionString = WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = "SELECT COUNT(*) FROM Student WHERE stud_id = @UserID AND stud_password = @CurrentPassword";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@UserID", userId);
                    command.Parameters.AddWithValue("@CurrentPassword", currentPassword);
                    int count = (int)command.ExecuteScalar();
                    return count > 0;
                }
            }
        }

        private bool UpdatePassword(int userId, string newPassword)
        { 
             
            string connectionString = WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = "UPDATE Student SET stud_password = @NewPassword WHERE stud_id = @UserID";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@NewPassword", newPassword);
                    command.Parameters.AddWithValue("@UserID", userId);
                    int rowsAffected = command.ExecuteNonQuery();
                    return rowsAffected > 0;
                }
            }
        }
    }
}