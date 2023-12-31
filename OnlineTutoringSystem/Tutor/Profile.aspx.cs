﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Text.RegularExpressions;

namespace OnlineTutoringSystem.Tutor
{

    public class TutorInfo
    {
        public int TutorId { get; set; } // Add this property for TutorId
        public string TutorName { get; set; }
        public string TutorUsername { get; set; }
        public string TutorEmail { get; set; }
        public string TutorPassword { get; set; }
        public DateTime TutorDob { get; set; }
        public byte[] TutorPicture { get; set; }
        public string TutorGender { get; set; }
        public string TutorPhoneNumber { get; set; }
        public string TutorExpertice { get; set; }
        public string TutorLocation { get; set; }
        public string TutorLanguageProficiency { get; set; }
        public int TutorTeachingExperience { get; set; }
        public string TutorDescription { get; set; }
        public string ChatLink { get; set; }

        // Add other properties as needed based on your database schema
    }

    public partial class WebForm1 : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadTutorData();
            }
        }

        private void LoadTutorData()
        {
            TutorInfo tutor = GetTutorInformation(Session["userId"].ToString());

            if (tutor != null)
            {
                // Set the labels with tutor information
                lblUserName.Text = tutor.TutorUsername;
                lblFullName.Text = tutor.TutorName; // Display the full name directly

                lblPhoneNumber.Text = tutor.TutorPhoneNumber;
                lblGender.Text = tutor.TutorGender;
                lblTeachingExperience.Text = tutor.TutorTeachingExperience.ToString();
                lblLanguageProficiency.Text = tutor.TutorLanguageProficiency;
                lblLocation.Text = tutor.TutorLocation;
                lblTutorExpertice.Text = tutor.TutorExpertice;
                lblDob.Text = tutor.TutorDob.ToString("yyyy-MM-dd");
                lblDes.Text = tutor.TutorDescription.ToString();

                // Set the labels with tutor information
                txtUsername.Text = tutor.TutorUsername;
                txtName.Text = tutor.TutorName; // Display the full name directly

                txtPhoneNumber.Text = tutor.TutorPhoneNumber;
                ddlGender.Text = tutor.TutorGender;
                txtTeachingExperience.Text = tutor.TutorTeachingExperience.ToString();
                txtLangPro.Text = tutor.TutorLanguageProficiency;
                txtLocation.Text = tutor.TutorLocation;
                txtTutorExpertice.Text = tutor.TutorExpertice;
                txtDob.Text = tutor.TutorDob.ToString("yyyy-MM-dd");
                txtBiography.Text = tutor.TutorDescription.ToString();

                // Set the profile picture
                imgUserProfile.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String(tutor.TutorPicture);
                imgUserProfile_2.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String(tutor.TutorPicture);
            }
            else
            {
                // Handle the case where tutor information is not found (e.g., redirect to login page)
                Response.Redirect("~/Login.aspx");
            }
        }


        private TutorInfo GetTutorInformation(string userID)
        {
            TutorInfo tutor = new TutorInfo();

            string connectionString = WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "SELECT tutor_name, tutor_username, tutor_email, tutor_gender, tutor_phoneNo, tutor_picture, tutor_dob ,tutor_teachingExperience,tutor_location,tutor_expertice,tutor_languageProficiency,tutor_description,chat_link FROM Tutor WHERE tutor_id = @userID";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@userID", userID);
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            tutor.TutorName = reader["tutor_name"].ToString();
                            tutor.TutorUsername = reader["tutor_username"].ToString();
                            tutor.TutorEmail = reader["tutor_email"].ToString();
                            tutor.TutorGender = reader["tutor_gender"].ToString();
                            tutor.TutorPhoneNumber = reader["tutor_phoneNo"].ToString();
                            tutor.TutorPicture = (byte[])reader["tutor_picture"];
                            tutor.TutorDob = (DateTime)reader["tutor_dob"];
                            tutor.TutorTeachingExperience = reader["tutor_teachingExperience"] as int? ?? 0;
                            tutor.TutorLocation = reader["tutor_location"].ToString();
                            tutor.TutorExpertice = reader["tutor_expertice"].ToString();
                            tutor.TutorLanguageProficiency = reader["tutor_languageProficiency"].ToString();
                            tutor.TutorDescription = reader["tutor_description"].ToString();
                            tutor.ChatLink = reader["chat_link"].ToString();
                        }
                    }
                }
            }

            return tutor;
        }

        protected void ContactMeButton_Click(object sender, ImageClickEventArgs e)
        {
            string userID = Session["userID"].ToString();

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Fetch chat_link based on tutor_id
                string chatLinkQuery = "SELECT chat_link FROM Tutor WHERE tutor_id = @TutorId";
                using (SqlCommand command = new SqlCommand(chatLinkQuery, connection))
                {
                    // Correct the parameter name to @TutorId
                    command.Parameters.AddWithValue("@TutorId", userID);

                    string chatLink = command.ExecuteScalar()?.ToString();

                    // Open a new window to navigate to the chat link
                    if (!string.IsNullOrEmpty(chatLink))
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "openWindow", $"window.open('{chatLink}', '_blank');", true);
                    }
                }
            }
        }


        protected void btnUpdateTutorProfile_Click(object sender, EventArgs e)
        {

            // Get the tutor ID from the session
            bool success = UpdateTutorInformation();

            if (success)
            {
                // Show success alert
                ClientScript.RegisterStartupScript(this.GetType(), "SuccessAlert", "alert('Changes saved successfully.');", true);

                LoadTutorData();
            }
            else
            {
                // Show error alert
                ClientScript.RegisterStartupScript(this.GetType(), "ErrorAlert", "alert('Failed to save changes. Please try again.');", true);
            }
        }

        private bool UpdateTutorInformation()
        {
            try
            {
                // Get the tutor ID from the session
                int userId = Convert.ToInt32(Session["userID"]);

                string tutorName = txtName.Text;
                string tutorUsername = txtUsername.Text;
                string tutorLanguage = txtLangPro.Text;
                string tutorPhoneNo = txtPhoneNumber.Text;
                string tutorGender = ddlGender.SelectedValue;
                int tutorTeachingExperience = Convert.ToInt32(txtTeachingExperience.Text);
                string tutorLocation = txtLocation.Text;
                string tutorExpertice = txtTutorExpertice.Text;
                string tutorDescription = txtBiography.Text;
                string tutorDob = txtDob.Text;

                // Validate Date of Birth
                if (!IsValidDob(tutorDob))
                {
                    // Show error alert
                    ClientScript.RegisterStartupScript(this.GetType(), "ErrorAlert", "alert('Invalid Date of Birth. Please make sure it is at least 18 years old.');", true);
                    return false;
                }

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
                            command.CommandText = "UPDATE Tutor SET tutor_name = @TutorName, tutor_username = @TutorUsername, tutor_phoneNo = @TutorPhoneNo, tutor_gender = @TutorGender, tutor_teachingExperience = @TutorTeachingExperience, tutor_location = @TutorLocation, tutor_expertice = @TutorExpertice, tutor_description = @TutorDescription,tutor_languageProficiency = @TutorLanguagePro , tutor_dob = @TutorDob, tutor_picture = @ProfilePicture , chat_link = @ChatLink WHERE tutor_id = @UserId";

                            command.Parameters.AddWithValue("@ProfilePicture", profilePicture);
                        }
                        else
                        {
                            // If no file is uploaded, update without changing the profile picture
                            command.CommandText = "UPDATE Tutor SET tutor_name = @TutorName, tutor_username = @TutorUsername, tutor_phoneNo = @TutorPhoneNo, tutor_gender = @TutorGender, tutor_teachingExperience = @TutorTeachingExperience, tutor_location = @TutorLocation, tutor_expertice = @TutorExpertice, tutor_languageProficiency = @TutorLanguagePro ,tutor_description = @TutorDescription, tutor_dob = @TutorDob , chat_link = @ChatLink WHERE tutor_id = @UserId";
                        }

                        string chatLink = $"https://wa.me/6{tutorPhoneNo}";

                        // Add parameters to the SQL command
                        command.Parameters.AddWithValue("@UserId", userId);
                        command.Parameters.AddWithValue("@TutorName", tutorName);
                        command.Parameters.AddWithValue("@TutorUsername", tutorUsername);
                        command.Parameters.AddWithValue("@TutorPhoneNo", tutorPhoneNo);
                        command.Parameters.AddWithValue("@TutorGender", tutorGender);
                        command.Parameters.AddWithValue("@TutorTeachingExperience", tutorTeachingExperience);
                        command.Parameters.AddWithValue("@TutorLocation", tutorLocation);
                        command.Parameters.AddWithValue("@TutorExpertice", tutorExpertice);
                        command.Parameters.AddWithValue("@TutorDescription", tutorDescription);
                        command.Parameters.AddWithValue("@TutorDob", tutorDob);
                        command.Parameters.AddWithValue("@TutorLanguagePro",tutorLanguage);
                        command.Parameters.AddWithValue("@ChatLink", chatLink);

                        // Execute the SQL command
                        int rowsAffected = command.ExecuteNonQuery();

                        return rowsAffected > 0;
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle the exception (log it, display an error message)
                Response.Write("An error occurred: " + ex.Message);
                return false;
            }
        }

        private bool IsValidDob(string dob)
        {
            DateTime currentDate = DateTime.Now;
            DateTime dateOfBirth;

            if (DateTime.TryParse(dob, out dateOfBirth))
            {
                // Check if the user is at least 18 years old
                return currentDate.Year - dateOfBirth.Year >= 18;
            }

            // If the date is not a valid DateTime, consider it as invalid
            return false;
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["userID"]);

            // Get the current, new, and confirmed passwords from the textboxes
            string currentPassword = lblCurrentPass.Text;
            string newPassword = lblNewPass.Text;
            string confirmNewPassword = lblReNewPass.Text;

            if (currentPassword == newPassword)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "MismatchAlert", "alert('New password cannot same as current password.');", true);
                return;
            }

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

            // Validate the new password format
            if (!ValidatePasswordFormat(newPassword))
            {
                // Display an error message indicating that the new password format is invalid
                ClientScript.RegisterStartupScript(this.GetType(), "InvalidFormatAlert", "alert('New password must contain at least one alphabet, one digit, and one \"@\"');", true);
                return;
            }

            // If validation is successful, update the password in the database
            bool success = UpdatePassword(userId, newPassword);

            if (success)
            {
                // Display a success message
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
                string query = "SELECT COUNT(*) FROM Tutor WHERE tutor_id = @UserID AND tutor_password = @CurrentPassword";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@UserID", userId);
                    command.Parameters.AddWithValue("@CurrentPassword", currentPassword);
                    int count = (int)command.ExecuteScalar();
                    return count > 0;
                }
            }
        }
        private bool ValidatePasswordFormat(string password)
        {
            // Password should contain at least one alphabet, one digit, and one '@'
            var regex = new Regex("^(?=.*[a-zA-Z])(?=.*\\d)(?=.*[@])[a-zA-Z\\d@]+$");
            return regex.IsMatch(password);

        }

        private bool UpdatePassword(int userId, string newPassword)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = "UPDATE Tutor SET tutor_password = @NewPassword WHERE tutor_id = @UserID";
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
