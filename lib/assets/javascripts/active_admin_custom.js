//= require redactor/redactor
//= require pluploader
//= require expandable

$(document).ready(function() {
	
    // uservoice scripts
    var uvOptions = {};
    (function() {
      var uv = document.createElement('script'); uv.type = 'text/javascript'; uv.async = true;
      uv.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'widget.uservoice.com/Mt9CkotxlGJTw3ceV0mnA.js';
      var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(uv, s);
    })();
    
    var csrf_token = $('meta[name=csrf-token]').attr('content');
    var csrf_param = $('meta[name=csrf-param]').attr('content');
    var params;
    if (csrf_param !== undefined && csrf_token !== undefined) {
      params = csrf_param + "=" + encodeURIComponent(csrf_token);
    }
    $('.tinymce').redactor({
      autoresize: false,
      imageUpload: '/admin/cmspages/image_upload?' + params,
      imageGetJson: '/admin/cmspages/images?' + params,
      wym: true,
      keyupCallback: function(obj, e) {
        Cmspage.isDirty = true;
      },
      buttons: ['html', '|', 'formatting', '|', 'bold', 'italic', '|',
      'unorderedlist', 'orderedlist', 'outdent', 'indent', '|',
      'image', 'video', 'file', 'table', 'link', '|',
      'fontcolor', '|',
      'alignleft', 'aligncenter', 'alignright', 'justify', '|',
      'horizontalrule']
    });


    $('#new_user #user_send_invitation').on('click', function(){
      if($(this).is(':checked')){
        $('#user_invitation_text').removeAttr('disabled');
      } else {
	$('#user_invitation_text').attr("disabled", "disabled");
      }
    }).triggerHandler('click');

    $("#custom_field_type_cd").on('change',function () {

      //First we hide all of them
      $("#custom_field_more_info_label_input").hide();
      $("#custom_field_date_format_input").hide();
      $("#custom_field_prefix_input").hide();
      $("#custom_field_values_input").show();

      switch($(this).val()) {
          case "0":
              $("#custom_field_prefix_input").show();
              break;
        case "5":
          $("#custom_field_more_info_label_input").show();
          //Break is left intentionally
        case "4":
          $("#custom_field_values_input").hide();
          break;
        case "6":
          $("#custom_field_date_format_input").show();
          $("#custom_field_values_input").hide();
          break;
      }
    }).triggerHandler('change');
	
    if ($("#help_menu").length > 0) {
      $("#help_menu a").attr('target','_blank') 
    }
});


$(function(){
    $(".datepicker").datepicker({dateFormat: 'yy-mm-dd'});

    $(".clear_filters_btn").click(function(){
        window.location.search = "";
        return false;
    });
});

var sendSortRequestOfModel;
sendSortRequestOfModel = function(model_name) {
    var formData;
    formData = $('#' + model_name + ' tbody').sortable('serialize');
    formData += "&" + $('meta[name=csrf-param]').attr("content") + "=" + encodeURIComponent($('meta[name=csrf-token]').attr("content"));
    return $.ajax({
        type: 'post',
        data: formData,
        dataType: 'script',
        url: '/admin/' + model_name + '/sort'
    });
};
jQuery(function($) {
    if ($('body.admin_cities.index').length) {
        $("#cities tbody").disableSelection();
        return $("#cities tbody").sortable({
            axis: 'y',
            cursor: 'move',
            update: function(event, ui) {
                return sendSortRequestOfModel("cities");
            }
        });
    }
});

jQuery(function($) {
    if ($('body.admin_frontpage_images.index').length) {
        $("#frontpage_images tbody").disableSelection();
        return $("#frontpage_images tbody").sortable({
            axis: 'y',
            cursor: 'move',
            update: function(event, ui) {
                return sendSortRequestOfModel("frontpage_images");
            }
        });
    }
});

jQuery(function($) {
    if ($('body.admin_currencies.index').length) {
        $("#currencies tbody").disableSelection();
        return $("#currencies tbody").sortable({
            axis: 'y',
            cursor: 'move',
            update: function(event, ui) {
                return sendSortRequestOfModel("currencies");
            }
        });
    }
});

jQuery(function($) {
    if ($('body.admin_custom_fields.index').length) {
        $("#currencies tbody").disableSelection();
        return $("#custom_fields tbody").sortable({
            axis: 'y',
            cursor: 'move',
            update: function(event, ui) {
                return sendSortRequestOfModel("custom_fields");
            }
        });
    }
});


jQuery(function($) {
    if ($('body.admin_gallery_items.index').length) {
        $("#gallery_items tbody").disableSelection();
        return $("#gallery_items tbody").sortable({
            axis: 'y',
            cursor: 'move',
            update: function(event, ui) {
                var formData = $('#gallery_items tbody').sortable('serialize');
                formData += "&" + $('meta[name=csrf-param]').attr("content") + "=" + encodeURIComponent($('meta[name=csrf-token]').attr("content"));

                return $.ajax({
                    type: 'post',
                    data: formData,
                    dataType: 'script',
                    url: document.location.pathname + '/sort'
                });
            }
        });
    }
});

jQuery(function($) {
    if ($('body.admin_locales.index').length) {
        $("#locales tbody").disableSelection();
        return $("#locales tbody").sortable({
            axis: 'y',
            cursor: 'move',
            update: function(event, ui) {
                return sendSortRequestOfModel("locales");
            }
        });
    }
});

jQuery(function($) {
    if ($('body.admin_preference_sections.index').length) {
        $("#preference_sections tbody").disableSelection();
        return $("#preference_sections tbody").sortable({
            axis: 'y',
            cursor: 'move',
            update: function(event, ui) {
                return sendSortRequestOfModel("preference_sections");
            }
        });
    }
});


jQuery(function($) {

    $( "#selected_pages, #available_pages" ).sortable({
        connectWith: ".connectedSortable",
        dropOnEmpty : true
    }).disableSelection();

    $("#selected_pages").bind('sortupdate', function(event,ui){
        var item = ui.item;
        var formData = $('meta[name=csrf-param]').attr("content") + "=" + encodeURIComponent($('meta[name=csrf-token]').attr("content"));
        formData += "&m_id=" + $('#menu_show').attr('data-menu-section-id');

        if(ui.sender != null)
        {
            //Drop Event
            formData += "&p_id=" + item.attr('data-p-id')
            return $.ajax({
                type: 'post',
                data: formData,
                url: '/admin/menu_sections/menuadd',
                success: function(data){
                    $("#selected_pages").children().remove();
                    $("#selected_pages").append(data);
                }
            });
        }
        else
        {
            var item_id = item.attr('id');

            if($('#selected_pages > #' + item_id).length)
            {
                formData += "&" + $("#selected_pages").sortable('serialize');
                return $.ajax({
                    type: 'post',
                    data: formData,
                    dataType: 'script',
                    url: '/admin/menu_sections/sort',
                    success: function(){
                    }
                });
            }
        }
    });


    $("#available_pages").bind('sortreceive', function(e,ui){
        if(ui.sender != null)
        {
            var removed_item = ui.item;
            var removed_menu_section_id = removed_item.attr('data-ms-id');
            var formData = $('meta[name=csrf-param]').attr("content") + "=" + encodeURIComponent($('meta[name=csrf-token]').attr("content"));
            formData += "&ms_id=" + removed_menu_section_id;
            formData += "&m_id=" + $('#menu_show').attr('data-menu-section-id');

            return $.ajax({
                type: 'post',
                data: formData,
                url: '/admin/menu_sections/menuremove',
                success: function(data){
                    $("#available_pages").children().remove();
                    $("#available_pages").append(data)

                    if($('#selected_pages').children().length == 0)
                    {
                        $('#selected_pages').append('<tr id = "dp_1"><td>You may drag&amp;drop any menu item here </td></tr>');
                    }
                }
            });
        }
    });
});

window.Cmspage =  new Object();
Cmspage.isDirty = false;

jQuery(function($) {
    if($('#cmspage_description').length)
    {
        Cmspage.load_page_version_to_editor = function (page_version)
        {
            $('#cmspage_description').setCode(page_version.content);
            Cmspage.isDirty = true;
        }

        $('#cmspage_submit_action input[type="submit"]').click(function(){
            Cmspage.isDirty = false;
        });

        window.onbeforeunload = function(e) {
            if (Cmspage.isDirty)
                return true;
            return null;
        };
    }
});

window.Translation = new Object();

jQuery(function($) {
    if($('#translation_value').length){

        $('div#versions_sidebar_section.sidebar_section div.panel_contents table tbody').tooltip({
            selector: "a[rel=tooltip]"
        });

        Translation.load_version = function(version) {
            $('#translation_value').val(version.value);
        }
    }
});


$(document).ready(function(){
    $('head').append("<link href='/assets/admin_favico.png' rel='icon' type='image/png'>");
});