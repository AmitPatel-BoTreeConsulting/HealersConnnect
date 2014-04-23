//$(document).ready(function() {
//  var clickCount = 0;
//  $('#addCulpritsBtn').click(function(){
//    clickCount++;
//    var containerObj = $('#culpritsNameContainer');
//
//    appendCulpritsField(containerObj, clickCount);
//    toggleRemoveBtnCaseFirstField(containerObj);
//  });
//});
//
//function appendCulpritsField(containerObj, clickCount) {
//  // Append the text field
//  var fieldTemplate = $('#culpritsNameFieldTemplateContainer').html();
//  var newDiv = $("<div></div>").html(fieldTemplate);
//  $(newDiv).find("input").each(function(item){
//    var idStr = $(this).attr("id") + "_" + clickCount;
//    $(this).attr("id", idStr);
//  });
//  containerObj.append(newDiv.html());
//  // Append the Remove Btn to the text field
//  fieldRemoveBtnTemplate = $('#culpritsNamesFieldRemoveBtnTemplateContainer').html();
//  containerObj.find('.fieldCollection:last').append(fieldRemoveBtnTemplate);
//  var appendedField = containerObj.find('.fieldCollection:last');
//  bindClickEventOnCulpritsFieldRemoveBtn(appendedField);
//  bindDatePickerOnCulpritsField();
//}
//
//function bindDatePickerOnCulpritsField() {
//  $('.date-picker').datepicker({autoclose:true, format: 'dd/mm/yyyy'}).next().on(ace.click_event, function(){
//      $(this).prev().focus();
//    });
//  }
//
//function bindClickEventOnCulpritsFieldRemoveBtn(fieldObj) {
//  if(emptyObject(fieldObj)) {
//    return;
//  }
//  fieldObj.find('.icon-remove').click(function(event) {
//    var removeBtnMainParentContainer = $(this).closest('.wrapper-class');
//    removeBtnMainParentContainer.remove();
//
//    var container = $('#culpritsNameContainer');
//    toggleRemoveBtnCaseFirstField(container);
//    event.preventDefault();
//  });
//}
//
//// When new fields are added then the remove btn must be displayed against
//// the default first field too.
//// On the other hand when any of the fields are removed by clicking
//// the remove btn, then if only one field is left, then the remove
//// btn should not be displayed against it.
//// This function handles both above mentioned scenarios.
//function toggleRemoveBtnCaseFirstField(containerObj) {
//  if(emptyObject(containerObj)) {
//    return;
//  }
//  var fields = containerObj.find('.fieldCollection');
//  var fieldsCount = fields.length;
//  var firstField = fields.first();
//  var firstFieldRemoveBtn = firstField.find('.icon-remove');
//  var firstFieldRemoveBtnPresent = firstFieldRemoveBtn.length > 0;
//  if(fieldsCount > 1) {
//    // If not present then only append the Remove Btn
//    if(!firstFieldRemoveBtnPresent) {
//      // Append the Remove btn against the first field
//      fieldRemoveBtnTemplate = $('#culpritsNamesFieldRemoveBtnTemplateContainer').html();
//      firstField.append(fieldRemoveBtnTemplate);
//      bindClickEventOnCulpritsFieldRemoveBtn(firstField);
//    } else {
//      removeBreakTagFromFirstField(firstField);
//    }
//  } else {
//    if(firstFieldRemoveBtnPresent) {
//      removeBreakTagFromFirstField(firstField);
//      // Remove the Remove btn against the first field
//      firstFieldRemoveBtn.parent().remove();
//    }
//  }
//
//}
//
//// Dynamically added text fields starts with a <br/> tag.
//// In case the default first field is removed and there remains only
//// one dynamically added fields then from that the <br/> tag must
//// be removed so as to maintain alignment with the label.
//function removeBreakTagFromFirstField(firstFieldObj) {
//  if(emptyObject(firstFieldObj)) {
//    return;
//  }
//
//  var breakTag = firstFieldObj.find('.spacer5');
//  if(breakTag.length > 0) {
//    breakTag.remove();
//  }
//}
//
//function emptyObject(obj) {
//  if((obj == undefined) || (obj == null) ) {
//    return true;
//  }
//  return false;
//}