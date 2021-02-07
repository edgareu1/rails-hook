// Function that displays a loading icon while the page loads
// Arguments:
//   loadingAnchor: Element where the loading icon will appear
function loadingIcon(loadingAnchor) {
  loadingAnchor.addEventListener("click", () => {
    loadingAnchor.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
  });
}

export { loadingIcon };
