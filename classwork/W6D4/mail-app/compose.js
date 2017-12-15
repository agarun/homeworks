const MessageStore = require("./message_store");

const Compose = {
  render: () => {
    const div = document.createElement("div");
    div.className = "new-message";
    div.innerHTML = Compose.renderForm();

    div.addEventListener('change', event => {
      let target = event.target;
      MessageStore.updateDraftField(
        target.name, target.value
      );
    });

    div.addEventListener('submit', event => {
      event.preventDefault();
      MessageStore.sendDraft();
      location.hash = "inbox";
    });

    return div;
  },
  renderForm: (form) => {
    const currentDraft = MessageStore.getMessageDraft();
    let formString = `<p class ='new-message-header'>New Message</p> ` +
      `<form class='compose-form'> <input placeholder = 'Subject' name = 'subject' type='text' value ='${currentDraft.subject}'></input> ` +
      `<input placeholder = 'Recipient' name = 'to' type='text' value ='${currentDraft.to}'></input> ` +
      `<textarea name = 'body' rows=20 type='text'>${currentDraft.body}</textarea> ` +
      `<button class = 'btn btn-primary submit-message' type='submit'>Send</button> `;
    return formString;
  }
};

module.exports = Compose;
