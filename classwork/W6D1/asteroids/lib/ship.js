const Util = require("./util"); 
const Bullet = require("./bullet"); 
const MovingObject = require("./moving_object");

Util.inherits(Ship, MovingObject);

Ship.RADIUS = 14;
Ship.COLOR = 'mediumpurple';

function Ship(pos, game) {
  options = {
    pos: pos,
    game: game,
    vel: [0, 0],
    radius: this.constructor.RADIUS,
    color: this.constructor.COLOR,
  };
  
  // call the MovingObject superconstructor
  MovingObject.call(this, options);
}

Ship.prototype.relocate = function () {
  this.pos = this.game.randomPosition();
  this.vel = [0, 0];
};

Ship.prototype.power = function (impulse) {
  this.vel = [this.vel[0] + impulse[0], this.vel[1] + impulse[1]];
};

Ship.prototype.fireBullet = function () {
  bullet = new Bullet(this.game, this.game.ship.pos, this.game.ship.vel);
  this.game.add(bullet);
};

module.exports = Ship;