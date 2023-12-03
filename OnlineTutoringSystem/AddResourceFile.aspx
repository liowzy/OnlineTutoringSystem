<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddResourceFile.aspx.cs" Inherits="OnlineTutoringSystem.AddResourceFile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.18.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="../Content/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">

    <!-- Lightbox2 CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/css/lightbox.min.css">

    <link rel="stylesheet" href="../Content/css/studentMaster.css" />
    <link rel="stylesheet" href="../Content/fontawesome-free-5.15.4-web/css/all.min.css">

    <style>

    </style>
</head>
<body>
   <form id="form1" runat="server">
        <div>
            <h2>Resource and File Attachment Input</h2>
            <hr />

            <!-- Resource Input Section -->
            <h3>Resource Information</h3>
            <div>
                <label for="txtResourceName">Resource Name:</label>
                <asp:TextBox ID="txtResourceName" runat="server" CssClass="form-control" />
            </div>
            <br />

            <!-- File Attachment Input Section -->
            <h3>File Attachment Information</h3>
            <div>
                <label for="txtFileName">File Name:</label>
                <asp:TextBox ID="txtFileName" runat="server" CssClass="form-control" />
            </div>
            <div>
                <label for="fileUpload">Select File:</label>
                <asp:FileUpload ID="fileUpload" runat="server" CssClass="form-control" />
            </div>
            <br />

            <!-- Course ID Input Section -->
            <h3>Course Information</h3>
            <div>
                <label for="txtCourseId">Course ID:</label>
                <asp:TextBox ID="txtCourseId" runat="server" CssClass="form-control" />
            </div>
            <br />

            <!-- Submit Button -->
            <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-primary" OnClick="Submit_Click" />
        </div>
    </form>
<!-- Include Bootstrap JS and Popper.js -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

</body>
</html>
