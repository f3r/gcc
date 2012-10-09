var UserEdit = {
  initialize: function(opts){
    // Tooltip generation
    $('div.private').tooltip(         {placement:"above" });
    $('div.fully_private').tooltip(   {placement:"above" });
    $('.public').tooltip(             {placement:"above" });

    $('#cancel_email_change').tooltip({ placement:"above"});

    // Validation Engine
    $("#new_password, #change_address, #update_user, #change_bank_account").validationEngine();

    // For Singapore we show local bank, on change, we show international bank
    $(".local_bank").hide();
    $(".international_bank").hide();
    $('#bank_account_holder_country_code').change(function() {
      $("input#bank_account_holder_country_name").val($(this).find("option:selected").text());
      if (this.value == "SG") {
        $(".local_bank").show();
        $(".international_bank").hide();
        $(".international_bank input").val("");
      } else {
        $(".international_bank").show();
        $(".local_bank").hide();
        $(".local_bank input").val("");
      }
    });

    // User uses avatar from their facebook profile
    $('a.facebook_avatar').click(function() {
      facebook_image = $('input#user_facebook_image').val();
      $('input#user_avatar_url').val(facebook_image);
      $('.avatar_placeholder').attr('src', facebook_image).width(100);
      $('input#user_avatar').hide();
    });

    // User uploads avatar
    $('a.upload_avatar').click(function() {
      $('a.upload_avatar').hide();
      $('input#user_avatar').show();
      $('input#user_avatar_url').val("");
    });

    $('#delete_avatar_link').click(function() {
      $('#user_delete_avatar').prop('checked', true);
      $('.avatar-box').hide();
      return false;
    });
  },

  readURL: function (input) {
    if (input.files && input.files[0])
    {
      $('#user_delete_avatar').prop('checked', false);
      $('.avatar-box').show();
      var reader = new FileReader();
      reader.onload = function (e) {
        $('.avatar_placeholder')
        .attr('src', e.target.result)
        .width(100)
      };
      reader.readAsDataURL(input.files[0]);
    }
  }
}