function displayTimeErrors(errorMessageText, action) {
  let startTime = document.getElementById(`log_${action}_start_time`);
  let endTime = document.getElementById(`log_${action}_end_time`);

  if (errorMessageText == "") {
    startTime.className = "form-control is-valid";
    endTime.className = "form-control is-valid";

  } else {
    startTime.className = "form-control is-invalid";
    endTime.className = "form-control is-invalid";

    let containerDateErrors = document.querySelector(`.simple_form.${action}_log .invalid-feedback.date-input`);
    containerDateErrors.innerHTML = errorMessageText;
  }
}

export { displayTimeErrors };
