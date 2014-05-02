$(document).ready ->

  if $('#workshop_fees_on_rejoining').val() is ''
    $('#workshop_fees_on_rejoining').val(0)

  clickCount = 0
  $("#addCulpritsBtn").click ->
    clickCount++
    containerObj = $("#culpritsNameContainer")
    appendCulpritsField containerObj, clickCount
    toggleRemoveBtnCaseFirstField containerObj
    return

  $("#id-date-picker-11").on "change", ->
    $("#workshop_fees_after").text $("#id-date-picker-11").val()
    return

  $("#id-date-picker-12").on "change", ->
    sessionDate = $("#id-date-picker-12").val()
    $('#id-date-picker-11').val sessionDate
    $("#workshop_fees_after").text sessionDate
    $("#workshop_fees_spot").text sessionDate
    return

  $("#workshop_course_id").change ->
    courseId = $('#workshop_course_id').val()
    unless $("#workshop_course_id").val() is ""
      $.ajax
        cache: false
        type: "POST"
        url: "/workshops/course/instructors"
        data:
          id: courseId

  return

appendCulpritsField = (containerObj, clickCount) ->

  # Append the text field
  fieldTemplate = $("#culpritsNameFieldTemplateContainer").html()
  newDiv = $("<div></div>").html(fieldTemplate)
  $(newDiv).find("input").each (item) ->
    idStr = $(this).attr("id") + "_" + clickCount
    $(this).attr "id", idStr
    return

  containerObj.append newDiv.html()

  # Append the Remove Btn to the text field
  fieldRemoveBtnTemplate = $("#culpritsNamesFieldRemoveBtnTemplateContainer").html()
  containerObj.find(".fieldCollection:last").append fieldRemoveBtnTemplate
  appendedField = containerObj.find(".fieldCollection:last")
  bindClickEventOnCulpritsFieldRemoveBtn appendedField
  bindDatePickerOnCulpritsField()
  return
bindDatePickerOnCulpritsField = ->
  $(".date-picker").datepicker(
    autoclose: true
    format: "dd/mm/yyyy"
  ).next().on ace.click_event, ->
    $(this).prev().focus()
    return

  return
bindClickEventOnCulpritsFieldRemoveBtn = (fieldObj) ->
  return  if emptyObject(fieldObj)
  fieldObj.find(".icon-minus-sign").click (event) ->
    removeBtnMainParentContainer = $(this).closest(".wrapper-class")
    removeBtnMainParentContainer.remove()
    container = $("#culpritsNameContainer")
    toggleRemoveBtnCaseFirstField container
    event.preventDefault()
    return

  return

# When new fields are added then the remove btn must be displayed against
# the default first field too.
# On the other hand when any of the fields are removed by clicking
# the remove btn, then if only one field is left, then the remove
# btn should not be displayed against it.
# This function handles both above mentioned scenarios.
toggleRemoveBtnCaseFirstField = (containerObj) ->
  return  if emptyObject(containerObj)
  fields = containerObj.find(".fieldCollection")
  fieldsCount = fields.length
  firstField = fields.first()
  firstFieldRemoveBtn = firstField.find(".icon-minus-sign")
  firstFieldRemoveBtnPresent = firstFieldRemoveBtn.length > 0
  if firstFieldRemoveBtnPresent
    removeBreakTagFromFirstField firstField

    # Remove the Remove btn against the first field
    firstFieldRemoveBtn.parent().remove()
  return

# Dynamically added text fields starts with a <br/> tag.
# In case the default first field is removed and there remains only
# one dynamically added fields then from that the <br/> tag must
# be removed so as to maintain alignment with the label.
removeBreakTagFromFirstField = (firstFieldObj) ->
  return  if emptyObject(firstFieldObj)
  breakTag = firstFieldObj.find(".spacer5")
  breakTag.remove()  if breakTag.length > 0
  return
emptyObject = (obj) ->
  return true  if (obj is `undefined`) or (not (obj?))
  false
