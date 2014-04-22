$(document).ready(function() {

  var clientForm = $('#new_contact_us_post');
  if(clientForm.length > 0) {
    validateContactUsPageForm();
  }

});

function validateContactUsPageForm() {
  var form = $('#new_contact_us_post');
  if(form.length > 0) {
    form.validate({
      ignore: ".ignore",
      rules: {
        "contact_us_post[name]": "required",
        "contact_us_post[phone]": { required: true, number: true },
        "contact_us_post[email]": { required: true, email: true },
        "contact_us_post[message]": "required"
      },

      // Inline with Twitter Bootstrap theme
      errorElement: 'span',
      errorClass: 'review_form_error_msg',
      errorPlacement: function(error, element) {
        error.appendTo(element.next());
      },
      submitHandler: function(form) {
        $.rails.handleRemote( $(form) );
      }
    });
  }
}