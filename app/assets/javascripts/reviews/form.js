$(document).ready(function(){
  checkToTriggerOther();

  $("#review_reason_for_taking_seminar").change(function() {
    checkToTriggerOther();
  })

  function checkToTriggerOther() {
    var selectedText = $("#review_reason_for_taking_seminar option:selected").val()
    if (selectedText == "Other") {
      $(".hidden-reason-for-taking-seminar").removeClass("hidden")
    } else {
      $(".hidden-reason-for-taking-seminar").addClass("hidden")
    }
  }
})
