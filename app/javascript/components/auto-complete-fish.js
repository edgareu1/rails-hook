function autoCompleteFish(searchField) {
  // Define a variable to follow the currently selected item
  let activeItem;

  // Each time the user writes on the 'searchField', then...
  searchField.addEventListener('input', (event) => {
    const param = event.target.value.trim();        // Search param striped of trailing whitespaces
    const fish_names = gon.fish_names.split(', ');  // Array of Fish to search into

    activeItem = -1;  // No item is selected

    let listContainer = document.getElementById("autocomplete-list"); // Get the List for the matched items

    // If the List does not exist, then create it and insert it in the document
    if (!listContainer) {
      listContainer = document.createElement("div");
      listContainer.setAttribute("id", "autocomplete-list");

      searchField.parentNode.insertBefore(listContainer, searchField.nextSibling);

      // Make sure the position of the List is relative to the 'searchField'
      searchField.parentNode.style.position = 'relative';

    // If the List already exists, then empty it
    } else {
      emptyList(listContainer);
    }

    if (param === '') return; // If the param is empty, then do not populate the List

    // Iterate over the array of Fish
    for (let i = 0; i < fish_names.length; i++) {
      // Check if the item matches the search param
      let wordIndex = fish_names[i].toUpperCase().indexOf(param.toUpperCase());

      // If it matches then add the Fish to the List
      if (wordIndex >= 0) {
        let fishElement = document.createElement("div");

        // Make the matching letters bold
        fishElement.innerHTML = fish_names[i].substr(0, wordIndex);
        fishElement.innerHTML += "<strong>" + fish_names[i].substr(wordIndex, param.length) + "</strong>";
        fishElement.innerHTML += fish_names[i].substr(wordIndex + param.length);

        // Insert the matched item in the List
        listContainer.appendChild(fishElement);

        // If the item is clicked upon then the 'searchField' value becomes the that item's name
        fishElement.addEventListener('click', function(e) {
          searchField.value = fish_names[i];

          emptyList(listContainer);
        });
      }
    }
  });

  // Each time the user presses down a key on the 'searchField', then...
  searchField.addEventListener("keydown", function(e) {
    // Only advance if the List exists and has items
    let listContainer = document.getElementById("autocomplete-list");
    if (!listContainer) return;
    listContainer = listContainer.getElementsByTagName("div");
    if (listContainer.length == 0) return;

    // If the arrow DOWN key is pressed, then increase the 'activeItem' variable and make it more visible
    if (e.keyCode == 40) {
      activeItem++;
      addActive(listContainer);

    // If the arrow UP key is pressed, then decrease the 'activeItem' variable and make it more visible
    } else if (e.keyCode == 38) {
      activeItem--;
      addActive(listContainer);

    // If the ENTER key is pressed, then prevent the form from being submitted and simulate the click on the 'activeItem'
    } else if (e.keyCode == 13) {
      e.preventDefault();
      if (activeItem > -1) listContainer[activeItem].click();
    }
  });

  // Empty the 'List'
  function emptyList(listContainer) {
    if (listContainer) listContainer.innerHTML = '';
  }

  // Make the 'activeItem' more visible
  function addActive(listContainer) {
    // Remove the classification of 'active' from the previous 'activeItem'
    let activeElement = document.getElementsByClassName('autocomplete-active')[0];
    if (activeElement) activeElement.classList.remove("autocomplete-active");

    // Add the classification of 'active' to the new 'activeItem'
    if (activeItem >= listContainer.length) activeItem = 0;
    if (activeItem < 0) activeItem = (listContainer.length - 1);

    listContainer[activeItem].classList.add("autocomplete-active");
  }
}

export { autoCompleteFish };
