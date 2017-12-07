// since `var` is function-scoped, the value of `x` changes
// expect to see 'in block' printed twice
function mysteryScoping1() {
  var x = 'out of block';
  if (true) {
    var x = 'in block';
    console.log(x);
  }
  console.log(x);
};

// since `const` is block-scoped, the value of `x` outside of the
// `if` block persists, but inside it is declared anew. expect to see
// 'in block' first from inside, and then 'out of...' from outside
function mysteryScoping2() {
  const x = 'out of block';
  if (true) {
    const x = 'in block';
    console.log(x);
  }
  console.log(x);
};

// `const` *cannot be reassigneed*
// since `var x ...` is reassignment, SyntaxError thrown
function mysteryScoping3() {
  const x = 'out of block';
  if (true) {
    var x = 'in block';
    console.log(x);
  }
  console.log(x);
};

// `let` is block-scoped and the `if` block is a valid block
// block-scoped vars of the same names can be declared in nested scopes
// "redeclaring same var within same function/block scope is a syntax error"
// expect to see 'in block' logged first, and then 'out of block'
function mysteryScoping4() {
  let x = 'out of block';
  if (true) {
    let x = 'in block';
    console.log(x);
  }
  console.log(x);
};

// JS is compiled (tokenize -> parse -> generate code) *right* before execution
// the SyntaxError is thrown in this step, so the `if` block contents
// will not be executed. (details in YDKJS Scope & Closures)
// -> we expect SyntaxError to be thrown because `let x` tries to *declare* the
// same variable name twice.
function mysteryScoping5() {
  let x = 'out of block';
  if (true) {
    let x = 'in block';
    console.log(x);
  }
  let x = 'out of block again';
  console.log(x);
};

// uppercases and interpolates args into an arbitrary sentence
const madLib = function madLib(verb, adjective, noun) {
  return `We shall ${verb.toUpperCase()} the ${adjective.toUpperCase()} ${noun.toUpperCase()}`;
};

console.log(madLib('make', 'best', 'guac')); // We shall MAKE the BEST GUAC

const isSubstring = function isSubstring(searchString, subString) {
  return searchString.includes(subString) ? true : false
};

console.log(isSubstring("time to program", "time")); // true
console.log(isSubstring("Jump for joy", "joys")); // false

// `Array.prototype.slice()` excludes the `end` index
const isSubstring2 = function isSubstring(searchString, subString) {
  for (let i = 0; i + subString.length <= searchString.length; i++) {
    if (searchString.slice(i, i + subString.length) === subString) return true;
  }

  return false;
};

console.log(isSubstring2("time to program", "time")); // true
console.log(isSubstring2("Jump for joy", "joys")); // false

// Define a function `fizzBuzz(array)` that takes an array and returns
// a new array of every number in the array that is divisible by either 3 or 5, but not both.
const fizzBuzz = function fizzBuzz(array) {
  let fizzyBuzzyNumbers = [];

  array.forEach((number) => {
    if ((number % 3 === 0 || number % 5 === 0) && number % 15 !== 0) {
      fizzyBuzzyNumbers.push(number);
    }
  });

  return fizzyBuzzyNumbers;
};

console.log(fizzBuzz([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]));

// ^ is the bitwise XOR operator
// performs XOR on each bit pair: x XOR y => 1 if x and y are different
// e.g. 0 ^ 0 === 0; 1 ^ 1 === 0; 0 ^ 1 === 1; 1 ^ 0 === 1;
// since 0 is falsy and 1 is truthy, the number is only pushed to the array
// when 0 ^ 1 or 1 ^ 0, and not when both are the same bits.
const fizzBuzz2 = function fizzBuzz2(array) {
  let fizzyBuzzyNumbers = [];

  array.forEach((number) => {
    if (number % 3 === 0 ^ number % 5 === 0) {
      fizzyBuzzyNumbers.push(number);
    }
  });

  return fizzyBuzzyNumbers;
};

console.log(fizzBuzz2([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]));

const isPrime = function isPrime(number) {
  if (number <= 1) return false;

  for (let i = 2; i < number; i++) {
    if (number % i === 0) return false;
  }

  return true;
};

console.log(isPrime(2)); // true
console.log(isPrime(10)); // false
console.log(isPrime(15485863)); // true
console.log(isPrime(3548563)); // false

const sumOfNPrimes = function sumOfNPrimes(n) {
  let primes = [];

  for (let i = 2; primes.length < n; i++) {
    if (isPrime(i)) primes.push(i);
  }

  // single-line arrow function implicitly returns value
  const primesSum = primes.reduce((sum, num) => sum + num, 0);

  return primesSum;
}

console.log(sumOfNPrimes(0));
console.log(sumOfNPrimes(1));
console.log(sumOfNPrimes(4));

const sumOfNPrimes2 = function sumOfNPrimes2(n) {
  let numberOfPrimes = 0;
  let primesSum = 0;

  for (let i = 2; numberOfPrimes < n; i++) {
    if (isPrime(i)) {
      numberOfPrimes += 1;
      primesSum += i;
    }
  }

  return primesSum;
}

console.log(sumOfNPrimes2(0));
console.log(sumOfNPrimes2(1));
console.log(sumOfNPrimes2(4));
