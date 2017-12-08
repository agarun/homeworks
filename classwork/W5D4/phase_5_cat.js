function Cat(name, owner) {
  this.name = name;
  this.owner = owner;
}

Cat.prototype.cuteStatement = function() {
  return `${this.owner} loves ${this.name}`;
};

kitty = new Cat('kitty', 'aaron');
jonas = new Cat('jonas', 'aaron');
timmy = new Cat('timmy', 'aaron');

// console.log(kitty.cuteStatement());
// console.log(jonas.cuteStatement());
// console.log(timmy.cuteStatement());

// Reassign the Cat.prototype.cuteStatement method with a function that returns "Everyone loves [name]!"
// Invoke the cuteStatement method on your old cats; the new method should be invoked
Cat.prototype.cuteStatement = function() {
  return `Everyone loves ${this.name}`;
};

// console.log(kitty.cuteStatement());
// console.log(jonas.cuteStatement());
// console.log(timmy.cuteStatement());

Cat.prototype.meow = function() {
  return 'meow';
};

// console.log(kitty.meow());
// console.log(jonas.meow());
// console.log(timmy.meow());

// overrides the prototype and is only on this kitty 'instance'
// 'instances' are really just objects that are able to behave 
// like a class by maintaining a reference to their prototype
kitty.meow = function() {
  return 'completely different meow';
};

// console.log(kitty.meow());
// console.log(jonas.meow());