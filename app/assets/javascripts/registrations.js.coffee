$(document).ready ->
  $(".date-picker").datepicker(
    autoclose: true
    format: "dd/mm/yyyy"
  ).next().on ace.click_event, ->
    $(this).prev().focus()

  $("#accept_vow").change ->
    if $(this).is(":checked")
      $("#register").addClass "btn-primary"
    else
      $("#register").removeClass "btn-primary"
  $("#register").click ->
    if $("#accept_vow").length > 0
      if $("#accept_vow").is(":checked")
        telephoneNumber = $("#registration_user_profile_attributes_telephone").val()
        value = Number(telephoneNumber)
        if Math.floor(value) is value
          true
        else
          alert "Please enter vaild telephone number"
          false
      else
        false

  $("#registration_payment_type_id").change ->
    paymentType = $("option:selected", this).val()
    if paymentType is '2'
      $("#cheque_details").show()
      $("#net_banking_details").hide()
    else if paymentType is '4'
      $("#cheque_details").hide()
      $("#net_banking_details").show()
    else
      $("#cheque_details").hide()
      $("#net_banking_details").hide()

  # =============== course registration page
  # whenever user add/change phone number or mobile
  # Show popup confirmation for sign in if user is not logged in
  # and changed number matches with any existing user's number
  $('#registration_user_profile_attributes_mobile, #registration_user_profile_attributes_telephone').change ->
    unless user_signed_in()
      checkPhoneNumberByAjax()

  # Determine user is signed_in or not using hiddenfield
  user_signed_in = ->
    $('#user_signed_in').val is 'true'

  # Ajax for comparing inserted phonenumber with existing user's phonenumber
  # if numbers matched then the response will open login confirmation popup
  # and disables the submit button
  # if not matched then response enables the submit button
  checkPhoneNumberByAjax = ->
    $.ajax
      type: "POST"
      beforeSend: (xhr) ->
        xhr.setRequestHeader "X-CSRF-Token", $("meta[name=\"csrf-token\"]").attr("content")
      url: '/check_phone_number'
      data:
        mobile: $('#registration_user_profile_attributes_mobile').val()
        telephone: $('#registration_user_profile_attributes_telephone').val()