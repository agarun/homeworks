// monkey-patching

// Array#uniq - returns a new array containing only the unique elements of the original array
// the unique elements should be in the order in which they first appear
// should not mutate the original array
Array.prototype.uniq = function uniq() {
  let uniqElements = [];
  
  this.forEach((element) => {
    if (!uniqElements.includes(element)) uniqElements.push(element);
  });
  
  return uniqElements;
};

// console.log([5, 5, 6].uniq());
// console.log([5, 8, 2, 1, 8, 1, 8].uniq());

// Array#twoSum - returns an array of position pairs where the elements sum to zero
Array.prototype.twoSum = function twoSumZero() {
  const complements = {};
  const positionPairs = [];
  
  this.forEach((element, index) => {
    if (complements[-element] !== undefined) { // TODO: best practice? check soln.
      positionPairs.push([complements[-element], index]);
    } else {
      complements[element] = index;
    }
  });
  
  return positionPairs;
};

// console.log([5, -5, 6, 1, 2, -1, -6].twoSum()); // [[0, 1], [2, 6], [3, 5]] 
// console.log([5, -5].twoSum()); // [[0, 1]]

// Array#transpose - where we have a two-dimensional array representing a matrix. returns the transpose
// should not mutate the original array
Array.prototype.transpose = function transpose() {
  let transposed = [];

  const array = this;
  const numRows = array.length;
  const numCols = array[0].length;
  
  for (let i = 0; i < numCols; i += 1) {
    let newRow = [];

    for (let j = 0; j < numRows; j += 1) {
      newRow.push(array[j][i]);
    }
    
    transposed.push(newRow);
  }
  
  return transposed;
};

// console.log(
//   [
//     [1, 2, 3],
//     [4, 5, 6],
//     [7, 8, 9],
//   ].transpose()
// );
// 
// console.log(
//   [
//     [1, 2, 3],
//     [4, 5, 6],
//     [7, 8, 9],
//     [10, 11, 12],
//   ].transpose()
// );

// Array.prototype.transpose2 = function transpose2() {
  // let arr = Array(this[0].length).fill(null).map(() => Array(this.length).fill(null));
  // arr.forEach((colElement, colIndex) => {
  //   arr[colIndex].forEach((rowElement, rowIndex) => {
  //     colElement = this[colIndex][rowIndex];
  //   });
  // });
  // return arr;
// };

// console.log(
//   [
//     [1, 2, 3],
//     [4, 5, 6],
//     [7, 8, 9],
//   ].transpose2()
// );