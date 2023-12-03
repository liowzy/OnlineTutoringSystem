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

                // Query based on email or username for Student
                string studentQuery;
                if (isEmail)
                {
                    studentQuery = "SELECT stud_id, stud_name FROM Student WHERE stud_email = @Email AND stud_password = @Password";
                }
                else
                {
                    studentQuery = "SELECT stud_id, stud_name FROM Student WHERE stud_name = @Username AND stud_password = @Password";
                }

                // Query based on email or username for Tutor
                string tutorQuery;
                if (isEmail)
                {
                    tutorQuery = "SELECT tutor_id, tutor_name FROM Tutor WHERE tutor_email = @Email AND tutor_password = @Password";
                }
                else
                {
                    tutorQuery = "SELECT tutor_id, tutor_name FROM Tutor WHERE tutor_name = @Username AND tutor_password = @Password";
                }

                using (SqlCommand studentCommand = new SqlCommand(studentQuery, connection))
                using (SqlCommand tutorCommand = new SqlCommand(tutorQuery, connection))
                {
                    if (isEmail)
                    {
                        studentCommand.Parameters.AddWithValue("@Email", emailOrUsername);
                        tutorCommand.Parameters.AddWithValue("@Email", emailOrUsername);
                    }
                    else
                    {
                        studentCommand.Parameters.AddWithValue("@Username", emailOrUsername);
                        tutorCommand.Parameters.AddWithValue("@Username", emailOrUsername);
                    }

                    studentCommand.Parameters.AddWithValue("@Password", password);
                    tutorCommand.Parameters.AddWithValue("@Password", password);

                    using (SqlDataReader studentReader = studentCommand.ExecuteReader())
                    using (SqlDataReader tutorReader = tutorCommand.ExecuteReader())
                    {
                        if (studentReader.HasRows)
                        {
                            studentReader.Read();
                            // Store user information in session variables for Student
                            Session["userID"] = studentReader["stud_id"];
                            Session["userType"] = "student";
                            return true; // User is valid
                        }
                        else if (tutorReader.HasRows)
                        {
                            tutorReader.Read();
                            // Store user information in session variables for Tutor
                            Session["userID"] = tutorReader["tutor_id"];
                            Session["userType"] = "tutor";
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
                string userType = Session["userType"].ToString();

                // Redirect based on the user type
                if (userType=="student")
                {
                    // Redirect the student to the homepage
                    Response.Redirect("../Student/HomePage.aspx");
                }
                else if (userType == "tutor")
                {
                    // Redirect the tutor to the dashboard
                    Response.Redirect("../Tutor/Profile.aspx");
                }
                else
                {
                    // Handle unexpected user type
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Invalid user type.');", true);
                } 
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