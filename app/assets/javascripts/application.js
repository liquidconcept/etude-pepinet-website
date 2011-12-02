// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require modernizr
//= require jquery
//= require jquery_ujs
//= require jquery.pjax
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

var switchTeamMember = function(event) {
  var button    = $(event.currentTarget),
      direction = button.parent().hasClass('previous') ? 'previous' : 'next',
      current   = $('.team article:not(:hidden)'),
      target    = undefined;

  event.preventDefault();

  if ($('.team article:not(:hidden)').queue('fx').length !== 0) {
    _.delay(switchTeamMember, 100, event);
    return true;
  }

  if (direction == 'previous') {
    target = current.prev();
    if (target.length === 0) {
      target = $('.team article').last()
    }

    target.css({left: '-=700px'}).show();
    $('.team article:not(:hidden)').animate({left: '+=700px'}, function() {
      current.hide().css({left: '0px'});
    });
  } else {
    target = current.next();
    if (target.length === 0) {
      target = $('.team article').first()
    }

    target.css({left: '+=700px'}).show();
    $('.team article:not(:hidden)').animate({left: '-=700px'}, function() {
      current.hide().css({left: '0px'});
    });
  }
}

var showRandomTeamMember = function() {
  $(_.shuffle($('#main .team article').hide())[0]).show();
}

var clickWithPjax = function(event) {
  if (!Modernizr.history) {
    return true;
  }
  event.preventDefault();

  var href = $(this).attr('href');

  $(this).addClass('active').closest('li').siblings().find('a').removeClass('active');
  if (href == '/') {
    $('html').addClass('homepage');
    $.pjax({
      url: href,
      container: '#main',
      success: function() {
        $('#overlay').animate({opacity: 0}, 800);
      }
    });
  } else {
    $('#overlay').animate({opacity: 0.85}, function() {
      $.pjax({
        url: href,
        container: '#main',
        success: function() {
          $('html').removeClass('homepage');
          showRandomTeamMember(); // only occure on team page
        }
      });
    });
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

  // Initialize pjax on menu
  $('body > header a, body > footer a').on('click', clickWithPjax);
  $('#main').on('click', '.news h3 a', clickWithPjax);

  // Initialize team member switcher
  $('#main').on('click', '.team button', switchTeamMember);
  showRandomTeamMember();

  // Fade in content (only occure on browser with Histroy capability)
  $('body').children().fadeIn(2000);
});

