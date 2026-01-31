using System;
using System.Collections.Generic;
using System.Linq;
using GadgetHub.Web.GHServiceRef;

namespace GadgetHub.Web
{
    public partial class CheckoutPage : System.Web.UI.Page
    {
        protected GadgetHubServiceClient serviceClient;

        protected void Page_Load(object sender, EventArgs e)
        {
            serviceClient = new GadgetHubServiceClient();

            if (!IsPostBack)
            {
                LoadOrderSummary();
            }
        }

        private void LoadOrderSummary()
        {
            if (Session["UserId"] != null)
            {
                int userId = Convert.ToInt32(Session["UserId"]);
                var cartItems = serviceClient.GetCartItems(userId);

                if (cartItems != null && cartItems.Length > 0)
                {
                    rptOrderItems.DataSource = cartItems;
                    rptOrderItems.DataBind();

                    int total = cartItems.Sum(item => item.Price * item.Qty);
                    lblTotal.Text = total.ToString();
                }
            }
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] != null)
            {
                int userId = Convert.ToInt32(Session["UserId"]);
                string deliveryAddress = "Default Address (Or retrieve from user profile later)";
                bool success = serviceClient.PlaceOrder(userId, deliveryAddress);

                if (success)
                {
                    Response.Redirect("OrderSuccess.aspx");
                }
                else
                {
                    // Optional: Show error message
                }
            }
        }
        protected void btnContinueShopping_Click(object sender, EventArgs e)
        {
            Response.Redirect("HomePage.aspx");
        }
    }
}
