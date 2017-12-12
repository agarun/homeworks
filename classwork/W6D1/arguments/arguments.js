// function sum() {
//   let sum = 0;
//   for (var i = 0; i < arguments.length; i++) {
//     sum += arguments[i];
//   }
//   return sum;
//
// }

// function sum(...numbers) {
//   return numbers.reduce( (el, acc) => {
//      return el + acc;
//    }, 0);
// }

// console.log(sum(1,2,3));

// with rest operator
// Function.prototype.myBind = function (context, ...bindArgs) {
//   return (...callArgs) => {
//     const allArgs = bindArgs.concat(callArgs);
//     return this.apply(context, allArgs);
//   };
// };

// with arguments object:
// arrow functions do not have their own arguments object
Function.prototype.myBind = function () {
  const bindArgs = [].slice.call(arguments);
  const that = this;
  return function() {
    const callArgs = [].slice.call(arguments);
    const allArgs = bindArgs.concat(callArgs);
    // apply's first arg is context, apply args is optional
    return that.apply(allArgs[0], allArgs.slice(1));
  };
};
// could also use Array.from and slice to create args arrays from
// the array-like arguments
// i.e. const bindArgs = Array.from(arguments).slice(1);

class Cat {
  constructor(name) {
    this.name = name;
  }

  says(sound, person) {
    console.log(`${this.name} says ${sound} to ${person}!`);
    return true;
  }
}

const markov = new Cat("Markov");
const breakfast = new Cat("Breakfast");

// markov.says("meow", "Ned");
// Markov says meow to Ned!
// true

// bind time args are "meow" and "Kush", no call time args
markov.says.myBind(breakfast, "meow", "Kush")();
// Breakfast says meow to Kush!
// true

// no bind time args (other than context), call time args are "meow" and "me"
markov.says.myBind(breakfast)("meow", "a tree");
// Breakfast says meow to a tree!
// true

// bind time arg is "meow", call time arg is "Markov"
// markov.says.myBind(breakfast, "meow")("Markov");
// Breakfast says meow to Markov!
// true

// no bind time args (other than context), call time args are "meow" and "me"
// const notMarkovSays = markov.says.myBind(breakfast);
// notMarkovSays("meow", "me");
// Breakfast says meow to me!
// true

const curriedSum = function (numArgs) {
  let numbers = [];

  return function _curriedSum(newNum) {
    numbers.push(newNum);

    if (numbers.length === numArgs) {
      return numbers.reduce((el, acc) => el + acc, 0);
    } else {
      return _curriedSum;
    }
  };
};

// const sum = curriedSum(4);
// console.log(sum(5)(30)(20)(1)); // => 56

Function.prototype.curry = function (numArgs) {
  let args = [];
  const originalFunction = this;

  return function _curry(newArg) {
    args.push(newArg);

    if (args.length === numArgs) {
      return originalFunction(...args);
      // return originalFunction.bind(originalFunction)(...args);
      // return originalFunction.apply(originalFunction, args);
    } else {
      // too few args
      return _curry;
    }
  };
};

function sumThree(num1, num2, num3) {
  return num1 + num2 + num3;
}

// sumThree(4, 20, 6); // == 30

// let f1 = sumThree.curry(3); // tells `f1` to wait until 3 arguments are given before running `sumThree`
// f1 = f1(4); // [Function]
// f1 = f1(20); // [Function]
// f1 = f1(6); // = 30

// or more briefly:
console.log(sumThree.curry(3)(4)(20)(6)); // == 30
