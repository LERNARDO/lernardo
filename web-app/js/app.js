// shows the spinner
function showspinner(id) {
    $(id).html('<img id="spinner" src="${resource(dir: 'images', file: 'spinner.gif')}" alt="Lade.."/>');
}

// toggle element
function toggle(id) {
    $(id).toggle(400);
}

// clears the value of multiple elements
function clearElements(elements) {
    for (x = 0; x <= elements.length; x++)
        $(elements[x]).val('');
}

// toggles the disabled attribute of an element
function toggleDisabled(id) {
    var status = $(id).attr('disabled');
    if (!status) {
        $(id).attr('disabled', 'disabled');
        $(id).val('');
    }
    else
        $(id).removeAttr('disabled');
}

function showBigSpinner() {
    $('#loading').css('visibility', 'visible');
}

$(document).ready(function() {

    $('input:text:visible:first').not('.datepicker, .datepicker-birthday, .search').focus();

    $('.tooltip').each(function() {
        $(this).qtip({
            content: {
                text: function(api) {
                    return $(this).attr('data-tooltip');
                }
            },
            position: {
                my: 'top left',  // Position my top left...
                at: 'right bottom', // at the bottom right of...
                target: $(this) // my target
            },
            style: {
                classes: 'ui-tooltip-blue'
            }
        });
    });

    $('.timepicker').timepicker();

    $(".datepicker-birthday").datepicker({
        monthNamesShort: ['${message(code: "january.short")}', '${message(code: "february.short")}', '${message(code: "march.short")}',
            '${message(code: "april.short")}', '${message(code: "may.short")}', '${message(code: "june.short")}',
            '${message(code: "july.short")}', '${message(code: "august.short")}', '${message(code: "september.short")}',
            '${message(code: "october.short")}', '${message(code: "november.short")}', '${message(code: "december.short")}'],
        dayNamesMin: ['${message(code: "sunday.short")}', '${message(code: "monday.short")}', '${message(code: "tuesday.short")}',
            '${message(code: "wednesday.short")}', '${message(code: "thursday.short")}', '${message(code: "friday.short")}',
            '${message(code: "saturday.short")}'],
        changeMonth: true,
        changeYear: true,
        dateFormat: 'dd. mm. yy',
        minDate: new Date(1900, 1, 1),
        maxDate: new Date(),
        firstDay: 1,
        yearRange: 'c-99:c+99',
        showMonthAfterYear: true,
        appendText: ' (DD. MM. YYYY)',
        autoSize: true});

    $(".datepicker").datepicker({
        monthNamesShort: ['${message(code: "january.short")}', '${message(code: "february.short")}', '${message(code: "march.short")}',
            '${message(code: "april.short")}', '${message(code: "may.short")}', '${message(code: "june.short")}',
            '${message(code: "july.short")}', '${message(code: "august.short")}', '${message(code: "september.short")}',
            '${message(code: "october.short")}', '${message(code: "november.short")}', '${message(code: "december.short")}'],
        dayNamesMin: ['${message(code: "sunday.short")}', '${message(code: "monday.short")}', '${message(code: "tuesday.short")}',
            '${message(code: "wednesday.short")}', '${message(code: "thursday.short")}', '${message(code: "friday.short")}',
            '${message(code: "saturday.short")}'],
        changeMonth: true,
        changeYear: true,
        dateFormat: 'dd. mm. yy',
        minDate: new Date(1900, 1, 1),
        firstDay: 1,
        autoSize: true});

    $('.datetimepicker').datetimepicker({
        timeText: '${message(code: "time")}',
        hourText: '${message(code: "hour")}',
        minuteText: '${message(code: "minute")}',
        dayNamesMin: ['${message(code: "sunday.short")}', '${message(code: "monday.short")}', '${message(code: "tuesday.short")}',
            '${message(code: "wednesday.short")}', '${message(code: "thursday.short")}', '${message(code: "friday.short")}',
            '${message(code: "saturday.short")}'],
        monthNames: ['${message(code: "january")}', '${message(code: "february")}', '${message(code: "march")}',
            '${message(code: "april")}', '${message(code: "may")}', '${message(code: "june")}',
            '${message(code: "july")}', '${message(code: "august")}', '${message(code: "september")}',
            '${message(code: "october")}', '${message(code: "november")}', '${message(code: "december")}'],
        dateFormat: 'dd. mm. yy'
    });

    $('.datetimepicker2').datetimepicker({
        timeText: '${message(code: "time")}',
        hourText: '${message(code: "hour")}',
        minuteText: '${message(code: "minute")}',
        dayNamesMin: ['${message(code: "sunday.short")}', '${message(code: "monday.short")}', '${message(code: "tuesday.short")}',
            '${message(code: "wednesday.short")}', '${message(code: "thursday.short")}', '${message(code: "friday.short")}',
            '${message(code: "saturday.short")}'],
        monthNames: ['${message(code: "january")}', '${message(code: "february")}', '${message(code: "march")}',
            '${message(code: "april")}', '${message(code: "may")}', '${message(code: "june")}',
            '${message(code: "july")}', '${message(code: "august")}', '${message(code: "september")}',
            '${message(code: "october")}', '${message(code: "november")}', '${message(code: "december")}'],
        dateFormat: 'dd. mm. yy,',
        timeFormat: 'hh:mm'
    });

    $('#flash-msg').delay(4000).fadeOut(2000); //fadeTo(2000,0).toggle(2000);

    $('.countable50').jqEasyCounter({
        'maxChars': 50,
        'maxCharsWarning': 50
    });

    $('.countable500').jqEasyCounter({
        'maxChars': 500,
        'maxCharsWarning': 500
    });

    $('.countable2000').jqEasyCounter({
        'maxChars': 2000,
        'maxCharsWarning': 2000
    });

    $('.countable5000').jqEasyCounter({
        'maxChars': 5000,
        'maxCharsWarning': 5000
    });

});
