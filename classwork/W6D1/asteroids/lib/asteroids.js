const Game = require("./game");
const GameView = require("./game_view");

const canvas = document.getElementById("canvas");
const ctx = canvas.getContext('2d');

window.GameView = GameView;
const g = new GameView(new Game(), ctx);
g.start();