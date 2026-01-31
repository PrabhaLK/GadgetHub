<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DashboardCustomer.aspx.cs" Inherits="GadgetHub.Web.GHCustomer.DashboardCustomer" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My Orders</title>
    <style>
        /* Reset & base */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f7f9fc;
            margin: 0;
            padding: 0;
            color: #333;
        }

        h2 {
            color: #2980b9;
            font-weight: 700;
            margin-bottom: 25px;
            text-align: center;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        /* Main gridview styling */
        .orders-grid {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 10px rgb(41 128 185 / 0.15);
            font-size: 14px;
        }

        /* Header styles */
        .orders-grid thead th,
        .grid-header {
            background-color: #2980b9 !important;
            color: white !important;
            font-weight: 600;
            border-bottom: 3px solid #1c5980;
            padding: 12px 15px;
            text-align: left;
            user-select: none;
        }

        .orders-grid thead th:first-child {
            border-top-left-radius: 8px;
        }

        .orders-grid thead th:last-child {
            border-top-right-radius: 8px;
        }

        /* Row styles */
        .orders-grid tbody tr {
            transition: background-color 0.3s ease;
            cursor: default;
        }
        .orders-grid tbody tr:nth-child(even) {
            background-color: #f9faff;
        }
        .orders-grid tbody tr:hover {
            background-color: #d6e6fb;
        }

        /* Cells */
        .orders-grid tbody td {
            padding: 12px 15px;
            border-bottom: 1px solid #e1e8f0;
            vertical-align: middle;
        }

        /* Order items table inside placeholder */
        .order-items {
            margin-top: 10px;
            font-size: 0.9em;
            border-collapse: collapse;
            width: 100%;
            border-radius: 6px;
            overflow: hidden;
            box-shadow: 0 2px 6px rgb(0 0 0 / 0.1);
        }
        .order-items th, .order-items td {
            border: 1px solid #ccc;
            padding: 6px 10px;
            text-align: left;
        }
        .order-items th {
            background-color: #2980b9;
            color: white;
            font-weight: 600;
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

        /* Cart area */
        #cartArea {
            display: flex;
            align-items: center;
            gap: 20px;
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
}
        /* Responsive */
        @media (max-width: 700px) {
            .orders-grid, .orders-grid thead, .orders-grid tbody, .orders-grid th, .orders-grid td, .orders-grid tr {
                display: block;
            }
            .orders-grid thead tr {
                position: absolute;
                top: -9999px;
                left: -9999px;
            }
            .orders-grid tbody tr {
                margin-bottom: 20px;
                background: white;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgb(41 128 185 / 0.15);
                padding: 15px;
            }
            .orders-grid tbody td {
                border: none;
                position: relative;
                padding-left: 50%;
                text-align: right;
                font-size: 13px;
            }
            .orders-grid tbody td::before {
                position: absolute;
                left: 15px;
                top: 12px;
                width: 45%;
                white-space: nowrap;
                font-weight: 600;
                text-transform: uppercase;
                font-size: 12px;
                color: #2980b9;
                content: attr(data-label);
                text-align: left;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <header>
            <div id="companyName" style="font-weight:bold; font-size:1.5em;">Gadget Hub</div>

            <div id="cartArea">
                <asp:Button ID="btnHome" runat="server" Text="Back to Store" OnClick="btnHome_Click" CssClass="button-link" />
            </div>
        </header>
        <h2>My Orders</h2>
        <asp:GridView 
            ID="gvOrders" 
            runat="server" 
            AutoGenerateColumns="false" 
            EmptyDataText="No orders found" 
            CssClass="orders-grid"
            OnRowDataBound="gvOrders_RowDataBound">
            <Columns>
                <asp:BoundField DataField="Id" HeaderText="Order ID" />
                <asp:BoundField DataField="Total" HeaderText="Total" DataFormatString="{0:C}" />
                <asp:BoundField DataField="DeliveryAddress" HeaderText="Delivery Address" />
                <asp:BoundField DataField="Status" HeaderText="Status" />
                <asp:BoundField DataField="CreatedAt" HeaderText="Order Date" DataFormatString="{0:yyyy-MM-dd HH:mm}" />
                <asp:TemplateField HeaderText="Items">
                    <ItemTemplate>
                        <asp:PlaceHolder ID="phOrderItems" runat="server"></asp:PlaceHolder>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </form>
</body>
</html>
