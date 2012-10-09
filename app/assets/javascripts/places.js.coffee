PlaceFilters =
  initialize : (containerId) ->
    container = $(containerId)

    $("#new_search").bind('ajax:complete', PlaceFilters.loadingIndicatorOff)

    # Top filters
    $("#search_guests, #search_sort_by").change(PlaceFilters.search)

    # Initialize the date pickers
    $('.check-in-picker, .check-out-picker').datepicker('destroy').datepicker
      dateFormat: 'yy-mm-dd',
      minDate: +1,
      onSelect: (selectedDate) ->
        # we only refresh results if both calendar pickers are not empty
        checkin  = $('.check-in-picker').val()
        checkout = $('.check-out-picker').val()
        PlaceFilters.search() if (checkin != "") && (checkout != "")

        who = $(@).attr("data-date")
        instance = $(@).data("datepicker")

        date = $.datepicker.parseDate(
          instance.settings.dateFormat || $.datepicker._defaults.dateFormat
          selectedDate
          instance.settings)

        if who == 'from'
          from = $(@).next()
          from.datepicker("option", "minDate", date)
        else
          to = $(@).prev()
          to.datepicker("option", "maxDate", date)

    # Sticky filters
    #$(".search-aside-wrapper").height $(".search-aside").height()
    $(".search-bar-wrapper").height   $(".search-bar").height()
    $(".search_filter_wrapper").height   $(".search_filter").height()

    $('.search_filter_wrapper,.search-bar-wrapper').waypoint(
      (event, direction) ->
        $(@).children().toggleClass('sticky', direction == "down")
        event.stopPropagation()
      offset: 60)  # NOTE: when you change this, goto application.css.less -> .sticky and change top attr

    @.initializeViews()
    @.initializeScroll()

  search: ->
    $('html, body').animate({scrollTop: 0}, '1000')
    PlaceFilters.loadingIndicatorOn()
    $('#submitted_action').val('filter')
    $('#search_current_page').val(1)
    $('#new_search').submit()

  seeMore: ->
    $('#submitted_action').val('see_more');
    page = parseInt($('#search_current_page').val())
    $('#search_current_page').val(page + 1)
    $('#see_more_load_indicator').show()
    $('#new_search').submit()

  initializeViews: ->
    $("#disp-gallery").click ->
      $(".show-grid").show()
      $(".list-display").hide()
      $(@).addClass('current')
      $("#disp-list").removeClass('current')
      false

    $("#disp-list").click ->
      $(".list-display").show()
      $(".show-grid").hide()
      $(@).addClass('current')
      $("#disp-gallery").removeClass('current')
      false

  initializeScroll: ->
    nearBottomOfPage = ->
      $(window).scrollTop() > $(document).height() - $(window).height() - 200

    lastPage = ->
      $('#search_current_page').val() >= $('#search_total_pages').val()

    # Endless scroll
    $(window).scroll ->
      return if PlaceFilters.loading
      PlaceFilters.seeMore() if nearBottomOfPage() && !lastPage()

  bindTypeFilters: (field) ->
    # Type filters
    container = $('#' + field + '_filter');
    container.find('input').click ->
      ids = []
      container.find('input').each ->
        ids.push($(@).val()) if $(@).is(":checked")
      $('#search_' + field).val(ids.join());
      PlaceFilters.search()

  bindPriceFilters: ->

  loadingIndicatorOn: ->
    PlaceFilters.loading = true
    $('#search_load_indicator').show()
    $("#search_results").css('opacity', '.3')

  loadingIndicatorOff: ->
    PlaceFilters.loading = false
    $('.results > #search-load-indicator').remove()
    $('#see_more_load_indicator').hide()
    $('#search_load_indicator').hide()
    $('#search_results').css('opacity', '1')

window.PlaceFilters = PlaceFilters