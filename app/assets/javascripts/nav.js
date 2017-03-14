$("body").on("click", ".search-form-input-anchor", function(e) {
  debugger
  e.preventDefault();
  var baseUrl = $("#search-form").attr("action")
  var searchTerm = $('.search-form-input').val()
  var fullUrl = baseUrl + "?s=" + searchTerm
  document.location.href = fullUrl
})