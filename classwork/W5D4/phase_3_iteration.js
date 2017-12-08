// Array#bubbleSort 
// receives an array, returns a sorted array by implementing [bubble sort][bubble sort] sorting algorithm
Array.prototype.bubbleSort = function bubbleSort() {
  const swapElements = function swapElements(array, idx1, idx2) {
    let temp = array[idx1];
    array[idx1] = array[idx2];
    array[idx2] = temp;
    
  };
  
  let sorted = false;
  
  while (!sorted) {
    sorted = true;
    
    let i = 0;
    while (i < this.length - 1) {
      if (this[i] > this[i + 1]) {
        swapElements(this, i, i + 1);
        // or [this[i], this[i + 1]] = [this[i + 1], this[i]]
        sorted = false;
      }
      
      i += 1;
    }
  }
  
  return this;
};

// console.log([9, 8, 7, 6, 5, 4, 3, 2, 1].bubbleSort());

// String#substrings 
// receives a string, returns an array of all substrings
// Array.prototype.slice() takes parameters `begin` and `end`, `end` exclusive
String.prototype.substrings = function substrings(string) {
  const substrings = [];
  
  for (i = 0; i < this.length; i++) {
    for (j = i; j < this.length; j++) {
      substrings.push(this.slice(i, j + 1)); // `end` exclusive
    }
  }

  return substrings;
};

// console.log("testString".substrings());

// another way to rewrite this implementation ->
// use `j` as a length (minimum would be 1, similar to how line 41 says `j + 1 when `j = 0`)
// -> check on condition that `i + j` is less than or equal to the length of the string
// -> slice from the new begin `i` to `i + j` where `i + j` is start idx + length
