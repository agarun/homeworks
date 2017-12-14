const APIUtil = require('./api_util');
const FollowToggle = require('./follow_toggle');

class UsersSearch {
  constructor(el) {
    this.$el = $(el);
    this.$ul = this.$el.find(".users");
    this.$input = this.$el.find("input");

    this.$input.on(
      "input",
      this.handleInput.bind(this)
    );
  }

  handleInput() {
    event.preventDefault();

    APIUtil.searchUsers(
      this.$input.val())
      .then(this.renderResults.bind(this)
    );
  }

  renderResults(users) {
    this.$ul.empty();
    users.forEach((user) => {
      const link = $(`<a href="/users/${user.id}">${user.username}</a>`);
      const listItem = $("<li>");
      const buttonElement = $("<button>");
      const followState = user.followed ? "followed" : "unfollowed";

      new FollowToggle(buttonElement, {
        userId: user.id,
        followState: followState
      });

      this.$ul.append(listItem.append(link));
      listItem.append(buttonElement);
    });
  }
}

module.exports = UsersSearch;
