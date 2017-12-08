// range(start, end)
// receives a start and end value, returns an array from start up to end

const range = function range(start, end) {
  if (start === end) return [end];
  return [start].concat(range(start + 1, end));
};

// console.log(range(2, 5)); // [2, 3, 4, 5]

// sumRec(arr)
// receives an array of numbers and recursively sums them
const sumRec = function sumRec(arr) {
  if (!arr.length) return 0;
  return arr[0] + sumRec(arr.slice(1));
};

// console.log(sumRec([0, 1, 2, 3, 4, 5])); // 15

// exponent(base, exp)
// receives a base and exponent, returns the base raise to the power of the exponent (base ^ exp)
const exponent1 = function exponent1(base, exp) {
  if (!exp) return 1;

  if (exp < 0) {
    return (1 / base) * exponent1(base, exp + 1);
  } else {
    return base * exponent1(base, exp - 1);
  }
};

// console.log(exponent1(2, 3)); // 8
// console.log(exponent1(2, -3)); // (1 / 8)

const exponent2 = function exponent2(base, exp) {
  if (!exp) return 1;

  if (exp % 2 === 0) {
    return exponent2(base, Math.floor(exp / 2)) * exponent2(base, Math.floor(exp / 2));
  } else {
    return base * exponent2(base, Math.floor(exp / 2)) * exponent2(base, Math.floor(exp / 2));
  }
};

// console.log(exponent2(2, 3)); // 8

// fibonacci(n) - receives an integer, n, and returns the first n Fibonacci numbers
const fibonacci = function fibonacci(n) {
  if (n === 1) return [0];
  if (n === 2) return [0, 1];

  let fibs = fibonacci(n - 1);
  fibs.push(fibs[fibs.length - 1] + fibs[fibs.length - 2]);
  return fibs;
};

// console.log(fibonacci(11));

const bsearch = function bsearch(arr, target) {
  if (!arr.length) return -1;
  const mid = Math.floor(arr.length / 2);

  if (arr[mid] === target) {
    return mid;
  } else if (arr[mid] > target) {
    // target is on left side
    return bsearch(arr.slice(0, mid), target);
  } else {
    // target is on right side (account for `mid + 1`)
    const searchResult = bsearch(arr.slice(mid + 1), target);
    return searchResult === -1 ? -1 : searchResult + mid + 1;
  }
};

// console.log(bsearch([0, 1, 2, 3, 4, 5], 4));
// console.log(bsearch([0, 1, 2, 3, 4, 5], 2));
// console.log(bsearch([0, 1, 2, 3, 4, 5], 3));
console.log(bsearch([0, 1, 2, 3, 4, 5], 6));

// O(n^2)
const merge = function merge(left, right) {
  const mergedArray = [];

  while (left.length && right.length) {
    if (left[0] <= right[0]) {
      mergedArray.push(left.shift());
    } else {
      mergedArray.push(right.shift());
    }
  }

  return mergedArray.concat(left).concat(right);
};

const mergeSort = function mergeSort(arr) {
  if (arr.length <= 1) return arr;

  const midIdx = Math.floor(arr.length / 2);
  const left = arr.slice(0, midIdx);
  const right = arr.slice(midIdx);

  const leftSorted = mergeSort(left);
  const rightSorted = mergeSort(right);

  return merge(leftSorted, rightSorted);
};

// console.log(mergeSort([5, 6, 2, 1, 4, 0, 3]));
// console.log(mergeSort([4, 0, 3]));

// subsets(arr)
// receives an array, returns an array containing all the subsets of the original array
const subsets = function subsets(arr) {
  if (!arr.length) return [arr]; // subsets([]) returns [[]]

  const lastEl = arr[arr.length - 1];
  const subsAfterPop = subsets(arr.slice(0, arr.length - 1));

  const subsAfterPopWithLastEl = subsAfterPop.map((subset) => {
    subset = subset.concat(lastEl);
    return subset;
  });

  return subsAfterPop.concat(subsAfterPopWithLastEl);
};

// console.log(subsets([]));
// console.log(subsets([1]));
// console.log(subsets([1, 2, 3]));
