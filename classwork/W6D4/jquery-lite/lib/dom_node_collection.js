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