$(document).ready(function() {
  var inside_country = false;
  $("#open-country-select").click(function() {
    $("#country-select").show();
    return false;
  });

  $("#country-select").hover(function() {
    inside_country = true;
  }, function() {
    inside_country = false;
  });

  $("body").mouseup(function() {
    if (!inside_country) $("#country-select").hide();
  });

  $('#my-modal').modal({backdrop:true});
  $('#my-modal').bind('hidden', function () {
    $("#country-select").hide();
  });

});