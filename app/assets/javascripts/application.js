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

var fixSize = function() {
  var windowWidth  = $(window).width(),
      windowHeight = $(window).height();

  // background image
  var imageWidth   = $('#background').width(),
      imageHeight  = $('#background').height(),
      widthRatio   = windowWidth  / imageWidth,
      heightRatio  = windowHeight / imageHeight,
      widthDiff    = windowWidth  - imageWidth;

  if (widthRatio < heightRatio) {
    $('#background').css({ width: 'auto', height: '100%', left: (widthDiff < 0 ? widthDiff / 2 : 0) + 'px' });
  } else {
    $('#background').css({ width: '100%', height: 'auto', left: '0px' });
  }

  // footer position
  if (windowHeight < parseInt($('body > content').css('min-height')) + $('#main').offset().top + $('body > footer').outerHeight(true)) {
    $('body > footer').css({ position: 'relative' });
  } else {
    $('body > footer').css({ position: 'fixed' });
  }
}

$(document).on('ready', function() {
  // Hide content to show only background image
  if (Modernizr.history) {
    $('body').children(':not(img)').hide();
  }

  // Call function to fix appearance depending on the size
  fixSize();
  $(window).on('resize', fixSize);

  // Fade in content
  $('body').children().fadeIn(2000);
});

