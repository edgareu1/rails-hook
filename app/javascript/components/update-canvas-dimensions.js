// Function that updates the Canvas dimensions to fill the whole window of the Users device
// The parameter is the canvas to which the dimensions is to be updated
function updateCanvasDimensions(canvas) {
  // Get the height and width of the Users device
  let windowWidth = window.innerWidth;
  let windowHeight = window.innerHeight;

  // Set the canvas dimensions to be equal to the ones of the Users device
  canvas.width = windowWidth;
  canvas.height = windowHeight;

  // Set the canvas container dimensions to equal to the ones of the Users device
  canvas.style.width = `${windowWidth}px`;
  canvas.style.height = `${windowHeight}px`;
};

export { updateCanvasDimensions };
