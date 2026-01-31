using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GadgetHub.Web.GHAdmin
{
    public partial class DashboardAdmin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Example: pull from session
                if (Session["Email"] != null)
                {
                    lblAdminEmail.Text = Session["Email"].ToString();
                }
                else
                {
                    Session.Clear();
                    Response.Redirect("~/Login.aspx");
                }
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Clear session and redirect to login
            Session.Clear();
            Response.Redirect("~/Login.aspx");
        }
    }
}