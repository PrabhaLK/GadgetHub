<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuotationsSection.aspx.cs" Inherits="GadgetHub.Web.GHDistributor.QuotationsSection" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Distributor Quotations</title>
    <style>
        body {
            margin: 0;
            padding: 32px 18px 48px;
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

        .feedback {
            margin-top: 16px;
            padding: 12px 18px;
            border-radius: 18px;
            font-weight: 600;
            letter-spacing: 0.06em;
            display: inline-flex;
            align-items: center;
            gap: 10px;
        }

        .feedback-success {
            border: 1px solid rgba(34, 197, 94, 0.45);
            background: rgba(34, 197, 94, 0.15);
            color: #bbf7d0;
        }

        .feedback-error {
            border: 1px solid rgba(248, 113, 113, 0.45);
            background: rgba(248, 113, 113, 0.12);
            color: #fecaca;
        }

        .quote-stack {
            margin-top: 28px;
            display: flex;
            flex-direction: column;
            gap: 24px;
        }

        .quote-card {
            padding: 26px 28px;
            border-radius: 28px;
            background: rgba(5, 12, 30, 0.72);
            border: 1px solid rgba(148, 163, 184, 0.18);
            box-shadow: 0 32px 60px rgba(5, 8, 22, 0.55);
            position: relative;
            overflow: hidden;
        }

        .quote-card::before {
            content: "";
            position: absolute;
            inset: -35% -20% auto;
            height: 60%;
            background: radial-gradient(55% 55% at 20% 35%, rgba(56, 189, 248, 0.18), transparent 60%),
                        radial-gradient(40% 40% at 80% 15%, rgba(236, 72, 153, 0.16), transparent 65%);
        }

        .quote-card::after {
            content: "";
            position: absolute;
            inset: 0;
            border-radius: 28px;
            border: 1px solid rgba(99, 102, 241, 0.14);
            mix-blend-mode: screen;
            pointer-events: none;
        }

        .quote-body {
            position: relative;
            z-index: 1;
            display: flex;
            flex-direction: column;
            gap: 18px;
        }

        .quote-table-scroll {
            position: relative;
            z-index: 1;
            overflow-x: auto;
            border-radius: 20px;
        }

        .quote-table-scroll::-webkit-scrollbar {
            height: 10px;
        }

        .quote-table-scroll::-webkit-scrollbar-track {
            background: rgba(15, 23, 42, 0.65);
            border-radius: 999px;
        }

        .quote-table-scroll::-webkit-scrollbar-thumb {
            background: linear-gradient(135deg, rgba(56, 189, 248, 0.55), rgba(129, 140, 248, 0.65));
            border-radius: 999px;
        }

        .quote-table-scroll::-webkit-scrollbar-thumb:hover {
            background: linear-gradient(135deg, rgba(56, 189, 248, 0.75), rgba(129, 140, 248, 0.85));
        }

        .quote-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 12px 24px;
            font-size: 0.95rem;
            letter-spacing: 0.05em;
            color: rgba(226, 232, 240, 0.78);
        }

        .quote-meta span {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 6px 14px;
            border-radius: 999px;
            background: rgba(15, 23, 42, 0.55);
            border: 1px solid rgba(148, 163, 184, 0.18);
            color: rgba(226, 232, 240, 0.9);
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            overflow: hidden;
            border-radius: 22px;
            background: rgba(12, 21, 38, 0.9);
            border: 1px solid rgba(148, 163, 184, 0.18);
            box-shadow: inset 0 1px 0 rgba(148, 163, 184, 0.18);
        }

        thead th {
            background: rgba(56, 189, 248, 0.28);
            color: #e0f2fe;
            letter-spacing: 0.12em;
            text-transform: uppercase;
            font-weight: 700;
            padding: 16px 18px;
            border-bottom: 1px solid rgba(148, 163, 184, 0.22);
        }

        tbody td {
            padding: 16px 18px;
            border-bottom: 1px solid rgba(148, 163, 184, 0.14);
            color: rgba(226, 232, 240, 0.9);
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        tbody tr:hover {
            background: linear-gradient(135deg, rgba(56, 189, 248, 0.12), rgba(236, 72, 153, 0.1));
        }

        input[type="number"],
        input[type="text"] {
            width: 110px;
            padding: 8px 12px;
            border-radius: 16px;
            border: 1px solid rgba(148, 163, 184, 0.28);
            background: rgba(15, 23, 42, 0.55);
            color: #e2e8f0;
            font-size: 0.95rem;
            transition: border 0.2s ease, box-shadow 0.2s ease;
        }

        input[type="number"]:focus,
        input[type="text"]:focus {
            outline: none;
            border-color: rgba(56, 189, 248, 0.45);
            box-shadow: 0 0 0 3px rgba(56, 189, 248, 0.22);
        }

        .btn-update {
            border: none;
            border-radius: 999px;
            padding: 10px 24px;
            font-weight: 700;
            cursor: pointer;
            background: linear-gradient(135deg, #34d399, #22d3ee);
            color: #022c22;
            transition: transform 0.2s ease, box-shadow 0.3s ease;
        }

        .btn-update:hover {
            transform: translateY(-1px);
            box-shadow: 0 18px 32px rgba(34, 211, 238, 0.35);
        }

        .empty-state {
            padding: 28px;
            border-radius: 22px;
            border: 1px solid rgba(148, 163, 184, 0.22);
            background: rgba(15, 23, 42, 0.7);
            text-align: center;
            font-size: 1.05rem;
            color: rgba(226, 232, 240, 0.65);
        }

        @media (max-width: 760px) {
            .panel {
                padding: 26px 22px;
            }

            .quote-card {
                padding: 22px 22px;
            }

            table,
            thead,
            tbody,
            tr,
            td,
            th {
                display: block;
            }

            thead {
                display: none;
            }

            tbody tr {
                margin-bottom: 16px;
                border-radius: 20px;
                overflow: hidden;
                border: 1px solid rgba(148, 163, 184, 0.18);
            }

            tbody td {
                border-bottom: none;
                position: relative;
                padding: 12px 16px;
            }

            tbody td::before {
                display: block;
                font-size: 0.75rem;
                letter-spacing: 0.12em;
                text-transform: uppercase;
                color: rgba(148, 163, 184, 0.75);
                margin-bottom: 6px;
            }

            tbody td:nth-child(1)::before { content: "Product"; }
            tbody td:nth-child(2)::before { content: "Quantity"; }
            tbody td:nth-child(3)::before { content: "Price"; }
            tbody td:nth-child(4)::before { content: "Total"; }
            tbody td:nth-child(5)::before { content: "Action"; }
        }
    </style>
    <script>
        function updateQuotationItem(quotationId, productId) {
            var qtyInput = document.getElementById('qty_' + quotationId + '_' + productId);
            var priceInput = document.getElementById('price_' + quotationId + '_' + productId);

            var qty = qtyInput.value;
            var price = priceInput.value;

            __doPostBack('UpdateItem', quotationId + ',' + productId + ',' + qty + ',' + price);
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="page-shell">
            <div class="panel">
                <h1>Quotations</h1>
                <asp:Label ID="lblMessage" runat="server" CssClass="feedback"></asp:Label>
                <div class="quote-stack">
                    <asp:PlaceHolder ID="phQuotations" runat="server"></asp:PlaceHolder>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
