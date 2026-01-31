<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ContactsSection.aspx.cs" Inherits="GadgetHub.Web.GHAdmin.ContactsSection" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Contact Messages</title>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 20px;
    }

    div {
        margin-bottom: 10px;
    }

    input[type="text"], input[type="search"], textarea {
        padding: 6px;
        font-size: 14px;
        border: 1px solid #ccc;
        border-radius: 4px;
        width: 250px;
        box-sizing: border-box;
    }

    input[type="button"], input[type="submit"], button, asp\:Button {
        background-color: #2980b9;
        border: none;
        color: white;
        padding: 7px 14px;
        text-align: center;
        text-decoration: none;
        font-size: 14px;
        border-radius: 4px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    input[type="button"]:hover, input[type="submit"]:hover, button:hover, asp\:Button:hover {
        background-color: #3498db;
    }

    asp\:GridView, table {
        border-collapse: collapse;
        width: 100%;
        margin-top: 15px;
    }

    asp\:GridView th, asp\:GridView td, table th, table td {
        border: 1px solid #ccc;
        padding: 10px 12px;
        text-align: left;
        vertical-align: middle;
    }

    asp\:GridView th, table th {
        background-color: #2980b9;
        color: white;
        font-weight: normal;
    }

    asp\:GridView tr:nth-child(even), table tr:nth-child(even) {
        background-color: #f9f9f9;
    }

    asp\:GridView tr:hover, table tr:hover {
        background-color: #f1f1f1;
    }

    asp\:GridView .emptydatatext {
        font-style: italic;
        color: #666;
        padding: 10px;
    }
</style>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            Search by user or subject:
            <asp:TextBox ID="txtSearch" runat="server" placeholder="User or subject"></asp:TextBox>
            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
        </div>

        <br />

        <asp:GridView ID="gvMessages" runat="server" AutoGenerateColumns="false" EmptyDataText="No messages found">
            <Columns>
                <asp:BoundField DataField="Id" HeaderText="ID" />
                <asp:BoundField DataField="Timestamp" HeaderText="Timestamp" DataFormatString="{0:yyyy-MM-dd HH:mm}" />
                <asp:BoundField DataField="UserName" HeaderText="User" />
                <asp:BoundField DataField="Subject" HeaderText="Subject" />
                <asp:TemplateField HeaderText="Message">
                    <ItemTemplate>
                        <asp:Label ID="lblMessage" runat="server" Text='<%# Eval("Message") %>' 
                            ToolTip='<%# Eval("Message") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </form>
</body>
</html>
