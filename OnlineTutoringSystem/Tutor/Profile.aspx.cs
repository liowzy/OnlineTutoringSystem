using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

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
        public string TutorExpertise { get; set; }
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
            TutorInfo tutor = GetTutorInformation(Session["userID"].ToString());

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
                lblTutorExpertise.Text = tutor.TutorExpertise;

                // Set the profile picture
                imgUserProfile.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String(tutor.TutorPicture);
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

                string query = "SELECT tutor_name, tutor_username, tutor_email, tutor_gender, tutor_phoneNo, tutor_picture, tutor_dob FROM Tutor WHERE tutor_id = @userID";

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
                        }
                    }
                }
            }

            return tutor;
        }


        protected void btnSaveChanges_Click(object sender, EventArgs e)
        {
            try
            {
                // Retrieve values from the form
                string tutorUsername = txtUsername.Text;
                string tutorPhoneNumber = txtPhoneNumber.Text;
                string tutorGender = ddlGender.SelectedValue;
                int tutorTeachingExperience = Convert.ToInt32(txtTeachingExperience.Text);
                string tutorCountry = txtCountry.Text;
                string tutorLocation = txtLocation.Text;
                string tutorAddress = txtAddress.Text;
                string tutorExpertise = txtTutorExpertise.Text;
                string tutorBiography = txtBiography.Text;

                // Update the tutor profile using the UpdateTutorProfile method
                UpdateTutorProfile(tutorUsername, tutorPhoneNumber, tutorGender, tutorTeachingExperience, tutorLocation, tutorExpertise, tutorBiography);

                // Optionally, you can redirect the user to another page or display a success message
                Response.Write("Profile updated successfully!");
            }
            catch (Exception ex)
            {
                // Handle the exception (log it, display an error message)
                Response.Write("An error occurred: " + ex.Message);
            }
        }

        private DataTable GetTutorProfile(string tutorUsername)
        {
            DataTable dt = new DataTable();

            try
            {
                // Get the connection string from the web.config file
                string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

                // Create a SQL connection
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    // Define the SQL query
                    string query = "SELECT * FROM [dbo].[Tutor] WHERE tutor_username = @TutorUsername";

                    // Create a SQL command
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        // Add parameters to the SQL command
                        command.Parameters.AddWithValue("@TutorUsername", tutorUsername);

                        // Open the connection
                        connection.Open();

                        // Execute the SQL command and fill the DataTable
                        SqlDataAdapter adapter = new SqlDataAdapter(command);
                        adapter.Fill(dt);
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle the exception (log it, display an error message)
                Response.Write("An error occurred: " + ex.Message);
            }

            return dt;
        }

        private void AddProfileToDatabase(
            string tutorName,
            string tutorUsername,
            string tutorEmail,
            string tutorPassword,
            DateTime tutorDob,
            byte[] tutorPicture,
            string tutorGender,
            string tutorPhoneNo,
            string tutorExpertise,
            string tutorLocation,
            string tutorLanguageProficiency,
            int tutorTeachingExperience,
            string tutorDescription,
            string chatLink)
        {
            try
            {
                // Get the connection string from the web.config file
                string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

                // Create a SQL connection
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    // Define the SQL query
                    string query = @"
                        INSERT INTO [dbo].[Tutor] (
                            tutor_name,
                            tutor_username,
                            tutor_email,
                            tutor_password,
                            tutor_dob,
                            tutor_picture,
                            tutor_gender,
                            tutor_phoneNo,
                            tutor_expertise,
                            tutor_location,
                            tutor_languageProficiency,
                            tutor_teachingExperience,
                            tutor_description,
                            chat_link
                        ) VALUES (
                            @TutorName,
                            @TutorUsername,
                            @TutorEmail,
                            @TutorPassword,
                            @TutorDob,
                            @TutorPicture,
                            @TutorGender,
                            @TutorPhoneNo,
                            @TutorExpertise,
                            @TutorLocation,
                            @TutorLanguageProficiency,
                            @TutorTeachingExperience,
                            @TutorDescription,
                            @ChatLink
                        );";

                    // Create a SQL command
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        // Add parameters to the SQL command
                        command.Parameters.Add("@TutorName", SqlDbType.NVarChar).Value = tutorName;
                        command.Parameters.Add("@TutorUsername", SqlDbType.NVarChar).Value = tutorUsername;
                        command.Parameters.Add("@TutorEmail", SqlDbType.NVarChar).Value = tutorEmail;
                        command.Parameters.Add("@TutorPassword", SqlDbType.NVarChar).Value = tutorPassword;
                        command.Parameters.Add("@TutorDob", SqlDbType.DateTime).Value = tutorDob;
                        command.Parameters.Add("@TutorPicture", SqlDbType.VarBinary).Value = tutorPicture;
                        command.Parameters.Add("@TutorGender", SqlDbType.NVarChar).Value = tutorGender;
                        command.Parameters.Add("@TutorPhoneNo", SqlDbType.NVarChar).Value = tutorPhoneNo;
                        command.Parameters.Add("@TutorExpertise", SqlDbType.NVarChar).Value = tutorExpertise;
                        command.Parameters.Add("@TutorLocation", SqlDbType.NVarChar).Value = tutorLocation;
                        command.Parameters.Add("@TutorLanguageProficiency", SqlDbType.NVarChar).Value = tutorLanguageProficiency;
                        command.Parameters.Add("@TutorTeachingExperience", SqlDbType.Int).Value = tutorTeachingExperience;
                        command.Parameters.Add("@TutorDescription", SqlDbType.NVarChar).Value = tutorDescription;
                        command.Parameters.Add("@ChatLink", SqlDbType.NVarChar).Value = chatLink;

                        // Open the connection
                        connection.Open();

                        // Execute the SQL command
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle the exception (log it, display an error message)
                Response.Write("An error occurred: " + ex.Message);
            }
        }

        private void UpdateTutorProfile(
        string tutorUsername,
        string tutorPhoneNo,
        string tutorGender,
        int tutorTeachingExperience,
        string tutorLocation,
        string tutorExpertise,
        string tutorDescription)
        {
            try
            {
                // Get the connection string from the web.config file
                string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

                // Create a SQL connection
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    // Define the SQL query
                    string query = @"
                UPDATE [dbo].[Tutor] SET
                tutor_phoneNo = @TutorPhoneNo,
                tutor_gender = @TutorGender,
                tutor_teachingExperience = @TutorTeachingExperience,
                tutor_location = @TutorLocation,
                tutor_expertise = @TutorExpertise,
                tutor_description = @TutorDescription
                WHERE tutor_username = @TutorUsername";

                    // Create a SQL command
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        // Add parameters to the SQL command
                        command.Parameters.AddWithValue("@TutorUsername", tutorUsername);
                        command.Parameters.AddWithValue("@TutorPhoneNo", tutorPhoneNo);
                        command.Parameters.AddWithValue("@TutorGender", tutorGender);
                        command.Parameters.AddWithValue("@TutorTeachingExperience", tutorTeachingExperience);
                        command.Parameters.AddWithValue("@TutorLocation", tutorLocation);
                        command.Parameters.AddWithValue("@TutorExpertise", tutorExpertise);
                        command.Parameters.AddWithValue("@TutorDescription", tutorDescription);

                        // Open the connection
                        connection.Open();

                        // Execute the SQL command
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle the exception (log it, display an error message)
                Response.Write("An error occurred: " + ex.Message);
            }
        }
    }
}
