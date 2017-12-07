// titleize, takes an array of names and a function (callback).
// use Array.prototype.map to create a new array full of
// titleized versions of each name in the format "Mx. <NAME> Jingleheimer Schmidt"
// pass this new array of names to the callback (use Array.prototype.forEach
// to print out each titleized name)

// callback is invoked with three arguments:
//   - the element value
//   - the element index
//   - the array being traversed
//   -> i.e. callback(value, index, array)
//   - Source: MDN
const printCallback = function printCallback(titledNames) {
  titledNames.forEach(name => console.log(name));
};

const titleize = function titleize(names, callback) {
  const titledNames = names.map(name => `Mx. ${name} Jingleheimer Schmidt`);
  callback(titledNames)
};

titleize(["Mary", "Brian", "Leo"], printCallback);
// Mx. Mary Jingleheimer Schmidt
// Mx. Brian Jingleheimer Schmidt
// Mx. Leo Jingleheimer Schmidt
// undefined

// write a constructor function for an elephant
// each elephant should have a name, height (in inches), and array of tricks
// in gerund form (e.g. "painting a picture" rather than "paint a picture")

function Elephant(name, height, tricks) {
  this.name = name;
  this.height = height;
  this.tricks = tricks;
}

// prototype functions that will be shared among all elephants

Elephant.prototype.trumpet = function trumpet() {
  return `${this.name} the elephant goes 'phrRRRRRRRRRRR!!!!!!!`;
};

Elephant.prototype.grow = function grow() {
  this.height += 12;
};

Elephant.prototype.addTrick = function addTrick(trick) {
  this.tricks.push(trick);
};

// random integer, exclusive of max, inclusive of min:
// Math.floor((Math.random() * (max - min)) + min);
Elephant.prototype.play = function play() {
  const randomIndex = Math.floor(Math.random() * this.tricks.length);
  return `${this.name} is ${this.tricks[randomIndex]}`;
};

const johnnyTheElephant = new Elephant('johnny', 120, ['spinning', 'breakdancing', 'flying']);
johnnyTheElephant.trumpet();
johnnyTheElephant.grow();
console.log(johnnyTheElephant.height); // 132

johnnyTheElephant.addTrick('mining');
console.log(johnnyTheElephant.tricks); // includes 'mining'

console.log(johnnyTheElephant.play());

const ellie = new Elephant("Ellie", 185, ["giving human friends a ride", "playing hide and seek"]);
const charlie = new Elephant("Charlie", 200, ["painting pictures", "spraying water for a slip and slide"]);
const kate = new Elephant("Kate", 234, ["writing letters", "stealing peanuts"]);
const micah = new Elephant("Micah", 143, ["trotting", "playing tic tac toe", "doing elephant ballet"]);

const herd = [ellie, charlie, kate, micah];

Elephant.paradeHelper = function paradeHelper(elephant) {
  console.log(`${elephant.name} is trotting by!`);
};

herd.forEach(Elephant.paradeHelper);

// make a function dinerBreakfast. we want it to return an anonymous closure,
// which we will be able to use to keep adding breakfast foods to our initial order.

// shared lexical environment when returning & saving `dinerBreakfast`
const dinerBreakfast = function dinerBreakfast() {
  let firstString = "I'd like cheesy scrambled eggs please";

  return function(string) {
    firstString = [firstString, string].join(' and ');
    return `${firstString} please.`;
  };
};

const bfastOrder = dinerBreakfast(); // "I'd like cheesy scrambled eggs please"
console.log(bfastOrder("chocolate chip pancakes")); // "I'd like cheesy scrambled eggs and chocolate chip pancakes please."
console.log(bfastOrder("grits")); // "I'd like cheesy scrambled eggs and chocolate chip pancakes and grits please."
