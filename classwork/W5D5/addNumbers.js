const readline = require("readline");

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function addNumbers(sum, numsLeft, completionCallback){
  if (numsLeft === 0) {
    reader.close();
    return completionCallback(sum);
  }else {
    reader.question("What number? ", function(number) {
      sum += parseInt(number);
      console.log(sum);
      numsLeft -= 1;
      addNumbers(sum, numsLeft, completionCallback);
    });
  }
}

// why isn't this executed?
// function addTwoNumbers(sum, numsLeft, completionCallback){
//   if (numsLeft === 0) {
//     console.log("not executed");
//     reader.close();
//     return completionCallback(sum);
//   }else {
//     reader.question("What number two?", function(number) {
//       sum += parseInt(number);
//       numsLeft -= 1;
//       addNumbers(sum, numsLeft, completionCallback);
//     });
//   }
// }

addNumbers(0, 3, sum => console.log(`Total Sum: ${sum}`));
// addTwoNumbers(0, 3, sum => console.log(`Total Sum: ${sum}`));
// console.log("done with both functions");
