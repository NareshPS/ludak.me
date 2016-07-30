function openStoryImageOverlay(source)
{
  var w = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
  var h = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;

  var overlay = document.getElementById("story-image-overlay-div")
  overlay.style.display = "block";

  var overlayImage = document.getElementById("story-image-overlay-img")
  overlayImage.src = source
  overlayImage.style.maxHeight = h + 'px'
  overlayImage.style.maxWidth = w + 'px'
}

function closeStoryImageOverlay()
{
  var overlay = document.getElementById("story-image-overlay-div")
  overlay.style.display = "none";
}

/*hide masthead on scroll down.*/
$(function() {
  var mastheadElem = document.querySelector('#masthead');
  var mastheadHeadroom  = new Headroom(mastheadElem);
  mastheadHeadroom.init();
});
