// loads a new image in storySliderElement div
$('#storySliderElement img').click(function(){
  $this = $(this);
  $image = $this.attr('full');
  $("#storyImage").hide().html('<img src="'+$image +'" />').fadeIn(2000);
});
