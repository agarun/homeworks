const Router = require("./router");
const Inbox = require("./inbox");
const Sent = require("./sent");
const Compose = require("./compose");

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
