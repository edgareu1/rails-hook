function autoCompleteFish(searchField) {
  searchField.addEventListener('keyup', (event) => {
    const { value } = event.target;                 // Search param
    const fish_names = gon.fish_names.split(', ');  // Array of Fish to search into

    for (let i = 0; i < fish_names.length; i++) {
      // Iterate over the array of Fish and check if the element includes the search param
      if (fish_names[i].toUpperCase().includes(value.toUpperCase())) {
        console.log(fish_names[i]);
      }
    }
  });
}

export { autoCompleteFish };
