using GadgetHub.Web.GHServiceRef; // Namespace of your service reference
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.UI.WebControls;

namespace GadgetHub.Web
{
    public partial class HomePage : System.Web.UI.Page
    {
        protected GadgetHubServiceClient serviceClient;
        public int CartCount = 0;  // For displaying cart count in header
        protected void Page_Load(object sender, EventArgs e)
        {
            serviceClient = new GadgetHubServiceClient();

            if (!IsPostBack)
            {
                LoadCategories();
                LoadProducts();
            }

            LoadCartCount();  // Always refresh cart count 
        }

        private void LoadCategories()
        {
            var categories = serviceClient.GetCategories();
            rptCategories.DataSource = categories;
            rptCategories.DataBind();
        }

        private void LoadProducts(string searchTerm = "", List<int> selectedCategoryIds = null)
        {
            var products = serviceClient.GetProducts(searchTerm, selectedCategoryIds?.ToArray() ?? new int[0]);
            rptProducts.DataSource = products;
            rptProducts.DataBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchTerm = txtSearch.Text.Trim();
            LoadProducts(searchTerm, GetSelectedCategoryIds());
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            LoadProducts(txtSearch.Text.Trim(), GetSelectedCategoryIds());
        }

        private List<int> GetSelectedCategoryIds()
        {
            List<int> selectedIds = new List<int>();

            foreach (RepeaterItem item in rptCategories.Items)
            {
                CheckBox chk = (CheckBox)item.FindControl("chkCategory");
                if (chk != null && chk.Checked)
                {
                    HiddenField hfId = (HiddenField)item.FindControl("hfCategoryId");
                    if (hfId != null)
                    {
                        selectedIds.Add(Convert.ToInt32(hfId.Value));
                    }
                }
            }

            return selectedIds;
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx"); // Must be logged in
                return;
            }

            int userId = Convert.ToInt32(Session["UserId"]);
            Button btn = (Button)sender;
            int productId = Convert.ToInt32(btn.CommandArgument);

            serviceClient.AddToCart(userId, productId, 1);

            // Reload cart count
            LoadCartCount();

            // Optional: Small success alert
            Response.Write("<script>alert('Product added to cart!');</script>");
        }

        private void LoadCartCount()
        {
            if (Session["UserId"] != null)
            {
                int userId = Convert.ToInt32(Session["UserId"]);
                CartCount = serviceClient.GetCartItemCount(userId);
            }
            else
            {
                CartCount = 0;
            }
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            Response.Redirect("CheckoutPage.aspx");
        }

        protected void btnDashboard_Click(object sender, EventArgs e)
        {
            Response.Redirect("DashboardCustomer.aspx");
        }
    }
}
