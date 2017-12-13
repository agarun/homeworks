console.log('hey!');

$.ajax({
  type: 'GET',
  url: 'http://api.openweathermap.org/data/2.5/weather?q=New%20York,US&appid=bcb83c4b54aee8418983c2aff3073b3b',
  success: () => {
    console.log('weather update successful');
  },
  failure: () => {
    console.log('request failed');
  },
});

console.log('outside AJAX request, but will log prior to AJAX completion');

// ~ quick notes
// the request is sent after all the synchronous code in the document is executed & ran
// the response is returned when the web API sends back a response status code and/or JSON data
// since this is an AJAX request, the page did not refresh!
// the `type` option in $.ajax( ... ) can be GET/POST/PATCH/DELETE. alias of `method` option (jQ > 1.9)
