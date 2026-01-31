<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DashboardDistributor.aspx.cs" Inherits="GadgetHub.Web.GHDistributor.DashboardDistributor" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Distributor Dashboard</title>
    <style>
        body {
            margin: 0;
            font-family: Arial;
        }
        .topbar {
            height: 60px;
            background-color: #2980b9;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
        }
        .sidebar {
            width: 220px;
            background: #34495e;
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
            background: #3d566e;
        }
        .content {
            margin-left: 220px;
            margin-top: 60px;
        }
        iframe {
            width: 100%;
            height: calc(100vh - 60px);
            border: none;
        }
        .distributor-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .logout-btn {
            background-color: #e67e22;
            color: white;
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .logout-btn:hover {
            background-color: #d35400;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Top Header -->
        <div class="topbar">
            <div><strong>Distributor Dashboard</strong></div>
            <div class="distributor-info">
                <asp:Label ID="lblDistributorEmail" runat="server" Text="distributor@example.com"></asp:Label>
                <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="logout-btn" OnClick="btnLogout_Click" />
            </div>
        </div>

        <!-- Side Navigation -->
        <div class="sidebar">
            <a href="QuotationsSection.aspx" target="contentFrame">Quotations</a>
            <a href="MessagesSection.aspx" target="contentFrame">Contact Messages</a>
            <a href="OrdersSection.aspx" target="contentFrame">Orders</a>
        </div>
        <div class="content">
            <iframe id="contentFrame" name="contentFrame" src="QuotationsSection.aspx"></iframe>
        </div>
    </form>
</body>
</html>

