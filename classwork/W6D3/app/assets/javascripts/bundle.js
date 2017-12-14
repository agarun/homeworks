/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// identity function for calling harmony imports with the correct context
/******/ 	__webpack_require__.i = function(value) { return value; };
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

const FollowToggle = __webpack_require__(1);
const UsersSearch = __webpack_require__(3);
const TweetCompose = __webpack_require__(4);

$(document).ready(() => {
  $('.follow-toggle').each((i, el) => {
    new FollowToggle(el);
  });
  $('.users-search').each((i, el) => {
    new UsersSearch(el);
  });
  $('.tweet-compose').each((i, form) => {
    new TweetCompose(form);
  });
});

// dev
window.$ = $;

/***/ }),
/* 1 */
/***/ (function(module, exports, __webpack_require__) {

const APIUtil = __webpack_require__(2);

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



/***/ }),
/* 2 */
/***/ (function(module, exports) {

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





/***/ }),
/* 3 */
/***/ (function(module, exports, __webpack_require__) {

const APIUtil = __webpack_require__(2);
const FollowToggle = __webpack_require__(1);

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

/***/ }),
/* 4 */
/***/ (function(module, exports, __webpack_require__) {

const APIUtil = __webpack_require__(2);

class TweetCompose {
  constructor(form) {
    this.$form = $(form);
    
    this.$form.on(
      "submit",
      this.submit.bind(this)
    );
    
    this.$textarea = $('form textarea');
    this.$form.append(
      $(`<strong class="chars-left">Chars left: 140</strong>`)
    );
    this.$textarea.on(
      'input',
      this.showCharCount.bind(this)
    );
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
    console.log(newTweet);
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
    const selectMentions = $(`<select></select>`);
    window._all_users.forEach((username) => {
      let newOption = $(`<option value="${username}">`);
      selectMentions.append(newOption);
    });
  }
}

module.exports = TweetCompose;

/***/ })
/******/ ]);
//# sourceMappingURL=bundle.js.map