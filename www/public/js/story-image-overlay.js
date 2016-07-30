/* Story image overlay */

function openStoryImageOverlay(source)
{
  var overlay = document.getElementById("story-image-overlay-div")
  var overlayImage = document.getElementById("story-image-overlay-img")
  var w = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
  var h = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;

  overlay.style.display = "block";

  overlayImage.src = source
  overlayImage.style.maxHeight = h + 'px'
  overlayImage.style.maxWidth = w + 'px'
}

function closeStoryImageOverlay()
{
  var overlay = document.getElementById("story-image-overlay-div")
  overlay.style.display = "none";
}
