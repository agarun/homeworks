class Clock {
  constructor() {
    // 1. Create a Date object.
    this.date = new Date();
    // 2. Store the hours, minutes, and seconds.
    this.hours = this.date.getHours();
    this.minutes = this.date.getMinutes();
    this.seconds = this.date.getSeconds();
    // 3. Call printTime.
    this.printTime();
    // 4. Schedule the tick at 1 second intervals.
    // callback is invoked at 1 second intervals with `this` context
    // set to the clock instance
    setInterval(this._tick.bind(this), 1000);
    // without `bind`, `this` refers to the global object on every
    // function-style invocation of the callback
    // with an arrow function as the callback, `bind` is unnecessary
    // because it shares the `this` from the constructor's scope
  }

  printTime() {
    // Format the time in HH:MM:SS
    // Use console.log to print it.
    console.log(`${this.hours}:${this.minutes}:${this.seconds}`);
  }

  _tick() {
    // 1. Increment the time by one second.
    // 2. Call printTime.
    this.date.setSeconds(this.seconds + 1);
    this.seconds = this.date.getSeconds();

    if (this.seconds == 0) {
      this.date.setMinutes(this.minutes + 1);
      this.minutes = this.date.getMinutes();
    }

    if (this.minutes == 0 && this.seconds == 0) {
      this.date.setHours(this.hours + 1);
      this.hours = this.date.getHours();
      this.minutes = 0;
    }

    this.printTime();
  }
}

const clock = new Clock();
