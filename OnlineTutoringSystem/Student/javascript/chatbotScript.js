const chatbotContainer = document.querySelector(".chatbotContainer");
const chatbox = document.querySelector(".chatbox");
const chatInput = document.querySelector(".chat-input textarea");
const sendChatBtn = document.querySelector(".chat-input span");

let userMessage = null; // Variable to store user's message
const inputInitHeight = chatInput.scrollHeight;

const createChatLi = (message, className) => {
    // Create a chat <li> element with the passed message and className
    const chatLi = document.createElement("li");
    chatLi.classList.add("chat", `${className}`);
    let chatContent = className === "outgoing" ? `<p></p>` : `<span><i class='bx bxs-game'></i></span><p></p>`;
    chatLi.innerHTML = chatContent;
    chatLi.querySelector("p").textContent = message;
    return chatLi; // return chat <li> element
}

const generateResponse = () => {
    const userMessageLowerCase = userMessage.toLowerCase();

    for (const pattern in predefinedResponses) {
        const patternLowerCase = pattern.toLowerCase();
        if (userMessageLowerCase.includes(patternLowerCase)) {
            handlePredefinedResponse(pattern);
            return;
        }
    }

    // If no predefined pattern matches, display a default response
    chatbox.appendChild(createChatLi("I'm not sure how to respond to that.", "incoming"));
    chatbox.scrollTo(0, chatbox.scrollHeight);
}

const handlePredefinedResponse = (pattern) => {
    const patternLowerCase = pattern.toLowerCase();

    if (patternLowerCase.endsWith(".aspx")) {
        const pageName = patternLowerCase.substring(0, patternLowerCase.indexOf(".aspx"));
        redirectToPage(pageName);
    } else {
        const response = predefinedResponses[pattern];
        chatbox.appendChild(createChatLi(response, "incoming"));
        chatbox.scrollTo(0, chatbox.scrollHeight);
    }
}


const redirectToPage = (pageName) => {
    const pageData = predefinedResponses[pageName];
    if (pageData) {
        const { message, buttonText } = pageData;
        chatbox.appendChild(createChatLi(message, "incoming"));
        chatbox.scrollTo(0, chatbox.scrollHeight);
    } else {
        chatbox.appendChild(createChatLi("I'm not sure which page you're referring to.", "incoming"));
        chatbox.scrollTo(0, chatbox.scrollHeight);
    }

    switch (pageName) {
        case "course":
            window.location.href = "course.aspx";
            break;
        case "tutor":
            window.location.href = "TutorList.aspx";
            break;
        case "account":
            window.location.href = "StudAccount.aspx";
            break;
        // Add more cases for other pages
        default:
            chatbox.appendChild(createChatLi("I'm not sure which page you're referring to.", "incoming"));
            chatbox.scrollTo(0, chatbox.scrollHeight);
            break;
    }
}


const handleChat = () => {
    userMessage = chatInput.value.trim(); // Get the user's entered message and remove extra whitespace
    if (!userMessage) return;

    // Clear the input textarea and set its height to default
    chatInput.value = "";
    chatInput.style.height = `${inputInitHeight}px`;

    // Append the user's message to the chatbox
    chatbox.appendChild(createChatLi(userMessage, "outgoing"));
    chatbox.scrollTo(0, chatbox.scrollHeight);

    // Display "Thinking..." message while waiting for the response
    const incomingChatLi = createChatLi("Thinking...", "incoming");
    chatbox.appendChild(incomingChatLi);
    chatbox.scrollTo(0, chatbox.scrollHeight);

    setTimeout(() => {
        generateResponse();
        chatbox.removeChild(incomingChatLi);
    }, 600);
}

chatInput.addEventListener("input", () => {
    chatInput.style.height = `${inputInitHeight}px`;
    chatInput.style.height = `${chatInput.scrollHeight}px`;
});

chatInput.addEventListener("keydown", (e) => {
    if (e.key === "Enter" && !e.shiftKey && window.innerWidth > 800) {
        e.preventDefault();
        handleChat();
    }
});

sendChatBtn.addEventListener("click", handleChat);