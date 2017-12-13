const board = require ('./board.js');
const coord = require ('./coord.js');
const deltas = {
  'N': [0, 1],
  'S': [0, -1],
  'E': [1, 0],
  'W': [-1, 0]
};

class Snake {
  constructor(direction, segments) {
    this.direction = direction;
    this.segments = segments;
  }

  move() {
    for (var i = 0; i < h; i++) {
      //
    }

    this.segments = this.segments.map((seg) => {
      const x = seg[0] + deltas[this.direction][0];
      const y = seg[1] + deltas[this.direction][1];
      return [x, y];
    });
  }
}
