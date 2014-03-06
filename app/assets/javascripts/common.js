var valid_location = false;

function initGoogleLocationSearchFields(location_input_id, longitude_id, latitude_id, location_search_fields, callback_func) {

    if(location_search_fields == false) {
        location_search_fields = ['(cities)'];
    }
    var input = document.getElementById(location_input_id);

    valid_location = (input.value!='' && input.value.length>0);

    var options = {
        types: location_search_fields
    };

    autocomplete = new google.maps.places.Autocomplete(input, options);
    google.maps.event.addListener(autocomplete, 'place_changed', function() {
        var place = autocomplete.getPlace();
        $("#"+longitude_id).val(place.geometry.location.lng());
        $("#"+latitude_id).val(place.geometry.location.lat());
        valid_location = true;
        if(typeof callback_func !== 'undefined' && callback_func != false){
            callback_func();
        }
    });
}