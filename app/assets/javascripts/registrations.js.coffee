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
