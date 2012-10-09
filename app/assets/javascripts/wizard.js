//= require jquery.inlineedit

PhotoManager = {
  initialize: function(sortUrl, min_photo_count){
    this.min_photo_count = min_photo_count;
    this.initializePhotoSortable(sortUrl);
  },

  initializePhotoSortable: function(sortUrl){
    self = this;
    $('#photos_list').sortable({
        grid: [8,2],
        start: function(event, ui) {
          $(event.currentTarget).addClass('noclick');
        },
        stop: function(event, ui) {
          self.afterSort();

          $.ajax({
            type: 'PUT',
            url: sortUrl,
            data: $('#photos_list').sortable('serialize'),
            success: function() {
            }
          });
        }
    });

    self.afterSort();
    self.showLatestPhoto();

    $('#photos_list li').live('click', function(){
      if(!$(this).parent().hasClass('noclick')){
       PhotoManager.setPhoto($(this).find('img'));
      }
      $(this).parent().removeClass('noclick');
    });
  },
  afterSort: function(event, ui){
    $('#wizard_submit').attr('disabled', true);
    if($('#photos_list li').size() > 0) {
      $('.photos_wrapper').show();
    } else {
      $('.photos_wrapper').hide();
    }

    $('#photos_list li').removeClass("active");
    $('#photos_list li:first').addClass("active");

    $('#photos_list li').hover(function() {
      $(this).find(".photo_action").show();
    }, function() {
      $(this).find(".photo_action").hide();
    });
    if($('#photos_list li').size() >= this.min_photo_count) {
        $('#wizard_submit').attr('disabled', false);
    }
  },
  deletePhoto: function(photo){
    self = this;
    photo.fadeOut('slow', function(){
      photo.parent().remove();
      self.afterSort();
      self.showLatestPhoto();
    });
  },
  showLatestPhoto: function() {
    var photo = $('#photos_list li img').last();
    if(photo.size() > 0) {
      PhotoManager.setPhoto(photo);
    } else {
      $('.photo_wrapper').empty();
    }
  },
  insert: function(newList) {
    $('#photos_list').html(newList);
    this.afterSort();
    this.showLatestPhoto();
  },
  adjustScroll: function() {
    $('html').animate({scrollTop: $('.photo_wrapper').offset()['top'] - 60}, "slow");
  },
  setPhoto: function(photo) {
    $('.photo_wrapper').empty();

    var img_wrapper = $("<div class='active-photo well'></div>");

    var large_photo = photo.clone();
    large_photo.attr('src', large_photo.attr('data-large'));
    img_wrapper.append(large_photo);

    $('.photo_wrapper').append(img_wrapper);
    //this.adjustScroll();
  }
}

Cropper = {
  load: function(){
    $('#jcrop_target').Jcrop({
      bgOpacity: .3,
      aspectRatio: 1,
      allowMove: true,
      onChange: Cropper.updateDimensions,
      onSelect: Cropper.updateDimensions
      //setSelect: [ 100, 100, 50, 50 ]
    }, function(){
      var h = $('img#jcrop_target').height();
      var w = $('img#jcrop_target').width();
      $('#user_image_h').val(h);
      $('#user_image_w').val(w);
    });
  },
  updateDimensions: function(c){
    if (parseInt(c.w) > 0) {
      $('#user_crop_x').val(c.x);
      $('#user_crop_y').val(c.y);
      $('#user_crop_w').val(c.w);
      $('#user_crop_h').val(c.h);
    }
  }
};
