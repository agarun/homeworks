const APIUtil = require('./api_util');

class TweetCompose {
  constructor(form) {
    this.$form = $(form);

    this.$form.on(
      "submit",
      this.submit.bind(this)
    );

    this.$textarea = $('form textarea');
    this.$form.append($('<strong class="chars-left">Chars left: 140</strong>'));
    this.$textarea.on('input', this.showCharCount.bind(this));
  }

  showCharCount() {
    const charsLeft = 140 - this.$textarea.val().length;
    $('.chars-left').text(`Chars left: ${charsLeft}`);
  }

  submit(event) {
    event.preventDefault();

    const formData = $(event.currentTarget).serializeJSON();
    $(':input').prop('disabled', true);

    APIUtil.createTweet(formData).then(this.handleSuccess.bind(this));
  }

  handleSuccess(newTweet) {
    this.clearInput();
    $(':input').prop('disabled', false);

    const formId = this.$form.data('tweets-ul');
    const listOfAllTweets = $('ul#feed');
    const newTweetLi = $(`<li>${newTweet.content} -- ${newTweet.user.username} -- ${newTweet.created_at}</li>`);

    if (newTweet.metions.length > 0) {
      newTweetLi.append(
        $(`<ul><li>${newTweet.metions[0].user.username}</li></ul>`)
      );
    }

    listOfAllTweets.prepend(newTweetLi);
  }

  clearInput() {
    $(':input:not([type="submit"])').val('');
  }

  newUserSelect() {
    const users = window.users;
    // map -> option value is user id
    // const selectMentions = $(`<select></select>`);
    // window._all_users.forEach((username) => {
    //   let newOption = $(`<option value="${username}">`);
    //   selectMentions.append(newOption);
    // });
  }
}

module.exports = TweetCompose;
