// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery.remotipart
//= require jquery-ui
//= require jquery.ui.touch.punch.min
//= require jquery.tinycarousel.min
//= require jquery.cycle.all
//= require jquery.waypoints.min
//= require jquery.charcounter
//= require jquery.validationEngine-en
//= require jquery.validationEngine
//= require jquery.bootstrap.confirm.popover
//= require jquery.bookmark
//= require jquery.textfill
//= require jquery.Jcrop
//= require modernizr
//= require fullcalendar.min
//= require twitter/bootstrap
//= require_self
//= require_tree
//= require expandable

function customerSupportDialog() {
 $("#fdbk_tab").click();
}

function showIndicator(elem, html_attr) {
  if (arguments.length == 2) {
    elem.after("<span class='save-indicator' style=" + html_attr +"><img src='/assets/loading.gif' alt='' /></span>");
  } else {
    elem.after("<span class='save-indicator'><img src='/assets/loading.gif' alt='' /></span>");
  }
}

function showRightIndicator(elem) {
  elem.after("<span class='save-indicator right'><img src='/assets/loading.gif' alt='' /></span>");
}

function showSavedIndicator(elem) {
  elem.parent().find('.save-indicator').html("<span class='label success'>" + t('save') + "</span>");
  window.setTimeout(function() {
    hideIndicator(elem);
  }, 2000);
}

function showErrorIndicator(elem) {
  // $('#place_zip').validationEngine('showPrompt', 'Invalid format of zipcode', 'load');
  $(elem).validationEngine('showPrompt', 'Error', 'load');
}

function validateElement(elem) {
  if ($('#wizard_form').validationEngine('validateField', elem)) {
    elem.toggleClass("error");
    return true
  } else {
    elem.toggleClass("error");
    return false
  }
}

function hideIndicator(elem) {
  elem.parent().find('.save-indicator').detach();
}

function add_datepicker() {
  $('.from-to-picker').datepicker('destroy').datepicker({
    // dateFormat: 'dd/mm/yy',
    dateFormat: 'yy-mm-dd',
    minDate: +1,
    onSelect: function(selectedDate) {
      var me = $(this);
      var who = me.attr("data-date");
      var instance = me.data("datepicker");

      var date = $.datepicker.parseDate(
            instance.settings.dateFormat ||
            $.datepicker._defaults.dateFormat,
            selectedDate, instance.settings);

      if (who == 'from') {
        from = me.next();
        from.datepicker("option", "minDate", date);
      } else {
        to = me.prev();
        to.datepicker("option", "maxDate", date);
      }
    }
  });
}

function getAmenityCheckBoxes(select_id) {
  ag_checkboxes = null;
  if( select_id != null && select_id != '' && select_id != 'undefined') {
    fieldset_id = select_id.substr(select_id.indexOf('_')+1,select_id.length);
    ag_checkboxes = $("#" + fieldset_id +" label").find("input[type=checkbox]");
  }
  return ag_checkboxes;
}

$(document).ready(function() {
  $("#registerForm").submit(function(e) {
    var isChecked = $('#terms_and_conditions').is(':checked');
    if(!isChecked) {
      alert("Please check 'I accept the terms and conditions' to continue");
      e.preventDefault();
    }
  });

  $('.alert-message').remove();
  $("#contact_form").validationEngine("attach",{
    promptPosition : "bottomRight:-10,-10",
    relative : true,
    onValidationComplete : function(form, status){
      if(status == true){
        $("#contact_button").button('loading');
        form.validationEngine('detach');
        form.submit();
	  }
    }
  });

  if ($("#contact_form").length > 0) {
  	$("#contact_submit").click(function(){

  		$(".contact_error").hide();
  		var hasError = false;
  		var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;

  		if ($('#contact_name').val() == '') {
  			$("#contact_name").after('<span class="contact_error">Please enter your Name.</span>');
  			hasError = true;
  		}

  		if ($("#contact_email").val() == '') {
  			$("#contact_email").after('<span class="contact_error">Please enter your email address.</span>');
  			hasError = true;
  		}
  		else
  			if (!emailReg.test($("#contact_email").val())) {
  				$("#contact_email").after('<span class="contact_error">Enter a valid email address.</span>');
  				hasError = true;
  			}

  		var message = $.trim($('#contact_query').val());
  		if (message == null || message == '' || message.indexOf('\n') > 0) {
  			$("#contact_query").after('<span class="contact_error">Please enter Message.</span>');
  			hasError = true;
  		}

  		return !hasError;
  	});
  }

  $("form.validated").validationEngine();

  $("a.tooltip, a[rel=tooltip], a[rel='tooltip nofollow'], button[rel=tooltip], a.tooltip-link").tooltip({
      animation: false,
      placement: 'top',
  });

  $('a[rel=popover], a.popover-link').popover();

  $('.dropdown-toggle').dropdown();

  $.waypoints.settings.scrollThrottle = 30;

  $('.navbar-wrapper').waypoint(function(event, direction) {
    $('.navbar').toggleClass('navbar-fixed-top', direction === "down");
    event.stopPropagation();
  });

  $('[id^=all_amenity_group_]').click(function(event) {
  	event.preventDefault();
    select_id = $(this)[0].id;
    ag_checkboxes = getAmenityCheckBoxes(select_id);

    if(ag_checkboxes != null) {
      ag_checkboxes.attr('checked', 'checked');
    }
  });

  $('[id^=none_amenity_group_]').click(function(event) {
  	event.preventDefault();
    select_id = $(this)[0].id;
    ag_checkboxes = getAmenityCheckBoxes(select_id);
    if(ag_checkboxes != null) {
      ag_checkboxes.attr('checked', false);
    }
  });
});

var Expandable = {
  initialize: function(selector){
  var container = $(selector);
  container.find('.expandable').each(function(){
    var section = $(this);
    section.find('.inner').hide();
    section.addClass('collapsed');
    section.click(function(){
    if(section.hasClass('collapsed')){
      section.find('a').hide();
      section.find('.inner').slideDown('slow');
      section.removeClass('collapsed');
      return false;
    } else {
      section.find('a').show();
      section.find('.inner').slideUp('slow', function(){
        section.addClass('collapsed');
      });
    }
    })
  })
  }
}