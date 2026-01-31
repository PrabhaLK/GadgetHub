using GadgetHub.Web.GHServiceRef;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GadgetHub.Web.GHCustomer
{
    public partial class DashboardCustomer : System.Web.UI.Page
    {
        private GHServiceRef.GadgetHubServiceClient service = new GHServiceRef.GadgetHubServiceClient();

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

            var ordersArray = service.GetOrdersByUserId(userId);
            var orders = ordersArray.ToList();

            gvOrders.DataSource = orders;
            gvOrders.DataBind();
        }

        protected void gvOrders_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                var order = (GHServiceRef.OrderDTO)e.Row.DataItem;
                var phOrderItems = (PlaceHolder)e.Row.FindControl("phOrderItems");

                if (order.Items != null && order.Items.Any())
                {
                    System.Text.StringBuilder sb = new System.Text.StringBuilder();
                    sb.Append("<table class='order-items'>");
                    sb.Append("<tr><th>Product</th><th>Quantity</th></tr>");

                    foreach (var item in order.Items)
                    {
                        sb.AppendFormat("<tr><td>{0}</td><td>{1}</td></tr>", item.ProductName, item.Qty);
                    }

                    sb.Append("</table>");
                    phOrderItems.Controls.Add(new LiteralControl(sb.ToString()));
                }
                else
                {
                    phOrderItems.Controls.Add(new LiteralControl("<i>No items</i>"));
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
    }
}
