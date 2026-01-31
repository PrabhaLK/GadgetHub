using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GadgetHub.Web.GHAdmin
{
    public partial class ContactsSection : System.Web.UI.Page
    {
        private GHServiceRef.GadgetHubServiceClient service = new GHServiceRef.GadgetHubServiceClient();
        private List<GHServiceRef.ContactMessageDTO> messages;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadMessages();
            }
        }

        private void LoadMessages()
        {
            var messagesArray = service.GetAllContactMessages();
            messages = messagesArray.ToList();

            FilterAndBind();
        }

        private void FilterAndBind()
        {
            string search = txtSearch.Text?.Trim().ToLower() ?? "";

            var filtered = messages.AsEnumerable();

            if (!string.IsNullOrEmpty(search))
            {
                filtered = filtered.Where(m =>
                    (!string.IsNullOrEmpty(m.UserName) && m.UserName.ToLower().Contains(search)) ||
                    (!string.IsNullOrEmpty(m.Subject) && m.Subject.ToLower().Contains(search))
                );
            }

            gvMessages.DataSource = filtered.ToList();
            gvMessages.DataBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            FilterAndBind();
        }
    }
}