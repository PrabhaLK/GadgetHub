<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OrdersSection.aspx.cs" Inherits="GadgetHub.Web.GHDistributor.OrdersSection" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Distributor Orders</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f7f9fc;
            color: #333;
            margin: 0;
            padding: 20px;
        }
        h2, h3 {
            color: #2c3e50;
            font-weight: 600;
            margin-bottom: 20px;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            background: white;
            box-shadow: 0 2px 6px rgb(0 0 0 / 0.1);
            border-radius: 6px;
            overflow: hidden;
            margin-bottom: 25px;
        }

        thead {
            background-color: #2980b9;
            color: white;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #e1e8f0;
            font-size: 14px;
        }

        tbody tr:hover {
            background-color: #f0f4f8;
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        .update-btn {
            padding: 8px 15px;
            background-color: #2980b9;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s ease;
        }
        .update-btn:hover {
            background-color: #3498db;
        }

        .status-select {
            width: 140px;
            padding: 6px 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
            transition: border-color 0.3s ease;
        }
        .status-select:hover,
        .status-select:focus {
            border-color: #2980b9;
            outline: none;
        }

        #pnlOrderItems {
            background: white;
            padding: 20px;
            border-radius: 6px;
            box-shadow: 0 2px 8px rgb(0 0 0 / 0.1);
        }

        #btnCloseItems {
            padding: 8px 15px;
            background-color: #e74c3c;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            margin-top: 15px;
            transition: background-color 0.3s ease;
        }
        #btnCloseItems:hover {
            background-color: #c0392b;
        }

        /* Responsive Table */
        @media (max-width: 700px) {
            table, thead, tbody, th, td, tr {
                display: block;
            }
            thead tr {
                position: absolute;
                top: -9999px;
                left: -9999px;
            }
            tbody tr {
                margin-bottom: 15px;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgb(0 0 0 / 0.1);
                background: white;
                padding: 15px;
            }
            tbody td {
                border: none;
                position: relative;
                padding-left: 50%;
                text-align: right;
                font-size: 13px;
            }
            tbody td::before {
                position: absolute;
                left: 15px;
                top: 15px;
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
        <h2>My Orders</h2>
        <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="false" OnRowCommand="gvOrders_RowCommand" CssClass="orders-grid">
            <Columns>
                <asp:BoundField DataField="Id" HeaderText="Order ID" ItemStyle-Width="80px" HeaderStyle-CssClass="grid-header" />
                <asp:BoundField DataField="UserName" HeaderText="Customer" HeaderStyle-CssClass="grid-header"/>
                <asp:BoundField DataField="Total" HeaderText="Total" DataFormatString="{0:C}" HeaderStyle-CssClass="grid-header"/>
                <asp:BoundField DataField="DeliveryAddress" HeaderText="Delivery Address" HeaderStyle-CssClass="grid-header"/>
                <asp:TemplateField HeaderText="Status" HeaderStyle-CssClass="grid-header">
                    <ItemTemplate>
                        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="status-select">
                            <asp:ListItem>Received</asp:ListItem>
                            <asp:ListItem>Processing</asp:ListItem>
                            <asp:ListItem>Shipped</asp:ListItem>
                            <asp:ListItem>Delivered</asp:ListItem>
                            <asp:ListItem>Cancelled</asp:ListItem>
                        </asp:DropDownList>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Update Status" HeaderStyle-CssClass="grid-header">
                    <ItemTemplate>
                        <asp:Button ID="btnUpdateStatus" runat="server" Text="Update" CommandName="UpdateStatus" CommandArgument='<%# Eval("Id") %>' CssClass="update-btn" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <RowStyle CssClass="order-row" />
            <EmptyDataTemplate>No orders found.</EmptyDataTemplate>
        </asp:GridView>

        <asp:Panel ID="pnlOrderItems" runat="server" Visible="false">
            <h3>Order Items for Order ID: <asp:Label ID="lblSelectedOrderId" runat="server" /></h3>
            <asp:GridView ID="gvOrderItems" runat="server" AutoGenerateColumns="false" CssClass="order-items-grid">
                <Columns>
                    <asp:BoundField DataField="ProductId" HeaderText="Product ID" />
                    <asp:BoundField DataField="ProductName" HeaderText="Product Name" />
                    <asp:BoundField DataField="Qty" HeaderText="Quantity" />
                </Columns>
            </asp:GridView>
            <asp:Button ID="btnCloseItems" runat="server" Text="Close" OnClick="btnCloseItems_Click" />
        </asp:Panel>
    </form>
</body>
</html>
