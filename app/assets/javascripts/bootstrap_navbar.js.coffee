jQuery ->
  for link in $(".topbar .nav a")
    do (link) ->
      if (window.location.pathname == link.pathname)
        $(link).parent().toggleClass("active")