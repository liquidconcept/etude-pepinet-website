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
//= require jquery.scroll
//= require underscore

// function
// - fix background size & position
// - fix footer position
var fixSize = function() {
  var windowWidth  = $(window).width(),
      windowHeight = $(window).height();

  // background image
  var background   = $('#background'),
      imageWidth   = background.width(),
      imageHeight  = background.height(),
      widthRatio   = windowWidth  / imageWidth,
      heightRatio  = windowHeight / imageHeight,
      imageLeft    = windowWidth  - imageWidth;

  if (widthRatio < heightRatio) {
    background.css({ width: 'auto', height: '100%'});
    background.css({ left: -Math.abs((windowWidth - background.width()) / 2) }); // image width shoulb be recalculed to center image
  } else {
    background.css({ width: '100%', height: 'auto', left: '0px' });
  }

  // footer position
  if (windowHeight < parseInt($('#main').outerHeight(true)) + $('#main').offset().top + $('body > footer').outerHeight(true)) {
    $('body > footer').css({ position: 'relative' });
  } else {
    $('body > footer').css({ position: 'fixed' });
  }
}

// functiom
// - enable scrollbar on long content
var enableScrollbar = function() {
  var content = $('#main > section');

  if (content.length > 0) {
    content.css({ height: content.parent().height() - content.position().top - parseInt(content.css('margin-top')) - parseInt(content.css('padding-top')) });
    content.scrollbar();
  }
}

// function
// - switch member on team page
var switchTeamMember = function(event) {
  var direction, target,
      button    = $(this),
      current   = $('.team article:not(:hidden)');

  if (event) { event.preventDefault(); }

  // delay if slide animation is already active (on multiple click)
  if ($('.team article:not(:hidden)').queue('fx').length !== 0) {
    _.delay(function(that) { switchTeamMember.call(that) }, 100, this);
    return true;
  }

  // detect target & direct
  //
  // if user click on arrow button, direction is set by button clicked
  // and target is next or previous element
  if (button.parents('nav.people').length !== 0) {
    var targetIndex  = button.closest('li').index(),
        currentIndex = $('nav.people li.active').index();

        target       = $('.team article').eq(targetIndex);

    // abort if target is current member
    if (target.index() === current.index()) {
      return true;
    }

    if (targetIndex > currentIndex) {
      direction = 'next';
    } else {
      direction = 'previous';
    }
  // if user click on name button, direction is set by reltive position of
  // name to active name et target is set vy button clicked
  } else {
    direction = button.parent().hasClass('previous') ? 'previous' : 'next';

    if (direction == 'previous') {
      target = current.prev();
      if (target.length === 0) {
        target = $('.team article').last()
      }
    } else {
      target = current.next();
      if (target.length === 0) {
        target = $('.team article').first()
      }
    }
  }

  // slide member
  if (direction == 'previous') {
    target.css({left: '-=700px'}).show();
    $('.team article:not(:hidden)').animate({left: '+=700px'}, function() {
      current.hide().css({left: '0px'});
    });
  } else {
    target.css({left: '+=700px'}).show();
    $('.team article:not(:hidden)').animate({left: '-=700px'}, function() {
      current.hide().css({left: '0px'});
    });
  }

  // select active people menu
  if (!$('nav.people ul').data('hover')) {
    $('nav.people li.active button').animate({opacity: 0.2}, function() {
      $(this).closest('li').css({opacity: '', filter: '', zoom: ''}).removeClass('active');
    });
    $('nav.people button').eq(target.index()).animate({opacity: 1}, function() {
      $(this).closest('li').css({opacity: '', filter: '', zoom: ''}).addClass('active');
    });
  } else {
    $('nav.people li.active').removeClass('active');
    $('nav.people button').eq(target.index()).closest('li').addClass('active');
  }
}

// function
// - random member tp show on team page
var showRandomTeamMember = function() {
  var people = $('#main .team article').hide();
  var index  = people.index(_.shuffle(people)[0]);

  people.eq(index).show();
  $('nav.people li').eq(index).addClass('active');
}

// function
// - use pjax to call link if site support HTML5 histroy
var clickWithPjax = function(event) {
  if (!Modernizr.history) { return true; }
  event.preventDefault();

  // get link href
  var href = $(this).attr('href');

  // don't load link if it is current page
  if (window.location.href === href) { return false; }

  // switch active class on menu when user click on menu link
  $('body header a[href="' + href.match(/\/[^/]*/)[0] + '"]').addClass('active').closest('li').siblings().find('a').removeClass('active');

  // link go to homepage
  if (href == '/') {
    $('html').addClass('homepage'); // return on homepage
    $.pjax({
      url: href,
      timeout: 2000,
      container: '#main',
      success: function() {
        $('#overlay').animate({opacity: 0}, 800);  // remove overlay to show background image without filter
        enableScrollbar(); // re-initialize scrollbar on main content
      }
    });
  // link got to another page
  } else {
    $('#overlay').animate({opacity: 0.85}, function() { // add overlay to show image bacground with a filter
      $.pjax({
        url: href,
        timeout: 2000,
        container: '#main',
        success: function() {
          $('html').removeClass('homepage'); // not on homepage
          showRandomTeamMember(); // only occure on team page
          enableScrollbar(); // re-initialize scrollbar on main content
        }
      });
    });
  }
}

// initialization
$(function() {
  // Overlay is set on front of background until is loaded
  $('#overlay').addClass('on-load');

  // hide team members to avoid flash on load
  $('#main > section.team > section > article').hide();

  // Initialize when background image is loaded
  $('#background').on('load', function() {
    // Initialize size fix
    fixSize();
    $(window).on('resize', fixSize);

    // Initialize pjax on menu
    $('body > header a, body > footer a').on('click', clickWithPjax);
    $('#main').on('click', '.news h3 a', clickWithPjax);

    // Initialize team member switcher
    $('#main').on('click', '.team button', switchTeamMember);
    $('nav.people ul').hover(
      function() { $.data(this, 'hover', true); },
      function() { $.data(this, 'hover', false); }
    ).data('hover', false);
    _.defer(showRandomTeamMember);

    // Fade in content (only occure on browser with Histroy capability)
    if (Modernizr.history) {
      $('body').children(':not(#background)').hide(); // hide all ellements on front of background image
      $('#overlay').removeClass('on-load'); // site is loaded, ensure overlay is not on front

      $('body').children().fadeIn(2000, function() {
        _.defer(enableScrollbar); // Initialize scrollbar on main content
      });
    } else {
      $('#overlay').removeClass('on-load'); // hide overlay to show site
      _.defer(enableScrollbar); // Initialize scrollbar on main content
    }
  }).attr('src', $('#background').attr('src')); // ensure load event is fired
});

// add MSIE class to html tag
if (jQuery.browser.msie) {
  $('html').addClass('msie-' + parseInt(jQuery.browser.version));
}
