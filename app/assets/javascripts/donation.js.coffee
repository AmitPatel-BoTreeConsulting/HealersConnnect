$(document).ready ->
  $(".chosen-select").chosen()
  $("#chosen-multiple-style").on "click", (e) ->
    target = $(e.target).find("input[type=radio]")
    which = parseInt(target.val())
    if which is 2
      $("#form-field-select-4").addClass "tag-input-style"
    else
      $("#form-field-select-4").removeClass "tag-input-style"
    return

  $("#export_donation").on "click", ->
    $("#donationExportPdfForm").submit()
    return
  return