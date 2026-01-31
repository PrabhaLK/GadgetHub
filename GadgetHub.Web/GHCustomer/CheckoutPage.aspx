<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CheckoutPage.aspx.cs" Inherits="GadgetHub.Web.CheckoutPage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Checkout - Gadget Hub</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f7f9fc;
            margin: 0;
            padding: 0;
            color: #2c3e50;
        }
        .order-summary {
            max-width: 600px;
            margin: 50px auto;
            padding: 30px 40px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 8px 25px rgba(41, 128, 185, 0.15);
        }
        h2 {
            color: #2980b9;
            font-weight: 700;
            margin-bottom: 25px;
            user-select: none;
        }
        .product-item {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #e1e8f0;
            font-size: 1em;
            user-select: none;
        }
        .product-item:last-child {
            border-bottom: none;
        }
        .total {
            font-weight: 700;
            font-size: 1.3em;
            text-align: right;
            margin-top: 30px;
            color: #34495e;
            user-select: none;
        }
        .button-group {
            display: flex;
            justify-content: space-between;
            margin-top: 40px;
        }
        .checkout-btn,
        .continue-shopping-btn {
            padding: 14px 28px;
            font-size: 1.1em;
            border-radius: 8px;
            font-weight: 700;
            border: none;
            cursor: pointer;
            user-select: none;
            transition: background-color 0.3s ease;
            min-width: 45%;
            text-align: center;
        }
        .checkout-btn {
            background-color: #2980b9;
            color: white;
            box-shadow: 0 5px 15px rgba(41, 128, 185, 0.4);
        }
        .checkout-btn:hover {
            background-color: #3498db;
        }
        .checkout-btn:active {
            background-color: #1c5980;
        }
        .continue-shopping-btn {
            background-color: #7f8c8d;
            color: white;
            box-shadow: 0 5px 15px rgba(127, 140, 141, 0.4);
        }
        .continue-shopping-btn:hover {
            background-color: #95a5a6;
        }
        .continue-shopping-btn:active {
            background-color: #626d70;
        }
        @media (max-width: 500px) {
            .button-group {
                flex-direction: column;
                gap: 15px;
            }
            .checkout-btn,
            .continue-shopping-btn {
                min-width: 100%;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="order-summary">
            <h2>Order Summary</h2>
            <asp:Repeater ID="rptOrderItems" runat="server">
                <ItemTemplate>
                    <div class="product-item">
                        <div><%# Eval("ProductName") %> (x<%# Eval("Qty") %>)</div>
                        <div>LKR <%# Convert.ToInt32(Eval("Price")) * Convert.ToInt32(Eval("Qty")) %></div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <div class="total">
                Total: LKR <asp:Label ID="lblTotal" runat="server" Text="0"></asp:Label>
            </div>
            <div class="button-group">
                <asp:Button ID="btnContinueShopping" runat="server" Text="Continue Shopping" CssClass="continue-shopping-btn" OnClick="btnContinueShopping_Click" />
                <asp:Button ID="btnPlaceOrder" runat="server" Text="Place Order" CssClass="checkout-btn" OnClick="btnPlaceOrder_Click" />
            </div>
        </div>
    </form>
</body>
</html>
