<%@ Page Title="" Language="C#" MasterPageFile="~/Tutor/TutorSideBar.Master" AutoEventWireup="true" CodeBehind="UploadFile.aspx.cs" Inherits="OnlineTutoringSystem.Tutor.WebForm7" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Course File Details</title>
    <!-- Bootstrap CSS link -->

    <!-- Boostrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.18.0/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Include Lightbox2 CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/css/lightbox.min.css">
    <link href="~/Content/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">

    <!-- Add Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"
        integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="
        crossorigin="anonymous"
        referrerpolicy="no-referrer" />
    <!-- Bootstrap JS and Popper.js -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
        integrity="sha384-XqVuQ3TK1Zl9+mzgJz4NSeVoWTV2LJ1dvhE3HbXepXuUUuAKPfuIEjaaB6EGQhx"
        crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <main id="main" class="main">
        <div class="pagetitle">
            <h1>File Management</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="../Student/HomePage.aspx">Home</a></li>
                    <li class="breadcrumb-item active">File Management</li>
                </ol>
            </nav>
        </div>
        <!-- End Page Title -->

        <section class="section profile">
    <div class="row">
        <div class="col-xl-8">
            <h3 class="mb-4">File Management</h3>

            <div class="mb-3">
                <label for="txtResourceName" class="form-label">Resource Name:</label>
                <asp:TextBox runat="server" ID="txtResourceName" CssClass="form-control" placeholder="Enter Resource Name"></asp:TextBox>
            </div>
            <div class="mb-3">
                <label for="txtFileName" class="form-label">File Name:</label>
                <asp:TextBox runat="server" ID="txtFileName" CssClass="form-control" placeholder="Enter File Name"></asp:TextBox>
            </div>
            <div class="mb-3">
                <label for="fileUpload" class="form-label">Upload File:</label>
                <asp:FileUpload runat="server" ID="fileUpload" CssClass="form-control"/>
            </div>

            <!-- Button to Add Resource -->
            <div class="mb-3">
                <asp:Button ID="btnAddResource" runat="server" Text="Add Resource" OnClick="btnAddResource_Click" CssClass="btn btn-primary" />
            </div>

            <!-- GridView to Display Resources -->
            <div class="mt-4">
                <asp:GridView ID="GridViewResource" runat="server" AutoGenerateColumns="false" CssClass="table table-striped"
                    Width="100%" OnRowCommand="GridViewResource_RowCommand" EnableViewState="true" DataKeyNames="ResId">
                    <Columns>
                        <asp:TemplateField HeaderText="Resource Name">
    <ItemTemplate>
        <asp:Label ID="lblResourceName" runat="server" Text='<%# Bind("ResourceName") %>'></asp:Label>
    </ItemTemplate>
</asp:TemplateField>
                         <asp:TemplateField HeaderText="File Name">
            <ItemTemplate>
                <%# string.IsNullOrEmpty(Convert.ToString(Eval("FileName"))) ? "[no file]" : Convert.ToString(Eval("FileName")) %>
            </ItemTemplate>
        </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                    <asp:Button ID="btnDelete" runat="server" CommandName="DeleteFile" CommandArgument='<%# Container.DataItemIndex %>' CssClass="btn btn-danger" CausesValidation="false" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this file?');" />
                 <asp:Button ID="btnAddMore" runat="server" CommandName="AddMoreFile" CommandArgument='<%# Container.DataItemIndex %>' CssClass="btn btn-success" CausesValidation="false" Text="Add More File" OnClick="btnAddMore_Click" />
            </ItemTemplate>
            </asp:TemplateField></Columns>
                </asp:GridView>
            </div>

            <!-- Button to Submit (for testing) -->
            <div class="mt-4">
                <asp:Button ID="btnSubmit" runat="server" Text="Cancel" OnClick="btnSubmit_Click" CssClass="btn btn-primary" />
            </div>
        </div>
    </div>
</section>

    </main>
</asp:Content> 