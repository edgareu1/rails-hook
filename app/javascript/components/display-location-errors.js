// Function that displays the error message related with the Location input of the Log form
function displayLocationErrors(errorMessageText) {
  // Get the Log forms Location input field
  let locationInput = document.getElementById('log_location_id');

  // If the error message is empty, then make the Location input field as valid
  if (errorMessageText == "") {
    locationInput.className = "form-control is-valid";

  // Otherwise...
  } else {
    // Make the Location input field as invalid
    locationInput.className = "form-control is-invalid";

    // Add the error message to its container
    let locationErrorsContainer = document.querySelector('.location-input');
    locationErrorsContainer.innerHTML = errorMessageText;
  }
}

export { displayLocationErrors };
