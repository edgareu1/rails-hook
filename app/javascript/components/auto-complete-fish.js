// Create an autocomplete list for the Fish search while refreshing the Fish#index page automatically (using AJAX)
// based on the search parameter
function autoCompleteFish(searchField) {
  // Define two variables to follow both the items indexes and the currently selected item index
  let indexCounter, selectedItemIndex;

  // Each time the user writes on the 'searchField', then...
  searchField.addEventListener('input', (event) => {
    // Use the gem 'gon' to call the Fish Controller variable 'fish_names'
    const fishNames = gon.fish_names.split(', ');   // Array of Fish to search into
    const param = event.target.value.trim();        // Search param striped of trailing whitespaces

    indexCounter = -1;      // The autocomplete list is empty
    selectedItemIndex = -1;   // No item is selected

    let autoCompleteList = document.getElementById("autocomplete-list"); // Get the autocomplete list

    // If the autocomplete list does not exist, then create it
    if (!autoCompleteList) {
      autoCompleteList = document.createElement("div");
      autoCompleteList.setAttribute("id", "autocomplete-list");

      let searchFieldContainer = searchField.parentNode;
      searchFieldContainer.appendChild(autoCompleteList);

      // Make sure the position of the autocomplete list is relative to the 'searchField'
      searchFieldContainer.style.position = 'relative';

    // If the autocomplete list already exists, then empty it
    } else {
      emptyList();
    }

    // If the param is empty, then just refresh the Fish#index Page
    if (param === '') {
      refreshPageSearch(param);
      return;
    };

    // Iterate over the array of Fish
    for (let i = 0; i < fishNames.length; i++) {
      // Check if the item matches the search param
      let wordIndex = fishNames[i].toUpperCase().indexOf(param.toUpperCase());

      // If it matches, then add the Fish to the autocomplete list
      if (wordIndex >= 0) {
        // Make sure the maximum number of matches displayed is 5
        indexCounter++;
        if (indexCounter > 4) break;

        let fishElement = document.createElement("div");

        // Save the index of the item in a data attribute
        fishElement.setAttribute('data-index', indexCounter);

        // Make the matching letters bold
        fishElement.innerHTML = fishNames[i].substr(0, wordIndex);
        fishElement.innerHTML += "<strong>" + fishNames[i].substr(wordIndex, param.length) + "</strong>";
        fishElement.innerHTML += fishNames[i].substr(wordIndex + param.length);

        // Insert the matched item in the autocomplete list
        autoCompleteList.appendChild(fishElement);

        // If the item is clicked upon, then the 'searchField' is filled with that item's value
        fishElement.addEventListener('click', function(e) {
          searchField.value = fishNames[i];

          refreshPageSearch(searchField.value); // Refresh the Fish#index Page with the clicked item as a search param
          emptyList();
        });

        // Each time the user hovers it's mouse over the item makes it the 'selected' item
        fishElement.addEventListener("mouseover", function(e) {
          selectedItemIndex = fishElement.getAttribute('data-index');
          removeSelected();
          addSelected();
        });
      }
    }

    refreshPageSearch(param); // Refresh the Fish#index Page with the search param
  });

  // Each time the user presses down a key on the 'searchField'...
  searchField.addEventListener("keydown", function(e) {
    // Only advance if the autocomplete list exists and has items
    let autoCompleteList = document.getElementById("autocomplete-list");
    if ((!autoCompleteList) || autoCompleteList.childElementCount == 0) return;

    // If the arrow DOWN key is pressed, then the 'selected' item becomes the one with +1 index value
    if (e.keyCode == 40) {
      selectedItemIndex++;
      removeSelected();
      addSelected();

    // If the arrow UP key is pressed, then the 'selected' item becomes the one with -1 index value
    } else if (e.keyCode == 38) {
      selectedItemIndex--;
      removeSelected();
      addSelected();

    // If the ENTER key is pressed, then prevent the form from being submitted and simulate the click on the
    // 'selected' item
    } else if (e.keyCode == 13) {
      e.preventDefault();

      autoCompleteList = autoCompleteList.getElementsByTagName("div");
      if (selectedItemIndex > -1) autoCompleteList[selectedItemIndex].click();
    }
  });

  // If the user clicks outside the 'searchField' or the autocomplete list, then empty the autocomplete list
  document.addEventListener("click", function(e) {
    if (e.target.hasAttribute('data-index') || e.target.id == 'search-input') return;
    emptyList();
  });

  // Empty the autocomplete list
  function emptyList() {
    let autoCompleteList = document.getElementById("autocomplete-list");
    if (autoCompleteList) autoCompleteList.innerHTML = '';
  }

  // Use jQuery to refresh the Fish#index Page based on that search param
  function refreshPageSearch(param) {
    $.getScript(`/fish?query=${param}&commit=Search`);
  }

  // Remove the 'selected' classification from the previous 'selected' item
  function removeSelected() {
    let autoCompleteList = document.getElementById("autocomplete-list")
                                .getElementsByTagName("div");

    let selectedElement = document.getElementsByClassName('autocomplete-selected')[0];
    if (selectedElement) selectedElement.classList.remove("autocomplete-selected");
  }

  // Get the new 'selected' item (which highlights the item)
  function addSelected() {
    let autoCompleteList = document.getElementById("autocomplete-list")
                                .getElementsByTagName("div");

    if (selectedItemIndex >= autoCompleteList.length) selectedItemIndex = 0;
    if (selectedItemIndex < 0) selectedItemIndex = (autoCompleteList.length - 1);

    autoCompleteList[selectedItemIndex].classList.add("autocomplete-selected");
  }
}

export { autoCompleteFish };
