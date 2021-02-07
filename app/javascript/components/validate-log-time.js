// Function that adds validations to the Logs form time input
// Arguments:
//   action: Action of the form ("new" or "edit")
//   valid:  Boolean value that determines if the time input is valid or not
function validateLogTime(action, valid) {
  var dateInputs = document.querySelectorAll(
    `.${action}_log [type=datetime-local]`
  );

  for (let i = 0; i < dateInputs.length; i++) {
    if (valid) {
      dateInputs[i].classList.remove("is-invalid");
      dateInputs[i].classList.add("is-valid");
    } else {
      dateInputs[i].classList.remove("is-valid");
      dateInputs[i].classList.add("is-invalid");
    }
  }
}

export { validateLogTime };
