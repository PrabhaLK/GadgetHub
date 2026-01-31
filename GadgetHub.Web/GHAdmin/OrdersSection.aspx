<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OrdersSection.aspx.cs" Inherits="GadgetHub.Web.GHAdmin.OrdersSection" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Orders Section</title>
    <style>

body {
    font-family: Arial, sans-serif;
    margin: 20px;
    background: #f8f9fa;
}
/* General table styling */
table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
    border: 1px solid #ccc;
    border-radius: 8px;
    overflow: hidden;
    background: white;
    box-shadow: 0 2px 6px rgb(0 0 0 / 0.1);
}

/* Blue header like other tables */
thead th,
.grid-header {
    background-color: #2980b9 !important; /* or #007BFF for Bootstrap blue */
    color: white !important;
    font-weight: normal;
    border-bottom: 2px solid #1c5980;
}

/* Rounded corners on thead */
thead th:first-child {
    border-top-left-radius: 8px;
}
thead th:last-child {
    border-top-right-radius: 8px;
}

/* Table cell padding and borders */
th, td {
    padding: 10px 12px;
    text-align: left;
    border-bottom: 1px solid #ccc;
    vertical-align: middle;
    font-size: 14px;
}

/* Zebra striping */
tbody tr:nth-child(even) {
    background-color: #f9f9f9;
}

/* Hover effect */
tbody tr:hover {
    background-color: #f1f1f1;
}

/* Status dropdown style */
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

/* Update button style */
.update-btn {
    padding: 6px 12px;
    background-color: #2980b9;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 13px;
    transition: background-color 0.3s ease;
}
.update-btn:hover {
    background-color: #3498db;
}
.orders-grid th {
    background-color: #2980b9 !important;
    color: white !important;
    font-weight: 600;
}

.orders-grid th:first-child {
    border-top-left-radius: 8px;
}
.orders-grid th:last-child {
    border-top-right-radius: 8px;
}

    </style>
</head>
<body>
    <form id="form1" runat="server">

        <div>
            Search by user or status: 
            <asp:TextBox ID="txtSearch" runat="server" placeholder="User name or status"></asp:TextBox>
            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
        </div>

        <br />

        <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="false" OnRowDataBound="gvOrders_RowDataBound" CssClass="orders-grid" UseAccessibleHeader="true" HeaderStyle-CssClass="grid-header">

            <Columns>
                <asp:BoundField DataField="Id" HeaderText="Order ID" />
                <asp:BoundField DataField="UserName" HeaderText="User" />
                <asp:BoundField DataField="Total" HeaderText="Total" DataFormatString="{0:C}" />
                <asp:BoundField DataField="DeliveryAddress" HeaderText="Delivery Address" />
                <asp:BoundField DataField="Status" HeaderText="Status" />
                <asp:BoundField DataField="CreatedAt" HeaderText="Created At" DataFormatString="{0:yyyy-MM-dd HH:mm}" />
                <asp:TemplateField HeaderText="Order Items">
                    <ItemTemplate>
                        <asp:PlaceHolder ID="phOrderItems" runat="server"></asp:PlaceHolder>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

    </form>
</body>
</html>
