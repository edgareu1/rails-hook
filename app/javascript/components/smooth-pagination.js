// Function that makes the pagination anchors scroll up to the beginning of the page
function smoothPagination() {
  const anchors = document.getElementsByClassName("page-link"); // Get the anchors of the pagination

  // For each of the anchors do...
  for (let anchor of anchors) {
    const anchorRef = anchor.href;

    // Make sure the anchor has a page destination
    if (typeof anchorRef !== "undefined") {
      anchor.setAttribute("data-remote", "true"); // Ajaxify the anchor

      // Upon clicking on the anchor...
      anchor.addEventListener('click', (event) => {
        event.preventDefault(); // Prevent the anchor's default click behavior

        // Use jQuery to perform a scrolling animation to the top of the page
        $(".body-container").animate( {
          scrollTop: 0
        }, 250);
      });
    }
  }
}

export { smoothPagination };
