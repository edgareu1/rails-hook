// Function that creates an autocomplete list for fish name suggestions
// Arguments:
//   fishInput: Input field where the user searches for the fish
function autoCompleteFish(fishInput) {
  // Define two variables to follow the number of items in the autocomplete
  // list and the currently selected item
  let ItemIndexCounter, selectedItemIndex;
  // Each time the user writes on the "fishInput"...
  fishInput.addEventListener("input", (event) => {
    // Use the gem "gon" to call the Fish controller variable "fish_names",
    // which is an array of fish to search into
    const fishNames = gon.fish_names.split(", ");
    // Search param
    const param = event.target.value.trim();
    // Autocomplete list is empty
    ItemIndexCounter = -1;
    // No item is selected
    selectedItemIndex = -1;
    // Get the autocomplete list
    let autoCompleteList = document.getElementById("autocomplete-list");
    // If the autocomplete list doesn't exist, then create it

    if (!autoCompleteList) {
      autoCompleteList = document.createElement("div");
      autoCompleteList.setAttribute("id", "autocomplete-list");
      fishInput.parentNode.appendChild(autoCompleteList);
      // If the autocomplete list already exists, then empty it
    } else {
      emptyList();
    }

    // If the search param is empty, then just refresh the Fish#index page
    if (param === "") {
      refreshPageSearch(param);
      return;
    }

    // Iterate over the array of fish
    for (let i = 0; i < fishNames.length; i++) {
      // Check if the item matches the search param (which happens when the
      // index is different from -1)
      let wordIndex = fishNames[i].toUpperCase().indexOf(param.toUpperCase());

      // If it matches, then add the fish to the autocomplete list
      if (wordIndex >= 0) {
        ItemIndexCounter++;
        // Make sure the maximum number of matches displayed is 5
        if (ItemIndexCounter > 4) break;
        let fishElement = document.createElement("div");
        // Save the index of the item in a data attribute
        fishElement.setAttribute("data-index", ItemIndexCounter);
        // Make the matching letters bold
        fishElement.innerHTML = fishNames[i].substr(0, wordIndex);
        fishElement.innerHTML +=
          "<strong>" +
          fishNames[i].substr(wordIndex, param.length) +
          "</strong>";
        fishElement.innerHTML += fishNames[i].substr(wordIndex + param.length);
        // Insert the matched item in the autocomplete list
        autoCompleteList.appendChild(fishElement);

        // If the item is clicked upon, then fill the "fishInput" with that
        // item value
        fishElement.addEventListener("click", () => {
          fishInput.value = fishNames[i];
          // Refresh the Fish#index page with the clicked item as a search
          // param
          refreshPageSearch(fishInput.value);
          emptyList();
        });

        // When the user hovers the mouse over an item, it gets "selected"
        fishElement.addEventListener("mouseover", () => {
          selectedItemIndex = fishElement.getAttribute("data-index");
          removeSelected();
          addSelected();
        });
      }
    }
    // Refresh the Fish#index page with the search param
    refreshPageSearch(param);
  });

  // When the user presses down a key on the "fishInput"...
  fishInput.addEventListener("keydown", (event) => {
    // Only advance if the autocomplete list exists and has items
    let autoCompleteList = document.getElementById("autocomplete-list");
    if (!autoCompleteList || autoCompleteList.childElementCount == 0) return;

    // If the arrow DOWN key is pressed, then the "selected" item becomes the
    // one with +1 index value
    if (event.keyCode == 40) {
      selectedItemIndex++;
      removeSelected();
      addSelected();
      // If the arrow UP key is pressed, then the "selected" item becomes the
      // one with -1 index value
    } else if (event.keyCode == 38) {
      selectedItemIndex--;
      removeSelected();
      addSelected();
      // If the ENTER key is pressed, then prevent the form from being
      // submitted and simulate the click on the "selected" item
    } else if (event.keyCode == 13) {
      event.preventDefault();
      autoCompleteList = autoCompleteList.getElementsByTagName("div");
      if (selectedItemIndex > -1) autoCompleteList[selectedItemIndex].click();
    }
  });

  // Function that empties the autocomplete list if the event is outside of the
  // "fishInput" and the autocomplete list
  function closeAutoCompleteList(event) {
    if (
      event.target.hasAttribute("data-index") ||
      event.target.id == "search-input"
    ) {
      return;
    }
    emptyList();
  }

  // Uppon the User clicking in a normal device
  document.addEventListener("click", closeAutoCompleteList);
  // Upoon the User touching in a mobile device
  document.addEventListener("touchstart", closeAutoCompleteList);

  // Function that empties the autocomplete list
  function emptyList() {
    let autoCompleteList = document.getElementById("autocomplete-list");
    if (autoCompleteList) autoCompleteList.innerHTML = "";
  }

  // Function that uses jQuery to refresh the Fish#index page with a certain
  // search param
  function refreshPageSearch(param) {
    $.getScript(`/fish?query=${param}&commit=Search`);
  }

  // Function that removes the "selected" classification from the previous
  // "selected" item
  function removeSelected() {
    let selectedElement = document.querySelector(".autocomplete-selected");
    if (selectedElement) {
      selectedElement.classList.remove("autocomplete-selected");
    }
  }

  // Function that marks the new selected item as "selected"
  function addSelected() {
    let autoCompleteList = document.querySelectorAll("#autocomplete-list div");
    if (selectedItemIndex >= autoCompleteList.length) selectedItemIndex = 0;
    if (selectedItemIndex < 0) selectedItemIndex = autoCompleteList.length - 1;
    autoCompleteList[selectedItemIndex].classList.add("autocomplete-selected");
  }
}

export { autoCompleteFish };
