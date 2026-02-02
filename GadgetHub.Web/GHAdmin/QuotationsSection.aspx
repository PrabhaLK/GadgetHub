<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuotationsSection.aspx.cs" Inherits="GadgetHub.Web.GHAdmin.QuotationsSection" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Quotations List</title>
    <style>
        body {
            margin: 0;
            padding: 32px 18px 48px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: radial-gradient(140% 160% at 10% 20%, #312e81 0%, #0f172a 55%, #050816 100%);
            color: #e2e8f0;
            min-height: 100vh;
            position: relative;
            overflow: hidden;
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
            width: min(1180px, 96%);
            display: flex;
            flex-direction: column;
            gap: 24px;
            position: relative;
            z-index: 1;
        }

        .panel {
            padding: 32px 34px;
            border-radius: 30px;
            background: rgba(15, 23, 42, 0.78);
            border: 1px solid rgba(148, 163, 184, 0.18);
            box-shadow: 0 32px 60px rgba(5, 8, 22, 0.55);
            backdrop-filter: blur(20px);
        }

        .panel h1 {
            margin: 0;
            font-size: 1.7rem;
            font-weight: 700;
            letter-spacing: 0.12em;
            text-transform: uppercase;
            color: #e0f2fe;
        }

        .filters {
            display: flex;
            flex-wrap: wrap;
            gap: 14px;
            margin-top: 28px;
            align-items: center;
        }

        .control {
            padding: 10px 14px;
            border-radius: 16px;
            border: 1px solid rgba(148, 163, 184, 0.28);
            background: rgba(15, 23, 42, 0.55);
            color: #e2e8f0;
            font-size: 0.95rem;
            transition: border 0.2s ease, box-shadow 0.2s ease;
            min-width: 160px;
        }

        .control:focus {
            outline: none;
            border-color: rgba(56, 189, 248, 0.45);
            box-shadow: 0 0 0 3px rgba(56, 189, 248, 0.22);
        }

        .control::placeholder {
            color: rgba(226, 232, 240, 0.58);
        }

        .primary-btn {
            border: none;
            border-radius: 999px;
            padding: 11px 26px;
            font-weight: 700;
            cursor: pointer;
            background: linear-gradient(135deg, #38bdf8, #6366f1);
            color: #061122;
            transition: transform 0.2s ease, box-shadow 0.3s ease;
        }

        .primary-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 18px 32px rgba(99, 102, 241, 0.35);
        }

        .table-shell {
            position: relative;
            margin-top: 26px;
            padding: 22px 24px;
            border-radius: 28px;
            background: linear-gradient(140deg, rgba(15, 23, 42, 0.92), rgba(17, 24, 39, 0.72));
            border: 1px solid rgba(148, 163, 184, 0.16);
            box-shadow: inset 0 1px 0 rgba(148, 163, 184, 0.18), 0 28px 45px rgba(6, 12, 34, 0.55);
            overflow: hidden;
        }

        .table-shell::before {
            content: "";
            position: absolute;
            inset: -40% -30% auto;
            height: 70%;
            background: radial-gradient(55% 55% at 20% 35%, rgba(56, 189, 248, 0.18), transparent 60%),
                        radial-gradient(40% 40% at 80% 15%, rgba(236, 72, 153, 0.16), transparent 60%);
            z-index: 0;
        }

        .table-shell::after {
            content: "";
            position: absolute;
            inset: 0;
            border-radius: 28px;
            border: 1px solid rgba(99, 102, 241, 0.18);
            mix-blend-mode: screen;
            pointer-events: none;
        }

        .table-scroll {
            position: relative;
            z-index: 1;
            overflow-x: auto;
            overflow-y: hidden;
            border-radius: 20px;
        }

        .table-scroll::-webkit-scrollbar {
            height: 10px;
        }

        .table-scroll::-webkit-scrollbar-track {
            background: rgba(15, 23, 42, 0.65);
            border-radius: 999px;
        }

        .table-scroll::-webkit-scrollbar-thumb {
            background: linear-gradient(135deg, rgba(56, 189, 248, 0.55), rgba(129, 140, 248, 0.65));
            border-radius: 999px;
        }

        .table-scroll::-webkit-scrollbar-thumb:hover {
            background: linear-gradient(135deg, rgba(56, 189, 248, 0.75), rgba(129, 140, 248, 0.85));
        }

        .data-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin-top: 0;
            overflow: hidden;
            border-radius: 24px;
            background: rgba(5, 12, 30, 0.75);
            border: 1px solid rgba(148, 163, 184, 0.1);
            box-shadow: 0 18px 35px rgba(8, 47, 73, 0.32);
            position: relative;
            z-index: 1;
            min-width: 860px;
        }

        .data-table thead {
            position: sticky;
            top: 0;
            z-index: 2;
        }

        .data-table thead th {
            background: linear-gradient(135deg, rgba(56, 189, 248, 0.32), rgba(129, 140, 248, 0.38));
            color: #f8fafc;
            font-weight: 700;
            letter-spacing: 0.12em;
            text-transform: uppercase;
            padding: 18px 20px;
            border-bottom: 1px solid rgba(148, 163, 184, 0.28);
        }

        .data-table tbody td {
            padding: 18px 20px;
            border-bottom: 1px solid rgba(148, 163, 184, 0.1);
            color: rgba(226, 232, 240, 0.92);
            backdrop-filter: blur(2px);
        }

        .data-table tbody tr:last-child td {
            border-bottom: none;
        }

        .data-table tbody tr {
            transition: background 0.25s ease, transform 0.2s ease;
        }

        .data-table tbody tr:hover {
            background: linear-gradient(135deg, rgba(56, 189, 248, 0.12), rgba(236, 72, 153, 0.1));
            transform: translateY(-2px);
        }

        .data-table tbody tr:nth-child(even) {
            background: rgba(15, 23, 42, 0.76);
        }

        .data-table tbody tr:nth-child(odd) {
            background: rgba(12, 21, 38, 0.86);
        }

        .data-table tbody td + td {
            border-left: 1px solid rgba(148, 163, 184, 0.08);
        }

        .data-table tbody td:first-child {
            font-weight: 700;
            color: #60a5fa;
        }

        .status-pill {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 6px 18px;
            border-radius: 999px;
            font-weight: 700;
            font-size: 0.85rem;
            letter-spacing: 0.06em;
            text-transform: uppercase;
        }

        .status-approved {
            background: rgba(34, 197, 94, 0.18);
            color: #4ade80;
        }

        .status-pending {
            background: rgba(250, 204, 21, 0.18);
            color: #fcd34d;
        }

        .status-rejected {
            background: rgba(248, 113, 113, 0.18);
            color: #f87171;
        }

        .status-neutral {
            background: rgba(148, 163, 184, 0.18);
            color: #cbd5f5;
        }

        .link-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 8px 18px;
            border-radius: 999px;
            font-weight: 600;
            font-size: 0.9rem;
            background: rgba(148, 163, 184, 0.16);
            color: #e2e8f0;
            text-decoration: none;
            transition: transform 0.2s ease, box-shadow 0.3s ease, border 0.3s ease;
            border: 1px solid rgba(148, 163, 184, 0.3);
        }

        .link-btn:hover {
            transform: translateY(-1px);
            border-color: rgba(226, 232, 240, 0.55);
            box-shadow: 0 14px 22px rgba(15, 23, 42, 0.45);
        }

        .empty-state {
            padding: 28px;
            text-align: center;
            font-size: 1.05rem;
            color: rgba(226, 232, 240, 0.65);
        }

        @media (max-width: 720px) {
            .panel {
                padding: 26px 22px;
            }

            .table-shell {
                padding: 18px 18px;
            }

            .table-scroll {
                overflow-x: visible;
                border-radius: 24px;
            }

            .data-table thead {
                display: none;
            }

            .data-table,
            .data-table tbody,
            .data-table tr,
            .data-table td {
                display: block;
            }

            .data-table tr {
                margin-bottom: 16px;
                border: 1px solid rgba(148, 163, 184, 0.18);
                border-radius: 24px;
                overflow: hidden;
            }

            .data-table tbody td {
                padding: 12px 16px;
                position: relative;
                border-bottom: none;
            }

            .data-table tbody td + td {
                border-left: none;
            }

            .data-table tbody td:last-child {
                text-align: left;
            }

            .data-table tbody td::before {
                display: block;
                font-size: 0.75rem;
                letter-spacing: 0.12em;
                text-transform: uppercase;
                color: rgba(148, 163, 184, 0.75);
                margin-bottom: 6px;
            }

            .data-table tbody td:nth-child(1)::before { content: "Quotation ID"; }
            .data-table tbody td:nth-child(2)::before { content: "Distributor"; }
            .data-table tbody td:nth-child(3)::before { content: "Status"; }
            .data-table tbody td:nth-child(4)::before { content: "Created At"; }
            .data-table tbody td:nth-child(5)::before { content: "Actions"; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="page-shell">
            <div class="panel">
                <h1>Quotations</h1>
                <div class="filters">
                    <asp:DropDownList ID="ddlStatus" runat="server" AutoPostBack="true" CssClass="control" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                        <asp:ListItem Text="All" Value="" />
                        <asp:ListItem Text="Pending" Value="Pending" />
                        <asp:ListItem Text="Approved" Value="Approved" />
                        <asp:ListItem Text="Rejected" Value="Rejected" />
                    </asp:DropDownList>

                    <asp:TextBox ID="txtSearch" runat="server" CssClass="control" Placeholder="Search by distributor name or ID"></asp:TextBox>
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="primary-btn" OnClick="btnSearch_Click" />
                </div>

                <div class="table-shell">
                    <div class="table-scroll">
                        <asp:GridView ID="gvQuotations" runat="server" AutoGenerateColumns="False" CssClass="data-table">
                            <Columns>
                                <asp:BoundField DataField="QuotationId" HeaderText="Quotation ID" />
                                <asp:BoundField DataField="DistributorName" HeaderText="Distributor" />
                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>' CssClass="status-pill"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="CreatedAt" HeaderText="Created At" DataFormatString="{0:yyyy-MM-dd}" />
                                <asp:TemplateField HeaderText="Actions">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="lnkView" runat="server" CssClass="link-btn" Text="View"
                                            NavigateUrl='<%# Eval("QuotationId", "~/GHAdmin/QuotationDetails.aspx?id={0}") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataTemplate>
                                <div class="empty-state">No quotations found.</div>
                            </EmptyDataTemplate>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
