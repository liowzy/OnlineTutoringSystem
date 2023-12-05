﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineTutoringSystem
{
    public partial class TutorSideBar : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnMyCourses_Click(object sender, EventArgs e)
        {

        }

        protected void btnSchedule_Click(object sender, EventArgs e)
        {
            Response.Redirect("Schedule.aspx");
        }

        protected void btnProfile_Click(object sender, EventArgs e)
        {
            Response.Redirect("Profile.aspx");
        }

        protected void btnSignOut_Click(object sender, EventArgs e)
        {
            // Perform logout actions here if needed
            // ...

            // Redirect to the logout page
            Response.Redirect("../Entry/Logout.aspx");
        }

        protected void btnCreateNewCourse_Click(object sender, EventArgs e)
        {
            Response.Redirect("CreateNewCourse.aspx");
        }
    }
}