// Function.prototype.myBind = function (context) {
//   // `this` outside => would be the function object that is being bound 
//   const that = this;
// 
//   return function () {
//     // `this` inside is window/global
//     that.call(context);
//   };
// };

Function.prototype.myBind = function (context, ...argsToBind) {
  return (...argsToApply) => {
    // `this` is not reset - it's the same as outside
    // bind fixes the context any parameters if given --> returns new function
    this.apply(context, argsToBind.concat(argsToApply));
  };
};

class Lamp {
  constructor() {
    this.name = "a lamp";
  }
}

const turnOn = function() {
   console.log("Turning on " + this.name);
};

const lamp = new Lamp();

turnOn(); // should not work the way we want it to

const boundTurnOn = turnOn.bind(lamp);
const myBoundTurnOn = turnOn.myBind(lamp);

boundTurnOn(); // should say "Turning on a lamp"
myBoundTurnOn(); // should say "Turning on a lamp"
