$(document).ready(function() {
  var user_signed_in;
  $('#WorkshopRegistrationTable tr a').click(function(e) {
    var registrationLink;
    if (!user_signed_in()) {
      e.preventDefault();
      registrationLink = $(this).attr('href');
      return $('#sign_in_confirmation').popup({
        autoopen: true,
        opacity: 0.7,
        onopen: function() {
          return $('#continueRegistrationBtn').attr('href', registrationLink);
        }
      });
    }
  });
  return user_signed_in = function() {
    return $('#user_signed_in').val() === 'true';
  };
});
