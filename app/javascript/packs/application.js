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
import { displayTimeErrors } from '../components/display-time-errors';
import { updateCanvasDimensions } from '../components/update-canvas-dimensions';

// Make the following JS functions accessible from HTML files
window.autoCompleteLocation = function(addressInput) {
  autoCompleteLocation(addressInput);
}

window.autoCompleteFish = function(searchField) {
  autoCompleteFish(searchField);
}

window.displayTimeErrors = function(errorMessageText, action) {
  displayTimeErrors(errorMessageText, action);
}

// Upon loading a page, load the following JS functions
document.addEventListener('turbolinks:load', () => {
  let searchField = document.getElementById('search-input');
  if (searchField) {
    autoCompleteFish(searchField);
  }

  let addressInput = document.getElementById('location_name');
  if (addressInput) {
    autoCompleteLocation(addressInput);
  }

  let canvas = document.getElementById('fishtank');
  if (canvas) {
    backgroundFish();
    updateCanvasDimensions(canvas);

    window.addEventListener('resize', () => {
      updateCanvasDimensions(canvas);
    });
  }

  let bottomFishContainer = document.querySelector('#jsi-flying-fish-container');
  if (bottomFishContainer) {
    bottomFish();
  }
});
