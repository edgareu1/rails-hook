// Function that displays an error message in a form
// Arguments:
//   errorSelector: Selector of the errors container;
//                  Eg: "log_new_time_errors", "catch_new_errors"
//   errorMessage:  Error message to display in the form
function displayFormErrors(errorSelector, errorMessage) {
  let errorsContainer = document.getElementById(errorSelector);
  errorsContainer.innerHTML = errorMessage;
}

export { displayFormErrors };
