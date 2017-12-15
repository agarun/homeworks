const MessageStore = require("./message_store");

const Sent = {
  render: () => {
    const sentMessages = MessageStore.getSentMessages();
    
    const ul = document.createElement('ul');
    ul.className = "messages";
    
    sentMessages.forEach((sentMessage) => {
      const li = Sent.renderMessage(sentMessage);
      ul.appendChild(li);
    });
    
    return ul;
  },
  renderMessage: (message) => {
    const li = document.createElement('li');
    li.className = "message";
    li.innerHTML += `<span class='to'>${message.to}</span>`;
    li.innerHTML += `<span class='subject'>${message.subject}</span>`;
    li.innerHTML += `<span class='body'>${message.body}</span>`;
    return li;
  }
};

module.exports = Sent;