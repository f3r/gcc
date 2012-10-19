# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$('.search-item-clickable').live('click', (e) ->
  me = $(this)
  resource_url = me.attr("data-url")
  window.location.href = resource_url
  false
)

$('.genre-link').live('click', (e) ->
  me = $(this)
  genre_id = me.attr("data-genre-id")
  $('#search_amenity_ids').val(genre_id)
  PlaceFilters.search()
  $('#genre-active').html(me.html().trim())
  false
  )


