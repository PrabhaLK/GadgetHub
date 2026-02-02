using GadgetHub.Web.GHServiceRef;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.UI;

namespace GadgetHub.Web.GHDistributor
{
    public partial class QuotationsSection : Page
    {
        private GadgetHubServiceClient service = new GadgetHubServiceClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMessage.Visible = false;
                lblMessage.Text = string.Empty;
                LoadQuotations();
            }
        }

        private int GetLoggedInDistributorId()
        {
            if (Session["UserId"] != null && int.TryParse(Session["UserId"].ToString(), out int distributorId))
            {
                return distributorId;
            }

            // Not logged in; send to login page
            Response.Redirect("~/Login.aspx", endResponse: true);
            return -1;
        }

        private void LoadQuotations()
        {
            phQuotations.Controls.Clear();

            int distributorId = GetLoggedInDistributorId();
            var quotationsArray = service.GetQuotationsByDistributor(distributorId);
            List<QuotationDTO> quotations = quotationsArray.ToList();

            if (quotations.Count == 0)
            {
                phQuotations.Controls.Add(new LiteralControl("<div class='empty-state'>No quotations found.</div>"));
                return;
            }

            foreach (var quote in quotations)
            {
                var builder = new StringBuilder();
                builder.Append("<div class='quote-card'><div class='quote-body'>");

                builder.Append("<div class='quote-meta'>");
                builder.Append($"<span>Quotation # {quote.QuotationId}</span>");

                string status = string.IsNullOrEmpty(quote.Status) ? "Pending" : quote.Status;
                builder.Append($"<span>Status: {Server.HtmlEncode(status)}</span>");

                if (quote.CreatedAt.HasValue)
                {
                    builder.Append($"<span>Created: {quote.CreatedAt.Value:yyyy-MM-dd}</span>");
                }

                var items = quote.Items ?? new QuotationItemDTO[0];
                int itemCount = items.Length;
                builder.Append($"<span>Items: {itemCount}</span>");
                builder.Append("</div>");

                builder.Append("<div class='quote-table-scroll'><table><thead><tr><th>Product</th><th>Quantity</th><th>Price</th><th>Total</th><th>Action</th></tr></thead><tbody>");

                foreach (var item in items)
                {
                    string qtyId = $"qty_{quote.QuotationId}_{item.ProductId}";
                    string priceId = $"price_{quote.QuotationId}_{item.ProductId}";
                    decimal lineTotal = item.Price * item.Quantity;

                    builder.Append("<tr>");
                    builder.Append($"<td>{Server.HtmlEncode(item.ProductName)}</td>");
                    builder.Append($"<td><input type='number' id='{qtyId}' value='{item.Quantity}' min='0' step='1' /></td>");
                    builder.Append($"<td><input type='text' id='{priceId}' value='{item.Price:F2}' /></td>");
                    builder.Append($"<td>{lineTotal:F2}</td>");
                    builder.Append($"<td><button type='button' class='btn-update' onclick=\"updateQuotationItem({quote.QuotationId}, {item.ProductId})\">Update</button></td>");
                    builder.Append("</tr>");
                }

                builder.Append("</tbody></table></div></div></div>");

                phQuotations.Controls.Add(new LiteralControl(builder.ToString()));
            }
        }

        protected override void RaisePostBackEvent(IPostBackEventHandler sourceControl, string eventArgument)
        {
            if (sourceControl == null && !string.IsNullOrEmpty(eventArgument))
            {
                // eventArgument format: "UpdateItem" is sent by __doPostBack('UpdateItem', args)
                // But our JS triggers __doPostBack with custom arguments, so use Request["__EVENTTARGET"] and __EVENTARGUMENT

                string eventTarget = Request["__EVENTTARGET"];
                string eventArgs = Request["__EVENTARGUMENT"];

                if (eventTarget == "UpdateItem")
                {
                    var args = eventArgs.Split(',');
                    if (args.Length == 4 &&
                        int.TryParse(args[0], out int quotationId) &&
                        int.TryParse(args[1], out int productId) &&
                        int.TryParse(args[2], out int qty) &&
                        decimal.TryParse(args[3], out decimal price))
                    {
                        bool success = service.UpdateQuotationItem(quotationId, productId, qty, price);
                        LoadQuotations();

                        if (success)
                        {
                            lblMessage.Text = "Update successful.";
                            lblMessage.CssClass = "feedback feedback-success";
                        }
                        else
                        {
                            lblMessage.Text = "Update failed.";
                            lblMessage.CssClass = "feedback feedback-error";
                        }

                        lblMessage.Visible = true;
                    }
                    else
                    {
                        lblMessage.Text = "Invalid update parameters.";
                        lblMessage.CssClass = "feedback feedback-error";
                        lblMessage.Visible = true;
                    }
                }
            }
            base.RaisePostBackEvent(sourceControl, eventArgument);
        }
    }
}
