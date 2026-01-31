using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GadgetHub.Web.GHServiceRef; 

namespace GadgetHub.Web
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            litLoginText.Text = "Already have an account? ";
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            GadgetHubServiceClient client = new GadgetHubServiceClient();
            bool result = client.RegisterUser(
                txtFirstName.Text, 
                txtLastName.Text, 
                txtPhoneNumber.Text, 
                txtUsername.Text, 
                txtPassword.Text, 
                txtEmail.Text, 
                "customer");

            if (result)
                lblStatus.Text = "Registration successful!";
            else
                lblStatus.Text = "Registration failed!";
        }

    }
}