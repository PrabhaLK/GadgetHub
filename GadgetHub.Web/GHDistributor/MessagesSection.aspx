<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MessagesSection.aspx.cs" Inherits="GadgetHub.Web.GHUser.MessagesSection" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My Messages</title>
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

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            overflow: hidden;
            border-radius: 24px;
            background: rgba(5, 12, 30, 0.75);
            border: 1px solid rgba(148, 163, 184, 0.1);
            box-shadow: 0 18px 35px rgba(8, 47, 73, 0.32);
            min-width: 780px;
        }

        thead th {
            background: linear-gradient(135deg, rgba(56, 189, 248, 0.32), rgba(129, 140, 248, 0.38));
            color: #f8fafc;
            font-weight: 700;
            letter-spacing: 0.12em;
            text-transform: uppercase;
            padding: 18px 20px;
            border-bottom: 1px solid rgba(148, 163, 184, 0.28);
        }

        tbody td {
            padding: 18px 20px;
            border-bottom: 1px solid rgba(148, 163, 184, 0.1);
            color: rgba(226, 232, 240, 0.9);
            vertical-align: top;
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        tbody tr {
            transition: background 0.25s ease, transform 0.2s ease;
        }

        tbody tr:hover {
            background: linear-gradient(135deg, rgba(56, 189, 248, 0.12), rgba(236, 72, 153, 0.1));
            transform: translateY(-2px);
        }

        tbody tr:nth-child(even) {
            background: rgba(15, 23, 42, 0.76);
        }

        tbody tr:nth-child(odd) {
            background: rgba(12, 21, 38, 0.86);
        }

        .no-messages {
            padding: 28px;
            border-radius: 22px;
            border: 1px solid rgba(148, 163, 184, 0.22);
            background: rgba(15, 23, 42, 0.7);
            text-align: center;
            font-size: 1.05rem;
            color: rgba(226, 232, 240, 0.65);
        }

        @media (max-width: 700px) {
            .panel {
                padding: 26px 22px;
            }

            .table-shell {
                padding: 18px 18px;
            }

            table {
                min-width: 0;
            }

            thead {
                display: none;
            }

            table,
            tbody,
            tr,
            td {
                display: block;
            }

            tbody tr {
                margin-bottom: 16px;
                border: 1px solid rgba(148, 163, 184, 0.18);
                border-radius: 24px;
                overflow: hidden;
            }

            tbody td {
                padding: 12px 16px;
                border-bottom: none;
                position: relative;
            }

            tbody td::before {
                display: block;
                font-size: 0.75rem;
                letter-spacing: 0.12em;
                text-transform: uppercase;
                color: rgba(148, 163, 184, 0.75);
                margin-bottom: 6px;
            }

            tbody td:nth-child(1)::before { content: "Date"; }
            tbody td:nth-child(2)::before { content: "Subject"; }
            tbody td:nth-child(3)::before { content: "Message"; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="page-shell">
            <div class="panel">
                <h1>My Contact Messages</h1>
                <div class="table-shell">
                    <div class="table-scroll">
                        <asp:PlaceHolder ID="phMessages" runat="server"></asp:PlaceHolder>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
