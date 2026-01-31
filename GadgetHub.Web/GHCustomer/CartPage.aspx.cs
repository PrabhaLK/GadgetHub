using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using GadgetHub.Web.GHServiceRef;

namespace GadgetHub.Web
{
    public partial class CartPage : System.Web.UI.Page
    {
        protected GadgetHubServiceClient serviceClient;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            serviceClient = new GadgetHubServiceClient();

            if (!IsPostBack)
            {
                LoadCartItems();
            }
        }

        private void LoadCartItems()
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            var cartItems = serviceClient.GetCartItems(userId);

            if (cartItems != null && cartItems.Length > 0)
            {
                rptCartItems.DataSource = cartItems;
                rptCartItems.DataBind();
                pnlEmptyCart.Visible = false;
            }
            else
            {
                pnlEmptyCart.Visible = true;
            }
        }

        protected void btnIncreaseQty_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int productId = Convert.ToInt32(btn.CommandArgument);

            int userId = Convert.ToInt32(Session["UserId"]);
            serviceClient.UpdateCartItemQty(userId, productId, 1);

            LoadCartItems();
        }

        protected void btnDecreaseQty_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int productId = Convert.ToInt32(btn.CommandArgument);

            int userId = Convert.ToInt32(Session["UserId"]);
            serviceClient.UpdateCartItemQty(userId, productId, -1);

            LoadCartItems();
        }

        protected void btnRemoveItem_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int productId = Convert.ToInt32(btn.CommandArgument);

            int userId = Convert.ToInt32(Session["UserId"]);
            serviceClient.RemoveCartItem(userId, productId);

            LoadCartItems();
        }

        protected void btnProceedCheckout_Click(object sender, EventArgs e)
        {
            // For now, redirect to a simple Checkout Page.
            Response.Redirect("CheckoutPage.aspx");
        }

        protected void btnContinueShopping_Click(object sender, EventArgs e)
        {
            Response.Redirect("HomePage.aspx");
        }
    }
}
