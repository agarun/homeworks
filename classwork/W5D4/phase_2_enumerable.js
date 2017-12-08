// monkey-patching

// Array#myEach(callback) 
// receives a callback function and executes the callback for each element in the array
Array.prototype.myEach = function(callback) {
  for (let i = 0; i < this.length; i += 1) {
    callback(this[i], i, this);
  }
};

// console.log([5, 6, 7, 8, 9].myEach((el, idx) => console.log(`el: ${el}, idx: ${idx}`)));

// Array#myMap(callback) 
// receives a callback function, returns a new array of the results of 
// calling the callback function on each element of the array
// should use myEach and a closure
Array.prototype.myMap = function(callback) {
  const mappedArray = [];
  
  this.myEach((el, idx, arr) => {
    mappedArray.push(callback(el, idx, arr));
  });
  
  return mappedArray;
};

const testArray = [1, 4, 9, 16];
const testMyMap = testArray.myMap(x => x * 2);
// console.log(testMyMap); // [2, 8, 18, 32]

// Array#myReduce(callback[, initialValue]) 
// receives a callback function, and optional initial value, 
// returns an accumulator by applying the callback function to each element 
// and the result of the last invocation of the callback (or initial value if supplied)
// initialValue is optional and should default to the first element of the array if not provided
Array.prototype.myReduce = function(callback, initialValue) {
  // since initialValue is optional, if it doesn't exist, adjust the array and set it to first el
  let array = this;
  if (!initialValue) {
    initialValue = this[0];
    array = this.slice(1);
  }
  
  let accumulator = initialValue;
  array.myEach((el, idx, arr) => {
    accumulator = callback(accumulator, el);
  });
  return accumulator;
};

// console.log(
//   [1, 2, 3].myReduce(function(acc, el) {
//     return acc + el;
//   })
// ); // => 6
// 
// console.log(
//   [1, 2, 3].myReduce(function(acc, el) {
//     return acc + el;
//   }, 25) 
// ); // => 31
