$(document).ready(function(){
  $("body").on("click", ".cancel-request-btn", function(e) {
    e.preventDefault();
    var url = $(this).data("url");
    var requestRole = $(this).data("request-role");
    var requestCourse = $(this).data("request-course");
    var descriptionText = "You are cancelling your request to be a " + requestRole + " for:" + "\n" + requestCourse

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
        method: "DELETE"
      }).done(function(data) {
        window.location.reload(false);
      })
    });
  })
})