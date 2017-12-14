const APIUtil = {
  followUser: id => {
    return $.ajax({
      url: `/users/${id}/follow`,
      type: 'POST',
      dataType: 'json'
    });
  },
  unfollowUser: id => {
    return $.ajax({
      url: `/users/${id}/follow`,
      type: 'DELETE',
      dataType: 'json'
    });
  },
  searchUsers(queryVal) {
    return $.ajax({
      url: `/users/search`,
      type: 'GET',
      dataType: 'json',
      data: { query: queryVal }
    });
  },
  createTweet(data) {
    return $.ajax({
      url: `/tweets`,
      type: 'POST',
      dataType: 'json',
      data: data
    });
  }
};

module.exports = APIUtil;



