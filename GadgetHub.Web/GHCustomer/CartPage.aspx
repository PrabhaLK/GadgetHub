<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CartPage.aspx.cs" Inherits="GadgetHub.Web.CartPage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Your Cart - Gadget Hub</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f7f9fc;
            margin: 0;
            padding: 0;
            color: #2c3e50;
        }
        .cart-container {
            max-width: 900px;
            margin: 40px auto;
            padding: 30px 40px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(41, 128, 185, 0.15);
        }
        h1 {
            color: #2980b9;
            margin-bottom: 30px;
            font-weight: 700;
            font-size: 2em;
            user-select: none;
        }
        .cart-item {
            display: flex;
            align-items: center;
            border-bottom: 1px solid #e1e8f0;
            padding: 20px 0;
            gap: 20px;
        }
        .cart-item:last-child {
            border-bottom: none;
        }
        .cart-item img {
            max-width: 300px;
            height: 100px;
            margin-right: 50px;
            object-fit: contain;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgb(0 0 0 / 0.1);
            user-select: none;
        }
        .cart-details {
            flex-grow: 1;
        }
        .cart-details h3 {
            margin: 0 0 8px 0;
            font-weight: 600;
            font-size: 1.2em;
            color: #34495e;
            user-select: none;
        }
        .cart-details p {
            margin: 4px 0;
            font-size: 1em;
            color: #555;
            user-select: none;
        }
        .cart-actions {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        .cart-actions button {
            background-color: #2980b9;
            border: none;
            color: white;
            padding: 8px 14px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
            transition: background-color 0.3s ease;
            user-select: none;
        }
        .cart-actions button:hover {
            background-color: #3a7bd5;
        }
        .cart-actions button:active {
            background-color: #1c4f7a;
        }
        .button-group {
            display: flex;
            justify-content: space-between;
            margin-top: 35px;
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
        }
        .checkout-btn {
            background-color: #27ae60;
            color: white;
            box-shadow: 0 5px 15px rgba(39, 174, 96, 0.4);
        }
        .checkout-btn:hover {
            background-color: #2ecc71;
        }
        .checkout-btn:active {
            background-color: #1e8449;
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
        .empty-cart {
            text-align: center;
            font-size: 1.3em;
            color: #7f8c8d;
            padding: 60px 20px;
            user-select: none;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="cart-container">
            <h1>Your Shopping Cart</h1>

            <asp:Repeater ID="rptCartItems" runat="server">
                <ItemTemplate>
                    <div class="cart-item">
                        <img src='<%# ResolveUrl("~/Images/" + Eval("Image")) %>' style="width:100%; height:150px; object-fit:contain;" />
                        <div class="cart-details">
                            <h3><%# Eval("ProductName") %></h3>
                            <p>Price: LKR <%# Eval("Price") %></p>
                            <p>Quantity: <%# Eval("Qty") %></p>
                        </div>
                        <div class="cart-actions">
                            <asp:Button ID="btnIncreaseQty" runat="server" Text="+" CommandArgument='<%# Eval("ProductId") %>' OnClick="btnIncreaseQty_Click" />
                            <asp:Button ID="btnDecreaseQty" runat="server" Text="-" CommandArgument='<%# Eval("ProductId") %>' OnClick="btnDecreaseQty_Click" />
                            <asp:Button ID="btnRemoveItem" runat="server" Text="Remove" CommandArgument='<%# Eval("ProductId") %>' OnClick="btnRemoveItem_Click" />
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <asp:Panel ID="pnlEmptyCart" runat="server" Visible="false">
                <div class="empty-cart">Your cart is empty!</div>
            </asp:Panel>

            <div class="button-group">
                <asp:Button ID="btnContinueShopping" runat="server" Text="Continue Shopping" CssClass="continue-shopping-btn" OnClick="btnContinueShopping_Click" />
                <asp:Button ID="btnProceedCheckout" runat="server" Text="Proceed to Checkout" CssClass="checkout-btn" OnClick="btnProceedCheckout_Click" />
            </div>
        </div>
    </form>
</body>
</html>
