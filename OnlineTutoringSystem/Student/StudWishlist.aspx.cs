﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineTutoringSystem.Student
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if the wishlist is empty
            if (DataListCourses.Items.Count == 0)
            {
                Checkwl.Visible = true;
            }
            else
            {

                Checkwl.Visible = false;
            }
        }

        protected string GetCardColor(int index)
        {
            string[] colors = { "#EBEBFF", "#E1F7E3", "#FFF2E5", "#FFF0F0", "#F5F7FA" };
            return colors[index % colors.Length];
        }

        protected void DataListCourses_SelectedIndexChanged(object sender, EventArgs e)
        {
            string courseId = Session["courseId"] as string;
            // Display a window alert with the session ID
            ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Session ID: {Session["courseId"]}');", true);

            // Use courseId as needed
            Response.Redirect("CourseOverview.aspx");
        }

        protected void selectBtn_Command(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {
                string courseId = e.CommandArgument.ToString();

                // Store the course_id in a session variable
                Session["courseId"] = courseId;

                // Redirect or perform any other actions
                Response.Redirect("CourseOverview.aspx");
            }
        }

    }
}