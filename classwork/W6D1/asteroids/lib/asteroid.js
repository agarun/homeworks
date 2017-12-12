const MovingObject = require("./moving_object");
const Util = require("./util"); 
const Ship = require("./ship"); 

Util.inherits(Asteroid, MovingObject);
Asteroid.COLOR = 'maroon';
Asteroid.RADIUS = 30;

function Asteroid(pos, game) {
  options = {
    pos: pos,
    vel: Util.randomVec(5),
    radius: this.constructor.RADIUS,
    color: this.constructor.COLOR,
    game: game
  };
  
  // call the MovingObject superconstructor
  MovingObject.call(this, options);
}

Asteroid.prototype.collideWith = function (otherObject) {
  if (otherObject instanceof Ship) {
    otherObject.relocate();
  }
};

module.exports = Asteroid;