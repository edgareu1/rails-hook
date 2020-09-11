function autoCompleteFish(searchField) {
  // Define two variables to follow both the items indexes and the currently selected item index
  let indexCounter, activeItemIndex;

  // Each time the user writes on the 'searchField', then...
  searchField.addEventListener('input', (event) => {
    // Use the gem 'gon' in order to call the Fish Controller variable 'fish_names'
    const fishNames = gon.fish_names.split(', ');   // Array of Fish to search into
    const param = event.target.value.trim();        // Search param striped of trailing whitespaces

    indexCounter = -1;      // No item is yet created
    activeItemIndex = -1;   // No item is selected

    let listContainer = document.getElementById("autocomplete-list"); // Get the List of the matched items

    // If the List does not exist, then create it
    if (!listContainer) {
      listContainer = document.createElement("div");
      listContainer.setAttribute("id", "autocomplete-list");

      searchField.parentNode.insertBefore(listContainer, searchField.nextSibling);

      // Make sure the position of the List is relative to the 'searchField'
      searchField.parentNode.style.position = 'relative';

    // If the List already exists, then empty it
    } else {
      emptyList();
    }

    // If the param is empty, then do not populate the List and refresh the Fish#index Page
    if (param === '') {
      refreshPageSearch(param);
      return;
    };

    // Iterate over the array of Fish
    for (let i = 0; i < fishNames.length; i++) {
      // Check if the item matches the search param
      let wordIndex = fishNames[i].toUpperCase().indexOf(param.toUpperCase());

      // If it matches, then add the Fish to the List
      if (wordIndex >= 0) {
        // Make sure the maximum number of matches displayed is 5
        indexCounter++;
        if (indexCounter > 4) break;

        let fishElement = document.createElement("div");

        // Save the index of the item in a data attribute
        fishElement.setAttribute('data-index', indexCounter);

        // Make the matching letter are bold
        fishElement.innerHTML = fishNames[i].substr(0, wordIndex);
        fishElement.innerHTML += "<strong>" + fishNames[i].substr(wordIndex, param.length) + "</strong>";
        fishElement.innerHTML += fishNames[i].substr(wordIndex + param.length);

        // Insert the matched item in the List
        listContainer.appendChild(fishElement);

        // If the item is clicked upon, then the 'searchField' value becomes the that item's value
        fishElement.addEventListener('click', function(e) {
          searchField.value = fishNames[i];

          refreshPageSearch(searchField.value); // Refresh the Fish#index Page with the clicked item as a search param
          emptyList();
        });

        // Each time the user hovers it's mouse over the item makes it the 'active' item
        fishElement.addEventListener("mouseover", function(e) {
          activeItemIndex = fishElement.getAttribute('data-index');
          removeActive();
          addActive();
        });
      }
    }

    refreshPageSearch(param); // Refresh the Fish#index Page with the search param
  });

  // Each time the user presses down a key on the 'searchField'...
  searchField.addEventListener("keydown", function(e) {
    // Only advance if the List exists and has items
    let listContainer = document.getElementById("autocomplete-list");
    if ((!listContainer) || listContainer.childElementCount == 0) return;

    // If the arrow DOWN key is pressed, then the 'active' item becomes the one with +1 index value
    if (e.keyCode == 40) {
      activeItemIndex++;
      removeActive();
      addActive();

    // If the arrow UP key is pressed, then the 'active' item becomes the one with -1 index value
    } else if (e.keyCode == 38) {
      activeItemIndex--;
      removeActive();
      addActive();

    // If the ENTER key is pressed, then prevent the form from being submitted and simulate the click on the 'active' item
    } else if (e.keyCode == 13) {
      e.preventDefault();

      listContainer = listContainer.getElementsByTagName("div");
      if (activeItemIndex > -1) listContainer[activeItemIndex].click();
    }
  });

  // If the user clicks outside the 'searchField' or the 'List' empty the 'List'
  document.addEventListener("click", function(e) {
    if (e.target.hasAttribute('data-index') || e.target.id == 'search-input') return;
    emptyList();
  });

  // Empty the 'List'
  function emptyList() {
    let listContainer = document.getElementById("autocomplete-list");
    if (listContainer) listContainer.innerHTML = '';
  }

  // Use jQuery to refresh the Fish#index Page based on that search param
  function refreshPageSearch(param) {
    $.getScript(`/fish?query=${param}&commit=Search`);
  }

  // Remove the 'active' classification from the previous 'active' item
  function removeActive() {
    let listContainer = document.getElementById("autocomplete-list")
                                .getElementsByTagName("div");

    let activeElement = document.getElementsByClassName('autocomplete-active')[0];
    if (activeElement) activeElement.classList.remove("autocomplete-active");
  }

  // Get the new 'active' item (which highlights the item)
  function addActive() {
    let listContainer = document.getElementById("autocomplete-list")
                                .getElementsByTagName("div");

    if (activeItemIndex >= listContainer.length) activeItemIndex = 0;
    if (activeItemIndex < 0) activeItemIndex = (listContainer.length - 1);

    listContainer[activeItemIndex].classList.add("autocomplete-active");
  }
}

export { autoCompleteFish };
