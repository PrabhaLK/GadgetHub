<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="GadgetHub.Web.HomePage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Gadget Hub - Home</title>
    <style>
        /* Futuristic gradient backdrop */
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
            background: radial-gradient(38% 38% at 80% 18%, rgba(236, 72, 153, 0.28), transparent),
                        radial-gradient(32% 32% at 18% 78%, rgba(56, 189, 248, 0.26), transparent),
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
            width: min(1240px, 96%);
            display: flex;
            flex-direction: column;
            gap: 28px;
            position: relative;
            z-index: 1;
            margin: 0 auto;
        }

        header {
            display: flex;
            align-items: center;
            gap: 24px;
            padding: 26px 32px;
            background: linear-gradient(135deg, rgba(15, 23, 42, 0.85), rgba(76, 29, 149, 0.72), rgba(34, 211, 238, 0.55));
            border-radius: 26px;
            border: 1px solid rgba(148, 163, 184, 0.18);
            box-shadow: 0 25px 60px rgba(15, 23, 42, 0.55);
            backdrop-filter: blur(18px);
        }

        #companyName {
            font-weight: 700;
            font-size: 1.9rem;
            letter-spacing: 0.18em;
            text-transform: uppercase;
            color: #f8fafc;
        }

        /* Search */
        #searchBar {
            flex: 1;
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 8px 10px 8px 22px;
            border-radius: 999px;
            border: 1px solid rgba(148, 163, 184, 0.22);
            background: rgba(15, 23, 42, 0.6);
            box-shadow: inset 0 0 0 1px rgba(255, 255, 255, 0.02);
        }

        #searchBar input[type="text"] {
            flex: 1;
            padding: 10px 0;
            background: transparent;
            border: none;
            color: #e2e8f0;
            font-size: 15px;
            outline: none;
        }

        #searchBar input::placeholder {
            color: rgba(226, 232, 240, 0.55);
        }

        .search-button {
            background: linear-gradient(135deg, #6366f1, #22d3ee);
            color: #0b1120;
            border: none;
            border-radius: 999px;
            padding: 10px 24px;
            font-weight: 700;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.3s ease;
        }

        .search-button:hover {
            transform: translateY(-1px);
            box-shadow: 0 18px 32px rgba(99, 102, 241, 0.35);
        }

        /* Cart + actions */
        #cartArea {
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .cart-icon {
            position: relative;
            font-size: 1.6rem;
            cursor: pointer;
            color: #e0f2fe;
            filter: drop-shadow(0 10px 18px rgba(15, 118, 110, 0.35));
            transition: transform 0.2s ease;
        }

        .cart-icon:hover {
            transform: translateY(-2px) scale(1.03);
        }

        .cart-count {
            position: absolute;
            top: -10px;
            right: -12px;
            min-width: 22px;
            padding: 3px 7px;
            background: linear-gradient(135deg, #f97316, #f43f5e);
            color: #0f172a;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 700;
            box-shadow: 0 10px 18px rgba(244, 63, 94, 0.35);
        }

        .pill-button {
            background: rgba(148, 163, 184, 0.15);
            color: #e2e8f0;
            border: 1px solid rgba(148, 163, 184, 0.28);
            border-radius: 999px;
            padding: 10px 22px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.3s ease, border 0.3s ease;
        }

        .pill-button:hover {
            transform: translateY(-1px);
            border-color: rgba(226, 232, 240, 0.55);
            box-shadow: 0 18px 28px rgba(15, 23, 42, 0.45);
        }

        .pill-button.accent {
            background: linear-gradient(135deg, #38bdf8, #6366f1);
            border: none;
            color: #020617;
        }

        .pill-button.ghost {
            background: rgba(148, 163, 184, 0.12);
        }

        .pill-button.danger {
            background: rgba(244, 63, 94, 0.18);
            border: 1px solid rgba(244, 63, 94, 0.45);
        }

        /* Content layout */
        .layout {
            display: grid;
            grid-template-columns: 260px 1fr;
            gap: 28px;
        }

        .glass-panel {
            background: rgba(15, 23, 42, 0.7);
            border-radius: 28px;
            border: 1px solid rgba(148, 163, 184, 0.16);
            backdrop-filter: blur(20px);
            box-shadow: 0 32px 65px rgba(5, 8, 22, 0.55);
        }

        nav.glass-panel {
            padding: 28px 26px;
        }

        nav h3 {
            margin: 0 0 22px;
            color: #bae6fd;
            font-weight: 700;
            letter-spacing: 0.08em;
            text-transform: uppercase;
        }

        nav div {
            margin-bottom: 14px;
            font-size: 14px;
            color: rgba(226, 232, 240, 0.85);
        }

        nav input[type="checkbox"] {
            margin-right: 10px;
            transform: scale(1.15);
            accent-color: #38bdf8;
            cursor: pointer;
        }

        .filter-apply {
            width: 100%;
            margin-top: 16px;
            padding: 12px 0;
            border-radius: 16px;
            border: none;
            background: linear-gradient(135deg, #22d3ee, #6366f1);
            color: #0f172a;
            font-weight: 700;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.3s ease;
        }

        .filter-apply:hover {
            transform: translateY(-1px);
            box-shadow: 0 16px 28px rgba(34, 211, 238, 0.35);
        }

        main.product-grid {
            padding: 16px 8px;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(230px, 1fr));
            gap: 24px;
        }

        .product-card {
            position: relative;
            display: flex;
            flex-direction: column;
            gap: 14px;
            padding: 22px;
            border-radius: 24px;
            background: linear-gradient(160deg, rgba(15, 23, 42, 0.78), rgba(49, 46, 129, 0.78));
            border: 1px solid rgba(148, 163, 184, 0.18);
            box-shadow: 0 30px 48px rgba(14, 116, 144, 0.38);
            transition: transform 0.25s ease, box-shadow 0.25s ease, border-color 0.25s ease;
        }

        .product-card:hover {
            transform: translateY(-6px);
            border-color: rgba(236, 72, 153, 0.45);
            box-shadow: 0 40px 62px rgba(236, 72, 153, 0.35);
        }

        .product-card img {
            width: 100%;
            height: 160px;
            object-fit: contain;
            border-radius: 18px;
            background: radial-gradient(circle at 50% 28%, rgba(34, 211, 238, 0.25), transparent 55%),
                        radial-gradient(circle at 70% 75%, rgba(236, 72, 153, 0.22), transparent 70%);
        }

        .product-card h4 {
            margin: 0;
            text-align: center;
            font-size: 1.1rem;
            font-weight: 700;
            color: #e0f2fe;
            min-height: 2.6em;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .product-card p {
            margin: 0;
            text-align: center;
            font-weight: 600;
            color: rgba(226, 232, 240, 0.8);
        }

        .cta-button {
            margin-top: auto;
            width: 100%;
            border: none;
            border-radius: 999px;
            padding: 11px 0;
            background: linear-gradient(135deg, #f472b6, #38bdf8);
            color: #061122;
            font-weight: 700;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.3s ease;
        }

        .cta-button:hover {
            transform: translateY(-1px);
            box-shadow: 0 18px 34px rgba(244, 114, 182, 0.35);
        }

        @media (max-width: 1080px) {
            header {
                flex-direction: column;
                align-items: stretch;
            }

            #searchBar {
                width: 100%;
            }

            #cartArea {
                width: 100%;
                justify-content: center;
                flex-wrap: wrap;
            }

            .layout {
                grid-template-columns: 1fr;
            }

            nav.glass-panel {
                order: 2;
            }

            main.product-grid {
                order: 1;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="page-shell">
            <header>
                <div id="companyName">Gadget Hub</div>

                <div id="searchBar">
                    <asp:TextBox ID="txtSearch" runat="server" placeholder="Search products..." />
                    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" CssClass="search-button" />
                </div>

                <div id="cartArea">
                    <div class="cart-icon" onclick="location.href='CartPage.aspx'">
                        🛒
                        <span id="cartCount" class="cart-count"><%= CartCount %></span>
                    </div>
                    <asp:Button ID="btnCheckout" runat="server" Text="Checkout" OnClick="btnCheckout_Click" CssClass="pill-button accent" />
                    <asp:Button ID="btnDashboard" runat="server" Text="Dashboard" OnClick="btnDashboard_Click" CssClass="pill-button ghost" />
                    <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="pill-button danger" OnClick="btnLogout_Click" />
                </div>
            </header>
            <div class="layout">
                <nav class="glass-panel">
                <h3>Filter by Category</h3>
                <asp:Repeater ID="rptCategories" runat="server">
                    <ItemTemplate>
                        <div>
                            <asp:CheckBox ID="chkCategory" runat="server" Text='<%# Eval("Name") %>' />
                            <asp:HiddenField ID="hfCategoryId" runat="server" Value='<%# Eval("Id") %>' />
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                    <asp:Button ID="btnFilter" runat="server" Text="Apply Filter" OnClick="btnFilter_Click" CssClass="filter-apply" />
                </nav>

                <main class="product-grid glass-panel">
                    <asp:Repeater ID="rptProducts" runat="server">
                        <ItemTemplate>
                            <div class="product-card">
                                <a href='<%# "ProductDetails.aspx?id=" + Eval("Id") %>' style="text-decoration:none; color:inherit;">
                                    <img src='<%# ResolveUrl("~/Images/" + Eval("Image")) %>' alt='<%# Eval("Name") %>' />
                                    <h4><%# Eval("Name") %></h4>
                                    <p>Price: LKR <%# Eval("Price") %></p>
                                </a>
                                <asp:Button ID="btnAddToCart" runat="server" CommandArgument='<%# Eval("Id") %>' Text="Add to Cart" OnClick="btnAddToCart_Click" CssClass="cta-button" />
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </main>
            </div>
        </div>
    </form>
</body>
</html>
