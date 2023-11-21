using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Net.Mail;
using SendGrid.Helpers.Mail;
using System.Net;

namespace OnlineTutoringSystem.Entry
{
    public partial class Registration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //table1.Style.Add("display", "block");
            //table2.Style.Add("display", "none");
            //btn.Style.Add("display", "none");
        }

        protected Boolean checkEmailExist(string email)
        {
            SqlConnection con;
            string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            con = new SqlConnection(strCon);
            con.Open();
            string cmdText = "SELECT * FROM Student where stud_email = '" + email + "'";
            SqlCommand cmd = new SqlCommand(cmdText, con);
            SqlDataReader dtrProd = cmd.ExecuteReader();
            if (dtrProd.HasRows)
            {
                return true;
            }

            con.Close();
            return false;
        }

        protected void btnSend_Click(object sender, EventArgs e)
        {
            string email = tbEmail.Text;

            if (checkEmailExist(email))
            {
                string script = "alert(\"This email already used!\");";
                ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
            }
            else
            {
                //Create OTP code
                Random random = new Random();
                string otpCode = random.Next(10000000, 99999999).ToString();


                //Email content
                MailMessage mail = new MailMessage();
                mail.To.Add(email);
                mail.From = new MailAddress("tutore2023@gmail.com");
                mail.Subject = "Sign Up OTP";

                string emailBody = "";
                emailBody += "<h1>Hello User, </h1>";
                emailBody += "<p>OTP code: " + otpCode + "</p>";
                emailBody += "<p><b>Only valid for 10 mins</b></p>";

                mail.Body = emailBody;
                mail.IsBodyHtml = true;

                //Send email
                SmtpClient smtp = new SmtpClient();
                smtp.Port = 587;
                smtp.EnableSsl = true;
                smtp.UseDefaultCredentials = true;
                smtp.Host = "smtp.gmail.com";
                smtp.Credentials = new System.Net.NetworkCredential("tutore2023@gmail.com", "e-tutor2023");
                smtp.Send(mail);

                string otpSentTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                this.Session["otpCode"] = otpCode;
                this.Session["otpSentTime"] = otpSentTime;

                tbEmail.Enabled = false;
                verifyRow.Style.Add("visibility", "visible");
                btnSubmit.Style.Add("display", "block");
                btnSend.Style.Add("display", "none");



            }

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }

        protected void btnCreate_Click(object sender, EventArgs e)
        {
            string email = tbEmail.Text;

            if (checkEmailExist(email))
            {
                string script = "alert(\"This email already used!\");";
                ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
            }
            else
            {
                //add data in db

            }
        }
    }
}