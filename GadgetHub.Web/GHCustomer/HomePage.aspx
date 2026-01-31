<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="GadgetHub.Web.HomePage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Gadget Hub - Home</title>
    <style>
        /* Reset & base */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f7f9fc;
            margin: 0;
            padding: 0;
            color: #333;
        }

        /* Header */
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 30px;
            background-color: #2980b9;
            color: white;
            box-shadow: 0 2px 6px rgb(0 0 0 / 0.1);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        #companyName {
            font-weight: 700;
            font-size: 1.8em;
            letter-spacing: 1px;
            user-select: none;
        }

        /* Search bar */
        #searchBar {
            flex-grow: 1;
            max-width: 400px;
            margin: 0 20px;
            display: flex;
            gap: 8px;
        }
        #searchBar input[type="text"] {
            flex-grow: 1;
            padding: 8px 12px;
            border-radius: 6px;
            border: none;
            font-size: 14px;
            outline: none;
        }
        #searchBar input[type="text"]::placeholder {
            color: #a5c1e0;
        }
        #searchBar input[type="submit"],
        #searchBar button, 
        #searchBar asp\\:Button {
            background-color: #1f5fa7;
            color: white;
            border: none;
            border-radius: 6px;
            padding: 8px 15px;
            cursor: pointer;
            font-weight: 600;
            transition: background-color 0.3s ease;
        }
        #searchBar input[type="submit"]:hover,
        #searchBar button:hover,
        #searchBar asp\\:Button:hover {
            background-color: #3a7bd5;
        }

        /* Cart area */
        #cartArea {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        .cart-icon {
            position: relative;
            font-size: 1.5em;
            cursor: pointer;
            user-select: none;
            transition: color 0.3s ease;
        }
        .cart-icon:hover {
            color: #d1e7ff;
        }
        .cart-count {
            position: absolute;
            top: -8px;
            right: -10px;
            background: #e74c3c;
            color: white;
            border-radius: 50%;
            padding: 3px 7px;
            font-size: 12px;
            font-weight: 700;
            box-shadow: 0 0 3px rgba(0,0,0,0.3);
        }

        /* Buttons in cart area */
        .button-link {
            background-color: #e67e22;
            color: white;
            padding: 8px 18px;
            border-radius: 6px;
            border: none;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }
        .button-link:hover {
            background-color: #d35400;
        }

        /* Layout */
        .layout {
            display: flex;
            min-height: calc(100vh - 72px); /* header height approx */
            background-color: #f7f9fc;
        }

        nav {
            width: 240px;
            background: white;
            padding: 25px 20px;
            border-right: 1px solid #d6dbe5;
            box-shadow: 2px 0 6px rgb(0 0 0 / 0.05);
            border-radius: 0 8px 8px 0;
        }
        nav h3 {
            margin-top: 0;
            margin-bottom: 20px;
            color: #2980b9;
            font-weight: 700;
            user-select: none;
        }
        nav div {
            margin-bottom: 12px;
            font-size: 14px;
        }
        nav input[type="checkbox"] {
            margin-right: 8px;
            transform: scale(1.1);
            cursor: pointer;
        }
        nav button {
            margin-top: 10px;
            width: 100%;
            padding: 10px;
            background-color: #2980b9;
            border: none;
            border-radius: 6px;
            color: white;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        nav button:hover {
            background-color: #3a7bd5;
        }

        main {
            flex-grow: 1;
            padding: 30px 40px;
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 25px;
            overflow-y: auto;
        }

        .product-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgb(41 128 185 / 0.15);
            padding: 15px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            cursor: pointer;
            transition: transform 0.25s ease, box-shadow 0.25s ease;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgb(41 128 185 / 0.3);
        }
        .product-card img {
            width: 100%;
            height: 150px;
            object-fit: contain;
            border-radius: 8px;
            margin-bottom: 12px;
            user-select: none;
        }
        .product-card h4 {
            margin: 0 0 10px 0;
            color: #2980b9;
            font-weight: 700;
            font-size: 1.1em;
            user-select: none;
        }
        .product-card p {
            margin: 0 0 15px 0;
            font-weight: 600;
            color: #555;
            user-select: none;
        }

        /* Add to cart button inside product card */
        .product-card asp\\:Button, .product-card button {
            background-color: #2980b9;
            border: none;
            color: white;
            padding: 8px 0;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease;
            width: 100%;
        }
        .product-card asp\\:Button:hover, .product-card button:hover {
            background-color: #3a7bd5;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <header>
            <div id="companyName" style="font-weight:bold; font-size:1.5em;">Gadget Hub</div>

            <div id="searchBar">
                <asp:TextBox ID="txtSearch" runat="server" placeholder="Search products..." />
                <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
            </div>

            <div id="cartArea">
                <div class="cart-icon" onclick="location.href='CartPage.aspx'">
                    🛒
                    <span id="cartCount" class="cart-count"><%= CartCount %></span>
                </div>
                <asp:Button ID="btnCheckout" runat="server" Text="Checkout" OnClick="btnCheckout_Click" CssClass="button-link" />
                <asp:Button ID="btnDashboard" runat="server" Text="Dashboard" OnClick="btnDashboard_Click" CssClass="button-link" />
            </div>
        </header>
        <div class="layout">
            <nav>
                <h3>Filter by Category</h3>
                <asp:Repeater ID="rptCategories" runat="server">
                    <ItemTemplate>
                        <div>
                            <asp:CheckBox ID="chkCategory" runat="server" Text='<%# Eval("Name") %>' />
                            <asp:HiddenField ID="hfCategoryId" runat="server" Value='<%# Eval("Id") %>' />
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <asp:Button ID="btnFilter" runat="server" Text="Apply Filter" OnClick="btnFilter_Click" />
            </nav>

            <main>
                <asp:Repeater ID="rptProducts" runat="server">
                    <ItemTemplate>
                        <div class="product-card">
                            <a href='<%# "ProductDetails.aspx?id=" + Eval("Id") %>' style="text-decoration:none; color:inherit;">
                                <img src='<%# ResolveUrl("~/Images/" + Eval("Image")) %>' alt='<%# Eval("Name") %>' style="width:100%; height:150px; object-fit:contain;" />
                                <p>Price: LKR <%# Eval("Price") %></p>
                            </a>
                            <asp:Button ID="btnAddToCart" runat="server" CommandArgument='<%# Eval("Id") %>' Text="Add to Cart" OnClick="btnAddToCart_Click" />
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </main>
        </div>
    </form>
</body>
</html>
