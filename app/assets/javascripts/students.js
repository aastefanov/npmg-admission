function find_selected_value(selector) {
    return selector.find('option:selected').attr('value');
}


function is_school_selected(school_selector) {
    return school_selector.children("option:selected").length !== 0;
}

function load_cities(selected_region, cities_by_region_url, city_selector, callback) {
    if (callback == null) {
        callback = function () {
        }
    }
    $.get(cities_by_region_url.replace(/%id%/, selected_region), function (cities) {

        city_selector.parent().show();

        city_selector.find('option').remove();

        $.each(cities, function (index, city) {
            $('<option/>').val(city.id).text(city.name).appendTo(city_selector);
        });

        callback();
    });
}

function load_schools(selected_city, schools_by_city_url, school_selector, callback) {
    if (callback == null) {
        callback = function () {
        }
    }
    $.get(schools_by_city_url.replace(/%id%/, selected_city), function (schools) {

        school_selector.parent().show();

        school_selector.find('option').remove();

        $.each(schools, function (index, school) {
            $('<option/>').val(school.id).text(school.name).appendTo(school_selector);
        });

        callback();
    });
}

function initialize_schools_selector(cities_by_region_url, schools_by_city_url, region_data_url, city_data_url, school_data_url) {
    var region_selector = $('#student_region');
    var city_selector = $('#student_city');
    var school_selector = $('#student_school_id');


    if (is_school_selected(school_selector)) {
        var selected_school = school_selector.find('option:selected').attr('value');
        $.get(school_data_url.replace(/%id%/, selected_school), function (school_data) {
            $.get(city_data_url.replace(/%id%/, school_data.city_id), function (city_data) {
                $.get(region_data_url.replace(/%id%/, city_data.region_id), function (region_data) {
                    region_selector.val(region_data.id);

                    load_cities(region_data.id, cities_by_region_url, city_selector, function () {
                        city_selector.val(city_data.id);
                    });


                    load_schools(city_data.id, schools_by_city_url, school_selector, function () {
                        school_selector.val(school_data.id);
                    });

                });
            });
        });
    } else {
        city_selector.parent().hide();
        school_selector.parent().hide();
    }

    region_selector.change(function () {
        var selected_region = find_selected_value(region_selector);
        load_cities(selected_region, cities_by_region_url, city_selector);

        school_selector.find('option').remove();
        school_selector.parent().hide();
    });

    city_selector.change(function () {
        var selected_city = find_selected_value(city_selector);
        load_schools(selected_city, schools_by_city_url, school_selector);
    });
}
