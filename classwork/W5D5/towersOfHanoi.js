class Game {
  constructor() {
    this.stacks = [[3,2,1], [], []];
  }

  run(completionCallback) {
    this.promptMove((startIndex, endIndex) => {
      if (!this.move(startIndex, endIndex)) {
        console.log("Move invalid");
      }
      if (!this.isWon()) {
        this.run(completionCallback);
      } else {
        console.log("You won!");
        completionCallback();
      }
    });
  }

  isWon() {
    return (this.stacks[0].length == 0 && (this.stacks[1].length == 0 || this.stacks[2].length == 0));
  }

  promptMove(callback) {
    this.printStacks();

    reader.question("Enter from", function(from) {
      reader.question("Enter to", function(to) {
        const startIndex = parseInt(from);
        const endIndex = parseInt(to);
        callback(startIndex, endIndex);
      });
    });
  }

  move(startIndex, endIndex) {
    if (this.isValidMove(startIndex, endIndex)) {
      const val = this.stacks[startIndex].pop();
      this.stacks[endIndex].push(val);
      return true;
    }
    return false;
  }

  isValidMove(start, end) {
    if (start < 0 || start > 2 || end < 0 || end > 2) return false;
    if (this.stacks[start].length === 0) return false;
    if (this.stacks[end][this.stacks.length - 1] < this.stacks[start][this.stacks.length - 1]) {
      return false;
    }
    return true;
  }

  printStacks() {
    for (let i = 0; i < this.stacks.length; i += 1) {
      console.log(`${i}: ${JSON.stringify(this.stacks[i])}`);
    }
    console.log("---------");
  }
}

module.exports = Game;
