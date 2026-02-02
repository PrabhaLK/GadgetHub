using System;
using System.Data;
using System.Linq;

namespace GadgetHub.Web.GHAdmin
{
    public partial class QuotationsSection : System.Web.UI.Page
    {
        private readonly GHServiceRef.GadgetHubServiceClient service = new GHServiceRef.GadgetHubServiceClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadQuotations();
            }
        }

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            gvQuotations.RowDataBound += gvQuotations_RowDataBound;
        }

        private void LoadQuotations(string status = "", string search = "")
        {
            var quotations = service.GetAllQuotations();

            var filtered = quotations.AsQueryable();

            if (!string.IsNullOrEmpty(status))
            {
                filtered = filtered.Where(q => q.Status.Equals(status, StringComparison.OrdinalIgnoreCase));
            }

            if (!string.IsNullOrEmpty(search))
            {
                filtered = filtered.Where(q =>
                    (q.DistributorName != null && q.DistributorName.IndexOf(search, StringComparison.OrdinalIgnoreCase) >= 0) ||
                    q.DistributorId.ToString() == search);
            }

            gvQuotations.DataSource = filtered.ToList();
            gvQuotations.DataBind();
        }

        protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadQuotations(ddlStatus.SelectedValue, txtSearch.Text.Trim());
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadQuotations(ddlStatus.SelectedValue, txtSearch.Text.Trim());
        }

        protected void gvQuotations_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
        {
            if (e.Row.RowType != System.Web.UI.WebControls.DataControlRowType.DataRow)
            {
                return;
            }

            var label = e.Row.FindControl("lblStatus") as System.Web.UI.WebControls.Label;
            if (label == null)
            {
                return;
            }

            var status = Convert.ToString(label.Text ?? string.Empty).Trim().ToLowerInvariant();

            string pillClass;
            switch (status)
            {
                case "approved":
                    pillClass = "status-pill status-approved";
                    break;
                case "rejected":
                    pillClass = "status-pill status-rejected";
                    break;
                case "pending":
                    pillClass = "status-pill status-pending";
                    break;
                default:
                    pillClass = "status-pill status-neutral";
                    break;
            }

            label.CssClass = pillClass;
            label.Text = string.IsNullOrWhiteSpace(label.Text) ? "Unknown" : label.Text;
        }
    }
}
