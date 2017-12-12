/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// identity function for calling harmony imports with the correct context
/******/ 	__webpack_require__.i = function(value) { return value; };
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 6);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports) {

// ES6 method definition syntax
const Util = {
  inherits (childClass, parentClass) {
    function Surrogate () {}
    Surrogate.prototype = parentClass.prototype;
    childClass.prototype = new Surrogate();
    childClass.prototype.constructor = childClass;
  },
  // Return a randomly oriented vector with the given length.
  randomVec (length) {
    const deg = 2 * Math.PI * Math.random();
    return Util.scale([Math.sin(deg), Math.cos(deg)], length);
  },
  // Scale the length of a vector by the given amount.
  scale (vec, m) {
    return [vec[0] * m, vec[1] * m];
  }
};

module.exports = Util;

/***/ }),
/* 1 */
/***/ (function(module, exports, __webpack_require__) {

const Util = __webpack_require__(0); 

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

/***/ }),
/* 2 */
/***/ (function(module, exports, __webpack_require__) {

const Util = __webpack_require__(0); 
const Bullet = __webpack_require__(7); 
const MovingObject = __webpack_require__(1);

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

/***/ }),
/* 3 */
/***/ (function(module, exports, __webpack_require__) {

const Asteroid = __webpack_require__(5);
const Ship = __webpack_require__(2);
const Bullet = __webpack_require__(7);

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
  // this.checkCollisions();
};

// Game.prototype.remove = function (asteroid) {
//   let indexOfAsteroid = this.asteroids.indexOf(asteroid);
//   if (indexOfAsteroid !== -1) this.asteroids.splice(indexOfAsteroid, 1);
// };

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

/***/ }),
/* 4 */
/***/ (function(module, exports) {

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




/***/ }),
/* 5 */
/***/ (function(module, exports, __webpack_require__) {

const MovingObject = __webpack_require__(1);
const Util = __webpack_require__(0); 
const Ship = __webpack_require__(2); 

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

/***/ }),
/* 6 */
/***/ (function(module, exports, __webpack_require__) {

const Game = __webpack_require__(3);
const GameView = __webpack_require__(4);

const canvas = document.getElementById("canvas");
const ctx = canvas.getContext('2d');

window.GameView = GameView;
const g = new GameView(new Game(), ctx);
g.start();

/***/ }),
/* 7 */
/***/ (function(module, exports, __webpack_require__) {

const Util = __webpack_require__(0); 
const MovingObject = __webpack_require__(1);
const Asteroid = __webpack_require__(5);

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

/***/ })
/******/ ]);