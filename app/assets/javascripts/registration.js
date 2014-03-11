$( document ).ready(function() {
  $('.date-picker').datepicker({autoclose:true, format: 'dd/mm/yyyy'}).next().on(ace.click_event, function(){
    $(this).prev().focus();
  });

  $('#accept_vow').change(function() {
    if($(this).is(":checked")) {
      $( "#vow_accept" ).removeClass( "" ).addClass( "btn-primary" );
      $("#vow_accept").css('cursor', 'pointer');
    }
    else{
      $( "#vow_accept" ).addClass( "" ).removeClass( "btn-primary" );
      $("#vow_accept").css('cursor', 'default');
    }
  });

  $('#vow_accept').on('click', function() {
    if($("#accept_vow").is(":checked")) {
      return true;
    }
    else{
      return false;
    }
  });
});