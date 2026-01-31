<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="GadgetHub.Web.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>User Login - Gadget Hub</title>
    <style>
        body {
            background: #f0f4f8;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0; padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        form {
            background: white;
            padding: 40px 70px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            width: 450px;
            box-sizing: border-box;
            text-align: center;
        }
        h2 {
            color: #2980b9;
            margin-bottom: 40px;
            font-weight: bold;
        }
        label {
            display: block;
            font-weight: 600;
            color: #34495e;
            margin-bottom: 8px;
            text-align: left;
        }
        input[type="text"], input[type="password"], input[type="email"], input[type="search"], input[type="tel"] {
            width: 100%;
            padding: 10px 14px;
            border: 1px solid #2980b9;
            border-radius: 6px;
            font-size: 14px;
            color: #2c3e50;
            margin-bottom: 20px;
            transition: border-color 0.3s ease;
            box-sizing: border-box;
        }
        input[type="text"]:focus, input[type="password"]:focus {
            border-color: #3498db;
            outline: none;
        }
        .btn-primary {
            background-color: #2980b9;
            margin: 10px 0px;
            color: white;
            border: none;
            border-radius: 8px;
            padding: 12px 0;
            font-size: 16px;
            width: 100%;
            cursor: pointer;
            font-weight: 600;
            transition: background-color 0.3s ease;
            display: inline-block;
            text-align: center;
        }

        .btn-primary:hover {
            background-color: #3498db;
        }

        #lblStatus {
            margin-top: 16px;
            font-weight: 600;
        }
        .register-link {
            margin-top: 5px;
            display: block;
            font-size: 16px;
            color: #2980b9;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }
        .register-link:hover {
            color: #1c5980;
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h2>Login to The Gadget Hub</h2>

        <asp:Label ID="lblEmail" runat="server" Text="Email:" AssociatedControlID="txtEmail" />
        <asp:TextBox ID="txtEmail" runat="server" CssClass="input" /><br />

        <asp:Label ID="lblPassword" runat="server" Text="Password:" AssociatedControlID="txtPassword" />
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="input" /><br />

        <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn-primary" OnClick="btnLogin_Click" /><br />

        <asp:Label ID="lblStatus" runat="server" Text="" ForeColor="Red" />
        <br />
        <asp:Literal runat="server" ID="litRegisterText"></asp:Literal>
        <asp:HyperLink runat="server" ID="hlRegister" NavigateUrl="~/Register.aspx" Text="Register Now" CssClass="register-link" />
    </form>
</body>
</html>
