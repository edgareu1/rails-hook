// Function that creates and appends a flash with a certain text (flashText) to the body of the document
function createFlash(flashText) {
  // Create alert 'div'
  var div = document.createElement('div');
  div.classList = `alert alert-dismissible fade show m-1`;
  div.setAttribute("role", "alert");

  // Add text to the alert
  var alert = document.createTextNode(flashText);
  div.appendChild(alert);

  // Create closing button
  var button = document.createElement('button');
  button.setAttribute("type", "button");
  button.classList = 'close';
  button.setAttribute("data-dismiss", "alert");
  button.setAttribute("aria-label", "Close");

  // Button 'X' symbol
  var span = document.createElement('span');
  span.setAttribute("aria-hidden", "true");
  span.innerHTML = '&times;';

  button.appendChild(span);
  div.appendChild(button);

  // Append 'div' to the body of the document
  document.body.appendChild(div);
}

export { createFlash };
