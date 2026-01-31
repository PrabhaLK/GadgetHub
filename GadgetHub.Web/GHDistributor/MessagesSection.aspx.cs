using System;
using System.Linq;
using System.Web.UI;
using GadgetHub.Web.GHServiceRef; // Your service reference namespace

namespace GadgetHub.Web.GHUser
{
    public partial class MessagesSection : Page
    {
        private GadgetHubServiceClient service = new GadgetHubServiceClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadMessages();
            }
        }

        private void LoadMessages()
        {
            int userId = GetLoggedInUserId();

            var messagesArray = service.GetMessagesByUser(userId);
            var messages = messagesArray.ToList();

            phMessages.Controls.Clear();

            if (messages.Count == 0)
            {
                phMessages.Controls.Add(new LiteralControl("<p class='no-messages'>No messages found.</p>"));
                return;
            }

            var html = "<table><thead><tr><th>Date</th><th>Subject</th><th>Message</th></tr></thead><tbody>";

            foreach (var msg in messages)
            {
                html += $"<tr>" +
                        $"<td>{msg.Timestamp?.ToString("yyyy-MM-dd HH:mm")}</td>" +
                        $"<td>{Server.HtmlEncode(msg.Subject)}</td>" +
                        $"<td>{Server.HtmlEncode(msg.Message)}</td>" +
                        $"</tr>";
            }

            html += "</tbody></table>";

            phMessages.Controls.Add(new LiteralControl(html));
        }

        private int GetLoggedInUserId()
        {
            // Retrieve the logged in user id from session or authentication
            // Example:
            if (Session["UserId"] != null)
            {
                return (int)Session["UserId"];
            }
            else
            {
                // Not logged in, redirect to login or throw error
                Response.Redirect("~/Login.aspx");
                return -1; // unreachable
            }
        }
    }
}
