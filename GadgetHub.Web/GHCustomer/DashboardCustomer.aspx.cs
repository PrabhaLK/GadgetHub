using GadgetHub.Web.GHServiceRef;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GadgetHub.Web.GHCustomer
{
    public partial class DashboardCustomer : System.Web.UI.Page
    {
        private GHServiceRef.GadgetHubServiceClient service = new GHServiceRef.GadgetHubServiceClient();

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            if (rptOrders != null)
            {
                rptOrders.ItemDataBound += rptOrders_ItemDataBound;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadOrders();
            }
        }

        private void LoadOrders()
        {
            int userId = GetLoggedInUserId(); // Implement this to get current user's ID

            var ordersArray = service.GetOrdersByUserId(userId) ?? Array.Empty<GHServiceRef.OrderDTO>();
            var orders = ordersArray.ToList();

            rptOrders.DataSource = orders;
            rptOrders.DataBind();

            bool hasOrders = orders.Any();
            rptOrders.Visible = hasOrders;
            pnlEmptyOrders.CssClass = hasOrders ? "empty-state" : "empty-state show";
        }

        protected void rptOrders_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var order = (GHServiceRef.OrderDTO)e.Item.DataItem;
                var litTotal = (Literal)e.Item.FindControl("litTotal");
                var litDate = (Literal)e.Item.FindControl("litDate");
                var litStatus = (Literal)e.Item.FindControl("litStatus");
                var rptOrderItems = (Repeater)e.Item.FindControl("rptOrderItems");
                var litEmptyItems = (Literal)e.Item.FindControl("litEmptyItems");

                if (litTotal != null)
                {
                    decimal totalAmount = Convert.ToDecimal(order.Total);
                    litTotal.Text = $"LKR {totalAmount:N2}";
                }

                if (litDate != null)
                {
                    string formattedDate = order.CreatedAt.HasValue
                        ? order.CreatedAt.Value.ToString("yyyy-MM-dd HH:mm")
                        : string.Empty;
                    litDate.Text = formattedDate;
                }

                if (litStatus != null)
                {
                    string statusText = string.IsNullOrWhiteSpace(order.Status) ? "Pending" : order.Status;
                    string statusClass = statusText.Trim().ToLowerInvariant();
                    if (statusClass.Contains("complete"))
                    {
                        statusClass = "completed";
                    }
                    else if (statusClass.Contains("cancel"))
                    {
                        statusClass = "cancelled";
                    }
                    else
                    {
                        statusClass = "pending";
                    }

                    string safeStatusText = HttpUtility.HtmlEncode(statusText);
                    litStatus.Text = $"<span class='status-pill status-{statusClass}'>{safeStatusText}</span>";
                }

                if (rptOrderItems != null)
                {
                    var items = order.Items ?? Array.Empty<GHServiceRef.OrderItemDTO>();
                    bool hasLineItems = items.Any();
                    rptOrderItems.Visible = hasLineItems;

                    if (hasLineItems)
                    {
                        rptOrderItems.DataSource = items;
                        rptOrderItems.DataBind();
                    }
                    else
                    {
                        rptOrderItems.DataSource = null;
                        rptOrderItems.DataBind();
                    }

                    if (litEmptyItems != null)
                    {
                        if (hasLineItems)
                        {
                            litEmptyItems.Visible = false;
                        }
                        else
                        {
                            litEmptyItems.Text = "<div class='meta-value'>No items recorded for this order.</div>";
                            litEmptyItems.Visible = true;
                        }
                    }
                }
            }
        }

        // Dummy method — replace with actual user session or auth lookup
        private int GetLoggedInUserId()
        {
            if (Session["UserId"] != null && int.TryParse(Session["UserId"].ToString(), out int userId))
            {
                return userId;
            }
            else
            {
                // Handle the case when user ID is not in session - maybe redirect to login or throw
                throw new InvalidOperationException("User is not logged in.");
            }
        }

        protected void btnHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("HomePage.aspx");
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("~/Login.aspx");
        }
    }
}
