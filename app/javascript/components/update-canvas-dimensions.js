// Update the Canvas (Fish Tank) size to fill the whole window of the user's device
function updateCanvasDimensions(canvas) {
  let windowWidth = window.innerWidth;
  let windowHeight = window.innerHeight;

  canvas.width = windowWidth;
  canvas.height = windowHeight;

  canvas.style.width = `${windowWidth}px`;
  canvas.style.height = `${windowHeight}px`;
};

export { updateCanvasDimensions };
