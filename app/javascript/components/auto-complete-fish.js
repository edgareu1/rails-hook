function autoCompleteFish(searchField) {
  searchField.addEventListener('keyup', (event) => {
    const { value } = event.target;                 // Search param
    const fish_names = gon.fish_names.split(', ');  // Array of Fish to search into

    console.log(value);
    console.log(fish_names);

    index.search(value)
          .then(({ hits }) => {
            const visibleIds = hits.map(fish => fish.id);
            const boxes = document.querySelectorAll('.fish_box');
            console.log(visibleIds);
            boxes.forEach(box => {
              const { id } = box.dataset;
              if (visibleIds.includes(parseInt(id)) || value === "") {
                box.style.display = "block"
              } else {
                box.style.display ="none"
              }
            });
            console.log(hits);
          })
          .catch(err => {
            console.log(err);
          });
  });
}

export { autoCompleteFish };
