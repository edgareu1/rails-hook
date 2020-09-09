import places from 'places.js';

const locationAutoComplete = (addressInput) => {
  places( { container: addressInput } );
};

export { locationAutoComplete };
