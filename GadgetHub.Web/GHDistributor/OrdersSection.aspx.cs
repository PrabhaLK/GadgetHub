using GadgetHub.Web.GHServiceRef;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;

namespace GadgetHub.Web.GHDistributor
{
    public partial class OrdersSection : System.Web.UI.Page
    {
        private GadgetHubServiceClient service = new GadgetHubServiceClient();
        private int distributorId;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Assume distributor ID stored in session after login
                if (Session["UserId"] != null && int.TryParse(Session["UserId"].ToString(), out int id))
                {
                    distributorId = id;
                    ViewState["DistributorId"] = distributorId;
                    LoadOrders();
                }
                else
                {
                    Response.Redirect("~/Login.aspx");
                }
            }
            else
            {
                if (ViewState["DistributorId"] != null)
                    distributorId = (int)ViewState["DistributorId"];
            }
        }

        private void LoadOrders()
        {
            var orders = service.GetOrdersForDistributor(distributorId);
            gvOrders.DataSource = orders;
            gvOrders.DataBind();

            pnlOrderItems.Visible = false;
        }

        protected void gvOrders_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "UpdateStatus")
            {
                int orderId = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = ((System.Web.UI.WebControls.Button)e.CommandSource).NamingContainer as GridViewRow;

                DropDownList ddlStatus = (DropDownList)row.FindControl("ddlStatus");
                string newStatus = ddlStatus.SelectedValue;

                bool success = service.UpdateOrderStatus(orderId, newStatus);

                if (success)
                {
                    LoadOrders();
                    // Optionally show success message
                }
                else
                {
                    // Optionally show error message
                }
            }
        }

        // Optional: Show order items when selecting an order (not wired to UI yet)
        protected void gvOrders_SelectedIndexChanged(object sender, EventArgs e)
        {
            int orderId = Convert.ToInt32(gvOrders.SelectedDataKey.Value);
            var orders = service.GetOrdersForDistributor(distributorId);
            var selectedOrder = orders.FirstOrDefault(o => o.Id == orderId);
            if (selectedOrder != null)
            {
                lblSelectedOrderId.Text = orderId.ToString();
                gvOrderItems.DataSource = selectedOrder.Items;
                gvOrderItems.DataBind();
                pnlOrderItems.Visible = true;
            }
        }

        protected void btnCloseItems_Click(object sender, EventArgs e)
        {
            pnlOrderItems.Visible = false;
        }
    }
}
