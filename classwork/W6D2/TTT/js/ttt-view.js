class View {
  constructor(game, $el) {
    this.game = game;
    this.$el = $el;
    this.$el.append(this.setupBoard());
    this.bindEvents();
  }

  makeMove($square) {
    const pos = $square.data('pos').split(', ');
    this.game.playMove(pos);
    if (this.game.currentPlayer === 'o') {
      $square.addClass('x');
    } else {
      $square.addClass('o');
    }
  }

  setupBoard() {
    const grid = $('<ul class="grid">');
    for (let row = 0; row < 3; row++) {
      for (let col = 0; col < 3; col++) {
        let $cell = $('<li>');
        $cell.data('pos', `${row}, ${col}`);
        grid.append($cell);
      }
    }
    return grid;
  }

  bindEvents() {
    const handleClick = (event) => {
      const $square = $(event.currentTarget);
      try {
        this.makeMove($square);
        if (this.game.isOver()) {
          if (this.game.winner()) {
            const $gameover = $(`<h1>Game Over. ${this.game.winner()} wins. </h1>`);
            $('.ttt').append($gameover);
            $(`.${this.game.winner()}`).addClass(`${this.game.winner()}-winner`);
            $(`.${this.game.currentPlayer}`).addClass(`${this.game.currentPlayer}-loser`);
          } else {
            const $tie = $(`<h1>Game Over. It's a tie!</h1>`);
            $('.ttt').append($tie);
            $('.grid').addClass('tie');
          }
          $('ul.grid').off('click', 'li', handleClick);
          $('ul.grid').removeClass('no-hover');
        }
      } catch (e) {
        alert('invalid move');
      }
    };
  $('ul.grid').on('click', 'li', handleClick);
  }
}

module.exports = View;
