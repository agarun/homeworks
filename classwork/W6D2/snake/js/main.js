const SnakeGame = require('./snake.js');
const SnakeView = require('./snake-view.js');

$(() => {
  const rootEl = $('.snake');
  const game = new SnakeGame();
  new SnakeView(game, rootEl);
});