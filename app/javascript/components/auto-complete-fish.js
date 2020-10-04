// Function that, based on a search parameter, creates an autocomplete list and also refreshes the Fish#index page
// (using AJAX requests); The functions parameter is the input field where the user searches for the Fish name
function autoCompleteFish(fishInput) {
  // Define two variables to follow the number of items in the autocomplete list and the currently selected item index
  let ItemIndexCounter, selectedItemIndex;

  // Each time the user writes on the 'fishInput', then...
  fishInput.addEventListener('input', (event) => {
    // Use the gem 'gon' to call the Fish Controller variable 'fish_names', which is the array of Fish to search into
    const fishNames = gon.fish_names.split(', ');
    const param = event.target.value.trim();  // Search param striped of trailing whitespaces

    ItemIndexCounter = -1;    // The autocomplete list is empty
    selectedItemIndex = -1;   // No item is selected

    let autoCompleteList = document.getElementById("autocomplete-list"); // Get the autocomplete list

    // If the autocomplete list doesn't exist, then create it
    if (!autoCompleteList) {
      autoCompleteList = document.createElement("div");
      autoCompleteList.setAttribute("id", "autocomplete-list");

      let fishInputContainer = fishInput.parentNode;
      fishInputContainer.appendChild(autoCompleteList);

      // Make sure the position of the autocomplete list is relative to the 'fishInput'
      fishInputContainer.style.position = 'relative';

    // If the autocomplete list already exists, then empty it
    } else {
      emptyList();
    }

    // If the search param is empty, then just refresh the Fish#index page
    if (param === '') {
      refreshPageSearch(param);
      return;
    };

    // Iterate over the array of Fish
    for (let i = 0; i < fishNames.length; i++) {
      // Check if the item matches the search param (which happens when the index is not -1)
      let wordIndex = fishNames[i].toUpperCase().indexOf(param.toUpperCase());

      // If it matches, then add the Fish to the autocomplete list
      if (wordIndex >= 0) {
        // Make sure the maximum number of matches displayed is 5
        ItemIndexCounter++;
        if (ItemIndexCounter > 4) break;

        let fishElement = document.createElement("div");

        // Save the index of the item in a data attribute
        fishElement.setAttribute('data-index', ItemIndexCounter);

        // Make the matching letters bold
        fishElement.innerHTML = fishNames[i].substr(0, wordIndex);
        fishElement.innerHTML += "<strong>" + fishNames[i].substr(wordIndex, param.length) + "</strong>";
        fishElement.innerHTML += fishNames[i].substr(wordIndex + param.length);

        // Insert the matched item in the autocomplete list
        autoCompleteList.appendChild(fishElement);

        // If the item is clicked upon, then the 'fishInput' is filled with that item's value
        fishElement.addEventListener('click', function() {
          fishInput.value = fishNames[i];

          refreshPageSearch(fishInput.value); // Refresh the Fish#index page with the clicked item as a search param
          emptyList();
        });

        // Each time the user hovers it's mouse over the item makes it the 'selected' item
        fishElement.addEventListener("mouseover", function() {
          selectedItemIndex = fishElement.getAttribute('data-index');
          removeSelected();
          addSelected();
        });
      }
    }

    refreshPageSearch(param); // Refresh the Fish#index page with the search param
  });

  // Each time the user presses down a key on the 'fishInput'...
  fishInput.addEventListener("keydown", function(e) {
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

  // If the user clicks outside the 'fishInput' or the autocomplete list, then empty the autocomplete list
  document.addEventListener("click", function(e) {
    if (e.target.hasAttribute('data-index') || e.target.id == 'search-input') return;
    emptyList();
  });

  // Function that empties the autocomplete list
  function emptyList() {
    let autoCompleteList = document.getElementById("autocomplete-list");
    if (autoCompleteList) autoCompleteList.innerHTML = '';
  }

  // Function that uses jQuery to refresh the Fish#index page based on that search param
  function refreshPageSearch(param) {
    $.getScript(`/fish?query=${param}&commit=Search`);
  }

  // Function that removes the 'selected' classification from the previous 'selected' item
  function removeSelected() {
    let selectedElement = document.querySelector('.autocomplete-selected');
    if (selectedElement) selectedElement.classList.remove("autocomplete-selected");
  }

  // Function that marks the new selected item as 'selected' (which highlights it)
  function addSelected() {
    let autoCompleteList = document.querySelectorAll('#autocomplete-list div');

    if (selectedItemIndex >= autoCompleteList.length) selectedItemIndex = 0;
    if (selectedItemIndex < 0) selectedItemIndex = (autoCompleteList.length - 1);

    autoCompleteList[selectedItemIndex].classList.add("autocomplete-selected");
  }
}

export { autoCompleteFish };
