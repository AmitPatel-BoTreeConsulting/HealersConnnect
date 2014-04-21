$(document).ready(function() {

  //bind click event on add button
  $.each(addBtnSelector('all'), function( key, value ) {
    if ($(value).length > 0 ) {
      bindClickOnAddBtn(key);
    }
  });

  //bind cancel event on button
  $.each(foundHiddenField('all'), function( key, value ) {
    var foundField = value;//foundHiddenField(key);
    if (foundField.length > 0) {
      var foundFieldVal = foundField.val();
      if(foundFieldVal == 'true') {
        // Edit Client view
        var fieldsArr = fields(key);
        // Append Remove btn against each existing field
        fieldsArr.append(fieldRemoveBtnTemplate(key));
        // Bind click event on existing fields
        fieldsArr.each(function() {
          bindClickEventOnFieldRemoveBtn($(this), key);
        });
      }
    }
  });

  // For previewing image before upload.
  $('#client_company_logo').change(function() {
    readURL($(this)[0], '#preview_client_logo');
  });
});


function readURL(input, previewContainerSelector) {
  if (input.files && input.files[0]) {
      var reader = new FileReader();

      reader.onload = function (e) {
          $(previewContainerSelector)
              .attr('src', e.target.result)
              .width('auto')
              .height(150).show();
      };

      reader.readAsDataURL(input.files[0]);
  }
}

function bindClickOnAddBtn(type) {
  $(addBtnSelector(type)).click(function() {
    var container = $(containerSelector(type));

    appendField(container, type);
    toggleRemoveBtnForFirstField(container, type);
  });
};

function bindCancelOnBtnEvent(FieldsArr, FoundFieldVal, type) {
  // Append Remove btn against each field
  FieldsArr.append(fieldRemoveBtnTemplate(type));
  // Bind click event on existing fields
  FieldsArr.each(function() {
    bindClickEventOnFieldRemoveBtn($(this), FoundFieldVal, type);
  });
}

// When new fields are added then the remove btn must be displayed against
// the default first field too.
// On the other hand when any of the fields are removed by clicking
// the remove btn, then if only one field is left, then the remove
// btn should not be displayed against it.
// This function handles both above mentioned scenarios.
function toggleRemoveBtnForFirstField(containerObj, type) {
  if(emptyObject(containerObj)) {
    return;
  }
  var fields = containerObj.find('.col-sm-8');
  var fieldsCount = fields.length;
  var firstField = fields.first();
  var firstFieldRemoveBtn = firstField.find('.icon-remove');
  var firstFieldRemoveBtnPresent = firstFieldRemoveBtn.length > 0;

  if(fieldsCount > 1) {
    // If not present then only append the Remove Btn
    if(!firstFieldRemoveBtnPresent) {
      // Append the Remove btn against the first field
      firstField.append(fieldRemoveBtnTemplate(type));
      bindClickEventOnFieldRemoveBtn(firstField, type);
    } else {
      removeBreakTagFromFirstFieldIfPresent(firstField);
    }
  } else {
    if(firstFieldRemoveBtnPresent) {
      removeBreakTagFromFirstFieldIfPresent(firstField);
      // Remove the Remove btn against the first field
      firstFieldRemoveBtn.parent().remove();
    }
  }
}

// Dynamically added text fields starts with a <br/> tag.
// In case the default first field is removed and there remains only
// one dynamically added fields then from that the <br/> tag must
// be removed so as to maintain alignment with the label.
function removeBreakTagFromFirstFieldIfPresent(firstFieldObj) {
  if(emptyObject(firstFieldObj)) {
    return;
  }

  var breakTag = firstFieldObj.find('.space-4');
  if(breakTag.length > 0) {
    breakTag.remove();
  }
}

function appendField(containerObj, type) {
  if(emptyObject(containerObj)) {
    return;
  }
  // Append the text field
  containerObj.append(fieldTemplate(type));
  // Append the Remove Btn to the text field
  containerObj.find('.col-sm-8:last').append(fieldRemoveBtnTemplate(type));
  var appendedField = containerObj.find('.col-sm-8:last');
  bindClickEventOnFieldRemoveBtn(appendedField, type);
}

function bindClickEventOnFieldRemoveBtn(fieldObj, type) {
  if(emptyObject(fieldObj)) {
    return;
  }

  fieldObj.find('.icon-remove').click(function(event) {
    var removeBtnMainParentContainer = $(this).closest('.wrapper-class');
    var foundField = foundHiddenField(type);
    var foundFieldVal = foundField.val();
    if(foundFieldVal == 'true') {
      // Applicable on Edit Client view
      var id = removeBtnMainParentContainer.find('input[type="hidden"]').val();

      var removedTemplate = removeTemplateContainer(type).html();
      var removeContainerObj = removeContainer(type);

      // Append the removed fields to a hidden container to mark them as
      // removed.
      removeContainerObj.append(removedTemplate);
      setAppendedFieldValue(removeContainerObj, id, type);

      // Remove the removed fields from display
      var fieldsArr = fields(type);
      var fieldsCount = fieldsArr.length;

      if(fieldsCount > 1) {
        removeBtnMainParentContainer.remove();
        removeBreakTagFromFirstFieldIfPresent(fields(type).first());
      } else {
        // Set the hidden field containing existing id to empty string
        removeBtnMainParentContainer.find('input[type="hidden"]').val('');
        // Clear the field
        removeBtnMainParentContainer.find('input[type="'+type+'"]').val('');
        // Finally remove the Remove btn
        $(this).parent().remove();
      }

    } else { // Applicable on Create Client view
      removeBtnMainParentContainer.remove();
      var container = $(containerSelector(type));
      toggleRemoveBtnForFirstField(container, type);
    }

    event.preventDefault();
  });
}

function setAppendedFieldValue(container, id, type) {
  if (type == 'url') {
    container.find('.clientUrlId:last').val(id);
    container.find('.clientUrlDestroy:last').val('1');
  }
  if (type == 'email') {
    container.find('.clientEmailId:last').val(id);
    container.find('.clientEmailDestroy:last').val('1');
  }
}

function fields(type) {
  var container = $(containerSelector(type));
  var fieldsArr = container.find('.col-sm-8');
  return fieldsArr;
}

function fieldTemplate(type) {
  return $(fieldTemplateContainerSelector(type)).html();
}

function fieldRemoveBtnTemplate(type) {
  return $(fieldRemoveBtnTemplateContainerSelector(type)).html();
}

function removeContainer(type) {
  if (type == 'url') {
    return $('#removeClientUrlsContainer');
  }
  if (type == 'email') {
    return $('#removeClientEmailsContainer');
  }
}

function removeTemplateContainer(type) {
  if (type == 'url') {
    return $('#removedWebsiteUrlTemplateContainer');
  }
  if (type == 'email') {
    return $('#removedAlternateEmailTemplateContainer');
  }
}

function addBtnSelector(type) {
  if (type == 'url') {
    return '#clientForm #addUrlBtn';
  }
  if (type == 'email') {
    return '#clientForm #addEmailBtn';
  }
  if (type == 'all') {
    return {
        'url': '#clientForm #addUrlBtn',
        'email': '#clientForm #addEmailBtn'
      };
  }
}

function containerSelector(type) {
  if (type == 'url') {
    return '#clientForm #websiteUrlsContainer';
  }
  if (type == 'email') {
    return '#clientForm #alternateEmailsContainer';
  }
}

function fieldTemplateContainerSelector(type) {
  if (type == 'url') {
    return '#websiteUrlFieldTemplateContainer';
  }
  if (type == 'email') {
    return '#alternateEmailFieldTemplateContainer';
  }
}

function fieldRemoveBtnTemplateContainerSelector(type) {
  if (type == 'url') {
    return '#websiteUrlFieldRemoveBtnTemplateContainer';
  }
  if (type == 'email') {
    return '#alternateEmailFieldRemoveBtnTemplateContainer';
  }
}

function foundHiddenField(type) {
  if (type == 'url') {
    return $('#clientUrlsFound');
  }
  if (type == 'email') {
    return $('#clientEmailsFound');
  }
  if (type == 'all') {
    return {
      'url': $('#clientUrlsFound'),
      'email': $('#clientEmailsFound')
    };
  }
}

function emptyString(string) {
  if((string == undefined) || (string == null) || ($.trim(string) == '') ) {
    return true;
  }

  return false;
}

function emptyObject(obj) {
  if((obj == undefined) || (obj == null) ) {
    return true;
  }

  return false;
}