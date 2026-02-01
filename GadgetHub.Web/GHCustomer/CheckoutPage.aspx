<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CheckoutPage.aspx.cs" Inherits="GadgetHub.Web.CheckoutPage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Checkout - Gadget Hub</title>
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
            width: min(620px, 96%);
            margin: 0 auto;
            position: relative;
            z-index: 1;
        }

        .summary-card {
            padding: 42px 48px;
            border-radius: 30px;
            background: rgba(15, 23, 42, 0.78);
            border: 1px solid rgba(148, 163, 184, 0.18);
            box-shadow: 0 32px 65px rgba(5, 8, 22, 0.55);
            backdrop-filter: blur(20px);
        }

        h2 {
            margin: 0 0 32px;
            font-size: 1.9rem;
            font-weight: 700;
            color: #e0f2fe;
            letter-spacing: 0.08em;
            text-transform: uppercase;
            text-align: center;
        }

        .product-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            padding: 16px 0;
            border-bottom: 1px solid rgba(148, 163, 184, 0.18);
            font-size: 1rem;
            color: rgba(226, 232, 240, 0.85);
        }

        .product-item:last-child {
            border-bottom: none;
        }

        .line-total {
            font-weight: 700;
            color: #bae6fd;
        }

        .total {
            margin-top: 32px;
            padding-top: 18px;
            border-top: 1px solid rgba(148, 163, 184, 0.24);
            display: flex;
            justify-content: space-between;
            align-items: baseline;
            font-size: 1.2rem;
            font-weight: 700;
            color: #f8fafc;
        }

        .total span {
            font-size: 1.4rem;
            color: #38bdf8;
            letter-spacing: 0.04em;
        }

        .button-group {
            margin-top: 40px;
            display: flex;
            gap: 18px;
        }

        .continue-shopping-btn,
        .checkout-btn {
            flex: 1;
            border: none;
            border-radius: 999px;
            padding: 14px 0;
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

        @media (max-width: 520px) {
            .summary-card {
                padding: 32px 28px;
            }

            .button-group {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="page-shell">
            <div class="summary-card">
                <h2>Order Summary</h2>
                <asp:Repeater ID="rptOrderItems" runat="server">
                    <ItemTemplate>
                        <div class="product-item">
                            <div><%# Eval("ProductName") %> (x<%# Eval("Qty") %>)</div>
                            <div class="line-total">LKR <%# Convert.ToInt32(Eval("Price")) * Convert.ToInt32(Eval("Qty")) %></div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <div class="total">
                    <span>Total</span>
                    <span>LKR <asp:Label ID="lblTotal" runat="server" Text="0"></asp:Label></span>
                </div>
                <div class="button-group">
                    <asp:Button ID="btnContinueShopping" runat="server" Text="Continue Shopping" CssClass="continue-shopping-btn" OnClick="btnContinueShopping_Click" />
                    <asp:Button ID="btnPlaceOrder" runat="server" Text="Place Order" CssClass="checkout-btn" OnClick="btnPlaceOrder_Click" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
