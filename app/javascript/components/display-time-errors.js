// Function that displays the error message related with the start/end_time input of the Log form
// Parameters: errorMessageText   Error message to display in the Form;
//             action             Takes the value 'new' or 'edit' depending on the Form action;
function displayTimeErrors(errorMessageText, action) {
  // Get the Log form input fields for start/end_time
  let startTime = document.getElementById(`log_${action}_start_time`);
  let endTime = document.getElementById(`log_${action}_end_time`);

  // If the error message is empty, then make the start/end_time input fields as valid
  if (errorMessageText == "") {
    startTime.className = "form-control is-valid";
    endTime.className = "form-control is-valid";

  // Otherwise...
  } else {
    // Make the start/end_time input fields as invalid
    startTime.className = "form-control is-invalid";
    endTime.className = "form-control is-invalid";

    // Add the error message to its container
    let timeErrorsContainer = document.querySelector(`.${action}_log .time-input`);
    timeErrorsContainer.innerHTML = errorMessageText;
  }
}
