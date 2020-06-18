import zoom from 'jquery-zoom';

$(document).on('turbolinks:load', function() {
  $('.full-size-image')
    .wrap('<span style="display: inline-block"></span>')
    .css('display', 'block')
    .parent()
    .zoom({
      magnify: 2
  });
});
