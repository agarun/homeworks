const DOMNodeCollection = require("./dom_node_collection");

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


