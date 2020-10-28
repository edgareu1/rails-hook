// Function that displays an error message in a form
// Arguments:
//   errorSelector: Selector of the errors container; Eg: 'log_new_start_time_error', 'catch_new_error'
//   errorMessage:  Error message to append to the form
function displayFormErrors(errorSelector, errorMessage) {
  let errorsContainer = document.querySelector(`.${errorSelector}`);
  errorsContainer.innerHTML = errorMessage;
}

export { displayFormErrors };
