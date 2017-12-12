const Util = require("./util");
const MovingObject = require("./moving_object");
const Asteroid = require("./asteroid");

Util.inherits(Bullet, MovingObject);

Bullet.RADIUS = 4;
Bullet.COLOR = 'seagreen';

function Bullet(game, pos, vel) {
  options = {
    pos: pos,
    game: game,
    vel: [vel[0] + 0.01, vel[1] + 0.01],
    radius: this.constructor.RADIUS,
    color: this.constructor.COLOR,
  };

  MovingObject.call(this, options);
}

Bullet.prototype.collideWith = function (otherObject) {
  console.log(otherObject);
  if (otherObject instanceof Asteroid) {
    this.game.remove(otherObject);
  }
};

module.exports = Bullet;
