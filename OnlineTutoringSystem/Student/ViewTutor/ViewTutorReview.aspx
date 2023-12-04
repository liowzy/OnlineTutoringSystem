<%@ Page Title="" Language="C#" MasterPageFile="~/Student/TutorDetailHeader.master" AutoEventWireup="true" CodeBehind="ViewTutorReview.aspx.cs" Inherits="OnlineTutoringSystem.Student.ViewTutor.WebForm4" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.18.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="../Content/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">

    <!-- Lightbox2 CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/lightbox2/2.11.3/css/lightbox.min.css">

    <link rel="stylesheet" href="../Content/css/studentMaster.css" />
    <link rel="stylesheet" href="../Content/fontawesome-free-5.15.4-web/css/all.min.css">
    <style>
        body {
            margin: 0;
            padding: 0;
            overflow-x: hidden;
            font-family: 'Lucida Sans'
        }

        .bg-image {
            background-size: cover;
            background-position: center center;
            background-repeat: no-repeat;
        }

        .bigger-row {
            height: 400px;
        }

        /*.card {
            height: 17rem;   
        }*/

        .card .card-img-top {
            height: 17rem;
            width: 100%;
            object-fit: cover;
        }

        .container {
            margin: 0;
        }

        .orangetxt {
            color: orangered;
        }

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

        .even-bg {
            background-color: #fff;
        }

        .odd-bg {
            background-color: #f8f9fa;
        }
    </style>

   <div class="container">
       <asp:Label ID="Label1" runat="server" CssClass="h2" Text="Student Feedback"></asp:Label> 
        <hr />
        <asp:SqlDataSource ID="SqlDataSourceReviews" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            SelectCommand="SELECT R.review_comment, R.review_rating, R.review_date, S.stud_name, S.stud_picture FROM Review R INNER JOIN Student S ON R.student_id = S.stud_id WHERE R.tutor_id = @TutorId">
            <SelectParameters>
                <asp:SessionParameter Name="TutorId" SessionField="TutorId" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:Repeater ID="RepeaterReviews" runat="server" DataSourceID="SqlDataSourceReviews">
            <ItemTemplate>
                <div class="p-3 border shadow mb-2 <%# (Container.ItemIndex % 2 == 0) ? "even-bg" : "odd-bg" %>">
                    <div class="row">
                        <div class="col-md-3">
                            <!-- Show the student image in a round container --> 
                                <asp:Image ID="StudentImage" runat="server" CssClass="rounded-circle" AlternateText="Stud Image"
                                    Style="width: 15vh; height: 15vh; object-fit: cover;"
                                    ImageUrl='<%# "data:image/jpeg;base64," + Convert.ToBase64String((byte[])Eval("stud_picture")) %>' />
                             
                        </div>
                        <div class="col-md-9"> 
                            <div class="row p-2">
                                <div class="col-md-6 ">
                                    <span class="value">
                                        <asp:Label runat="server" Text='<%# Eval("stud_name") %>' /></span>
                                </div>
                                <div class="col-md-6 ">
                                    <span class="value">
                                        <asp:Label runat="server" CssClass="text-muted" Text='<%# Eval("review_date", "{0:MM/dd/yyyy}") %>' /></span>
                                </div>
                            </div>
                            <!-- Show review rating in a new row -->
                            <div class="row p-2">
                                <div class="col-md-12 ">
                                    <label class="label">Rating:</label>
                                    <span class="value">
                                        <asp:Label runat="server" Text='<%# Eval("review_rating") + " / 5" %>' /></span>
                                </div>
                            </div>
                            <!-- Show comment in a new row -->
                            <div class="row p-2">
                                <div class="col-md-12"> 
                                    <span class="value">
                                        <asp:Label runat="server" CssClass="text-muted" Text='<%# Eval("review_comment") %>' />
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>
