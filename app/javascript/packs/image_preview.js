class ImagePreview {
  constructor(fileID) {
    this.fileInput = document.getElementById(fileID);
    this.imagePreview = document.querySelector('#preview');
    this.imageThumbnail = document.querySelector('#thumbnail');
  }
  readImage(e) {
    const reader = new FileReader();
    const file = e.target.files[0];
    const self = this;

    if (file.type.indexOf('image') === -1) {
      console.log('The file is not an image');
      return;
    }

    reader.addEventListener('load', (e) => {
      self.imagePreview.src = e.target.result;
      self.imageThumbnail.src = e.target.result;
      $('#image-actions').toggleClass('d-none', false);
      document.querySelector('input[type="submit"]').classList.toggle('d-none', false);
    });

    reader.readAsDataURL(file);
  }
  removeImage(e) {
    e.preventDefault();

    this.imagePreview.src = '';
    this.imageThumbnail.src = '';
    $('#image-actions').toggleClass('d-none', true);
    $('input[type="submit"]').toggleClass('d-none', true);
    this.fileInput.value = '';
  }
  bindEvents() {
    this.fileInput.addEventListener('change', this.readImage.bind(this));
    $('body').on('click', '#delete', this.removeImage.bind(this));
  }
  init() {
    this.bindEvents();
  }
}

export { ImagePreview }
