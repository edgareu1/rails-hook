// Function that creates and appends to the body of the document a flash message with a certain text (flashText)
function createFlash(flashText) {
  // Remove existing flash messages from the document
  var flashesList = document.querySelectorAll('div.alert.alert-dismissible');
  for (let i = 0; i < flashesList.length; i++) {
    flashesList[i].remove();
  }

  // Create the flash 'div'
  var div = document.createElement('div');
  div.classList = `alert alert-dismissible fade show m-1`;
  div.setAttribute("role", "alert");

  // Add text to the flash
  var alert = document.createTextNode(flashText);
  div.appendChild(alert);

  // Create the closing button
  var button = document.createElement('button');
  button.classList = 'close';
  button.setAttribute("aria-label", "Close");
  button.setAttribute("data-dismiss", "alert");
  button.setAttribute("type", "button");

  // Add the 'X' symbol to the button
  var span = document.createElement('span');
  span.setAttribute("aria-hidden", "true");
  span.innerHTML = '&times;';
  button.appendChild(span);

  div.appendChild(button);        // Append the button to the flash
  document.body.appendChild(div); // Append the flash to the body of the document
}

export { createFlash };
