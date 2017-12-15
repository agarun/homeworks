const MessageStore = require("./message_store");

const Inbox = {
  render: () => {
    const inboxMessages = MessageStore.getInboxMessages();
    
    const ul = document.createElement('ul');
    ul.className = "messages";
    
    inboxMessages.forEach((inboxMessage) => {
      const li = Inbox.renderMessage(inboxMessage);
      ul.appendChild(li);
    });
    
    return ul;
  },
  renderMessage: (message) => {
    const li = document.createElement('li');
    li.className = "message";
    li.innerHTML += `<span class='from'>${message.from}</span>`;
    li.innerHTML += `<span class='subject'>${message.subject}</span>`;
    li.innerHTML += `<span class='body'>${message.body}</span>`;
    return li;
  }
};

module.exports = Inbox;