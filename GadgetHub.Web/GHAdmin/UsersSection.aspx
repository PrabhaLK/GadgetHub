<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UsersSection.aspx.cs" Inherits="GadgetHub.Web.GHAdmin.UsersSection" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Users List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background: #f8f9fa;
        }

        /* Container for filters */
        form > *:not(table) {
            margin-bottom: 15px;
        }

        /* Style for dropdown and textbox */
        select, input[type="text"], .aspNetDisabled {
            padding: 8px 12px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            transition: border-color 0.3s ease;
            vertical-align: middle;
            margin-right: 10px;
        }
        select:focus, input[type="text"]:focus {
            border-color: #2980b9;
            outline: none;
        }

        /* Style for buttons */
        input[type="submit"], button, asp\\:Button {
            background-color: #2980b9;
            color: white;
            border: none;
            padding: 8px 15px;
            font-size: 14px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            vertical-align: middle;
        }
        input[type="submit"]:hover, button:hover, asp\\:Button:hover {
            background-color: #3498db;
        }

        /* GridView table styling */
        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            border: 1px solid #ccc;
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 10px 12px;
            text-align: left;
            border-bottom: 1px solid #ccc;
            vertical-align: middle;
        }

        /* Force blue table header */
table thead th {
    background-color: #007BFF !important; /* Bootstrap primary blue */
    color: white !important;
    border: none;
}

/* Rounded corners for the whole table */
table {
    border-collapse: separate;
    border-spacing: 0;
    border-radius: 8px;
    overflow: hidden; /* Ensures rounded corners show */
}

/* Optional: make first/last th corners rounded */
table thead th:first-child {
    border-top-left-radius: 8px;
}
table thead th:last-child {
    border-top-right-radius: 8px;
}
/* Target the first row of the GridView table */
#gvUsers tr:first-child th {
    background-color: #2980b9; /* Blue */
    color: white;
    font-weight: bold;
    border: none;
}

/* Optional rounded corners for first/last headers */
#gvUsers tr:first-child th:first-child {
    border-top-left-radius: 8px;
}
#gvUsers tr:first-child th:last-child {
    border-top-right-radius: 8px;
}

        /* Header row */
        thead th {
            background-color: #2980b9;
            color: white;
            font-weight: normal;
            border-bottom: 2px solid #1c5980;
        }

        /* Rounded corners on header */
        thead th:first-child {
            border-top-left-radius: 8px;
        }
        thead th:last-child {
            border-top-right-radius: 8px;
        }

        /* Zebra striping on rows */
        tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        /* Hover highlight for rows */
        tbody tr:hover {
            background-color: #f1f1f1;
        }

        /* Status text styling */
        .status-active {
            color: #27ae60;
            font-weight: bold;
        }
        .status-inactive {
            color: #c0392b;
            font-weight: bold;
        }

        /* Action button styling inside GridView */
        .aspNetButton {
            padding: 6px 12px;
            font-size: 13px;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

<asp:DropDownList ID="ddlRole" runat="server" AutoPostBack="true" 
    OnSelectedIndexChanged="ddlRole_SelectedIndexChanged">
    <asp:ListItem Text="All" Value="" />
    <asp:ListItem Text="Customer" Value="Customer" />
    <asp:ListItem Text="Distributor" Value="Distributor" />
</asp:DropDownList>

<asp:TextBox ID="txtSearch" runat="server" Placeholder="Search by name, email, etc."></asp:TextBox>
<asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />

<asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False">
    <Columns>
        <asp:BoundField DataField="Id" HeaderText="ID" />
        <asp:BoundField DataField="FirstName" HeaderText="First Name" />
        <asp:BoundField DataField="LastName" HeaderText="Last Name" />
        <asp:BoundField DataField="Username" HeaderText="Username" />
        <asp:BoundField DataField="Email" HeaderText="Email" />
        <asp:BoundField DataField="Role" HeaderText="Role" />
        <asp:TemplateField HeaderText="Status">
            <ItemTemplate>
                <%# (bool)Eval("IsActive") ? "Active" : "Inactive" %>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Actions">
            <ItemTemplate>
                <asp:Button ID="btnToggle" runat="server" Text='<%# (bool)Eval("IsActive") ? "Deactivate" : "Activate" %>'
                    CommandArgument='<%# Eval("Id") %>' OnClick="btnToggle_Click" />
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>

    </form>
</body>
</html>
