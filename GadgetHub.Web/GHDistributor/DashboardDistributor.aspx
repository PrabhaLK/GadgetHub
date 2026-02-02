<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DashboardDistributor.aspx.cs" Inherits="GadgetHub.Web.GHDistributor.DashboardDistributor" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Distributor Dashboard</title>
    <style>
        body {
            margin: 0;
            padding: 40px 24px 60px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: radial-gradient(140% 160% at 10% 20%, #312e81 0%, #0f172a 55%, #050816 100%);
            color: #e2e8f0;
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
            overflow-y: auto;
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

        .dashboard-shell {
            width: min(1280px, 96%);
            display: flex;
            flex-direction: column;
            gap: 26px;
            position: relative;
            z-index: 1;
        }

        .topbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 28px 32px;
            border-radius: 32px;
            background: linear-gradient(135deg, rgba(15, 23, 42, 0.85), rgba(76, 29, 149, 0.72), rgba(34, 211, 238, 0.55));
            border: 1px solid rgba(148, 163, 184, 0.18);
            box-shadow: 0 30px 65px rgba(5, 8, 22, 0.55);
            backdrop-filter: blur(20px);
        }

        .brand {
            font-size: 1.9rem;
            font-weight: 700;
            letter-spacing: 0.16em;
            text-transform: uppercase;
            color: #f8fafc;
        }

        .distributor-info {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .distributor-email {
            font-size: 0.95rem;
            letter-spacing: 0.08em;
            color: rgba(226, 232, 240, 0.78);
        }

        .pill-button {
            border: none;
            border-radius: 999px;
            padding: 12px 24px;
            font-weight: 600;
            cursor: pointer;
            background: rgba(244, 63, 94, 0.22);
            border: 1px solid rgba(244, 63, 94, 0.45);
            color: #fca5a5;
            transition: transform 0.2s ease, box-shadow 0.3s ease, border 0.3s ease;
        }

        .pill-button:hover {
            transform: translateY(-1px);
            border-color: rgba(252, 165, 165, 0.65);
            box-shadow: 0 18px 34px rgba(244, 63, 94, 0.35);
        }

        .layout {
            display: grid;
            grid-template-columns: 280px 1fr;
            gap: 28px;
            min-height: calc(100vh - 220px);
        }

        .sidebar {
            display: flex;
            flex-direction: column;
            gap: 20px;
            padding: 28px 24px;
            border-radius: 28px;
            background: rgba(15, 23, 42, 0.78);
            border: 1px solid rgba(148, 163, 184, 0.18);
            box-shadow: 0 32px 60px rgba(5, 8, 22, 0.55);
            backdrop-filter: blur(20px);
        }

        .nav-title {
            font-size: 0.78rem;
            letter-spacing: 0.18em;
            text-transform: uppercase;
            color: rgba(148, 163, 184, 0.75);
            font-weight: 700;
        }

        .nav-links {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .nav-link {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 14px 18px;
            border-radius: 18px;
            color: rgba(226, 232, 240, 0.85);
            text-decoration: none;
            font-weight: 600;
            letter-spacing: 0.04em;
            transition: transform 0.2s ease, box-shadow 0.3s ease, background 0.3s ease, color 0.3s ease;
            border: 1px solid transparent;
        }

        .nav-link:hover,
        .nav-link:focus {
            transform: translateY(-2px);
            background: linear-gradient(135deg, rgba(56, 189, 248, 0.3), rgba(236, 72, 153, 0.3));
            border-color: rgba(148, 163, 184, 0.24);
            color: #0b1120;
            box-shadow: 0 18px 30px rgba(56, 189, 248, 0.25);
        }

        .content-panel {
            border-radius: 32px;
            background: rgba(15, 23, 42, 0.78);
            border: 1px solid rgba(148, 163, 184, 0.18);
            box-shadow: 0 32px 60px rgba(5, 8, 22, 0.55);
            backdrop-filter: blur(20px);
            padding: 24px;
        }

        .frame-shell {
            position: relative;
            height: calc(100vh - 260px);
            min-height: 560px;
            border-radius: 26px;
            border: 1px solid rgba(148, 163, 184, 0.16);
            overflow: hidden;
            background: rgba(15, 23, 42, 0.65);
            box-shadow: inset 0 0 0 1px rgba(255, 255, 255, 0.02);
        }

        iframe {
            width: 100%;
            height: 100%;
            border: none;
            background: transparent;
        }

        @media (max-width: 1024px) {
            .layout {
                grid-template-columns: 1fr;
            }

            .frame-shell {
                height: auto;
                min-height: 520px;
            }
        }

        @media (max-width: 640px) {
            body {
                padding: 28px 16px 48px;
            }

            .topbar {
                flex-direction: column;
                align-items: flex-start;
                gap: 18px;
            }

            .distributor-info {
                width: 100%;
                justify-content: space-between;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="dashboard-shell">
            <div class="topbar">
                <div class="brand">Distributor Hub</div>
                <div class="distributor-info">
                    <asp:Label ID="lblDistributorEmail" runat="server" CssClass="distributor-email" Text="distributor@example.com"></asp:Label>
                    <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="pill-button" OnClick="btnLogout_Click" />
                </div>
            </div>

            <div class="layout">
                <nav class="sidebar">
                    <div class="nav-title">Manage</div>
                    <div class="nav-links">
                        <a class="nav-link" href="QuotationsSection.aspx" target="contentFrame">Quotations</a>
                        <a class="nav-link" href="OrdersSection.aspx" target="contentFrame">Orders</a>
                        <a class="nav-link" href="MessagesSection.aspx" target="contentFrame">Contact Messages</a>
                    </div>
                </nav>

                <section class="content-panel">
                    <div class="frame-shell">
                        <iframe id="contentFrame" name="contentFrame" src="QuotationsSection.aspx"></iframe>
                    </div>
                </section>
            </div>
        </div>
    </form>
</body>
</html>

