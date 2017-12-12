function GameView (game, ctx) {
  this.game = game;
  this.ctx = ctx;
}

GameView.prototype.start = function () {
  setInterval( () => {
    this.game.step();
    this.bindKeyHandlers();
    this.game.draw(this.ctx);
  }, 20);
};

GameView.prototype.bindKeyHandlers = function () {
  key('w', () => this.game.ship.power([0, -0.01]));
  key('a', () => this.game.ship.power([-0.01, 0]));
  key('s', () => this.game.ship.power([0, 0.01]));
  key('d', () => this.game.ship.power([0.01, 0]));
  key('space', () => this.game.ship.fireBullet());
};

module.exports = GameView;


