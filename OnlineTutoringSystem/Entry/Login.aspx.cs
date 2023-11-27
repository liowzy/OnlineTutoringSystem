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
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private bool ValidateUser(string emailOrUsername, string password)
        {
            // Perform database query to check if the user exists with the given email or username and password 
            string connectionString = WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Check if the input is a valid email address
                bool isEmail = IsValidEmail(emailOrUsername);

                // Query based on email or username
                string query;
                if (isEmail)
                {
                    query = "SELECT stud_id, stud_name FROM Student WHERE stud_email = @Email AND stud_password = @Password";
                }
                else
                {
                    query = "SELECT stud_id, stud_name FROM Student WHERE stud_name = @Username AND stud_password = @Password";
                }

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    if (isEmail)
                    {
                        command.Parameters.AddWithValue("@Email", emailOrUsername);
                    }
                    else
                    {
                        command.Parameters.AddWithValue("@Username", emailOrUsername);
                    }

                    command.Parameters.AddWithValue("@Password", password);

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            reader.Read();
                            // Store user information in session variables
                            Session["userID"] = reader["stud_id"]; 
                            Session["userType"] = "student";
                            return true; // User is valid
                        }
                        else
                        {
                            return false; // User is not valid
                        }
                    }
                }
            }
        }


        // Helper method to check if the input is a valid email address
        private bool IsValidEmail(string email)
        {
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == email;
            }
            catch
            {
                return false;
            }
        }


        protected void btnCreate_Click(object sender, EventArgs e)
        {
            // Get user input from the form
            string usernameOrEmail = tbFirstN.Text;
            string password = tbUserN.Text;

            // Check if the credentials are valid
            if (ValidateUser(usernameOrEmail, password))
            {  

                // Redirect the user to the homepage or another page
                Response.Redirect("../Student/HomePage.aspx");
            }
            else
            {
                // Login failed, show an error message or take appropriate action
                // For simplicity, I'm just showing an alert here, but you should handle it appropriately
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Invalid username/email or password.');", true);
            }
        }
    }
}