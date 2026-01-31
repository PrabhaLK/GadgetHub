<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MessagesSection.aspx.cs" Inherits="GadgetHub.Web.GHUser.MessagesSection" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My Messages</title>
    <style>
        /* Reset and base styles */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f7f9fc;
            color: #333;
            margin: 0;
            padding: 20px;
        }

        h2 {
            color: #2c3e50;
            font-weight: 600;
            margin-bottom: 20px;
        }

        /* Table styling */
        table {
            border-collapse: collapse;
            width: 100%;
            background: white;
            box-shadow: 0 2px 6px rgb(0 0 0 / 0.1);
            border-radius: 6px;
            overflow: hidden;
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

        /* Last row no border */
        tbody tr:last-child td {
            border-bottom: none;
        }

        /* No messages placeholder */
        .no-messages {
            margin-top: 30px;
            font-style: italic;
            color: #7f8c8d;
            font-size: 16px;
            text-align: center;
        }

        /* Responsive */
        @media (max-width: 600px) {
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
                padding: 10px;
            }

            tbody td {
                border: none;
                position: relative;
                padding-left: 50%;
                text-align: right;
                font-size: 13px;
            }

            tbody td::before {
                content: attr(data-label);
                position: absolute;
                left: 15px;
                top: 12px;
                font-weight: 600;
                text-transform: uppercase;
                font-size: 12px;
                color: #2980b9;
                text-align: left;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h2>My Contact Messages</h2>
        <asp:PlaceHolder ID="phMessages" runat="server"></asp:PlaceHolder>
    </form>
</body>
</html>
