function openStoryImageOverlay(source)
{
  var w = $(window).width();
  var h = $(window).height();

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

/*reload story image overlay on resize*/
$(window).resize(function() {
  if ($("#story-image-overlay-div").is(":visible"))
  {
    openStoryImageOverlay($("#story-image-overlay-img").attr("src"));
  }
});
