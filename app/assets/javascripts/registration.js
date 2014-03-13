$( document ).ready(function() {
  $('.date-picker').datepicker({autoclose:true, format: 'dd/mm/yyyy'}).next().on(ace.click_event, function(){
    $(this).prev().focus();
  });

  $('#accept_vow').change(function() {
    if($(this).is(":checked")) {
      $( "#register" ).addClass( "btn-primary" );
//      $("#register").css('cursor', 'pointer');
    }
    else{
      $( "#register" ).removeClass( "btn-primary" );
//      $("#register").css('cursor', 'default');
    }
  });

  $('#register').on('click', function() {
      if($("#accept_vow").length > 0){
          if($("#accept_vow").is(":checked")) {
              return true;
          }
          else{
              return false;
          }
      }
  });
});