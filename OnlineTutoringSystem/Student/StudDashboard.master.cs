using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineTutoringSystem
{
    public partial class StudDashboard : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSettings_Click(object sender, EventArgs e)
        {
            Response.Redirect("StudAccount.aspx");

        }

        protected void btnWishlist_Click(object sender, EventArgs e)
        {
            Response.Redirect("StudWishlist.aspx");

        }
    }
}