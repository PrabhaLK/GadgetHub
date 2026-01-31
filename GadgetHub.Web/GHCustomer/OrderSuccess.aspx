<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OrderSuccess.aspx.cs" Inherits="GadgetHub.Web.OrderSuccess" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Order Placed Successfully</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f7f9fc;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            color: #2c3e50;
        }

        .container {
            background: white;
            padding: 40px 50px;
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(41, 128, 185, 0.15);
            text-align: center;
            max-width: 450px;
            width: 90%;
        }

        h2 {
            color: #2980b9;
            margin-bottom: 20px;
            font-weight: 700;
            font-size: 1.8em;
            user-select: none;
        }

        p {
            font-size: 1.1em;
            margin-bottom: 30px;
            color: #555;
            user-select: none;
        }

        a {
            display: inline-block;
            padding: 12px 30px;
            background-color: #2980b9;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            transition: background-color 0.3s ease;
            user-select: none;
        }

        a:hover {
            background-color: #3a7bd5;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Your order has been placed successfully!</h2>
        <p>Please await confirmation from distributor. Thank you for shopping with us!</p>
        <a href="HomePage.aspx">Continue Shopping</a>
    </div>
</body>
</html>
