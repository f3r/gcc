PlaceShow =
  initialize: (opts) ->
    #*******************************************************************************************
    # INITIALIZERS
    #*******************************************************************************************
    isCalendarOpen = false
    @.initializePanoramas()
    @.initializeSlider()
    @.initializeSharePlace(opts.share_title, opts.share_url, opts.share_id)

    # Lazy Initialize Map and calendar
    $('a[data-toggle="tab"]').on('shown', (e) ->
      # Lazy load calendar
      if $(e.target).attr('href') == '#calendar-tab'
        if !isCalendarOpen
          self.PlaceShow.initializeCalendar(opts.cal_events, opts.cal_lastVisibleDay, opts.cal_month)
          isCalendarOpen = true

      # Lazy load map
      if $(e.target).attr('href') == '#map-tab'
        if opts.map_lat != 'null' && opts.map_lon != 'null'
          self.PlaceShow.initializeMap(opts.map_lat, opts.map_lon, opts.map_cityName, opts.map_countryName, opts.map_radius, "map")
    )

    if window.location.hash
      $('a[href="' + window.location.hash + '"]').tab('show')

  #*******************************************************************************************
  # Photo slider
  #*******************************************************************************************
  initializeSlider: ->
    slider = $('#photo-slider')
    if slider.length > 0
      slider.tinycarousel({ interval: true, pager: true, animation: false, fading: true })

      $('.extra-paginator').click ->
        slider.tinycarousel_move($(this).attr('data-page'))
        false

  #*******************************************************************************************
  # Panoramas
  #*******************************************************************************************
  initializePanoramas: ->
    pano_iframe = $('#panorama_container iframe')
    pano_list = $('#panoramas_list')
    if pano_list.length > 0
      idx = 0
      length = pano_list.find('a').length
      showPanorama = ->
        url = pano_list.find('a').eq(idx).attr('href')
        pano_iframe.attr('src', url)

      $('#panorama_container .prev').click ->
        if idx > 0
          idx -= 1
          showPanorama()
        false

      $('#panorama_container .next').click ->
        if idx < length - 1
          idx += 1
          showPanorama()
        false

      showPanorama()

  #*******************************************************************************************
  # Google Map initialization
  #*******************************************************************************************
  initializeMap: (lat, lon, cityName, countryName, radius, element_id) ->
    mapOptions = {
      zoom: 13,
      center: new google.maps.LatLng(lat, lon),
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      zoomControlOptions:
        position: google.maps.ControlPosition.TOP_LEFT
    }

    map = new google.maps.Map(document.getElementById(element_id),mapOptions)
    # We place a marker if radius is zero
    if radius == 0
      marker = new google.maps.Marker({
        position: new google.maps.LatLng(lat, lon),
        map: map,
        title: cityName + ', ' + countryName
      })
    # otherwise a random circle around the point
    else
      rand = parseFloat((Math.random() * (0.002 - (-.002)) + (-.002)).toFixed(4))
      circle_lat = lat + rand
      circle_lon = lon + rand

      # Add a Circle overlay to the map.
      circle = new google.maps.Circle({
        map: map,
        center: new google.maps.LatLng(circle_lat, circle_lon),
        strokeColor: '#004de8',
        strokeWeight: 1,
        strokeOpacity: 0.62,
        fillColor: '#004de8',
        fillOpacity: 0.27,
        radius: radius
      })

  #*******************************************************************************************
  # Calendar initialization
  #*******************************************************************************************
  initializeCalendar: (events, lastVisibleDay, month) ->
    $('#first-calendar').fullCalendar({
      header   : {left: 'prev', center: 'title', right: ''},
      editable : false,
      events   : events,         # A URL of a JSON feed that the calendar will fetch Event Objects from
      visEnd   : lastVisibleDay,  # A Date object of the day after the last visible day
      eventRender: PlaceShow.onEventRender,
      viewDisplay: PlaceShow.markFreeDays
    })

    $('#second-calendar').fullCalendar({
      header   : { left: '', center: 'title', right: 'next'},
      editable : false,
      events   : events,         # A URL of a JSON feed that the calendar will fetch Event Objects from
      month    : month,          # The initial month when the calendar loads.
      visStart : false,
      eventRender: PlaceShow.onEventRender,
      viewDisplay: PlaceShow.markFreeDays
    })

    $('.fc-header-left .fc-button-inner').hide()

    $('#first-calendar .fc-header-left .fc-button-prev').click( ->
      $('#second-calendar').fullCalendar('prev')
      first_cal = $('#first-calendar').fullCalendar('getDate')
      cur_date = new Date()
      if first_cal.getMonth() == cur_date.getMonth()
        $('.fc-header-left .fc-button-inner').hide()
      else
        $('.fc-header-left .fc-button-inner').show()
    )

    $('#second-calendar .fc-header-right .fc-button-next').click( ->
      $('#first-calendar').fullCalendar('next')
      $('.fc-header-left .fc-button-inner').show()
    )

    $('#first-calendar').fullCalendar('render')
    $('#second-calendar').fullCalendar('render')

  markFreeDays: ->
    $(@).find('.fc-content td').removeClass('free')
    $(@).find('.fc-content td').removeClass('busy')

    isBusy = (date) ->
      for event in $(@).fullCalendar('clientEvents')
        if event.color == "red" && (date.getTime() >= event.start.getTime()) && (date.getTime() <= event.end.getTime())
          return true
      false

    today    = $(@).fullCalendar('getDate')
    viewData = $(@).fullCalendar('getView')
    cMonth   = today.getMonth()
    cYear    = today.getFullYear()
    lYear    = parseInt(cYear)

    $(@).find('.fc-day-number').each( ->
      cell = $(@).parent().parent()

      if !cell.hasClass('fc-other-month')
        lDay   = parseInt($(@).text())
        lMonth = parseInt(cMonth)
        lDate  = new Date(lYear,lMonth,lDay)
        if isBusy(lDate)
          cell.addClass('busy')
        else
          cell.addClass('free')
    )

  onEventRender: (event, element, view) ->
    if event.color == 'red'
      false

  #*******************************************************************************************
  # Share Buttons initialization
  #*******************************************************************************************
  initializeSharePlace: (title, url, id) ->
    $('.sharePlace').bookmark({
      sites: ['facebook', 'twitter', 'google'],
      showAllText: 'Show all ({n})',
      title: title,
      hint: 'Share this!',
      url: url
    })
window.PlaceShow = PlaceShow