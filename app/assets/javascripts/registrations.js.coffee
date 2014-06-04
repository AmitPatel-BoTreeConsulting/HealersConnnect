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
        if skip_phone_validation || Math.floor(value) is value
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

  # When user add/change member id field, send ajax to get list of matched user
  # then show popup containing this list
  $('#user_member_id').change ->
    #unless user_signed_in()
    checkMemberIdByAjax()

# Determine user is signed_in or not using hiddenfield
user_signed_in = ->
  $('#user_signed_in').val() is 'true'

# Check if the phone should validate?
skip_phone_validation = ->
  $('#registration_user_profile_attributes_telephone').length

# Ajax for comparing inserted phonenumber with existing user's phonenumber
# if numbers matched then the response will open login confirmation popup
# and disables the submit button
# if not matched then response enables the submit button
checkPhoneNumberByAjax = ->
  ajax_data = 
    mobile: $('#registration_user_profile_attributes_mobile').val()
    telephone: $('#registration_user_profile_attributes_telephone').val()
    workshop_id: $('#registration_workshop_id').val()
  sendAjax('POST', '/check_phone_number', ajax_data)

# Ajax for sending value of member_id
# if any existing user with this member_id matched
# then the response will open login confirmation popup
# and show the list of users found
checkMemberIdByAjax = ->
  ajax_data = 
    member_id: $('#user_member_id').val()
    workshop_id: $('#registration_workshop_id').val()
  sendAjax('POST', '/check_phone_number', ajax_data)

sendAjax = (type, url, data) ->
  $.ajax
    type: type
    beforeSend: (xhr) ->
      xhr.setRequestHeader "X-CSRF-Token", $("meta[name=\"csrf-token\"]").attr("content")
    url: url
    data: data
