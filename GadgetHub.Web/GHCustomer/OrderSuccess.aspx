<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OrderSuccess.aspx.cs" Inherits="GadgetHub.Web.OrderSuccess" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Order Placed Successfully</title>
    <style>
        body {
            margin: 0;
            padding: 40px 18px 60px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: radial-gradient(140% 160% at 10% 20%, #312e81 0%, #0f172a 55%, #050816 100%);
            color: #e2e8f0;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
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

        .container {
            position: relative;
            z-index: 1;
            padding: 56px 60px;
            border-radius: 36px;
            background: rgba(15, 23, 42, 0.78);
            border: 1px solid rgba(148, 163, 184, 0.18);
            box-shadow: 0 36px 70px rgba(5, 8, 22, 0.55);
            backdrop-filter: blur(22px);
            text-align: center;
            max-width: 540px;
            width: min(540px, 96%);
        }

        .success-icon {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 72px;
            height: 72px;
            border-radius: 50%;
            background: linear-gradient(135deg, #22d3ee, #6366f1);
            margin-bottom: 24px;
            color: #020617;
            font-size: 2rem;
            box-shadow: 0 18px 32px rgba(99, 102, 241, 0.35);
        }

        h2 {
            margin: 0 0 18px;
            font-size: 2rem;
            font-weight: 700;
            color: #e0f2fe;
            letter-spacing: 0.08em;
            text-transform: uppercase;
        }

        p {
            margin: 0 0 32px;
            font-size: 1.05rem;
            color: rgba(226, 232, 240, 0.78);
            line-height: 1.6;
        }

        a {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 14px 34px;
            border-radius: 999px;
            background: linear-gradient(135deg, #f472b6, #38bdf8);
            color: #061122;
            font-weight: 700;
            text-decoration: none;
            transition: transform 0.2s ease, box-shadow 0.3s ease;
        }

        a:hover {
            transform: translateY(-1px);
            box-shadow: 0 18px 34px rgba(244, 114, 182, 0.35);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="success-icon">✓</div>
        <h2>Order Confirmed</h2>
        <p>Please await confirmation from the distributor. Thank you for choosing Gadget Hub!</p>
        <a href="HomePage.aspx">Continue Shopping</a>
    </div>
</body>
</html>
