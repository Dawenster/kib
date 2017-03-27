$(document).ready(function(){
  $(".has-tooltip").tooltip();
  $(".dataTable").DataTable({
    searching: false,
    lengthChange: false,
    paging: false,
    info: false,
    ordering: true,
    order: [[ 1, 'asc' ]]
  });
  $(".student-to-teaching-ratio-q").popover()
})