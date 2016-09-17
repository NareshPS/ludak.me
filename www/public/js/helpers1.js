
var mastheadContainerD = '#masthead-container'
var mastheadContainerQ = '.masthead-container'

/*hide masthead on scroll down.*/
$(function()
    {
      new Headroom(document.querySelector(mastheadContainerQ)).init();
    });
