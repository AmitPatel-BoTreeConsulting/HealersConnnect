$(document).ready ->

  $("#event_avatar").change ->
    $('#event_avatar_part').hide();
    readURL $(this)[0], "#preview_event_avatar"


readURL = (input, previewContainerSelector) ->
  if input.files and input.files[0]
    reader = new FileReader()
    reader.onload = (e) ->
      $(previewContainerSelector).attr("src", e.target.result).width("auto").height(150).show()

    reader.readAsDataURL input.files[0]