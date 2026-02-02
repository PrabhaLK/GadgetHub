using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GadgetHub.Web.GHAdmin
{
    public partial class OrdersSection : System.Web.UI.Page
    {
        private readonly GHServiceRef.GadgetHubServiceClient service = new GHServiceRef.GadgetHubServiceClient();
        private List<GHServiceRef.OrderDTO> orders;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadOrders();
            }
        }

        private void LoadOrders()
        {
            var orderArray = service.GetAllOrders();
            orders = orderArray.ToList();

            FilterAndBind();
        }

        private void FilterAndBind()
        {
            string search = txtSearch.Text?.Trim().ToLower() ?? "";

            var filtered = orders.AsEnumerable();

            if (!string.IsNullOrEmpty(search))
            {
                filtered = filtered.Where(o =>
                    (!string.IsNullOrEmpty(o.UserName) && o.UserName.ToLower().Contains(search)) ||
                    (!string.IsNullOrEmpty(o.Status) && o.Status.ToLower().Contains(search))
                );
            }

            gvOrders.DataSource = filtered.ToList();
            gvOrders.DataBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            FilterAndBind();
        }

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            gvOrders.RowDataBound += gvOrders_RowDataBound;
        }

        protected void gvOrders_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow)
            {
                return;
            }

            var order = (GHServiceRef.OrderDTO)e.Row.DataItem;
            var phOrderItems = (PlaceHolder)e.Row.FindControl("phOrderItems");
            var lblStatus = (Label)e.Row.FindControl("lblStatus");

            if (lblStatus != null)
            {
                var statusText = lblStatus.Text?.Trim() ?? string.Empty;
                lblStatus.Text = string.IsNullOrWhiteSpace(statusText) ? "Unknown" : statusText;
                lblStatus.CssClass = "status-pill " + GetStatusClass(statusText);
            }

            if (order?.Items != null && order.Items.Any())
            {
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append("<table class='order-items'>");
                sb.Append("<tr><th>Product</th><th>Quantity</th></tr>");

                foreach (var item in order.Items)
                {
                    sb.AppendFormat("<tr><td>{0}</td><td>{1}</td></tr>", item.ProductName, item.Qty);
                }

                sb.Append("</table>");
                phOrderItems?.Controls.Add(new LiteralControl(sb.ToString()));
            }
            else
            {
                phOrderItems?.Controls.Add(new LiteralControl("<i>No items</i>"));
            }
        }

        protected void gvOrders_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "UpdateStatus")
            {
                int orderId = Convert.ToInt32(e.CommandArgument);
            }
        }

        private static string GetStatusClass(string status)
        {
            var normalized = (status ?? string.Empty).Trim().ToLowerInvariant();

            switch (normalized)
            {
                case "pending":
                    return "status-pending";
                case "completed":
                case "processed":
                case "shipped":
                    return "status-complete";
                case "cancelled":
                case "canceled":
                    return "status-cancelled";
                default:
                    return "status-neutral";
            }
        }

    }
}
