$(document).ready(function(){
  $("body").on("click", ".mark-as-completed-btn", function(e) {
    e.preventDefault();
    var url = $(".mark-as-completed-form").attr('action');
    var valuesToSubmit = $(".mark-as-completed-form").serialize();
    var descriptionText = "You cannot edit the details of the class after you mark it as completed."

    swal({
      title: "Are you sure?",
      text: descriptionText,
      type: "warning",
      showCancelButton: true,
      confirmButtonText: "Yes",
      closeOnConfirm: false,
      showLoaderOnConfirm: true
    },
    function(){
      $("button.confirm").attr("disabled", "disabled")
      $.ajax({
        url: url,
        method: "POST",
        data: valuesToSubmit
      }).done(function(data) {
        window.location = $(".mark-as-completed-btn").data("return-url");
      })
    });
  })
})
