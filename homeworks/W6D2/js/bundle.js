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
/******/ 	__webpack_require__.p = "/js/";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

module.exports = __webpack_require__(1);


/***/ }),
/* 1 */
/***/ (function(module, exports, __webpack_require__) {

/* globals $ */

var View = __webpack_require__(2);

$(function () {
  var $easel = $("#easel");
  new View($easel);
});


/***/ }),
/* 2 */
/***/ (function(module, exports) {

/* jshint esversion: 6 */

function View($el) {
  this.$el = $el;
  this.setupEasel();
}

window._randomColorString = function () {
  return "#" + Math.random().toString(16).substr(-6);
};

View.prototype.exercise0 = function removeSquare() {
  // remove the "square" class from every li
  // this should cause the grid to turn into a long list of undecorated `li`s
  $("li").removeClass("square");
};

View.prototype.exercise1 = function allSquaresOrange() {
  // give every square the class "orange"
  // every square should turn orange (we already have a CSS rule)
  $(".square").addClass("orange");
};

// JS: const squares = document.querySelectorAll(".square");
// and for each square, square.parentElement.removeChild(square);
View.prototype.exercise2 = function () {
  $(".square").remove();
};

View.prototype.exercise3 = function () {
  // add an <h1> with the text "i love jquery" under the grid.
  const newH1 = $("<h1>i love jquery</h1>");
  $("#easel").after(newH1); // under the grid, outside #easel
  // $("#easel").append(newH1); // under the grid, inside #easel
};

View.prototype.exercise4 = function () {
  // write your first name in every other square.
  let i = 0;
  $(".square").append(() => {
    i += 1;
    return (i % 2 === 0) ? "" : "AA";
  });
};

View.prototype.exercise4v2 = function () {
  $(".square:nth-child(even)").text("AA");
};

View.prototype.exercise5 = function () {
  // alert the row and column of the square, when the square is clicked.
  // when a square is clicked, the row and column appear in an alert.
  // clicking the top left square should alert "0, 0".
  $("#easel").on("click", "li.square", (event) => {
    const square = $(event.currentTarget);
    const coords = square.data("pos");
    alert(coords);
  });
};

// callback runs once for each square
// alternatively solution is to invoke callback and use `jQuery#each`
View.prototype.exercise6 = function () {
  // give every square a random color!
  // every square becomes a color as soon as this code runs.
  $(".square").css("background-color", window._randomColorString);
};

View.prototype.exercise7 = function(){
  // when your mouse goes over a square, console log its color.
  $("#easel").on("mouseover", ".square", (event) => {
    const square = $(event.currentTarget);
    const color = square.css("background-color");
    console.log(color);
  });
};

View.prototype.setupEasel = function () {
  const $addRowButton = $("<button>").html("Add a row");
  this.$el.append($addRowButton);
  $addRowButton.on("click", this.addRow.bind(this));

  for(let j = 0; j <= 7; j++){
    const $button = $("<button>").html("Exercise " + j);
    $button.on("click", this["exercise" + j]);
    this.$el.append($button);
  }

  for(let i = 0; i < 20; i ++) {
    this.addRow();
  }
};

View.prototype.addRow = function() {
  const rowIdx = this.$el.find(".row").length;
  const $row = $("<ul>").addClass("row").addClass("group");
  for(let colIdx = 0; colIdx < 20; colIdx++) {
    const $square = $("<li>").addClass("square").attr("data-pos", [rowIdx, colIdx]);
    $square.on("mouseenter", (e) => {
      const $square = $(e.currentTarget);
      $square.css("background-color", window._randomColorString());
    });
    $row.append($square);
  }
  this.$el.append($row);
};

module.exports = View;


/***/ })
/******/ ]);
//# sourceMappingURL=bundle.js.map