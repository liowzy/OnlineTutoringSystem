<%@ Page Title="" Language="C#" MasterPageFile="~/Student/TutorDetailHeader.master" AutoEventWireup="true" CodeBehind="ViewTutorSchedule.aspx.cs" Inherits="OnlineTutoringSystem.Student.ViewTutor.WebForm51" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <title>Tutor Schedule</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.18.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="../Content/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">

    <!-- Lightbox2 CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/css/lightbox.min.css">

    <link rel="stylesheet" href="../Content/css/studentMaster.css" />
    <link rel="stylesheet" href="../Content/fontawesome-free-5.15.4-web/css/all.min.css">
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
        .even-row {
            background-color: #f9f9f9; /* Set your desired color for even rows */
            padding: 10px; /* Adjust padding as needed */
        }

        .odd-row {
            background-color: #ffffff; /* Set your desired color for odd rows */
            padding: 10px; /* Adjust padding as needed */
        }
    </style>
    
    <div class="container mt-2">
        <asp:Label ID="Label1" runat="server" CssClass="h2" Text="Tutor Schedule"></asp:Label>
        <hr />
        
            <asp:Label ID="Checkwl" runat="server" Text="No schedule" CssClass="h4 font-weight-bold text-muted" Visible="False"></asp:Label>
            
        <asp:DataList ID="DataList1" runat="server" CssClass="table" DataKeyField="schedule_id">
            <itemtemplate>
                <div class='<%# Container.ItemIndex % 2 == 0 ? "odd-row" : "even-row" %>'>

                    <div class="row justify-content-between">
                        <div class="col-8"> 
                            <asp:Label ID="LabelDate" runat="server" Text='<%# Eval("schedule_date", "{0:dd-MM-yyyy}") %>'></asp:Label>
                        </div>
                        <div class="col-4">
                            <asp:Label ID="LabelStartTime" runat="server" Text='<%# Eval("schedule_startTime") %>' CssClass="text-muted"></asp:Label>
                            -
                            <asp:Label ID="LabelEndTime" runat="server" Text='<%# Eval("schedule_endTime") %>' CssClass="text-muted"></asp:Label>
                        </div>
                    </div>
                    <div class="row pt-2">
                        <div class="col">
                            <asp:Label ID="LabelSubject" runat="server" CssClass="h4" Text='<%# Eval("schedule_subject") %>'></asp:Label>
                        </div>
                    </div>
                    <div class="row pt-2">
                        <div class="col">
                            <asp:Label ID="LabelDescription" runat="server" Text='<%# Eval("schedule_description") %>' CssClass="text-muted"></asp:Label>
                        </div>
                    </div>
                    <div class="row m-0 d-flex justify-content-end align-self-center">
                <div class="col text-right">
                    <asp:Button ID="ButtonMakeBooking" runat="server" Text="Make Booking" CssClass="btn btn-orange m-0" onClick="MakeBooking_Click"/>
                </div>
            </div>
                </div>
            </itemtemplate>
        </asp:DataList>

    </div>

    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>


</asp:Content>


