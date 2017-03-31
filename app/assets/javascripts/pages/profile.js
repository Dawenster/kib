$(document).ready(function(){
  $(".dataTable").DataTable({
    searching: false,
    lengthChange: false,
    paging: false,
    info: false,
    ordering: true,
    order: [[ 1, 'asc' ]]
  });

  var assignableSwitch = document.querySelector(".assignable-switch");
  if (assignableSwitch) {
    var init = new Switchery(assignableSwitch, {color: "#28a5d4"});
    assignableSwitch.onchange = function() {
      console.log(assignableSwitch.checked)
    };
  }

})