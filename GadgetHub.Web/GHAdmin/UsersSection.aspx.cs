using GadgetHub.Web.GHServiceRef;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GadgetHub.Web.GHAdmin
{
    public partial class UsersSection : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadUsers();
            }
        }

        protected void LoadUsers()
        {
            string role = ddlRole.SelectedValue;
            string search = txtSearch.Text.Trim();

            var client = new GadgetHubServiceClient();
            gvUsers.DataSource = client.GetUsers(role, search);
            gvUsers.DataBind();
        }

        protected void ddlRole_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadUsers();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadUsers();
        }

        protected void btnToggle_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int userId = int.Parse(btn.CommandArgument);

            var client = new GadgetHubServiceClient();
            client.ToggleUserStatus(userId); // We will create this method next
            LoadUsers();
        }

    }
}