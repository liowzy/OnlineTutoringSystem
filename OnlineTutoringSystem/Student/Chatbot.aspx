<%@ Page Title="" Language="C#" MasterPageFile="~/Header.Master" AutoEventWireup="true" CodeBehind="Chatbot.aspx.cs" Inherits="OnlineTutoringSystem.WebForm9" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <style>
        header {
            background-color: transparent;
        }

            header a {
                color: black;
            }

            header i {
                color: black;
            }

        .navigation-items ul li a {
            color: black;
        }

        .searchBtn i {
            color: black;
        }

        .chatbotBtn{
            display: none;
        }
    </style>

    <div class="chatbotContainer">                
        <div class="chatbot">
            <div class="header">
                <h2>Chatbot</h2>
            </div>
            <ul class="chatbox">
                <li class="chat incoming">
                    <span><i class='bx bxs-game'></i></span>
                    <p>Hi there 👋<br />How can I help you today?</p>
                </li>
            </ul>
            <div class="chat-input">
                <textarea placeholder="Enter a message..." spellcheck="false" required></textarea>
                <span><i class='bx bxs-send'></i></span>
            </div>
        </div>
    </div>
</asp:Content>
