<%@ Page Language="C#"  AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="OnlineTutoringSystem.Entry.Registration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <style>
        form{
            font-family: 'Lucida Sans';
            margin: 2% 10% 100px 10%;
            border: 1px solid #C4C4C4;
        }
        .pageTitle{
            width: 100%;
            text-align: center;
            margin-top: 5%;
            font-weight: bold;
            font-size: 2.5vw;
        }
        .table1, .table2{
            width: 85%;
            margin: 5% auto 5% auto;
            font-family: 'Lucida Sans';
            font-size: 1.2vw;
            border-collapse: separate;
            border-spacing: 100px 0px;
        }
        td{
            vertical-align: top;
        }
        .textBox{
            width: 100%;
            height: 35px;
            font-family: 'Lucida Sans';
            font-size: 1.2vw;
            margin-bottom: 15px;
        }
        .formTitle{
            font-size: 1.5vw;
            font-weight: 500;
            padding-bottom: 40px;
        }
        .btn{
            width: 100%;
            text-align: center;
            padding-bottom: 50px;
        }
        .btnCreate, .btnBack, .btnSubmit, .btnSend{
            font-family: 'Lucida Sans';
            font-weight: 500;
            border: none;
            padding: 20px 40px;
            margin-right: 20px;
            width: 280px;
        }
        .btnCreate, .btnSubmit, .btnSend{
            background-color: black;
            color: white;
        }
        .btnBack{
            background-color: transparent;
            color: #828282;
        }
        .btnCreate:hover, .btnBack:hover, .btnSubmit:hover, .btnSend:hover{
            cursor: pointer;
        }
        .btnSubmit{
            display: none;
        }
        .verifyRow{
            visibility: hidden;
        }
        .table1{
            display: none;
        }
    </style>

    <div class="pageTitle">
        <asp:Label ID="Label1" runat="server" Text="Create Your Account"></asp:Label>
    </div>

    <form runat="server">
        <table class="table1" id="table1" runat="server">
            <tr>
               <td class="formTitle" colspan="2">
                   <asp:Label ID="Label2" runat="server" Text="Email Verification"></asp:Label>
               </td>
           </tr>
            <tr>
               <td style="width: 25%;">
                   <asp:Label ID="lblEmail" runat="server" Text="Email"></asp:Label>                   
                   <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="tbEmail" ErrorMessage="Email is required" Display="None" ForeColor="Red">*</asp:RequiredFieldValidator>      
               </td>
               <td style="width: 75%;">
                   <asp:TextBox CssClass="textBox" ID="tbEmail" runat="server" placeholder="Email" TextMode="Email"></asp:TextBox>
               </td>
           </tr>

            <tr class="verifyRow" id="verifyRow" runat="server">
                <td style="width: 25%;">
                   <asp:Label ID="Label3" runat="server" Text="Verification Code"></asp:Label>                   
                   <!-- <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="tbCode" ErrorMessage="Code is required" Display="Dynamic" ForeColor="Red">*</asp:RequiredFieldValidator>      -->
               </td>
               <td style="width: 75%;">
                   <asp:TextBox CssClass="textBox" ID="tbCode" runat="server" placeholder="Verification Code" TextMode="SingleLine"></asp:TextBox>
               </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Button CssClass="btnSend" ID="btnSend" runat="server" Text="SEND VERIFICATION CODE" OnClick="btnSend_Click" />
                    <asp:Button CssClass="btnSubmit" ID="btnSubmit" runat="server" Text="SUBMIT" OnClick="btnSubmit_Click" />
                    <asp:Label ID="lblErrorMsg" runat="server" Text=""></asp:Label>
                </td>
            </tr>
        </table>
    
       <table class="table2" id="table2" runat="server">
           <tr>
               <td class="formTitle" colspan="2">
                   &nbsp;</td>
           </tr>
           <tr>
               <td style="width: 25%;">
                   <asp:Label ID="lblFfName" runat="server" Text="First name"></asp:Label>
                   <!-- <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbFName" ErrorMessage="First name is required" Display="Static" ForeColor="Red">*</asp:RequiredFieldValidator> -->
               </td>
               <td style="width: 75%;">
                   <asp:TextBox CssClass="textBox" ID="tbFName" runat="server" placeholder="First Name"></asp:TextBox>
               </td>
           </tr>
           <tr>
               <td>
                   <asp:Label ID="lblLName" runat="server" Text="Last name"></asp:Label>                   
                    <!-- <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="tbLName" ErrorMessage="Last name is required" Display="Static" ForeColor="Red">*</asp:RequiredFieldValidator>-->
               </td>
               <td>
                   <asp:TextBox CssClass="textBox" ID="tbLName" runat="server" placeholder="Last Name"></asp:TextBox>
               </td>
           </tr>
           <tr>
               <td>
                   <asp:Label ID="lblPsw" runat="server" Text="Password"></asp:Label>
                    <!-- <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="tbPsw" ErrorMessage="Password is required" Display="Static" ForeColor="Red">*</asp:RequiredFieldValidator>-->
               </td>
               <td>
                   <asp:TextBox CssClass="textBox" ID="tbPsw" runat="server" placeholder="Password" TextMode="Password"></asp:TextBox>                   
                    <!-- <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="tbPsw" ErrorMessage="Password should have at least 8 characters" Display="Dynamic" ValidationExpression=".{8}" ForeColor="Red"></asp:RegularExpressionValidator>-->
               </td>
           </tr>
           <tr>
               <td>
                   <asp:Label ID="lblCPsw" runat="server" Text="Confirm Password"></asp:Label>
                   <!-- <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="tbCPsw" ErrorMessage="Confirm password is required" Display="Static" ForeColor="Red">*</asp:RequiredFieldValidator>
                   <asp:CompareValidator runat="server" ControlToCompare="tbPsw" ControlToValidate="tbCPsw" ErrorMessage="Passwords do not match." ForeColor="Red" Display="Dynamic">
                       *</asp:CompareValidator>-->
               </td>
               <td>
                   <asp:TextBox CssClass="textBox" ID="tbCPsw" runat="server" placeholder="Confirm Password" TextMode="Password"></asp:TextBox>
                   
               </td>
           </tr>
           
           <tr>
               <td>
                   <asp:Label ID="lblGender" runat="server" Text="Gender"></asp:Label>                    
                   <!-- <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="rblGender" ErrorMessage="Gender is required" Display="Static" ForeColor="Red">*</asp:RequiredFieldValidator>-->
               </td>
               <td>
                   <div class="textBox">
                       <asp:RadioButtonList ID="rblGender" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                            <asp:ListItem>Male</asp:ListItem>
                            <asp:ListItem>Female</asp:ListItem>
                        </asp:RadioButtonList>
                   </div>
               </td>
           </tr>
           <tr>
               <td>
                   <asp:Label ID="lblPhone" runat="server" Text="Phone Number"></asp:Label>
                   <!-- <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="tbPhone" ErrorMessage="Phone Number is required" Display="Static" ForeColor="Red">*</asp:RequiredFieldValidator>-->
               </td>
               <td>
                   <asp:TextBox CssClass="textBox" ID="tbPhone" runat="server" TextMode="Phone" ></asp:TextBox>
               </td>
           </tr>
           </table>

       <div class="btn" id="btn" runat="server">
           <asp:Button CssClass="btnCreate" ID="btnCreate" runat="server" Text="CREATE AN ACCOUNT" OnClick="btnCreate_Click" />
           <asp:Button CssClass="btnBack" ID="btnBack" runat="server" Text="BACK" />
       </div>

       <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" HeaderText="The following problems have been encountered" ShowMessageBox="True" ShowSummary="False" />
   </form>

</asp:Content> 
