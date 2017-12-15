let messages = {
  sent: [
    {to: "friend@mail.com", subject: "Check this out", body: "It's so cool"},
    {to: "person@mail.com", subject: "zZz", body: "so boring"},
    {to: "bad@mouth.com", subject: "TIM < LUKE", body: "Truth"}
  ],
  inbox: [
    {from: "grandma@mail.com", subject: "Fwd: Fwd: Fwd: Check this out", body: "Stay at home mom discovers cure for leg cramps. Doctors hate her"}, 
    {from: "person@mail.com", subject: "Questionnaire", body: "Take this free quiz win $1000 dollars"},
    {from: "chuck_e_cheese@mail.com", subject: "Last Saturday", body: "Did you remember to hide all of the body parts? That was a wild party, man"} 
  ] 
};

class Message {
  constructor(from, to, subject, body) {
    this.from = from;
    this.to = to;
    this.subject = subject;
    this.body = body;
  }
}

let messageDraft = new Message();

const MessageStore = {
  getInboxMessages: () => messages.inbox,
  getSentMessages: () => messages.sent,
  getMessageDraft: () => messageDraft,
  updateDraftField: (field, value) => {
    messageDraft[field] = value;
  },
  sendDraft: () => {
    messages.sent.push(messageDraft);
    messageDraft = new Message();
  }
};

module.exports = MessageStore;