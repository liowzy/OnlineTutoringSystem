<%@ Page Language="C#"  AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="OnlineTutoringSystem.Entry.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

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
        .table{
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
        .btnLogin{
            font-family: 'Lucida Sans';
            font-weight: 500;
            border: none;
            padding: 20px 40px;
            width: 280px;
            background-color: black;
            color: white;
            margin-top: 50px;
        }
        .btnLogin:hover{
            cursor: pointer;
        }
    </style>

    <div class="pageTitle">
        <asp:Label ID="Label1" runat="server" Text="Login Your Account"></asp:Label>
    </div>
    
    <form id="form1" runat="server">
        <table class="table">
            <tr>
               <td class="formTitle" colspan="2">
                   <asp:Label ID="formTitle" runat="server" Text="Your Email"></asp:Label>
               </td>
           </tr>
            <tr>
                <td>
                   <asp:Label ID="lblEmail" runat="server" Text="Email"></asp:Label>                   
                   <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="tbEmail" ErrorMessage="Email is required" Display="Static" ForeColor="Red">*</asp:RequiredFieldValidator>      
               </td>
                <td>
                   <asp:TextBox CssClass="textBox" ID="tbEmail" runat="server" placeholder="Email" TextMode="Email"></asp:TextBox>
               </td>
            </tr>
            <tr>
                <td>
                   <asp:Label ID="lblPsw" runat="server" Text="Password"></asp:Label>
                   <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="tbPsw" ErrorMessage="Password is required" Display="Static" ForeColor="Red">*</asp:RequiredFieldValidator>
               </td>
                <td>
                   <asp:TextBox CssClass="textBox" ID="tbPsw" runat="server" placeholder="Password" TextMode="Password"></asp:TextBox>                   
               </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center;">
                    <asp:Button CssClass="btnLogin" ID="btnLogin" runat="server" Text="LOGIN" />
                </td>
            </tr>
        </table>
    </form>
</asp:Content>
