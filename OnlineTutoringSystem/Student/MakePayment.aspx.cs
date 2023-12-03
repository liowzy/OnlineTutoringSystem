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
using System.Globalization;
using System.Text.RegularExpressions;

namespace OnlineTutoringSystem
{
    public partial class WebForm6 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                if (Session["courseId"] != null)
                {
                    // Fetch and display course details
                    string courseId = Session["courseId"].ToString();
                FetchAndDisplayCourseDetails(courseId);
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Your session end. Please login again!');", true);
                    Response.Redirect("~/Student/Course.aspx");
                }
            }
        }

        private void FetchAndDisplayCourseDetails(string courseId)
        { 

            // Sample query to retrieve course details
            string query = "SELECT course_name, course_fee, course_pic FROM Course WHERE course_id = @CourseId";

            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    connection.Open();
                    command.Parameters.AddWithValue("@CourseId", courseId);

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            // Display course details
                            lblCourseName.Text = reader["course_name"].ToString();
                            lblCourseFee.Text = $"RM {reader["course_fee"]:N2}";
                            lblTotalToPay.Text = $"RM {reader["course_fee"]:N2}";
                            
                            // Load course image
                            byte[] coursePictureBytes = (byte[])reader["course_pic"];
                            string coursePictureUrl = $"data:image/jpeg;base64,{Convert.ToBase64String(coursePictureBytes)}";
                            CourseBanner.ImageUrl = coursePictureUrl;
                        }
                    }
                }
            }
        } 

        protected void btnMakePayment_Click(object sender, EventArgs e)
        {
            Page.Validate();
            if (Page.IsValid && IsValidExpirationDate(txtExpirationDate.Text))
            {
                // Get user input from the form
                string cardNumber = txtCardNumber.Text;
            string cardHolderName = txtCardHolderName.Text;
            string expirationDate = txtExpirationDate.Text;
            string cvv = txtCVV.Text;

            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Insert into PurchasedCourse table
                string purchaseQuery = "INSERT INTO PurchasedCourse (stud_id, course_id, purchase_date) VALUES (@StudentId, @CourseId, GETDATE())";
                using (SqlCommand command = new SqlCommand(purchaseQuery, connection))
                {
                    // Replace Session["userID"] with the appropriate session variable storing the user ID
                    command.Parameters.AddWithValue("@StudentId", Convert.ToInt32(Session["userID"]));
                    // Replace Session["courseId"] with the appropriate session variable storing the course ID
                    command.Parameters.AddWithValue("@CourseId", Convert.ToInt32(Session["courseId"]));

                    command.ExecuteNonQuery();
                }
            }

            // Show a success message
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Payment successful!');", true);

            Response.Redirect("~/Student/Enrollment.aspx");
            }
            else
            {
                // Handle the case where the expiration date is not valid
                Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Payment failed! Your card is Expired.');", true);
            }
        }
        private bool IsValidExpirationDate(string inputDate)
        {
            if (DateTime.TryParseExact(inputDate, "MM/yy", CultureInfo.InvariantCulture, DateTimeStyles.None, out DateTime expirationDate))
            {
                // Check if the expiration date is in the future or the current month
                return expirationDate >= DateTime.Now;
            }

            return false; // Invalid date
        }


    }
}