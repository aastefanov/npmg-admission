// // jQuery(function() {
// //     var states;
// //     $('#student_city').parent().hide();
// //     states = $('#student_city').html();
// //     console.log(states);
// //     return $('#student_region').change(function() {
// //         var country, escaped_country, options;
// //         country = $('#student_region :selected').text();
// //         escaped_country = country.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1');
// //         options = $(states).filter("optgroup[label=" + escaped_country + "]").html();
// //         console.log(options);
// //         if (options) {
// //             $('#student_city').html(options);
// //             return $('#student_city').parent().show();
// //         } else {
// //             $('#student_city').empty();
// //             return $('#student_city').parent().hide();
// //         }
// //     });
// // });
//

function initalize_schools_selector(cities_by_region_url, schools_by_city_url) {
    var region_selector = $('#student_region');
    var city_selector = $('#student_city');
    var school_selector = $('#student_school');
    city_selector.parent().hide();
    school_selector.parent().hide();

    region_selector.change(function () {
        var selected_region = region_selector.find('option:selected').attr('value');

        $.get(cities_by_region_url.replace(/%id%/, selected_region), function (cities) {
            console.log(cities);

            city_selector.parent().show();

            city_selector.find('option').remove();

            $.each(cities, function (index, city) {
                $('<option/>').val(city.id).text(city.name).appendTo(city_selector);
            });
        });
    });

    city_selector.change(function () {
        var selected_city = city_selector.find('option:selected').attr('value');

        $.get(schools_by_city_url.replace(/%id%/, selected_city), function (schools) {
            // console.log(cities);

            school_selector.parent().show();

            school_selector.find('option').remove();

            $.each(schools, function (index, school) {
                $('<option/>').val(school.id).text(school.name).appendTo(school_selector);
            });
        });
    });
}