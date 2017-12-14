const APIUtil = {
  followUser: id => (
    $.ajax({
      url: `/users/${id}/follow`,
      type: 'POST',
      dataType: 'json'
    })
  ),
  unfollowUser: id => (
    $.ajax({
      url: `/users/${id}/follow`,
      type: 'DELETE',
      dataType: 'json'
    })
  ),
  searchUsers: queryVal => (
    $.ajax({
      url: '/users/search',
      type: 'GET',
      dataType: 'json',
      data: { query: queryVal }
    })
  ),
  createTweet: data => (
    $.ajax({
      url: `/tweets`,
      type: 'POST',
      dataType: 'json',
      data: data
    })
  ),
};

module.exports = APIUtil;
