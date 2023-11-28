<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TempAddData.aspx.cs" Inherits="OnlineTutoringSystem.TempAddData" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add Course</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYvYHjFkt6i8fyMWf+3rEJs6O2TFxKPEvLxkY0i3lrZ8gqlDgsDGuBWo7O8r" crossorigin="anonymous">
    <style>
        .error-message {
            color: red;
        }
    </style>
</head>
<body>
   <div class="container mt-5">
       <asp:Label ID="lblMessage" runat="server" CssClass="error-message" Visible="false"></asp:Label>

        <h2>Add New Course</h2>
        <form id="form1" runat="server">
            <div class="mb-3">
                <label for="txtCourseName" class="form-label">Course Name:</label>
                <input type="text" class="form-control" id="txtCourseName" runat="server" />
            </div>

            <div class="mb-3">
                <label for="ddlCourseCategory" class="form-label">Course Category:</label>
                <asp:DropDownList ID="ddlCourseCategory" runat="server" CssClass="form-control" DataTextField="cat_name" DataValueField="cat_id" AutoPostBack="true"></asp:DropDownList>
            </div>

            <div class="mb-3">
                <label for="txtCatID" class="form-label">Category ID:</label>
                <input type="text" class="form-control" id="txtCatID" runat="server"/>
            </div>

            <div class="mb-3">
                <label for="txtCourseDesc" class="form-label">Course Description:</label>
                <textarea class="form-control" id="txtCourseDesc" runat="server" rows="3"></textarea>
            </div>

            <div class="mb-3">
                <label for="txtCourseLevel" class="form-label">Course Level:</label>
                <input type="text" class="form-control" id="txtCourseLevel" runat="server" />
            </div>

            <div class="mb-3">
                <label for="txtCourseFee" class="form-label">Course Fee:</label>
                <input type="text" class="form-control" id="txtCourseFee" runat="server" />
            </div>

            <div class="mb-3">
                <label for="txtCourseStatus" class="form-label">Course Status:</label>
                <input type="text" class="form-control" id="txtCourseStatus" runat="server" />
            </div>

            <div class="mb-3">
                <label for="txtCourseDuration" class="form-label">Course Duration:</label>
                <input type="text" class="form-control" id="txtCourseDuration" runat="server" />
            </div>

            <div class="mb-3">
                <label for="txtCourseLanguage" class="form-label">Course Language:</label>
                <input type="text" class="form-control" id="txtCourseLanguage" runat="server" />
            </div>

            <div class="mb-3">
                <label for="txtCourseTopic" class="form-label">Course Topic:</label>
                <input type="text" class="form-control" id="txtCourseTopic" runat="server" />
            </div>

            <div class="mb-3">
                <label for="txtCourseOverview" class="form-label">Course Overview:</label>
                <textarea class="form-control" id="txtCourseOverview" runat="server" rows="3"></textarea>
            </div>

            <div class="mb-3">
                <label for="txtCourseTargetAudience" class="form-label">Course Target Audience:</label>
                <input type="text" class="form-control" id="txtCourseTargetAudience" runat="server" />
            </div>

            <div class="mb-3">
                <label for="txtCourseRequirement" class="form-label">Course Requirement:</label>
                <input type="text" class="form-control" id="txtCourseRequirement" runat="server" />
            </div>

            <div class="mb-3">
                <label for="txtTutorID" class="form-label">Tutor ID:</label>
                <input type="text" class="form-control" id="txtTutorID" runat="server" />
            </div>

            <div class="mb-3">
    <label for="fileCoursePic" class="form-label">Course Picture:</label>
    <asp:FileUpload ID="fileCoursePic" runat="server" CssClass="form-control" />
</div>

<div class="mb-3">
    <label for="fileCourseVideo" class="form-label">Course Video:</label>
    <asp:FileUpload ID="fileCourseVideo" runat="server" CssClass="form-control" />
</div>


            <div class="mb-3">
                <button type="submit" class="btn btn-primary" runat="server" onserverclick="btnSubmit_Click">Submit</button>
            </div>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Ogvr5KZl5CInd7dVizxG7ZfQ6IRVeN4txAOrUKp9hJFQ4JZ5mi0glINDNCe6c/Ib" crossorigin="anonymous"></script>
</body>
</html>
