Function.prototype.inherits = function (parentClass) {
  function Surrogate () {}
  Surrogate.prototype = parentClass.prototype;
  this.prototype = new Surrogate();
  this.prototype.constructor = this;
};

// Function.prototype.inherits = function (parentClass) {
//   this.prototype = Object.create(parentClass);
//   this.prototype.constructor = this;
// };

function Dog(name) {
  this.name = name;
}

function Animal(name, dogtag) {
  this.name = name;
  this.dogtag = dogtag;
}

// if this isn't here, we will lose all dog.prototype methods if they existed before
Dog.inherits(Animal);

Dog.prototype.bark = function () {
  console.log("bark");
};

Animal.prototype.attack = function () {
  console.log("attack");
};

dog = new Dog("jerry");
chicken = new Animal("bwuk");

function Cat(name) {
  this.name = name;
}

Cat.inherits(Animal);
cat = new Cat("newcat");

Animal.prototype.newThing = function () {
  console.log("everyone has this");
};

Cat.prototype.onlyCat = function () {
  console.log("only for the cat");
};
