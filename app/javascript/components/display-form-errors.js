// Function that displays an error message in a form
// Arguments:
//   errorSelector: Selector of the specific input error container; E.g.: 'log_new_start_time', 'catch_quantity'
//   errorMessage:  Error message to append to the form
function displayFormErrors(errorSelector, errorMessage) {
  let inputField = document.getElementById(errorSelector); // Get the input field

  // If the error message is empty, then mark the input field as valid
  if (errorMessage == "") {
    inputField.classList.remove("is-invalid");
    inputField.classList.add("is-valid");

  // Otherwise...
  } else {
    // Mark the input field as invalid
    inputField.classList.remove("is-valid");
    inputField.classList.add("is-invalid");

    // Add the error message to its container
    let errorsContainer = document.querySelector(`.${errorSelector}_error`);
    errorsContainer.innerHTML = errorMessage;
  }
}

export { displayFormErrors };
