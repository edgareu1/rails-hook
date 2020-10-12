// Function that displays a loading icon while the page loads
function loadingIcon(loadingAnchor) {
  loadingAnchor.addEventListener('click', () => {
    loadingAnchor.innerHTML = "<i class=\"fas fa-spinner fa-spin\"></i>";
  });
}
