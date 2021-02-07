// Function that creates a flash message
// Arguments:
//   flashText: Fash message text
function createFlash(flashText) {
  // Remove existing flash messages from the document
  var flashesList = document.querySelectorAll("div.alert.alert-dismissible");

  for (let i = 0; i < flashesList.length; i++) {
    flashesList[i].remove();
  }

  // Create the flash "div"
  var div = document.createElement("div");
  div.classList = `alert alert-dismissible fade show m-1`;
  div.setAttribute("role", "alert");

  // Add a message to the flash
  var alert = document.createTextNode(flashText);
  div.appendChild(alert);

  // Create the closing button
  var button = document.createElement("button");
  button.classList = "close";
  button.setAttribute("aria-label", "Close");
  button.setAttribute("data-dismiss", "alert");
  button.setAttribute("type", "button");

  // Add the "X" symbol to the button
  var span = document.createElement("span");
  span.setAttribute("aria-hidden", "true");
  span.innerHTML = "&times;";
  button.appendChild(span);

  // Append the button to the flash
  div.appendChild(button);

  // Append the flash to the body of the document
  document.body.appendChild(div);
}

export { createFlash };
