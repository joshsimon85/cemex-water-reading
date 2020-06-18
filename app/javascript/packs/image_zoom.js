import zoom from 'jquery-zoom';

class ImageZoom {
  constructor(selector, power) {
    this.selector = selector;
    this.power = power;
  }
  init() {
    $(this.selector)
      .wrap('<span style="display: inline-block"></span>')
      .css('display', 'block')
      .parent()
      .zoom({ magnify: this.power });

    return this;
  }
}

export { ImageZoom };
