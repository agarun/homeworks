/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

const Router = __webpack_require__(1);
const Inbox = __webpack_require__(2);
const Sent = __webpack_require__(4);
const Compose = __webpack_require__(5);

const routes = {
  inbox: Inbox,
  sent: Sent,
  compose: Compose
};

document.addEventListener("DOMContentLoaded", (event) => {
  const sidebarNavs = Array.from(document.querySelectorAll(".sidebar-nav li"));
  const windowJunk = function(event) {
    const li = event.currentTarget;
    const newLoc = li.innerText.toLowerCase();
    window.location.hash = newLoc;
  };
  sidebarNavs.forEach((li) => {
    li.addEventListener("click", windowJunk);
  });
  
  const newNode = document.querySelector(".content");
  const newRouter = new Router(newNode, routes);
  newRouter.start();
  
  window.location.hash = "inbox";
});


/***/ }),
/* 1 */
/***/ (function(module, exports) {

class Router {
  constructor(node, routes) {
    this.node = node;
    this.routes = routes;
  }
  
  start() {
    this.render();
    window.addEventListener("hashchange", this.render.bind(this));
  }
  
  activeRoute() {
    const currentHash = window.location.hash.slice(1);
    return this.routes[currentHash];
  }
  
  render() {
    const component = this.activeRoute();
    this.node.innerHTML = "";
    if (component) {
      const routeNameNode = document.createTextNode(component);
      const newNode = component.render();
      this.node.appendChild(newNode);
    }
  }
}

module.exports = Router;

/***/ }),
/* 2 */
/***/ (function(module, exports, __webpack_require__) {

const MessageStore = __webpack_require__(3);

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

/***/ }),
/* 3 */
/***/ (function(module, exports) {

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

/***/ }),
/* 4 */
/***/ (function(module, exports, __webpack_require__) {

const MessageStore = __webpack_require__(3);

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

/***/ }),
/* 5 */
/***/ (function(module, exports, __webpack_require__) {

const MessageStore = __webpack_require__(3);

const Compose = {
  render: () => {
    const div = document.createElement("div");
    div.className = "new-message";
    div.innerHTML = Compose.renderForm();
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

/***/ })
/******/ ]);