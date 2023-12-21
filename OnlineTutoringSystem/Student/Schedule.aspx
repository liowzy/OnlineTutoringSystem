<%@ Page Title="" Language="C#" MasterPageFile="~/Header.Master" AutoEventWireup="true" CodeBehind="Schedule.aspx.cs" Inherits="OnlineTutoringSystem.WebForm11" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.18.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="../Content/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">

    <!-- Lightbox2 CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/css/lightbox.min.css">

    <link rel="stylesheet" href="../Content/css/studentMaster.css" />
    <link rel="stylesheet" href="../Content/fontawesome-free-5.15.4-web/css/all.min.css">

    <!-- Lightbox2 CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/css/lightbox.min.css">
      
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <style>
        .btn-orange {
            text-decoration: none;
            background-color: #FF6636; /* Orange background color */
            color: #fff;
            font-size: 1.1vw;
            border: none;
            margin-top: 9%;
            margin-right: 20%;
            padding: 1% 5% 1% 5%;
        }

            .btn-orange:hover {
                text-decoration: none;
                background-color: #FF8C00;
                color: #fff;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-fluid pb-0">
        <div class="container mt-5">
            <h2 class="text-center">Schedule Information</h2>
            <hr />
            <div class="row justify-content-center p-3" style="min-height: 60vh;"">
                        <asp:Label ID="Checkwl" runat="server" Text="Your schedule is empty" CssClass="h4 text-center font-weight-bold text-muted" Visible="False"></asp:Label>
                <asp:DataList ID="DataList1" runat="server" CssClass="schedule-lis mx-auto">
                    <ItemTemplate>
                        <div class="col-9 mb-4 mx-auto">
                            <div class="card h-100">
                                <div class="card-body">
                                    <h5 class="card-title"><%# Eval("schedule_subject") %></h5>
                                    <p class="card-text"><i class="bi bi-calendar"></i><%# Eval("schedule_date", "{0:yyyy-MM-dd}") %></p>
                                    <p class="card-text"><i class="bi bi-clock"></i><%# Eval("schedule_startTime" ) %> - <%# Eval("schedule_endTime" ) %></p>
                                    <p class="card-text"><i class="bi bi-info-circle"></i><%# Eval("schedule_description") %></p>
                                    <p class="card-text">
                                            <i class="bi bi-link-45deg"></i>
                                            <a href='<%# Eval("google_meet") %>' target="_blank">
                                                <%# Eval("google_meet") %>
                                            </a>
                                        </p>
                                    <asp:Button ID="btnOpen" runat="server" Text="View File" OnClick="btnOpen_Click" CssClass="btn btn-primary btn-sm" CommandArgument='<%# Eval("file_id") %>' />

                                </div> 
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:DataList>
            </div>

        </div>

    </div>
</asp:Content>
