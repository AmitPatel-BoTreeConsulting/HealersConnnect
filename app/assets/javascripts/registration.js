//$( document ).ready(function() {
//  $('.date-picker').datepicker({autoclose:true, format: 'dd/mm/yyyy'}).next().on(ace.click_event, function(){
//    $(this).prev().focus();
//  });
//
//  $('#accept_vow').change(function() {
//    if($(this).is(":checked")) {
//      $( "#register" ).addClass( "btn-primary" );
////      $("#register").css('cursor', 'pointer');
//    }
//    else{
//      $( "#register" ).removeClass( "btn-primary" );
////      $("#register").css('cursor', 'default');
//    }
//  });
//
//  $('#register').on('click', function() {
//      if($("#accept_vow").length > 0){
//          if($("#accept_vow").is(":checked")) {
//              return true;
//          }
//          else{
//              return false;
//          }
//      }
//  });
//
//  $('#registration_payment_type_id').change(function(){
//    var paymentType = $("option:selected", this).val();
//    if(paymentType == 2) {
//      $('#cheque_details').show();
//      $('#net_banking_details').hide();
//    } else if(paymentType == 4){
//      $('#cheque_details').hide();
//      $('#net_banking_details').show();
//    } else {
//      $('#cheque_details').hide();
//      $('#net_banking_details').hide();
//    }
//  });
//});