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

const DOMNodeCollection = __webpack_require__(1);

let queue = [];
const $l = function(arg) {
  if (arg instanceof HTMLElement) {
    return DOMNodeCollection.create([arg]);
  } else if(arg instanceof Function) {
    queue.push(arg); 
  } else {
    const nl = document.querySelectorAll(arg);
    return DOMNodeCollection.create(Array.from(nl));
  }
};
document.addEventListener("DOMContentLoaded", (event) => {
  queue.forEach((func) =>{
    func(event);
  });
});

$l.extend = function(...objects) {
  let extended = objects[0];
  objects.slice(1).forEach((object) => {
    for (let key in object) {
      extended[key] = object[key];
    }
  });
  return extended;
};

const defaultAjaxOptions = {
  success: function(fillerObject, textStatus, jqXHR) {
    console.log(textStatus);
  },
  error: function(jqXHR, textStatus, errorThrown) {
    console.log(textStatus + errorThrown);
  },
  url: '.',
  method: 'GET',
  data: "",
  contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
};

$l.ajax = function(options) {
  const allOptions = $l.extend(defaultAjaxOptions, options);
  
  // create xhr object
  const xhr = new XMLHttpRequest();
  
  // HTTP verb and path
  xhr.open(allOptions.method, allOptions.url);
  
  xhr.onload = () => {
    const statusString = xhr.status.toString();
    if (statusString.match(/2.*/)) {
      allOptions.success(JSON.parse(xhr.response));
    } else {
      allOptions.error(JSON.parse(xhr.response));
    }
  };
  
  xhr.send(allOptions.data);
};

// dev
window.$l = $l;
window.$ = $;

// dom content loaded events
$l(() => console.log('the document is ready!'));
$l(() => console.log('the document is still ready!'));




/***/ }),
/* 1 */
/***/ (function(module, exports) {

class DOMNodeCollection {
  constructor(htmlArr) {
    this.htmlArr = htmlArr;
  }
  
  static create(htmlArr) { 
    return new DOMNodeCollection(htmlArr);
  }
  
  html(string) {
    if (string) {
      this.htmlArr.forEach((el) =>{
        el.innerHTML = string;
      });
    } else {
      return this.htmlArr[0].innerHTML;
    }
  }
  
  empty() {
    this.htmlArr.forEach((el) => {
      el.innerHTML = "";
    });
  }
  
  append(arg) {
    if (typeof arg === 'string') {
      this.htmlArr.forEach((el) => {
        el.innerHTML += arg;
        // el.append(arg);
      });
    } else if (arg instanceof DOMNodeCollection) {
      this.htmlArr.forEach((htmlEl) => {
        arg.htmlArr.forEach((argEl) => {
          htmlEl.innerHTML += argEl.outerHTML;
          // htmlEl.append(argEl);
        });
      });
    } else if (arg instanceof HTMLElement) {
      this.htmlArr.forEach((htmlEl) => {
        // htmlEl.append(arg);
        htmlEl.innerHTML += arg.outerHTML;
      });
    }
  }
  
  attr(arg, desired) {
    if (!desired) {
      return this.htmlArr[0].getAttribute(arg);
    } else {
      this.htmlArr.forEach((htmlEl)=> {
        htmlEl.setAttribute(arg, desired);
      });
    }
  }
  
  addClass(classname) {
    this.htmlArr.forEach((htmlEl) => {
      htmlEl.classList.add(classname);
    });
  }
  
  removeClass(classname) {
    this.htmlArr.forEach((htmlEl) => {
      htmlEl.classList.remove(classname);
    });
  }
  
  children() {
    let childArr = [];
    this.htmlArr.forEach((htmlEl) => {
      childArr = childArr.concat(Array.from(htmlEl.children));
    });
    return this.constructor.create(childArr);
  }
  
  parent() {
    let parentArr = [];
    this.htmlArr.forEach((htmlEl) => {
      if (!parentArr.includes(htmlEl.parentNode)) {
        parentArr = parentArr.concat(htmlEl.parentNode);
      }
    });
    return this.constructor.create(parentArr);
  }
  
  find(selector) {
    let matchingSelectors = [];
    
    this.htmlArr.forEach((htmlEl) => {
      matchingSelectors = matchingSelectors.concat(
        Array.from(htmlEl.querySelectorAll(selector))
      );
    });
    
    return this.constructor.create(matchingSelectors);
  }
  
  remove() {
    this.htmlArr.forEach((htmlEl) => {
      htmlEl.remove();
    });
    this.htmlArr = [];
  }
  
  on(eventType, callback){
    this.htmlArr.forEach((htmlEl) => {
      htmlEl.callback = htmlEl.callback || {};
      htmlEl.callback[eventType] = callback;
      htmlEl.addEventListener(eventType, callback);
    });
  }
  
  off(eventType){
    this.htmlArr.forEach((htmlEl) => {
      const callback = htmlEl.callback[eventType];
      htmlEl.removeEventListener(eventType, callback);
    });
  }
}

module.exports = DOMNodeCollection;

/***/ })
/******/ ]);