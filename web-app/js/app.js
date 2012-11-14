// spinner credits: http://fgnass.github.com/spin.js/ and https://gist.github.com/1290439

function showspinner(id) {
    $(id).html("").spin({lines: 9, length: 4, width: 3, radius: 5, top: 15, left: 0});
}

function hidespinner(id) {
    $(id).spin(false);
}

// toggle element
function toggle(id) {
    $(id).toggle(400);
}

// clears the value of multiple elements
function clearElements(elements) {
    for (var x = 0; x <= elements.length; x++)
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

$(document).ready(function() {

    $.fn.spin = function(opts, color) {
        var presets = {
            "tiny": { lines: 8, length: 2, width: 2, radius: 3 },
            "small": { lines: 8, length: 4, width: 3, radius: 5 },
            "large": { lines: 10, length: 8, width: 4, radius: 8 }
        };
        if (Spinner) {
            return this.each(function() {
                var $this = $(this),
                    data = $this.data();

                if (data.spinner) {
                    data.spinner.stop();
                    delete data.spinner;
                }
                if (opts !== false) {
                    if (typeof opts === "string") {
                        if (opts in presets) {
                            opts = presets[opts];
                        } else {
                            opts = {};
                        }
                        if (color) {
                            opts.color = color;
                        }
                    }
                    data.spinner = new Spinner($.extend({color: $this.css('color')}, opts)).spin(this);
                }
            });
        } else {
            throw "Spinner class not available.";
        }
    };

    /*$('input:text:visible:first').not('.datepicker, .datepicker-birthday, .search').focus();

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

     $('.timepick').timepicker({
         timeText: '${message(code: "time")}',
         hourText: '${message(code: "hour")}',
         minuteText: '${message(code: "minute")}',
         timeOnlyTitle: '${message(code: "chooseTime")}',
         stepMinute: 5
     });

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

    $('#flash-msg').delay(4000).fadeOut(2000); //fadeTo(2000,0).toggle(2000);*/

});
