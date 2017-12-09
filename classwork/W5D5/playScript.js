const Game = require("./towersOfHanoi.js");
const readline = require("readline");
const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

const newGame = new Game();
newGame.run(()=>{
  reader.close();
});

