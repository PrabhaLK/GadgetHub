<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DashboardCustomer.aspx.cs" Inherits="GadgetHub.Web.GHCustomer.DashboardCustomer" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My Orders</title>
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
            width: min(1100px, 96%);
            margin: 0 auto;
            display: flex;
            flex-direction: column;
            gap: 28px;
            position: relative;
            z-index: 1;
        }

        header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 18px;
            padding: 26px 32px;
            border-radius: 26px;
            background: linear-gradient(135deg, rgba(15, 23, 42, 0.85), rgba(76, 29, 149, 0.72), rgba(34, 211, 238, 0.55));
            border: 1px solid rgba(148, 163, 184, 0.18);
            box-shadow: 0 25px 60px rgba(15, 23, 42, 0.55);
            backdrop-filter: blur(18px);
        }

        #companyName {
            font-weight: 700;
            font-size: 1.8rem;
            letter-spacing: 0.16em;
            text-transform: uppercase;
            color: #f8fafc;
        }

        .pill-button {
            border: none;
            border-radius: 999px;
            padding: 12px 26px;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            background: rgba(148, 163, 184, 0.12);
            color: rgba(226, 232, 240, 0.85);
            border: 1px solid rgba(148, 163, 184, 0.28);
            transition: transform 0.2s ease, box-shadow 0.3s ease, border 0.3s ease;
        }

        .pill-button:hover {
            transform: translateY(-1px);
            border-color: rgba(226, 232, 240, 0.55);
            box-shadow: 0 18px 28px rgba(15, 23, 42, 0.45);
        }

        h2 {
            margin: 0;
            font-size: 1.8rem;
            font-weight: 700;
            letter-spacing: 0.08em;
            text-transform: uppercase;
            text-align: center;
            color: #e0f2fe;
        }

        .orders-panel {
            padding: 36px 40px;
            border-radius: 32px;
            background: rgba(15, 23, 42, 0.78);
            border: 1px solid rgba(148, 163, 184, 0.18);
            box-shadow: 0 32px 65px rgba(5, 8, 22, 0.55);
            backdrop-filter: blur(20px);
        }

        .orders-list {
            margin-top: 28px;
            display: flex;
            flex-direction: column;
            gap: 26px;
        }

        .order-card {
            display: grid;
            grid-template-columns: minmax(0, 1fr) minmax(0, 340px);
            gap: 28px;
            padding: 28px 30px;
            border-radius: 28px;
            background: linear-gradient(160deg, rgba(15, 23, 42, 0.82), rgba(49, 46, 129, 0.78));
            border: 1px solid rgba(148, 163, 184, 0.18);
            box-shadow: 0 32px 48px rgba(14, 116, 144, 0.35);
            transition: transform 0.25s ease, box-shadow 0.25s ease, border-color 0.25s ease;
        }

        .order-card:hover {
            transform: translateY(-4px);
            border-color: rgba(236, 72, 153, 0.36);
            box-shadow: 0 40px 62px rgba(236, 72, 153, 0.25);
        }

        .order-meta {
            display: flex;
            flex-direction: column;
            gap: 22px;
        }

        .order-head {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
        }

        .order-id {
            font-size: 1.05rem;
            font-weight: 700;
            letter-spacing: 0.08em;
            text-transform: uppercase;
            color: #e0f2fe;
        }

        .meta-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 18px;
        }

        .meta-item {
            display: flex;
            flex-direction: column;
            gap: 6px;
            padding: 14px 16px;
            border-radius: 18px;
            background: rgba(15, 23, 42, 0.65);
            border: 1px solid rgba(148, 163, 184, 0.16);
        }

        .meta-item.span-2 {
            grid-column: span 2;
        }

        .meta-label {
            font-size: 0.75rem;
            letter-spacing: 0.12em;
            text-transform: uppercase;
            color: rgba(148, 163, 184, 0.75);
            font-weight: 600;
        }

        .meta-value {
            font-size: 0.98rem;
            color: rgba(226, 232, 240, 0.88);
            font-weight: 600;
        }

        .meta-value.total {
            color: #f472b6;
            font-size: 1.05rem;
        }

        .meta-value.date {
            color: rgba(148, 163, 184, 0.9);
        }

        .order-items-wrapper {
            display: flex;
            flex-direction: column;
            gap: 14px;
            background: rgba(15, 23, 42, 0.65);
            border-radius: 22px;
            padding: 20px 22px;
            border: 1px solid rgba(148, 163, 184, 0.18);
        }

        .items-title {
            font-size: 0.85rem;
            letter-spacing: 0.16em;
            text-transform: uppercase;
            color: rgba(148, 163, 184, 0.75);
            font-weight: 700;
        }

        .order-items-table {
            width: 100%;
            border-collapse: collapse;
            border-radius: 18px;
            overflow: hidden;
        }

        .order-items-table th,
        .order-items-table td {
            padding: 10px 14px;
            text-align: left;
            border-bottom: 1px solid rgba(148, 163, 184, 0.18);
            color: rgba(226, 232, 240, 0.9);
        }

        .order-items-table th {
            background: rgba(56, 189, 248, 0.2);
            color: #38bdf8;
            font-weight: 700;
        }

        .order-items-table tr:last-child td {
            border-bottom: none;
        }

        .status-pill {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 6px 16px;
            border-radius: 999px;
            font-weight: 700;
            font-size: 0.85rem;
            letter-spacing: 0.08em;
            text-transform: uppercase;
        }

        .status-pill.status-pending {
            background: rgba(250, 204, 21, 0.18);
            color: #facc15;
        }

        .status-pill.status-completed {
            background: rgba(34, 197, 94, 0.18);
            color: #4ade80;
        }

        .status-pill.status-cancelled {
            background: rgba(248, 113, 113, 0.2);
            color: #f87171;
        }

        .empty-state {
            display: none;
            margin-top: 32px;
            padding: 60px 30px;
            border-radius: 28px;
            text-align: center;
            background: rgba(15, 23, 42, 0.65);
            border: 1px solid rgba(148, 163, 184, 0.18);
            color: rgba(226, 232, 240, 0.78);
            font-size: 1.05rem;
            box-shadow: 0 28px 45px rgba(8, 47, 73, 0.35);
        }

        .empty-state.show {
            display: block;
        }

        @media (max-width: 980px) {
            .order-card {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 720px) {
            .orders-panel {
                padding: 28px 24px;
            }

            .order-card {
                padding: 24px;
            }

            .meta-item.span-2 {
                grid-column: span 1;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="page-shell">
            <header>
                <div id="companyName">Gadget Hub</div>
                <asp:Button ID="btnHome" runat="server" Text="Back to Store" OnClick="btnHome_Click" CssClass="pill-button" />
            </header>
            <div class="orders-panel">
                <h2>My Orders</h2>
                <div class="orders-list">
                    <asp:Repeater ID="rptOrders" runat="server">
                        <ItemTemplate>
                            <div class="order-card">
                                <div class="order-meta">
                                    <div class="order-head">
                                        <span class="order-id">Order #<%# Eval("Id") %></span>
                                        <asp:Literal ID="litStatus" runat="server"></asp:Literal>
                                    </div>
                                    <div class="meta-grid">
                                        <div class="meta-item">
                                            <span class="meta-label">Total</span>
                                            <span class="meta-value total"><asp:Literal ID="litTotal" runat="server"></asp:Literal></span>
                                        </div>
                                        <div class="meta-item">
                                            <span class="meta-label">Order Date</span>
                                            <span class="meta-value date"><asp:Literal ID="litDate" runat="server"></asp:Literal></span>
                                        </div>
                                        <div class="meta-item span-2">
                                            <span class="meta-label">Delivery Address</span>
                                            <span class="meta-value"><%# Eval("DeliveryAddress") %></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="order-items-wrapper">
                                    <div class="items-title">Items</div>
                                    <asp:Repeater ID="rptOrderItems" runat="server">
                                        <HeaderTemplate>
                                            <table class="order-items-table">
                                                <thead>
                                                    <tr>
                                                        <th>Product</th>
                                                        <th>Quantity</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                                    <tr>
                                                        <td><%# Eval("ProductName") %></td>
                                                        <td><%# Eval("Qty") %></td>
                                                    </tr>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                                </tbody>
                                            </table>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                    <asp:Literal ID="litEmptyItems" runat="server" Visible="false"></asp:Literal>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    <asp:Panel ID="pnlEmptyOrders" runat="server" CssClass="empty-state">
                        You have no orders yet. Head back to the store to discover something new.
                    </asp:Panel>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
