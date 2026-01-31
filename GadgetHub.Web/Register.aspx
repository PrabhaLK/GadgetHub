<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="GadgetHub.Web.Register" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>User Registration</title>
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
            padding: 40px 50px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            width: 580px;
            box-sizing: border-box;
            text-align: center;
        }
        h2 {
            color: #2980b9;
            margin-bottom: 40px;
            font-weight: bold;
        }
        .input-row {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }
        .input-group {
            flex: 1;
            text-align: left;
        }
        label {
            display: block;
            font-weight: 600;
            color: #34495e;
            margin-bottom: 8px;
        }
        input[type="text"], input[type="password"], input[type="email"], input[type="search"], input[type="tel"] {
            width: 100%;
            padding: 10px 14px;
            border: 1px solid #2980b9;
            border-radius: 6px;
            font-size: 14px;
            color: #2c3e50;
            transition: border-color 0.3s ease;
            box-sizing: border-box;
        }
        input[type="text"]:focus, input[type="password"]:focus, input[type="email"]:focus {
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
        <div>
            <h2>User Registration</h2>

            <div class="input-row">
                <div class="input-group">
                    <asp:Label ID="lblFirstName" runat="server" Text="First Name:" AssociatedControlID="txtFirstName" />
                    <asp:TextBox ID="txtFirstName" runat="server" CssClass="input-text" />
                </div>
                <div class="input-group">
                    <asp:Label ID="lblLastName" runat="server" Text="Last Name:" AssociatedControlID="txtLastName" />
                    <asp:TextBox ID="txtLastName" runat="server" CssClass="input-text" />
                </div>
            </div>

            <div class="input-row">
                <div class="input-group">
                    <asp:Label ID="lblPhoneNumber" runat="server" Text="Phone Number:" AssociatedControlID="txtPhoneNumber" />
                    <asp:TextBox ID="txtPhoneNumber" runat="server" CssClass="input-text" />
                </div>
                <div class="input-group">
                    <asp:Label ID="lblUsername" runat="server" Text="Username:" AssociatedControlID="txtUsername" />
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="input-text" />
                </div>
            </div>

            <div class="input-row">
                <div class="input-group">
                    <asp:Label ID="lblPassword" runat="server" Text="Password:" AssociatedControlID="txtPassword" />
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="input-text" />
                </div>
                <div class="input-group">
                    <asp:Label ID="lblEmail" runat="server" Text="Email:" AssociatedControlID="txtEmail" />
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="input-text" />
                </div>
            </div>

            <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn-primary" OnClick="btnRegister_Click" />

            <asp:Label ID="lblStatus" runat="server" Text="" ForeColor="Red" />

            <asp:Literal runat="server" ID="litLoginText"></asp:Literal>
            <asp:HyperLink runat="server" ID="hlLogin" NavigateUrl="~/Login.aspx" Text="Login" CssClass="register-link" />

        </div>
    </form>
</body>
</html>
