$(document).ready(function(){
  $("#seminar_scheduled_at").datepicker({
    autoclose: true,
    format: "mm/dd/yyyy"
  }).datepicker("setDate", new Date());
})
