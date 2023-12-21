<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Chatbot.aspx.cs" Inherits="OnlineTutoringSystem.Student.Chatbot2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Chatbot</title>
    <%--chatbot--%>
    <link rel="stylesheet" href="../Content/Style.css"/>

    <link href="https://fonts.googleapis.com/css2?family=Amiko&display=swap" rel="stylesheet"/>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'/>
    <script src="javascript/normal_script.js" defer></script>
    <script src="javascript/chatbotScript.js" defer></script>
    <script src="javascript/answer.js" defer></script>
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
</head>
<body>
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
</body>
</html>
