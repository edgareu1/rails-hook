function autoCompleteFish(searchField) {
  searchField.addEventListener('input', (event) => {
    const param = event.target.value.trim();        // Search param striped of trailing whitespaces
    const fish_names = gon.fish_names.split(', ');  // Array of Fish to search into

    // Get or create 'autocomplete-list' Div
    let autoCompleteContainer = document.getElementById("autocomplete-list")

    // If it does not exist then create it
    if (!autoCompleteContainer) {
      autoCompleteContainer = document.createElement("div");
      autoCompleteContainer.setAttribute("id", "autocomplete-list");

      // Insert the 'autocomplete-list' in the document
      searchField.parentNode.insertBefore(autoCompleteContainer, searchField.nextSibling);

      // Make sure the position of the 'autocomplete-list' is relative to the 'searchField'
      searchField.parentNode.style.position = 'relative';

    } else {
      emptyList(autoCompleteContainer); // Make sure the List is empty
    }

    if (param === '') return; // If the param is empty then let the List also be empty

    // Iterate over the array of Fish
    for (let i = 0; i < fish_names.length; i++) {
      // Check if the element matches the search param
      let wordIndex = fish_names[i].toUpperCase().indexOf(param.toUpperCase());

      // If it matches then...
      if (wordIndex >= 0) {
        let fishElement = document.createElement("div");

        // Make the matching letters bold
        fishElement.innerHTML = fish_names[i].substr(0, wordIndex);
        fishElement.innerHTML += "<strong>" + fish_names[i].substr(wordIndex, param.length) + "</strong>";
        fishElement.innerHTML += fish_names[i].substr(wordIndex + param.length);

        // Insert the matched element in the autoComplete list
        autoCompleteContainer.appendChild(fishElement);

        // If the element is clicked upon then the 'searchField' value becomes the own clicked element's name
        fishElement.addEventListener('click', function(e) {
          searchField.value = fish_names[i];

          emptyList(autoCompleteContainer);
        });
      }
    }
  });

  // Empties the elements in the 'autocomplete-list'
  function emptyList(autoCompleteContainer) {
    if (autoCompleteContainer) autoCompleteContainer.innerHTML = '';
  }
}

export { autoCompleteFish };
