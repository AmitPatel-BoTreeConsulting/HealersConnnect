$(document).ready ->
  $("#course_avatar").change ->
    $('#course_avatar_part').hide();
    readURL $(this)[0], "#preview_course_avatar"


readURL = (input, previewContainerSelector) ->
  if input.files and input.files[0]
    reader = new FileReader()
    reader.onload = (e) ->
      $(previewContainerSelector).attr("src", e.target.result).width("auto").height(150).show()

    reader.readAsDataURL input.files[0]