//= require jquery
//= require jquery_ujs
//= require moment
//= require bootstrap-datetimepicker

$(function(){
  $("#js-header-menu").on("click", function(){
    $("#js-header-menu-list").toggle();
  });
  
  $("#js-slider-button").on("click", function(){
    $('#js-slider-menu').slideToggle('normal');
  });
})
