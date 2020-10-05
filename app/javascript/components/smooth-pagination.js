// Function that make the pagination anchors scroll to the beginning of the page in a smooth manner
function smoothPagination() {
  const anchors = document.getElementsByClassName("page-link"); // Get the anchors of the pagination

  // For each of the anchors...
  for (let anchor of anchors) {
    const anchorRef = anchor.href;

    // If the anchor has a page destination, then...
    if (typeof anchorRef !== "undefined") {
      anchor.setAttribute("data-remote", "true"); // Ajaxify the anchor

      // Upon clicking on the anchor...
      anchor.addEventListener('click', (event) => {
        event.preventDefault(); // Prevent the anchors default click behavior

        // Use jQuery to perform a scrolling animation to the top of the page
        // 250 is the time (in milliseconds) the animation is going to take
        $("html, body").animate( {
          scrollTop: 0
        }, 250);
      });
    }
  }
}

export { smoothPagination };
