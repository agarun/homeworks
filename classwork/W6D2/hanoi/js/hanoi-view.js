class HanoiView {
  constructor(game, $el) {
    this.game = game;

    this.$el = $el;
    this.click = null;
    this.setupTowers();
    this.clickTower();
  }

  // TODO: DRY code with `HanoiView.prototype.render`
  setupTowers() {
    const classes = {
      3: 'three',
      2: 'two',
      1: 'one'
    };

    this.game.towers.forEach((tower, index) => {
      const $tower = $(`<ul id=${index}>`);
      this.$el.append($tower);

      tower.slice(0).reverse().forEach((disc) => {
        const $disc = $('<li>');
        $disc.addClass(classes[disc]);
        $tower.append($disc);
      });
    });
  }

  render() {
    $('ul').remove();
    const classes = {
      3: 'three',
      2: 'two',
      1: 'one'
    };

    this.game.towers.forEach((tower, index) => {
      const $tower = $(`<ul id=${index}>`);
      this.$el.append($tower);
      tower.slice(0).reverse().forEach((disc) => {
        const $disc = $('<li>');
        $disc.addClass(classes[disc]);
        $tower.append($disc);
      });
    });
    $('ul').removeClass('clicked');
    this.clickTower();
  }

  // TODO: Improve var names. e.g. `this.click` --> `this.fromTowerIdx`
  clickTower() {
    const clickHandler = (event) => {
      const clickedObject = $(event.currentTarget);

      if (this.click !== null) {
        const nextTower = clickedObject.attr('id');
        if (this.game.move(this.click, nextTower)) {
          this.render();
          if (this.game.isWon()) {
            alert("you won!");
            $('li').addClass('win-discs');
          }
        } else {
          alert("invalid move, try again homie");
        }
        this.click = null;
      } else {
        this.click = clickedObject.attr('id');
        clickedObject.addClass('clicked');
      }
    };

    this.game.towers.forEach((tower, index) => {
      const $tower = $(`ul#${index}`);
      $tower.on('click', clickHandler);
    });

    if (this.game.isWon()) {
      $('ul').off('click', clickHandler);
    }
  }
}

module.exports = HanoiView;
