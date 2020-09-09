function autoCompleteFish(searchField) {
  searchField.addEventListener('keyup', (event) => {
    const { value } = event.target;                 // Search param
    const fish_names = gon.fish_names.split(', ');  // Array of Fish to search into

    // Create the 'autocomplete-list' Div
    let autoCompleteContainer = document.createElement("div");
    autoCompleteContainer.setAttribute("id", "autocomplete-list");

    // Insert the 'autocomplete-list' in the document
    searchField.parentNode.insertBefore(autoCompleteContainer, searchField.nextSibling);

    searchField.parentNode.style.position = 'relative';

    // Iterate over the array of Fish
    for (let i = 0; i < fish_names.length; i++) {
      // Check if the element matches the search param
      let wordIndex = fish_names[i].toUpperCase().indexOf(value.toUpperCase());

      // If it matches then...
      if (wordIndex >= 0) {
        let fishElement = document.createElement("div");

        // Make the matching letters bold
        fishElement.innerHTML = fish_names[i].substr(0, wordIndex);
        fishElement.innerHTML += "<strong>" + fish_names[i].substr(wordIndex, value.length) + "</strong>";
        fishElement.innerHTML += fish_names[i].substr(wordIndex + value.length);

        // Insert the matched element in the autoComplete list
        autoCompleteContainer.appendChild(fishElement);
      }
    }
  });
}

export { autoCompleteFish };
