// Function that displays the error messages related with certain input of the Log form
function displayLogFormErrors(inputType, errorMessage) {
  // Get the Log form input field
  let inputField = document.getElementById(`log_${inputType}`);

  // If the error message is empty, then turn the input field valid
  if (errorMessage == "") {
    inputField.className = "form-control is-valid";

  // Otherwise...
  } else {
    // Turn the input field invalid
    inputField.className = "form-control is-invalid";

    // Add the error message to its container
    let errorsContainer = document.querySelector(`.${inputType}_input`);
    errorsContainer.innerHTML = errorMessage;
  }
}

export { displayLogFormErrors };
