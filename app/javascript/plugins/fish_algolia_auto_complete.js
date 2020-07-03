
const algoliasearch = require("algoliasearch");
const client = algoliasearch(process.env.APPLICATION_ID, process.env.API_KEY);
const index = client.initIndex("Fish");
const autoComplete = () => {
    const searchField = document.getElementById("search-input");
    searchField.addEventListener('keyup', (event) => {
        const { value } = event.target
        index
        .search(value)
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
        })
        console.log(hits);
        })
        .catch(err => {
        console.log(err);
        });
    });    
}

export { autoComplete };