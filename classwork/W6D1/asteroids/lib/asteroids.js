const Game = require("./game");
const GameView = require("./game_view");

document.addEventListener("DOMContentLoaded", () => {
  const canvas = document.getElementById("canvas");
  const ctx = canvas.getContext('2d');
  const g = new GameView(new Game(), ctx);
  g.start();
});
