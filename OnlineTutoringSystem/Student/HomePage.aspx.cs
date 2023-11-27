using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineTutoringSystem
{
    public partial class WebForm3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        //change color for card
        protected string GetCardColor(int index)
        {
            string[] colors = { "#EBEBFF", "#E1F7E3", "#FFF2E5", "#FFF0F0", "#F5F7FA" };
            return colors[index % colors.Length];
        }


        protected void btnCreateAccount_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Entry/Registration.aspx");
        }

        protected void LinkButton13_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Student/Course.aspx");
        }

        protected void LinkButton19_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Entry/Registration.aspx");
        } 
    }
}