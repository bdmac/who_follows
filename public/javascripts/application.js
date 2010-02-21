// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function() {
  $('.help_balloon').tooltip({
    showBody: " - ",
    showURL: false
  });
  $("#map_link").toggle(function() {
    $("#map_container").show();
    center_google_map();
  }, function() {
    $("#map_container").hide();
  });
  $(".search_submit").click(function() {
    $(".search_submit").hide();
    $(".filter").after(" <div class='loading_button' style='float:left'>Loading...</div>")
    $("#spinner").show();
    $("#results").hide();
  });
  $(".filter_link").click(function() {
    $("#spinner").show();
    $("#results").hide();
  });
});