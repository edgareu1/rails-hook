// Function that updates the Canvas dimensions to fill the whole window of the User device
// Arguments:
//   canvas: Canvas element that will have its dimensions updated
function updateCanvasDimensions(canvas) {
  // Get the height and width of the User device
  let windowWidth = window.innerWidth;
  let windowHeight = window.innerHeight;

  // Set the canvas dimensions to be equal to the ones of the User device
  canvas.width = windowWidth;
  canvas.height = windowHeight;

  // Set the canvas container dimensions to equal to the ones of the User device
  canvas.style.width = `${windowWidth}px`;
  canvas.style.height = `${windowHeight}px`;
}

export { updateCanvasDimensions };
