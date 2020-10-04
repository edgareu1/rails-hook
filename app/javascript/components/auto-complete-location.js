import places from 'places.js';

// Function that, from a search parameter, creates an autocomplete list for address suggestions
function autoCompleteLocation(locationInput) {
  places( { container: locationInput } );
};

export { autoCompleteLocation };
