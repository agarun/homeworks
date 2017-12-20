export const fetchSearchGiphys = (searchTerm) => {
  const apiKey = 'dc6zaTOxFJmzC';
  const baseUrl = 'http://api.giphy.com/v1/gifs/search';
  const fullUrl = `${baseUrl}?q=${searchTerm}&api_key=${apiKey}&limit=2`;

  return $.ajax({
    method: 'GET',
    url: fullUrl,
  });
};
