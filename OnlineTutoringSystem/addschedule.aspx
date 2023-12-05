<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addschedule.aspx.cs" Inherits="OnlineTutoringSystem.addschedule" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Schedule Input</title>
    <!-- Include Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-5">
            <h2>Schedule Input</h2>
            <div class="form-group">
                <label for="scheduleDate">Date:</label>
                <asp:TextBox runat="server" ID="scheduleDate" CssClass="form-control" TextMode="Date"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="startTime">Start Time:</label>
                <asp:TextBox runat="server" ID="startTime" CssClass="form-control" TextMode="Time"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="endTime">End Time:</label>
                <asp:TextBox runat="server" ID="endTime" CssClass="form-control" TextMode="Time"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="subject">Subject:</label>
                <asp:TextBox runat="server" ID="subject" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="description">Description:</label>
                <asp:TextBox runat="server" ID="description" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="status">Status:</label>
                <asp:DropDownList runat="server" ID="status" CssClass="form-control">
                    <asp:ListItem Text="Active" Value="Active"></asp:ListItem>
                    <asp:ListItem Text="Inactive" Value="Inactive"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="form-group">
                <label for="tutorId">Tutor ID:</label>
                <asp:TextBox runat="server" ID="tutorId" CssClass="form-control" TextMode="Number"></asp:TextBox>
            </div>
            <asp:Button runat="server" ID="submitBtn" CssClass="btn btn-primary" Text="Submit" OnClick="submitBtn_Click" />
        </div>
    </form>

    <!-- Include Bootstrap JS and Popper.js -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
