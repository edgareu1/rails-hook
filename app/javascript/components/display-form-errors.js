// Function that displays a error message (errorMessage) related with a certain input (inputType) in a
// certain form (formType)
function displayFormErrors(formType, inputType, errorMessage) {
  // Get the input field
  let inputField = document.getElementById(`${formType}_${inputType}`);

  // If the error message is empty, then turn the input field valid
  if (errorMessage == "") {
    inputField.classList.remove("is-invalid");
    inputField.classList.add("is-valid");

  // Otherwise...
  } else {
    // Turn the input field invalid
    inputField.classList.remove("is-valid");
    inputField.classList.add("is-invalid");

    // Add the error message to its container
    let errorsContainer = document.querySelector(`.${inputType}_input`);
    errorsContainer.innerHTML = errorMessage;
  }
}

export { displayFormErrors };
