<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductsSection.aspx.cs" Inherits="GadgetHub.Web.GHAdmin.ProductsSection" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Products Section</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }

        /* Filters container */
        div {
            margin-bottom: 15px;
        }

        /* Inputs and dropdown styling */
        input[type="text"], select, .aspNetDisabled {
            padding: 8px 10px;
            margin-right: 10px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            vertical-align: middle;
            transition: border-color 0.3s ease;
        }
        input[type="text"]:focus, select:focus {
            border-color: #2980b9;
            outline: none;
        }

        /* Button style */
        input[type="submit"], input[type="button"], button, asp\\:Button {
            background-color: #2980b9;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s ease;
            vertical-align: middle;
        }
        input[type="submit"]:hover, input[type="button"]:hover, button:hover, asp\\:Button:hover {
            background-color: #3498db;
        }

        /* Table styling */
        table {
            border-collapse: separate;
            border-spacing: 0;
            width: 100%;
            margin-top: 10px;
            border: 1px solid #ccc;
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            border-bottom: 1px solid #ccc;
            padding: 10px 12px;
            text-align: left;
            vertical-align: middle;
        }

        /* Remove border-bottom on last row */
        tbody tr:last-child td {
            border-bottom: none;
        }

        th {
            background-color: #2980b9;
            color: white;
            font-weight: normal;
            border-bottom: 2px solid #1c5980;
        }

        /* Rounded corners for header */
        thead tr th:first-child {
            border-top-left-radius: 8px;
        }
        thead tr th:last-child {
            border-top-right-radius: 8px;
        }

        /* Zebra striping */
        tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        /* Hover effect on rows */
        tbody tr:hover {
            background-color: #f1f1f1;
        }

        /* Status column formatting: optionally color code */
        /* You can add color coding if you want, e.g. green for active */
        .status-active {
            color: #27ae60;
            font-weight: bold;
        }
        .status-inactive {
            color: #c0392b;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <!-- Search box -->
            <asp:TextBox ID="txtSearch" runat="server" placeholder="Search by name, category, distributor..."></asp:TextBox>
            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />

            <!-- Category filter dropdown -->
            <asp:DropDownList ID="ddlCategory" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged">
                <asp:ListItem Text="All Categories" Value=""></asp:ListItem>
                <%-- Categories are loaded dynamically from code-behind --%>
            </asp:DropDownList>

            <!-- Status filter dropdown -->
            <asp:DropDownList ID="ddlStatus" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                <asp:ListItem Text="All Status" Value=""></asp:ListItem>
                <asp:ListItem Text="Active" Value="1"></asp:ListItem>
                <asp:ListItem Text="Inactive" Value="0"></asp:ListItem>
            </asp:DropDownList>

            <!-- Products grid -->
            <asp:GridView ID="gvProducts" runat="server" AutoGenerateColumns="false" 
                EmptyDataText="No products found.">
                <Columns>
                    <asp:BoundField DataField="Name" HeaderText="Product Name" />
                    <asp:BoundField DataField="Description" HeaderText="Description" />
                    <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:C}" />
                    <asp:BoundField DataField="Stock" HeaderText="Stock" />
                    <asp:BoundField DataField="CategoryName" HeaderText="Category" />
                    <asp:BoundField DataField="DistributorName" HeaderText="Distributor" />
                    <asp:BoundField DataField="IsActive" HeaderText="Status" 
                        DataFormatString="{0}" />
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
