import places from 'places.js';

// Function that creates an autocomplete list for address suggestions
// Arguments:
//   locationInput: Input field where the user searches for the address
function autoCompleteLocation(locationInput) {
  places( { container: locationInput } );
}

export { autoCompleteLocation };
