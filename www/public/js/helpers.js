var storyImageOverlayImg = '#story-image-overlay-img'
var storyImageOverlayDiv = '#story-image-overlay-div'
var storyImageOverlayCaption = '#story-image-overlay-caption'
var storyImageOverlayContentDiv = '#story-image-overlay-content-div'

/*open story image overlay*/
function openStoryImageOverlay(source, caption)
{
  $(storyImageOverlayDiv).css("display","block");

  $(storyImageOverlayImg).attr('src', source);
  $(storyImageOverlayImg).attr('alt', caption);
  $(storyImageOverlayImg).css("maxWidth", $(window).width());
  $(storyImageOverlayImg).css("maxHeight", $(window).height());

  $(storyImageOverlayCaption).html(caption);
}

/*hide masthead on scroll down.*/
$(function() {
  var mastheadElem = document.querySelector('#masthead');
  var mastheadHeadroom  = new Headroom(mastheadElem);
  mastheadHeadroom.init();
});

/*reload story image overlay on resize*/
$(window).resize(function()
  {
    if ($(storyImageOverlayDiv).is(":visible"))
    {
      openStoryImageOverlay($(storyImageOverlayImg).attr("src"));
    }
  });

$(function ()
  {
    /*onClick handler for story image overlay image*/
    $(storyImageOverlayImg).on('click', function()
      {
        $(storyImageOverlayDiv).css("display","none");
      });

    /*update story image overlay caption on image load*/
    $(storyImageOverlayImg).on('load', function()
      {
        var imgOffset = $(storyImageOverlayImg).offset();

        $(storyImageOverlayCaption).css('left', imgOffset.left);
        $(storyImageOverlayCaption).css("width", $(storyImageOverlayImg).width());

        $(storyImageOverlayContentDiv).css("width", $(window).width());
        $(storyImageOverlayContentDiv).css("height", $(window).height());
      });
  });
