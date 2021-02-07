// Function that makes the pagination anchors scroll to the beginning of the
// page in a smooth manner
function smoothPagination() {
  // Get the anchors of the pagination
  const anchors = document.getElementsByClassName("page-link");

  // For each of the anchors...
  for (let anchor of anchors) {
    const anchorRef = anchor.href;

    // If the anchor has a page destination...
    if (typeof anchorRef !== "undefined") {
      // Ajaxify the anchor
      anchor.setAttribute("data-remote", "true");

      // Upon clicking on the anchor...
      anchor.addEventListener("click", (event) => {
        // Prevent the anchor default click behavior
        event.preventDefault();

        // Use jQuery to perform a scrolling animation to the top of the page
        // 250 is the time (in milliseconds) the animation is going to take
        $("html, body").animate(
          {
            scrollTop: 0,
          },
          250
        );
      });
    }
  }
}

export { smoothPagination };
