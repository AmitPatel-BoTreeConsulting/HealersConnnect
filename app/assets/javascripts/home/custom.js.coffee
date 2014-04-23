# =============== HomePage
# Show popup confirmation for sign in before workshop registration
$(document).ready ->
  $('#WorkshopRegistrationTable tr a').click (e) ->
    unless user_signed_in()
      e.preventDefault()
      registrationLink = $(this).attr('href')
      $('#sign_in_confirmation').popup
        autoopen: true
        opacity: 0.7
        onopen: ->
          # set the href for continue registration button
          $('#continueRegistrationBtn').attr('href', registrationLink)

  # Determine user is signed_in or not using hiddenfield
  user_signed_in = ->
    $('#user_signed_in').val is 'true'
