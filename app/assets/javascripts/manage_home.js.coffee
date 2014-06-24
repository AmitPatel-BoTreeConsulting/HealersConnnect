$(document).ready ->
  $("input.ace.upcoming_workshop[type=checkbox]").on "change", ->
    status = (if $(this).is(":checked") then "true" else "false")
    $.blockUI()
    $.ajax
      url: "/manage_homes/update_upcoming_workshop/" + $(this).val() + "?status=" + status
      success: ->
        $.unblockUI()
        return
    return
  $("input.ace.upcoming_event[type=checkbox]").on "change", ->
    status = (if $(this).is(":checked") then "true" else "false")
    $.blockUI()
    $.ajax
      url: "/manage_homes/update_upcoming_event/" + $(this).val() + "?status=" + status
      success: ->
        $.unblockUI()
        return
    return
  return