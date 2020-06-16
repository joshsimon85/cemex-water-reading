import { ImagePreview } from './image_preview';

$(document).on('turbolinks:load', function() {
  new ImagePreview('water_meter_reading_image').init();
});
