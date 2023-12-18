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
    public partial class WebForm14 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Session["forget"] = "T";
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

            protected Boolean checkEmailExist2(string email)
            {
                SqlConnection con;
                string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

                con = new SqlConnection(strCon);
                con.Open();
                string cmdText = "SELECT * FROM Student where stud_email = '" + email + "'";
                SqlCommand cmd = new SqlCommand(cmdText, con);
                SqlDataReader dtr = cmd.ExecuteReader();
                if (dtr.HasRows)
                {
                    Session["forgetUser"] = "student";
                    return true;
                }
                else
                {
                    con.Close();
                    con.Open();
                    cmdText = "SELECT * FROM Tutor where tutor_email = '" + email + "'";
                    cmd = new SqlCommand(cmdText, con);
                    dtr = cmd.ExecuteReader();
                    if (dtr.HasRows)
                    {
                        Session["forgetUser"] = "tutor";
                        return true;
                    }
                }

                con.Close();
                return false;
            }

            protected void btnSend_Click(object sender, EventArgs e)
            {
                string email = tbEmail.Text;
                if (Session["forget"] != null)
                {
                    if (Session["forget"].ToString() == "T")
                    {
                        if (checkEmailExist2(email))
                        {
                            Session["email"] = email;

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
                                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Email sent!') ", true);
                            }

                            DateTime otpSentTime = DateTime.Now;
                            this.Session["otpCode"] = otpCode;
                            this.Session["otpSentTime"] = otpSentTime;
                            Response.Redirect("VerifyEmail.aspx");
                        }
                        else
                        {
                            string script = "alert(\"This email is not yet registered for our website!\");";
                            ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
                        }
                    }
                }
                else
                {
                    if (checkEmailExist(email))
                    {
                        string script = "alert(\"This email already used!\");";
                        ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
                    }
                    else
                    {
                        Session["email"] = email;

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
                            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Email sent!') ", true);
                        }

                        DateTime otpSentTime = DateTime.Now;
                        this.Session["otpCode"] = otpCode;
                        this.Session["otpSentTime"] = otpSentTime;
                        Response.Redirect("VerifyEmail.aspx");
                    }
                }


            }
        }
    }