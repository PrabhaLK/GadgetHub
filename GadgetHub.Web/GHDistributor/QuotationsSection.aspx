<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuotationsSection.aspx.cs" Inherits="GadgetHub.Web.GHDistributor.QuotationsSection" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Distributor Quotations</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
            margin-bottom: 30px;
        }
        th, td {
            border: 1px solid #ccc; /* match Orders table border color */
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #2980b9; /* darker blue header */
            color: white;             /* white text for header */
        }
        input[type="number"], input[type="text"] {
            width: 80px;
            padding: 4px;
            box-sizing: border-box;
        }
        .btn-update {
            background-color: #27ae60; /* slightly different green */
            color: white;
            border: none;
            padding: 6px 12px;
            cursor: pointer;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }
        .btn-update:hover {
            background-color: #2ecc71;
        }
        /* Optional: Add hover effect on rows */
        tbody tr:hover {
            background-color: #f9f9f9;
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
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
        <asp:PlaceHolder ID="phQuotations" runat="server"></asp:PlaceHolder>
    </form>
</body>
</html>
