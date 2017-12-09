const readline = require("readline");

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function askIfGreaterThan(el1, el2, callback) {
  reader.question(`Is ${el1} > ${el2}? `, function (userOutput) {
    if (userOutput === "yes") {
      callback(true);
    } else if (userOutput === "no") {
      callback(false);
    } else {
      throw "error";
    }
  });
}

// temp = arr[i];
// arr[i] = arr[i + 1];
// arr[i + 1] = temp;

// [5, 6, 2, 3]
// [5, 2, 6, 3]
// [5, 2, 3, 6]
// -> outerBubbleSortLoop is executed
// [2, 5, 3, 6]
// [2, 3, 5, 6]
// -> outerBubbleSortLoop is executed

function innerBubbleSortLoop(arr, i, madeAnySwaps, outerBubbleSortLoop) {
  if (i < arr.length - 1) {
    console.log(arr);
    askIfGreaterThan(arr[i], arr[i + 1], function (isGreaterThan) {
      if (isGreaterThan) {
        [arr[i], arr[i + 1]] = [arr[i + 1], arr[i]];
        madeAnySwaps = true;
      }
      innerBubbleSortLoop(arr, i + 1, madeAnySwaps, outerBubbleSortLoop); // ++i also works, or i += 1
    });
  } else {
    outerBubbleSortLoop(madeAnySwaps);
  }
}

function absurdBubbleSort(arr, sortCompletionCallback) {
  function outerBubbleSortLoop(madeAnySwaps) {
    if (madeAnySwaps) {
      innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop); // don't invoke outerBubbleSortLoop here
    } else {
      sortCompletionCallback(arr);
    }
  }

  outerBubbleSortLoop(true);
}

absurdBubbleSort([3, 2, 1], function (arr) {
  console.log("Sorted array: " + JSON.stringify(arr));
  reader.close();
});

// askIfGreaterThan(4, 5, (boolean) => {
//   console.log(boolean);
//   reader.close();
// });
