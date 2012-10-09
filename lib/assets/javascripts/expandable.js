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