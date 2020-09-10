import places from 'places.js';

const autoCompleteLocation = (addressInput) => {
  places( { container: addressInput } );
};

export { autoCompleteLocation };
