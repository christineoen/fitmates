$(function() {

  $('.edit-profile').on('click', function(){
    console.log(this);
    $(this).hide();
    $('.age-wrapper').html("<textarea></textarea>" + "<button class='edit-submit'>Submit</button>");

  })

});