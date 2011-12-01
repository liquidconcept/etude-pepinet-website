// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require modernizr
//= require jquery
//= require jquery_ujs
//= require underscore

$(function() {

  var backgroundResize = function() {
    var imageWidth   = $('.background').width(),
        imageHeight  = $('.background').height(),
        windowWidth  = $(window).width(),
        windowHeight = $(window).height(),
        widthRatio   = windowWidth  / imageWidth,
        heightRatio  = windowHeight / imageHeight;

    if (widthRatio < heightRatio) {
      $('.background').css({ width: 'auto', height: '100%', left: (windowWidth - imageWidth) / 2 + 'px' });
    } else {
      $('.background').css({ width: '100%', height: 'auto', left: '0px' });
    }
  }

  backgroundResize();
  $(window).on('resize', backgroundResize);
});
