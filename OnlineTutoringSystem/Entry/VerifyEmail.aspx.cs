using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Net.Mail;
using System.Net;
using System.Drawing;

namespace OnlineTutoringSystem
{
    public partial class WebForm142 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        { 
                string email = (string)Session["email"];
            tbEmailShow.Text = email;
        }

        protected void updatePsw(string psw)
        {
            SqlConnection con;
            string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            con = new SqlConnection(strCon);
            con.Open();

            string strUpdate = "";

            if (Session["forgetUser"].ToString() == "student")
            {
                strUpdate = "UPDATE Student SET stud_password = @psw WHERE stud_email = @email";
            }
            else
            {
                strUpdate = "UPDATE Tutor SET tutor_password = @psw WHERE tutor_email = @email";
            }
            SqlCommand cmdUpdate = new SqlCommand(strUpdate, con);
            cmdUpdate.Parameters.AddWithValue("@psw", psw);
            cmdUpdate.Parameters.AddWithValue("@email", (string)this.Session["email"]);
            cmdUpdate.ExecuteNonQuery();
            con.Close();
        }

        protected void sendNewPsw()
        {
            string email = (string)Session["email"];

            string psw = "Asd!!";
            Random random = new Random();
            psw += random.Next(100, 999).ToString();

            using (MailMessage mm = new MailMessage("ezfit2113@gmail.com", email))
            {
                mm.Subject = "Recovery Password";
                string body = "";
                body += "<h1>Hello User, </h1>";
                body += "<p>Recovery password: " + psw + "</p>";
                mm.Body = body;
                mm.IsBodyHtml = true;
                SmtpClient smtpClient = new SmtpClient();
                smtpClient.Host = "smtp.gmail.com";
                smtpClient.UseDefaultCredentials = false;
                NetworkCredential networkCred = new NetworkCredential("ezfit2113@gmail.com", "kthhselbmjbxakmi");
                smtpClient.Credentials = networkCred;
                smtpClient.EnableSsl = true;
                smtpClient.Port = 587;
                smtpClient.Send(mm);
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Recovery password sent!') ", true);
            }

            updatePsw(psw);
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string codeGiven = (string)this.Session["otpCode"];
            DateTime otpSentTime = (DateTime)this.Session["otpSentTime"];

            string otpCode = tbCode.Text;
            DateTime currentTime = DateTime.Now;

            if (otpCode.Length == 6)
            {
                if (currentTime.Subtract(otpSentTime) >= TimeSpan.FromMinutes(10))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('OTP is expried!') ", true);
                }
                else
                {
                    if (otpCode == codeGiven)
                    {
                        if (Session["forget"] != null)
                        {
                            if (Session["forget"].ToString() == "T")
                            {
                                sendNewPsw();
                                Response.Redirect("Login.aspx");
                            }
                        }
                        else
                        {
                            Response.Redirect("Registration.aspx");
                        }
                    }
                    else
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Invalid OTP!') ", true);
                }
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('OTP is in 6 numbers') ", true);
            }

        }

        protected void btnResend_Click(object sender, EventArgs e)
        {
            string email = (string)this.Session["Email"];

            //Create OTP code
            Random random = new Random();
            string otpCode = random.Next(100000, 999999).ToString();

            using (MailMessage mm = new MailMessage("ezfit2113@gmail.com", email))
            {
                mm.Subject = "Sign Up OTP";
                string body = "";
                body += "<h1>Hello User, </h1>";
                body += "<p>OTP code: " + otpCode + "</p>";
                body += "<p><b>Only valid for 10 mins</b></p>";
                mm.Body = body;
                mm.IsBodyHtml = true;
                SmtpClient smtpClient = new SmtpClient();
                smtpClient.Host = "smtp.gmail.com";
                smtpClient.UseDefaultCredentials = false;
                NetworkCredential networkCred = new NetworkCredential("ezfit2113@gmail.com", "kthhselbmjbxakmi");
                smtpClient.Credentials = networkCred;
                smtpClient.EnableSsl = true;
                smtpClient.Port = 587;
                smtpClient.Send(mm);
            }

            DateTime otpSentTime = DateTime.Now;
            this.Session["otpCode"] = otpCode;
            this.Session["otpSentTime"] = otpSentTime;
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Email resent!') ", true);

        }
    }
}