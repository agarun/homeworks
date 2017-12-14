const FollowToggle = require('./follow_toggle');
const UsersSearch = require('./users_search');
const TweetCompose = require('./tweet_compose');

$(document).ready(() => {
  $('.follow-toggle').each((i, el) => new FollowToggle(el));
  $('.users-search').each((i, el) => new UsersSearch(el));
  $('.tweet-compose').each((i, form) => new TweetCompose(form));
});

// dev
window.$ = $;
