<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuotationsSection.aspx.cs" Inherits="GadgetHub.Web.GHAdmin.QuotationsSection" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Quotations List</title>
    <style>
    body {
        font-family: Arial, sans-serif;
        margin: 20px;
    }

    table {
        border-collapse: collapse;
        width: 100%;
        margin-bottom: 30px;
    }

    th, td {
        border: 1px solid #ccc; /* consistent border color */
        padding: 10px 12px;
        text-align: left;
        vertical-align: middle;
    }

    th {
        background-color: #2980b9; /* darker blue header */
        color: white;
        font-weight: normal;
    }

    tbody tr:nth-child(even) {
        background-color: #f9f9f9; /* zebra stripes */
    }

    tbody tr:hover {
        background-color: #f1f1f1;
    }

    input[type="number"], input[type="text"] {
        width: 80px;
        padding: 6px 8px;
        box-sizing: border-box;
        border: 1px solid #ccc;
        border-radius: 3px;
        font-size: 14px;
        transition: border-color 0.3s ease;
    }

    input[type="number"]:focus, input[type="text"]:focus {
        border-color: #2980b9;
        outline: none;
    }

    .btn-update {
        background-color: #27ae60; /* green */
        color: white;
        border: none;
        padding: 8px 14px;
        cursor: pointer;
        border-radius: 4px;
        font-size: 14px;
        transition: background-color 0.3s ease;
    }

    .btn-update:hover {
        background-color: #2ecc71;
    }
</style>


</head>
<body>
    <form id="form1" runat="server">

<asp:DropDownList ID="ddlStatus" runat="server" AutoPostBack="true"
    OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
    <asp:ListItem Text="All" Value="" />
    <asp:ListItem Text="Pending" Value="Pending" />
    <asp:ListItem Text="Approved" Value="Approved" />
    <asp:ListItem Text="Rejected" Value="Rejected" />
</asp:DropDownList>

<asp:TextBox ID="txtSearch" runat="server" Placeholder="Search by distributor name or ID"></asp:TextBox>
<asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />

<asp:GridView ID="gvQuotations" runat="server" AutoGenerateColumns="False">
    <Columns>
        <asp:BoundField DataField="QuotationId" HeaderText="Quotation ID" />
        <asp:BoundField DataField="DistributorName" HeaderText="Distributor" />
        <asp:BoundField DataField="Status" HeaderText="Status" />
        <asp:BoundField DataField="CreatedAt" HeaderText="Created At" DataFormatString="{0:yyyy-MM-dd}" />
        <asp:TemplateField HeaderText="Actions">
            <ItemTemplate>
                <asp:HyperLink ID="lnkView" runat="server" Text="View" 
                    NavigateUrl='<%# Eval("QuotationId", "~/GHAdmin/QuotationDetails.aspx?id={0}") %>' />
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>

    </form>
</body>
</html>
