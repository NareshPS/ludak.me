var storyImageOverlayImg = '#story-image-overlay-img'
var storyImageOverlayDiv = '#story-image-overlay-div'

/*open story image overlay*/
function openStoryImageOverlay(source, caption)
{
  var w = $(window).width();
  var h = $(window).height();

  $(storyImageOverlayDiv).css("display","block");

  $(storyImageOverlayImg).attr('src', source)
  $(storyImageOverlayImg).attr('alt', caption)
  $(storyImageOverlayImg).css("maxWidth", w);
  $(storyImageOverlayImg).css("maxHeight", h);
}

/*close story image overlay*/
function closeStoryImageOverlay()
{
  $(storyImageOverlayDiv).css("display","none");
}

/*hide masthead on scroll down.*/
$(function() {
  var mastheadElem = document.querySelector('#masthead');
  var mastheadHeadroom  = new Headroom(mastheadElem);
  mastheadHeadroom.init();
});

/*reload story image overlay on resize*/
$(window).resize(function() {
  if ($(storyImageOverlayDiv).is(":visible"))
  {
    openStoryImageOverlay($(storyImageOverlayImg).attr("src"));
  }
});
