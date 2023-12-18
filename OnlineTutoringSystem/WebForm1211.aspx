<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1211.aspx.cs" Inherits="OnlineTutoringSystem.WebForm1211" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <!-- Bootstrap CSS -->
    <link href="../Content/boostrap-5.3.2-dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap JS (Popper.js and Bootstrap JS) -->
    <script src="../Content/boostrap-5.3.2-dist/js/bootstrap.bundle.min.js"></script>

    <!-- Bootstrap Icons CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.18.0/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Include Lightbox2 CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/css/lightbox.min.css">

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"
        integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="
        crossorigin="anonymous"
        referrerpolicy="no-referrer" />

    <!-- Bootstrap 4 CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-XqVuQ3TK1Zl9+mzgJz4NSeVoWTV2LJ1dvhE3HbXepXuUUuAKPfuIEjaaB6EGQhx" crossorigin="anonymous"></script>

    <!-- Bootstrap 5 JS (Popper.js is required for dropdowns, tooltips, and popovers) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Bootstrap JavaScript and Popper.js -->
    <%-- <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>--%>

    <title></title>
</head>
<body>
    <form id="form1" runat="server">

        <div>
            <h3>Resource Test Page</h3>

            <!-- Input Fields for Adding Resources -->
            <div>
                <label for="txtResourceName">Resource Name:</label>
                <asp:TextBox runat="server" ID="txtResourceName" CssClass="form-control" placeholder="Enter Resource Name" required="true"></asp:TextBox>
            </div>
            <div>
                <label for="txtFileName">File Name:</label>
                <asp:TextBox runat="server" ID="txtFileName" CssClass="form-control" placeholder="Enter File Name" required="true"></asp:TextBox>
            </div>
            <div>
                <label for="fileUpload">Upload File:</label>
                <asp:FileUpload runat="server" ID="fileUpload" CssClass="form-control" Required="true" />
            </div>

            <!-- Button to Add Resource -->
            <div>
                <asp:Button ID="btnAddResource" runat="server" Text="Add Resource" OnClick="btnAddResource_Click" CssClass="btn btn-primary" />
            </div>

            <!-- GridView to Display Resources -->
            <div class="mt-4">
                <asp:GridView ID="GridViewResource" runat="server" AutoGenerateColumns="false" Width="70%">
                    <Columns>
                        <asp:BoundField DataField="ResourceName" HeaderText="Resource Name" SortExpression="ResourceName" />
                        <asp:BoundField DataField="FileName" HeaderText="File Name" SortExpression="FileName" />
                    </Columns>
                </asp:GridView>
            </div>

            <!-- Button to Submit (for testing) -->
            <div class="mt-4">
                <asp:Button ID="btnSubmit" runat="server" Text="Save" OnClick="btnSubmit_Click" CssClass="btn btn-primary" />
            </div>
        </div>
    </form>
</body>
</html>
