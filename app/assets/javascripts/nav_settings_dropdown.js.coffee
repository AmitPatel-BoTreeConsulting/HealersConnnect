((e, t, n) ->
  return  if "ontouchstart" of document
  r = e()
  e.fn.dropdownHover = (n) ->
    r = r.add(@parent())
    @each ->
      i = e(this)
      s = i.parent()
      o =
        delay: 500
        instantlyCloseOthers: not 0

      u =
        delay: e(this).data("delay")
        instantlyCloseOthers: e(this).data("close-others")

      a = e.extend(not 0, {}, o, n, u)
      f = undefined
      s.hover ((n) ->
        return not 0  if not s.hasClass("open") and not i.is(n.target)
        a.instantlyCloseOthers is not 0 and r.removeClass("open")
        t.clearTimeout f
        s.addClass "open"
        nav_dropdown_link = s.children("a")
        nav_dropdown_link.addClass "nav_dropdown_blue_color"
        s.trigger e.Event("show.bs.dropdown")
        return
      ), ->
        f = t.setTimeout(->
          nav_dropdown_link = s.children("a")
          nav_dropdown_link.removeClass "nav_dropdown_blue_color"
          s.removeClass "open"
          s.trigger "hide.bs.dropdown"
          return
        , a.delay)
        return

      i.hover ->
        a.instantlyCloseOthers is not 0 and r.removeClass("open")
        t.clearTimeout f
        s.addClass "open"
        s.trigger e.Event("show.bs.dropdown")
        return

      s.find(".dropdown-submenu").each ->
        n = e(this)
        r = undefined
        n.hover (->
          t.clearTimeout r
          n.children(".dropdown-menu").show()
          n.siblings().children(".dropdown-menu").hide()
          return
        ), ->
          e = n.children(".dropdown-menu")
          r = t.setTimeout(->
            e.hide()
            return
          , a.delay)
          return

        return

      return


  e(document).ready ->
    e("[data-hover=\"dropdown\"]").dropdownHover()
    return

  return
) jQuery, this