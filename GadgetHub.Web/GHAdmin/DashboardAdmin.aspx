<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DashboardAdmin.aspx.cs" Inherits="GadgetHub.Web.GHAdmin.DashboardAdmin" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Admin Dashboard</title>
    <style>
        body {
            margin: 0;
            font-family: Arial;
        }
        .topbar {
            height: 60px;
            background-color: #1abc9c;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
        }
        .sidebar {
            width: 200px;
            background: #2c3e50;
            height: calc(100vh - 60px);
            float: left;
            color: white;
        }
        .sidebar a {
            display: block;
            color: white;
            padding: 15px;
            text-decoration: none;
        }
        .sidebar a:hover {
            background: #34495e;
        }
        .content {
            margin-left: 200px;
            margin-top: 60px;
        }
        iframe {
            width: 100%;
            height: calc(100vh - 60px);
            border: none;
        }
        .admin-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .logout-btn {
            background-color: #e74c3c;
            color: white;
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .logout-btn:hover {
            background-color: #c0392b;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Top Header -->
        <div class="topbar">
            <div><strong>GadgetHub Admin Dashboard</strong></div>
            <div class="admin-info">
                <asp:Label ID="lblAdminEmail" runat="server" Text="admin@gadgethub.lk"></asp:Label>
                <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="logout-btn" OnClick="btnLogout_Click" />
            </div>
        </div>

        <!-- Side Navigation -->
        <div class="sidebar">
            <a href="UsersSection.aspx" target="contentFrame">Users</a>
            <a href="QuotationsSection.aspx" target="contentFrame">Quotations</a>
            <a href="OrdersSection.aspx" target="contentFrame">Orders</a>
            <a href="ProductsSection.aspx" target="contentFrame">Products</a>
            <a href="ContactsSection.aspx" target="contentFrame">Contact Messages</a>
        </div>
        <div class="content">
            <iframe id="contentFrame" name="contentFrame"></iframe>
        </div>
    </form>
</body>
</html>
