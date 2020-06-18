import { ImageZoom } from './image_zoom';

$(window).on('turbolinks:load', function() {
  new ImageZoom('.full-size-image', 2).init();
});
