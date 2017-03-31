$(document).ready(function(){
  $(".dataTable").DataTable({
    searching: false,
    lengthChange: false,
    paging: false,
    info: false,
    ordering: true,
    order: [[ 1, 'asc' ]]
  });
})