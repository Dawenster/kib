$(document).ready(function(){
  var assignableSwitch = document.querySelector(".assignable-switch");
  if (assignableSwitch) {
    var init = new Switchery(assignableSwitch, {color: "#28a5d4"});
    assignableSwitch.onchange = function() {
      var url = $(this).data("url");
      var assignable = assignableSwitch.checked;
      setAssignableOnUser(url, assignable)
    };
  }

  function setAssignableOnUser(url, assignable) {
    $.ajax({
      url: url,
      method: "put",
      data: {
        assignable: assignable
      }
    }).done(function(data) {
      if (data.message) {
        // swal("Success!", data.message, "success")
      } else {
        swal("Oops", data.errors, "error");
      }
    })
  }
})