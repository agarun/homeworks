const Asteroid = require("./asteroid");
const Ship = require("./ship");
const Bullet = require("./bullet");

Game.DIM_X = 900;
Game.DIM_Y = 600;
Game.NUM_ASTEROIDS = 8;

function Game() {
  this.asteroids = [];
  this.bullets = [];

  for (var i = 0; i < this.constructor.NUM_ASTEROIDS; i++) {
    this.addAsteroids();
  }

  this.ship = new Ship(this.randomPosition(), this);
}

Game.prototype.addAsteroids = function () {
  this.asteroids.push(new Asteroid(this.randomPosition(), this));
};

Game.prototype.randomPosition = function () {
  const randomX = Math.floor(Math.random() * this.constructor.DIM_X);
  const randomY = Math.floor(Math.random() * this.constructor.DIM_Y);
  return [randomX, randomY];
};

Game.prototype.draw = function (ctx) {
  ctx.clearRect(0, 0, this.constructor.DIM_X, this.constructor.DIM_Y);
  this.allObjects().forEach ((movingObj) => { movingObj.draw(ctx);});
};

Game.prototype.moveObjects = function () {
  this.allObjects().forEach ((movingObj) => { movingObj.move();});
};

Game.prototype.wrap = function (pos) {
  let newPos = pos;

  if (pos[0] > this.constructor.DIM_X) {
    newPos[0] = 0;
  }
  if (pos[1] > this.constructor.DIM_Y) {
    newPos[1] = 0;
  }

  if (pos[0] < 0) {
    newPos[0] = this.constructor.DIM_X;
  }
  if (pos[1] < 0) {
    newPos[1] = this.constructor.DIM_Y;
  }

  return newPos;
};

Game.prototype.checkCollisions = function () {
  for (let i = 0; i < this.allObjects().length - 2; i++) {
    for (var j = i + 1; j < this.allObjects().length; j++) {
      if (i === j) continue;
      if (this.allObjects()[i].isCollidedWith(this.allObjects()[j])) {
        // alert("COLLISION");
      }
    }
  }
};

Game.prototype.step = function () {
  this.moveObjects();
  this.checkCollisions();
};

Game.prototype.allObjects = function () {
  return this.asteroids.concat([this.ship], this.bullets);
};

Game.prototype.add = function (obj) {
  if (obj instanceof Asteroid) {
    this.asteroids.push(obj);
  } else if (obj instanceof Bullet) {
    this.bullets.push(obj);
  }
};

Game.prototype.remove = function (obj) {
  if (obj instanceof Asteroid) {
    let indexOfAsteroid = this.asteroids.indexOf(asteroid);
    if (indexOfAsteroid !== -1) this.asteroids.splice(indexOfAsteroid, 1);
  } else if (obj instanceof Bullet) {
    let indexOfBullet = this.bullets.indexOf(bullet);
    if (indexOfBullet !== -1) this.bullets.splice(indexOfBullet, 1);
  }
};

module.exports = Game;
