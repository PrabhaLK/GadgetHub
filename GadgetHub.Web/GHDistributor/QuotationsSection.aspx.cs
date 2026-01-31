using GadgetHub.Web.GHServiceRef;
using System;
using System.Collections.Generic;
using System.Linq;
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
                LoadQuotations();
            }
        }

        private int GetLoggedInDistributorId()
        {
            // TODO: Replace with session or auth context
            return 1004;  // example fixed distributor id
        }

        private void LoadQuotations()
        {
            phQuotations.Controls.Clear();

            int distributorId = GetLoggedInDistributorId();
            var quotationsArray = service.GetQuotationsByDistributor(distributorId);
            List<QuotationDTO> quotations = quotationsArray.ToList();

            if (quotations.Count == 0)
            {
                phQuotations.Controls.Add(new LiteralControl("<p>No quotations found.</p>"));
                return;
            }

            foreach (var quote in quotations)
            {
                phQuotations.Controls.Add(new LiteralControl($"<h3>Quotation #{quote.QuotationId} - Status: {quote.Status} - Created At: {quote.CreatedAt?.ToString("yyyy-MM-dd")}</h3>"));

                phQuotations.Controls.Add(new LiteralControl("<table>"));
                phQuotations.Controls.Add(new LiteralControl("<tr><th>Product</th><th>Quantity</th><th>Price</th><th>Total</th><th>Action</th></tr>"));

                foreach (var item in quote.Items)
                {
                    string qtyId = $"qty_{quote.QuotationId}_{item.ProductId}";
                    string priceId = $"price_{quote.QuotationId}_{item.ProductId}";

                    phQuotations.Controls.Add(new LiteralControl("<tr>"));
                    phQuotations.Controls.Add(new LiteralControl($"<td>{item.ProductName}</td>"));
                    phQuotations.Controls.Add(new LiteralControl($"<td><input type='number' id='{qtyId}' value='{item.Quantity}' min='0' /></td>"));
                    phQuotations.Controls.Add(new LiteralControl($"<td><input type='text' id='{priceId}' value='{item.Price:F2}' /></td>"));
                    phQuotations.Controls.Add(new LiteralControl($"<td>{(item.Price * item.Quantity):F2}</td>"));
                    phQuotations.Controls.Add(new LiteralControl($"<td><button type='button' class='btn-update' onclick=\"updateQuotationItem({quote.QuotationId}, {item.ProductId})\">Update</button></td>"));
                    phQuotations.Controls.Add(new LiteralControl("</tr>"));
                }

                phQuotations.Controls.Add(new LiteralControl("</table>"));
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
                        lblMessage.Text = success ? "Update successful." : "Update failed.";
                        LoadQuotations();
                    }
                    else
                    {
                        lblMessage.Text = "Invalid update parameters.";
                    }
                }
            }
            base.RaisePostBackEvent(sourceControl, eventArgument);
        }
    }
}
