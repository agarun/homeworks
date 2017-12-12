const Util = require("./util"); 

function MovingObject(options) {
  this.pos = options.pos;
  this.vel = options.vel;
  this.radius = options.radius;
  this.color = options.color;
  this.game = options.game;
}

MovingObject.prototype.draw = function (ctx) {
  ctx.beginPath();
  ctx.arc(this.pos[0], this.pos[1], this.radius, 0, 2 * Math.PI);
  ctx.fillStyle = this.color;
  ctx.fill();
};

MovingObject.prototype.move = function () {
  this.game.wrap(this.pos);
  this.pos[0] += this.vel[0];
  this.pos[1] += this.vel[1];
};

MovingObject.prototype.isCollidedWith = function (otherObject) {
  // Two circles have collided if the distance between their center 
  // points is less than the sum of their radii.
  const x1 = this.pos[0];
  const y1 = this.pos[1];
  
  const x2 = otherObject.pos[0];
  const y2 = otherObject.pos[1];
  
  const distanceBetweenCenter = Math.sqrt(
    Math.pow((x1 - x2), 2) + Math.pow((y1 - y2), 2)
  );
  
  const sumOfRadii = this.radius + otherObject.radius;
  
  if (distanceBetweenCenter < sumOfRadii) {
    console.log(otherObject);
    this.collideWith(otherObject);
    return true;
  }
  
  return false;
};

MovingObject.prototype.collideWith = function (otherObject) {
  // duck typing
  // this.game.remove(otherObject);
  // this.game.remove(this);
};

module.exports = MovingObject;