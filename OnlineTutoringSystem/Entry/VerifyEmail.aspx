<%@ Page Title="" Language="C#" MasterPageFile="~/SignUp.Master" AutoEventWireup="true" CodeBehind="VerifyEmail.aspx.cs" Inherits="OnlineTutoringSystem.WebForm142" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Add Bootstrap stylesheet -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
        <div class="row">
            <div class="col-md-6 offset-md-3">
                <div class="card">
                    <div class="card-body">
                        <h2 class="text-center">Email Verification</h2> 
                            <div class="form-group row">
                                <label for="tbEmailShow" class="col-sm-3 col-form-label">Email</label>
                                <div class="col-sm-9">
                       <asp:TextBox CssClass="form-control" ID="tbEmailShow" runat="server" placeholder="Email" TextMode="Email" Enabled="False"></asp:TextBox>
                       </div>
                            </div>
                            <div class="form-group row verifyRow">
                                <label for="tbCode" class="col-sm-3 col-form-label">Verification Code</label>
                                <div class="col-sm-9">
                                    <asp:TextBox CssClass="form-control" ID="tbCode" runat="server" placeholder="Verification Code" TextMode="SingleLine"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="tbCode" ErrorMessage="Code is required" Display="Dynamic" ForeColor="Red">*</asp:RequiredFieldValidator>
                                    <asp:CompareValidator ID="CompareValidator2" runat="server" ErrorMessage="OTP must be a number" ControlToValidate="tbCode" Operator="DataTypeCheck" Type="Integer" Display="None">*</asp:CompareValidator>
                                </div>
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-12 text-center">
                                    <asp:Button CssClass="btn btn-primary" ID="btnSubmit" runat="server" Text="SUBMIT" OnClick="btnSubmit_Click" />
                                    <asp:Button CssClass="btn btn-secondary" ID="btnResend" runat="server" Text="RESEND" ValidationGroup="vGroup2" OnClick="btnResend_Click" />
                                    <asp:ValidationSummary ID="ValidationSummary2" runat="server" ForeColor="Red" HeaderText="The following problems have been encountered" ShowMessageBox="True" ShowSummary="False" />
                                </div>
                            </div> 
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
