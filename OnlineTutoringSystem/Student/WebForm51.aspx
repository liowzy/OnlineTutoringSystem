<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm51.aspx.cs" Inherits="OnlineTutoringSystem.Student.WebForm51" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PDF Viewer</title>
     <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"/>

    <!-- Bootstrap Icons CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.18.0/font/bootstrap-icons.css" rel="stylesheet"/>
    <link href="../Content/bootstrap-icons/bootstrap-icons.css" rel="stylesheet"/>

    <!-- Lightbox2 CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/css/lightbox.min.css"/>

    <link rel="stylesheet" href="../Content/css/studentMaster.css" />
    <link rel="stylesheet" href="../Content/fontawesome-free-5.15.4-web/css/all.min.css"/>
    <style>
        
        body {
            margin: 0;
            padding: 0;
            overflow-x: hidden; 
        }
    </style>
</head>
<body> 
        <div class="row justify-content-center">
        <div class="col-8">
            <asp:Repeater ID="rptFiles" runat="server">
                <ItemTemplate>
                    <iframe runat="server" width="900" height="680" src='<%# "data:application/pdf;base64," + Container.DataItem %>'></iframe>
                </ItemTemplate>
            </asp:Repeater>
            </div>
        </div> 
</body>
</html>
