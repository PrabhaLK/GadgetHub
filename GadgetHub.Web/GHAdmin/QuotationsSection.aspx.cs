using System;
using System.Data;
using System.Linq;

namespace GadgetHub.Web.GHAdmin
{
    public partial class QuotationsSection : System.Web.UI.Page
    {
        private GHServiceRef.GadgetHubServiceClient service = new GHServiceRef.GadgetHubServiceClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadQuotations();
            }
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
    }
}
