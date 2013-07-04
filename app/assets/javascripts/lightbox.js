// Overlay
var overlayToggle = window.overlayToggle = function(el, options) {
  options = _.defaults(options || {}, {
    loader: true
  });

  el = $(el);
  if (el.has('.overlay_lightbox').length === 0) {
    el.css('position', 'relative');
    var overlay = $('<div class="overlay_lightbox"><div class="background" /></div>');
    if (options.loader) {
      overlay.append('<div class="loader" />');
    }
    overlay.appendTo(el).fadeIn();
  } else {
    el.children('.overlay_lightbox').fadeOut(function() {
      $(this).remove();
    });
  }
}

scrollbarWidth = (function() {
  var $inner = jQuery('<div style="width: 100%; height:200px;">test</div>'),
  $outer = jQuery('<div style="width:200px;height:150px; position: absolute; top: 0; left: 0; visibility: hidden; overflow:hidden;"></div>').append($inner),
  inner = $inner[0],
  outer = $outer[0];

  jQuery('body').append(outer);
  var width1 = inner.offsetWidth;
  $outer.css('overflow', 'scroll');
  var width2 = outer.clientWidth;
  $outer.remove();

  return (width1 - width2);
})();

// LightBox Show
var lightboxShow = function() {
  var item_class = $(this).first();
  scrollPosition = $(window).scrollTop();

  $('#details article').show();
  $('body > *:not(#details)').wrapAll('<div class="wrapper" />').parent()
  .css({
    position: 'fixed',
    top: '0',
    'margin-top': -scrollPosition + 'px',
    width: '100%'
  });
  $('section#main').css('padding-right', scrollbarWidth + 'px');
  $(window).scrollTop(0);

  $('body').css({
    height: Math.max($(window).outerHeight() - ($('#details').outerHeight(true) - $('#details').outerHeight()), $('#details').outerHeight()),
    'padding-bottom': $(window).outerHeight() <= $('#details').outerHeight() ? '50px' : '0px'
  });

  overlayToggle($('body'), { loader: false });
  $('body > .overlay_lightbox').css({
    height: $('section#main > div').outerHeight(),
  });

  $('#details').fadeIn();

  // var item = _.find(items, function(item, key) { return item.index === parseInt(item_class.match(/\d+/)[0]) });
  // History.setLocation({item: item.key });
  // _gaq.push(['_trackPageview', '/items/' + item.key]);
}

// LightBox Hide
var hideDetail = function(){
  overlayToggle($('body'));

  $('#details').fadeOut(function() {
    $('section#main').css('padding-right', 0);
    $('header, section.content, footer').unwrap();
    $(window).scrollTop(scrollPosition);
    $('#details article').hide();
    $('body').css('height', '100%');
  });

  History.resetLocation();
  _gaq.push(['_trackPageview', '/']);
}