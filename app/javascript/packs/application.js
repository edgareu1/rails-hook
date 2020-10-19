// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";

// Internal imports
import { autoCompleteFish } from '../components/auto-complete-fish';
import { autoCompleteLocation } from '../components/auto-complete-location';
import { backgroundFish } from '../components/background-fish';
import { bottomFish } from '../components/bottom-fish';
import { createFlash } from '../components/create-flash';
import { displayFormErrors } from '../components/display-form-errors';
import { loadingIcon } from '../components/loading-icon';
import { smoothPagination } from '../components/smooth-pagination';
import { updateCanvasDimensions } from '../components/update-canvas-dimensions';

// Make the following JS functions accessible from HTML files
window.autoCompleteLocation = function(locationInput) {
  autoCompleteLocation(locationInput);
}

window.createFlash = function(flashText) {
  createFlash(flashText);
}

window.displayFormErrors = function(formType, inputType, errorMessage) {
  displayFormErrors(formType, inputType, errorMessage);
}

window.smoothPagination = function() {
  smoothPagination();
}

// Upon loading a page, also load the following JS functions
document.addEventListener('turbolinks:load', () => {
  // If in a page with pagination...
  let cardsList = document.getElementById('cards-list');
  if (cardsList) {
    smoothPagination(); // Smooth the pagination
  }

  // If in the Fish#index page...
  let fishInput = document.getElementById('search-input');
  if (fishInput) {
    autoCompleteFish(fishInput);  // Autocomplete the Fish name
  }

  // If in a page with a Locations#new form...
  let locationInputs = document.querySelectorAll('#location_name');
  if (locationInputs[0]) {
    for (let i = 0; i < locationInputs.length; i++) {
      autoCompleteLocation(locationInputs[i]);  // Autocomplete the Locations address
    }
  }

  // If in the Users#show page...
  let canvas = document.getElementById('fish-tank');
  if (canvas) {
    backgroundFish();               // Add the background canvas animation
    updateCanvasDimensions(canvas); // Resize the background canvas animation to the dimensions of the Users device

    // If the user resizes his device window, update the background canvas animation dimensions
    window.addEventListener('resize', () => {
      updateCanvasDimensions(canvas);
    });
  }

  // If in the Devise/registration or session pages...
  let bottomFishContainer = document.querySelector('#jsi-flying-fish-container');
  if (bottomFishContainer) {
    bottomFish(); // Add the bottom canvas animation
  }

  // If there is a navbar...
  let predictionAnchor = document.querySelector('a[href="/prediction"]');
  if (predictionAnchor) {
    loadingIcon(predictionAnchor);  // Add the loading animation while the app executes the prediction in the background
  }
});
