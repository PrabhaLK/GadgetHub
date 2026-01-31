using System;
using System.Collections.Generic;
using System.Linq;

namespace GadgetHub.Web.GHAdmin
{
    public partial class ProductsSection : System.Web.UI.Page
    {
        private GHServiceRef.GadgetHubServiceClient service = new GHServiceRef.GadgetHubServiceClient();

        // Cache loaded products for filtering
        private List<GHServiceRef.ProductDTO> products;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();
                LoadProducts();
            }
        }

        private void LoadCategories()
        {
            ddlCategory.Items.Clear();
            ddlCategory.Items.Add(new System.Web.UI.WebControls.ListItem("All Categories", ""));

            // Load categories from your service
            var categories = service.GetCategories();
            foreach (var cat in categories)
            {
                ddlCategory.Items.Add(new System.Web.UI.WebControls.ListItem(cat.Name, cat.Id.ToString()));
            }
        }

        private void LoadProducts()
        {
            var productArray = service.GetAllProducts(null, null, null);
            products = productArray.ToList();

            FilterAndBind();
        }

        private void FilterAndBind()
        {
            string search = txtSearch.Text?.Trim().ToLower() ?? "";
            string selectedCategory = ddlCategory.SelectedValue;
            string selectedStatus = ddlStatus.SelectedValue;

            var filtered = products.AsEnumerable();

            if (!string.IsNullOrEmpty(search))
            {
                filtered = filtered.Where(p =>
                    (!string.IsNullOrEmpty(p.Name) && p.Name.ToLower().Contains(search)) ||
                    (!string.IsNullOrEmpty(p.CategoryName) && p.CategoryName.ToLower().Contains(search)) ||
                    (!string.IsNullOrEmpty(p.DistributorName) && p.DistributorName.ToLower().Contains(search))
                );
            }

            if (!string.IsNullOrEmpty(selectedCategory) && int.TryParse(selectedCategory, out int catId))
            {
                filtered = filtered.Where(p => p.CategoryId == catId);
            }

            if (!string.IsNullOrEmpty(selectedStatus) && int.TryParse(selectedStatus, out int isActive))
            {
                filtered = filtered.Where(p => p.IsActive == isActive);
            }

            gvProducts.DataSource = filtered.ToList();
            gvProducts.DataBind();
        }

        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            FilterAndBind();
        }

        protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            FilterAndBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            FilterAndBind();
        }
    }

    public class ProductDTO
    {
        public int? Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public int? Price { get; set; }
        public string Image { get; set; }
        public int? Stock { get; set; }
        public int? CategoryId { get; set; }
        public string CategoryName { get; set; }
        public int? DistributorId { get; set; }
        public string DistributorName { get; set; }
        public int? IsActive { get; set; }
    }

    public class CategoryDTO
    {
        public int Id { get; set; }
        public string Name { get; set; }
    }
}
