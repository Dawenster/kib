$(document).ready(function(){
  $("body").on("click", ".main-cta", function() {
    scrollToAnchor("how-it-works");
  })

  function scrollToAnchor(anchorID){
    var anchorElement = $("#" + anchorID);
    $('html,body').animate({scrollTop: anchorElement.offset().top},'slow');
  }
})