var storyImageOverlayImg = '#story-image-overlay-img'
var storyImageOverlayDiv = '#story-image-overlay-div'
var storyImageOverlayCaption = '#story-image-overlay-caption'
var storyImageOverlayContentDiv = '#story-image-overlay-content-div'

/*open story image overlay*/
function openStoryImageOverlay(source, caption)
{
  $(storyImageOverlayDiv).css("display","block");

  $(storyImageOverlayContentDiv).css('width', $(window).width());
  $(storyImageOverlayContentDiv).css('height', $(window).height());

  $(storyImageOverlayImg).attr('src', source);
  $(storyImageOverlayImg).attr('alt', caption);
  $(storyImageOverlayImg).css("maxWidth", $(window).width());
  $(storyImageOverlayImg).css("maxHeight", $(window).height());

  $(storyImageOverlayCaption).html(caption);
}

/*reload story image overlay caption*/
function reloadStoryImageOverlayCaption()
{
  var captionDivLeftPos = $(storyImageOverlayImg).css('margin-left');
  var captionDivBottomPos = $(storyImageOverlayImg).css('margin-bottom');


  $(storyImageOverlayCaption).css('left', captionDivLeftPos);
  $(storyImageOverlayCaption).css('bottom', captionDivBottomPos);
  $(storyImageOverlayCaption).css('width', $(storyImageOverlayImg).width());
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
      openStoryImageOverlay($(storyImageOverlayImg).attr("src"), $(storyImageOverlayCaption).html());
      reloadStoryImageOverlayCaption();
    }
  });

$(function ()
  {
    /*onClick handler for story image overlay image*/
    $(storyImageOverlayImg).on('click', function()
      {
        $(storyImageOverlayDiv).css("display","none");
      });

    /*onClick handler for story image overlay caption*/
    $(storyImageOverlayCaption).on('click', function()
      {
        if ($(storyImageOverlayImg).attr('alt') != '')
        {
          $(storyImageOverlayCaption).html('');
          $(storyImageOverlayCaption).css('width', '5px');
        }
        else
        {
          $(storyImageOverlayCaption).html($(storyImageOverlayImg).attr('alt'));
          $(storyImageOverlayCaption).css('width', $(storyImageOverlayImg).width());
        }
      });

    /*update story image overlay caption on image load*/
    $(storyImageOverlayImg).on('load', function()
      {
        reloadStoryImageOverlayCaption();
      });
  });
