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
import { bottom_fish } from '../components/bottom_fish';
import { background_profile } from '../components/background_profile';
import { updateCanvasSize } from '../components/update_canvas_size';

import { initAutocomplete } from '../plugins/init_autocomplete';
import { autoComplete } from '../plugins/fish_algolia_auto_complete';

document.addEventListener('turbolinks:load', () => {
  initAutocomplete();
  let fishContainer = document.querySelector("#jsi-flying-fish-container");
  if (fishContainer) {
    bottom_fish();
  }

  let fishTank = document.querySelector("#fishtank");
  if (fishTank) {
    background_profile();

    let canvas = document.querySelector('canvas');
    updateCanvasSize(canvas);

    window.addEventListener('resize', () => {
      updateCanvasSize(canvas);
    });
  }

  let searchField = document.getElementById("search-input");
  if (searchField) {
    autoComplete();
  }
});
