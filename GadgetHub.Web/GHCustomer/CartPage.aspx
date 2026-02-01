<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CartPage.aspx.cs" Inherits="GadgetHub.Web.CartPage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Your Cart - Gadget Hub</title>
    <style>
        body {
            margin: 0;
            padding: 40px 18px 60px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: radial-gradient(140% 160% at 10% 20%, #312e81 0%, #0f172a 55%, #050816 100%);
            color: #e2e8f0;
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
        }

        body::before {
            content: "";
            position: fixed;
            inset: 0;
            background: radial-gradient(38% 38% at 82% 15%, rgba(236, 72, 153, 0.28), transparent),
                        radial-gradient(32% 32% at 20% 80%, rgba(56, 189, 248, 0.26), transparent),
                        radial-gradient(60% 60% at 110% -10%, rgba(129, 140, 248, 0.25), transparent);
            filter: blur(70px);
            pointer-events: none;
        }

        body::after {
            content: "";
            position: fixed;
            inset: 0;
            background: linear-gradient(140deg, rgba(2, 132, 199, 0.18), transparent 45%, rgba(168, 85, 247, 0.12) 70%, transparent);
            pointer-events: none;
        }

        form {
            display: flex;
            justify-content: center;
        }

        .page-shell {
            width: min(960px, 96%);
            margin: 0 auto;
            position: relative;
            z-index: 1;
        }

        .cart-container {
            padding: 42px;
            border-radius: 32px;
            background: rgba(15, 23, 42, 0.78);
            border: 1px solid rgba(148, 163, 184, 0.18);
            box-shadow: 0 32px 65px rgba(5, 8, 22, 0.55);
            backdrop-filter: blur(20px);
        }

        h1 {
            margin: 0 0 32px;
            text-align: center;
            font-size: 2rem;
            font-weight: 700;
            letter-spacing: 0.12em;
            text-transform: uppercase;
            color: #e0f2fe;
        }

        .cart-items {
            display: flex;
            flex-direction: column;
            gap: 22px;
        }

        .cart-item {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            gap: 24px;
            padding: 24px;
            border-radius: 24px;
            background: linear-gradient(160deg, rgba(15, 23, 42, 0.82), rgba(49, 46, 129, 0.78));
            border: 1px solid rgba(148, 163, 184, 0.18);
            box-shadow: 0 30px 48px rgba(14, 116, 144, 0.38);
        }

        .cart-item img {
            flex: 0 0 180px;
            width: 180px;
            height: 160px;
            object-fit: contain;
            border-radius: 18px;
            background: radial-gradient(circle at 50% 28%, rgba(34, 211, 238, 0.25), transparent 55%),
                        radial-gradient(circle at 70% 75%, rgba(236, 72, 153, 0.22), transparent 70%);
        }

        .cart-details {
            flex: 1 1 220px;
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .cart-details h3 {
            margin: 0;
            font-size: 1.2rem;
            font-weight: 600;
            color: #f8fafc;
        }

        .cart-details p {
            margin: 0;
            font-size: 0.98rem;
            color: rgba(226, 232, 240, 0.78);
        }

        .price-chip {
            display: inline-flex;
            align-items: center;
            padding: 6px 16px;
            border-radius: 999px;
            background: rgba(244, 114, 182, 0.18);
            color: #f472b6;
            font-weight: 600;
            font-size: 0.95rem;
        }

        .quantity-chip {
            display: inline-flex;
            align-items: center;
            padding: 6px 16px;
            border-radius: 999px;
            background: rgba(56, 189, 248, 0.18);
            color: #38bdf8;
            font-weight: 600;
            font-size: 0.95rem;
        }

        .cart-actions {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .control-btn {
            border: none;
            border-radius: 14px;
            padding: 10px 0;
            width: 120px;
            background: rgba(148, 163, 184, 0.12);
            color: #e2e8f0;
            font-weight: 700;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.3s ease, border 0.3s ease;
            border: 1px solid rgba(148, 163, 184, 0.25);
        }

        .control-btn:hover {
            transform: translateY(-1px);
            border-color: rgba(226, 232, 240, 0.55);
            box-shadow: 0 16px 24px rgba(15, 23, 42, 0.45);
        }

        .remove-btn {
            background: rgba(244, 63, 94, 0.18);
            border-color: rgba(244, 63, 94, 0.45);
            color: #f87171;
        }

        .button-group {
            display: flex;
            flex-wrap: wrap;
            gap: 18px;
            justify-content: center;
            margin-top: 36px;
        }

        .cta-btn {
            flex: 1 1 240px;
            border: none;
            border-radius: 999px;
            padding: 16px 0;
            font-size: 1.05rem;
            font-weight: 700;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.3s ease;
        }

        .continue-shopping-btn {
            background: rgba(148, 163, 184, 0.12);
            color: rgba(226, 232, 240, 0.85);
            border: 1px solid rgba(148, 163, 184, 0.28);
        }

        .continue-shopping-btn:hover {
            transform: translateY(-1px);
            border-color: rgba(226, 232, 240, 0.55);
            box-shadow: 0 18px 28px rgba(15, 23, 42, 0.45);
        }

        .checkout-btn {
            background: linear-gradient(135deg, #f472b6, #38bdf8);
            color: #061122;
        }

        .checkout-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 18px 34px rgba(244, 114, 182, 0.35);
        }

        .empty-cart {
            text-align: center;
            font-size: 1.2rem;
            color: rgba(226, 232, 240, 0.75);
            padding: 70px 20px;
        }

        @media (max-width: 640px) {
            .cart-container {
                padding: 32px 22px;
            }

            .cart-item {
                padding: 20px;
            }

            .cart-item img {
                flex-basis: 120px;
                width: 120px;
                height: 120px;
            }

            .control-btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="page-shell">
            <div class="cart-container">
                <h1>Your Shopping Cart</h1>

                <div class="cart-items">
                    <asp:Repeater ID="rptCartItems" runat="server">
                        <ItemTemplate>
                            <div class="cart-item">
                                <img src='<%# ResolveUrl("~/Images/" + Eval("Image")) %>' alt='<%# Eval("ProductName") %>' />
                                <div class="cart-details">
                                    <h3><%# Eval("ProductName") %></h3>
                                    <p><span class="price-chip">Price: LKR <%# Eval("Price") %></span></p>
                                    <p><span class="quantity-chip">Quantity: <%# Eval("Qty") %></span></p>
                                </div>
                                <div class="cart-actions">
                                    <asp:Button ID="btnIncreaseQty" runat="server" Text="Increase" CommandArgument='<%# Eval("ProductId") %>' OnClick="btnIncreaseQty_Click" CssClass="control-btn" />
                                    <asp:Button ID="btnDecreaseQty" runat="server" Text="Decrease" CommandArgument='<%# Eval("ProductId") %>' OnClick="btnDecreaseQty_Click" CssClass="control-btn" />
                                    <asp:Button ID="btnRemoveItem" runat="server" Text="Remove" CommandArgument='<%# Eval("ProductId") %>' OnClick="btnRemoveItem_Click" CssClass="control-btn remove-btn" />
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

                <asp:Panel ID="pnlEmptyCart" runat="server" Visible="false">
                    <div class="empty-cart">Your cart is empty!</div>
                </asp:Panel>

                <div class="button-group">
                    <asp:Button ID="btnContinueShopping" runat="server" Text="Continue Shopping" CssClass="cta-btn continue-shopping-btn" OnClick="btnContinueShopping_Click" />
                    <asp:Button ID="btnProceedCheckout" runat="server" Text="Proceed to Checkout" CssClass="cta-btn checkout-btn" OnClick="btnProceedCheckout_Click" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
