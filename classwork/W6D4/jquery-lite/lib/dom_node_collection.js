class DOMNodeCollection {
  constructor(nodes) {
    this.nodes = nodes;
  }

  static create(nodes) {
    return new DOMNodeCollection(nodes);
  }

  each(callback) {
    this.nodes.forEach(callback);
  }

  html(string) {
    if (string) {
      this.nodes.forEach((el) =>{
        el.innerHTML = string;
      });
    } else {
      return this.nodes[0].innerHTML;
    }
  }

  empty() {
    // or: `this.html("")`
    this.nodes.forEach((el) => {
      el.innerHTML = "";
    });
  }

  append(children) {
    if (typeof children === 'string') {
      this.nodes.forEach((el) => {
        el.innerHTML += children;
      });
    } else if (children instanceof DOMNodeCollection) {
      this.nodes.forEach((htmlEl) => {
        children.nodes.forEach((childrenEl) => {
          htmlEl.innerHTML += childrenEl.outerHTML;
        });
      });
    } else if (children instanceof HTMLElement) {
      this.nodes.forEach((htmlEl) => {
        htmlEl.innerHTML += children.outerHTML;
      });
    }
  }

  attr(key, val) {
    if (!val) {
      return this.nodes[0].getAttribute(key);
    } else {
      this.nodes.forEach((htmlEl) => {
        htmlEl.setAttribute(key, val);
      });
    }
  }

  addClass(className) {
    this.nodes.forEach((htmlEl) => {
      htmlEl.classList.add(className);
    });
  }

  removeClass(className) {
    this.nodes.forEach((htmlEl) => {
      htmlEl.classList.remove(className);
    });
  }

  children() {
    let childNodes = [];
    this.nodes.forEach((htmlEl) => {
      childNodes = childNodes.concat(Array.from(htmlEl.children));
    });
    return this.constructor.create(childNodes);
  }

  parent() {
    let parentNodes = [];
    this.nodes.forEach((htmlEl) => {
      if (!parentNodes.includes(htmlEl.parentNode)) {
        parentNodes = parentNodes.concat(htmlEl.parentNode);
      }
    });
    return this.constructor.create(parentNodes);
  }

  find(selector) {
    let matchingSelectors = [];

    this.nodes.forEach((htmlEl) => {
      matchingSelectors = matchingSelectors.concat(
        Array.from(htmlEl.querySelectorAll(selector))
      );
    });

    return this.constructor.create(matchingSelectors);
  }

  remove() {
    this.nodes.forEach((htmlEl) => {
      htmlEl.remove();
    });
    this.nodes = [];
  }

  on(eventType, callback) {
    this.nodes.forEach((htmlEl) => {
      htmlEl.callback = htmlEl.callback || {};
      htmlEl.callback[eventType] = callback;
      htmlEl.addEventListener(eventType, callback);
    });
  }

  off(eventType) {
    this.nodes.forEach((htmlEl) => {
      const callback = htmlEl.callback[eventType];
      htmlEl.removeEventListener(eventType, callback);
    });
  }
}

module.exports = DOMNodeCollection;
