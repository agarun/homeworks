document.addEventListener("DOMContentLoaded", () => {
  const toggleLi = (e) => {
    const li = e.target;
    if (li.className === "visited") {
      li.className = "";
    } else {
      li.className = "visited";
    }
  };

  document.querySelectorAll("#restaurants li").forEach((li) => {
    li.addEventListener("click", toggleLi);
  });

  const addToPlaces = (e) => {
    e.preventDefault();

    const li = document.createElement('li');
    const submitInput = document.querySelector('.favorite-input');
    li.textContent = submitInput.value;
    submitInput.value = "";

    document.getElementById('sf-places').appendChild(li);
  }

  const submitButton = document.querySelectorAll('.list-container input[type="submit"]')[0];
  submitButton.addEventListener("click", addToPlaces);

  const toggleForm = (e) => {
    const photoFormContainer = document.querySelectorAll('.photo-form-container')[0];
    photoFormContainer.classList.toggle('hidden');
  }

  const showButton = document.querySelectorAll('.photo-show-button')[0];
  showButton.addEventListener("click", toggleForm);

  const addImage = (e) => {
    event.preventDefault();

    const li = document.createElement('li');
    const img = document.createElement('img');

    const newImageURL = document.querySelectorAll('.photo-url-input')[0];
    img.src = newImageURL.value;
    newImageURL.value = "";

    li.appendChild(img);
    const imageList = document.querySelectorAll('.dog-photos')[0];
    imageList.appendChild(li);
  }

  const submitInput = document.querySelectorAll('.photo-url-submit')[0];
  submitInput.addEventListener("click", addImage);
});
