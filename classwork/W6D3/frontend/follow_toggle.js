const APIUtil = require('./api_util');

class FollowToggle {
  constructor(el, options) {
    this.$el = $(el);
    this.userId = this.$el.data('user-id') || options.userId;
    this.followState = this.$el.data('initial-follow-state') ||
      options.followState;

    this.render();
    this.$el.on("click", this.handleClick.bind(this));
  }

  render() {
    if (this.followState === "unfollowing" || this.followState === "following") {
      this.$el.prop("disabled", true);
    } else if (this.followState === "unfollowed") {
      this.$el.prop("disabled", false);
      this.$el.text("follow!");
    } else {
      this.$el.prop("disabled", false);
      this.$el.text("unfollow!");
    }
  }

  handleClick(event) {
    event.preventDefault();

    if (this.followState === "unfollowed") {
      this.followState = "following";
      this.render();
      const followed = () => {
        this.followState = "followed";
        this.render();
      };
      APIUtil.followUser(this.userId).then(followed);
    } else {
      this.followState = "unfollowing";
      this.render();
      const unfollowed = () => {
        this.followState = "unfollowed";
        this.render();
      };
      APIUtil.unfollowUser(this.userId).then(unfollowed);
    }
  }
}

module.exports = FollowToggle;
