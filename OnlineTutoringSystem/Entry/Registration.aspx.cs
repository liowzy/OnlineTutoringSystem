using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineTutoringSystem
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected bool CheckEmailExist(string email)
        {
            SqlConnection con;
            string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            con = new SqlConnection(strCon);

            con.Open();
            string cmdText = "SELECT * FROM Student WHERE stud_email = '" + email + "'";
            SqlCommand cmd = new SqlCommand(cmdText, con);
            SqlDataReader dtrProd = cmd.ExecuteReader();

            if (dtrProd.HasRows)
            {
                con.Close();
                return true;
            }

            con.Close();
            return false;
        }


        private void RegisterUser(string firstName, string lastName, string username, string email, string password, string gender, string userType, DateTime dob, string phoneNo, byte[] picture)
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                if (userType == "Student")
                {
                    string studentQuery = "INSERT INTO Student (stud_name,stud_username, stud_email, stud_password, stud_gender, stud_dob, stud_picture, stud_phoneNo) " +
                                          "VALUES (@Name, @Username, @Email, @Password, @Gender, @Dob, @Picture, @PhoneNo)";

                    using (SqlCommand command = new SqlCommand(studentQuery, connection))
                    {
                        command.Parameters.AddWithValue("@Name", firstName + " " + lastName);
                        command.Parameters.AddWithValue("@Username", username);
                        command.Parameters.AddWithValue("@Email", email);
                        command.Parameters.AddWithValue("@Password", password);
                        command.Parameters.AddWithValue("@Gender", gender);
                        command.Parameters.AddWithValue("@Dob", dob);
                        command.Parameters.AddWithValue("@PhoneNo", phoneNo);
                        command.Parameters.AddWithValue("@Picture", picture);

                        command.ExecuteNonQuery();
                    }
                }
                else if (userType == "Tutor")
                {
                    string tutorQuery = "INSERT INTO Tutor (tutor_name, tutor_username, tutor_email, tutor_password, tutor_gender, tutor_dob, tutor_picture, tutor_phoneNo) " +
                                        "VALUES (@Name, @Username, @Email, @Password, @Gender, @Dob, @Picture, @PhoneNo)";

                    using (SqlCommand command = new SqlCommand(tutorQuery, connection))
                    {
                        command.Parameters.AddWithValue("@Name", firstName + " " + lastName);
                        command.Parameters.AddWithValue("@Username", username);
                        command.Parameters.AddWithValue("@Email", email);
                        command.Parameters.AddWithValue("@Password", password);
                        command.Parameters.AddWithValue("@Gender", gender);
                        command.Parameters.AddWithValue("@Dob", dob);
                        command.Parameters.AddWithValue("@PhoneNo", phoneNo);
                        command.Parameters.AddWithValue("@Picture", picture);

                        command.ExecuteNonQuery();
                    }
                }
            }
        }



        protected void btnCreate_Click(object sender, EventArgs e)
        {
            // Get user input from the form
            string firstName = tbFirstN.Text;
            string lastName = tbLastN.Text;
            string username = tbUserN.Text;
            string email = tbEmail.Text;
            string password = tbPw.Text;
            string gender = RadioButtonListGender.SelectedItem.Value;  
            string confirmPassword = TextBox2.Text;
            string userType = DropDownList11.SelectedValue; // Student or Tutor
            DateTime dob = DateTime.Parse(tbDob.Text);  
            string phoneNo = tbPhone.Text;

            // Check if the email already exists in the database
            if (!CheckEmailExist(email))
            {
                // Email does not exist, proceed with registration
                // Get the profile picture as a byte array
                byte[] picture = null;
                if (FileUpload1.HasFile)
                {
                    using (Stream stream = FileUpload1.PostedFile.InputStream)
                    {
                        using (BinaryReader reader = new BinaryReader(stream))
                        {
                            picture = reader.ReadBytes((int)stream.Length);
                        }
                    }
                }

                // Implement your registration logic here, e.g., insert data into the database
                RegisterUser(firstName, lastName, username, email, password, gender, userType, dob, phoneNo, picture);

                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Registration successful.');", true);

                // Redirect the user to the homepage
                Response.Redirect("../Student/HomePage.aspx");
            }
            else
            {
                // Email already exists, show an error message or take appropriate action 
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Email already exists.');", true);
            }

        }
    }
}