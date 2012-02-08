<!DOCTYPE html>

<html>
<head>
  <meta charset="utf-8" />
  <title>${grailsApplication.config.application.name} ${grailsApplication.config.customerName} - <g:layoutTitle/></title>
  <link rel="stylesheet" href="http://yui.yahooapis.com/3.3.0/build/cssreset/reset.css" type="text/css">
  <link rel="stylesheet" href="http://yui.yahooapis.com/3.3.0/build/cssfonts/fonts.css" type="text/css">
  <link rel="stylesheet" href="http://yui.yahooapis.com/3.3.0/build/cssgrids/grids-min.css" type="text/css">
  <link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.qtip.min.css')}" type="text/css">
  <link rel="stylesheet" href="${resource(dir: 'css', file: 'kolorpicker.css')}" type="text/css">
  <g:set var="customer" value="${grailsApplication.config.customer}"/>
  <less:stylesheet name="common" />
  <less:stylesheet name="${customer}" />
  <less:scripts />
  <link rel="icon" href="${resource(dir: 'images', file: 'favicon.jpg')}" type="image/jpg"/>
  <g:javascript library="jquery" plugin="jquery"/>
  <jqui:resources/>
  <ckeditor:resources />
  %{--<script src="${g.resource(dir: 'js', file: 'erp.js')}" type="text/javascript"></script>--}%
  <script src="${g.resource(dir: 'js/jquery', file: 'jquery.jqEasyCharCounter.min.js')}" type="text/javascript"></script>
  <script src="${g.resource(dir: 'js/jquery', file: 'jquery-ui-timepicker-addon.js')}" type="text/javascript"></script>
  <script src="${g.resource(dir: 'js/jquery', file: 'jquery.qtip.min.js')}" type="text/javascript"></script>
  <script src="${g.resource(dir: 'js/jquery', file: 'jquery.kolorpicker.js')}" type="text/javascript"></script>

  <script type="text/javascript">
    // TODO: the following custom JavaScript functions have to be defined here else Chrome 10 and IE 9 are not able to find them, find out why..
    // hides an element
    hideform = function(id) {
      $(id).hide('slow');
    };

    // shows an element
    showform = function(id) {
      $(id).show('slow');
    };

    // clears the text of an element
    cleartext = function(){
      document.getElementById('hide').value='';
    };

    // shows the spinner
    showspinner = function(id) {
      $(id).html('<img id="spinner" src="${resource(dir: 'images', file: 'spinner.gif')}" alt="Lade.."/>');
    };

    // toggle element
    toggle = function(id) {
      $(id).toggle(400);
    };

    // fadetoggle element
    ftoggle = function(id) {
      $(id).fadeToggle(400);
    };

    // clears the value of multiple elements
    clearElements = function(elements) {
      for (x = 0; x <= elements.length; x++)
        $(elements[x]).val('');
    };

    // toggles the disabled attribute of an element
    toggleDisabled = function(id) {
      var status = $(id).attr('disabled');
      if (!status) {
        $(id).attr('disabled', 'disabled');
        $(id).val('');
      }
      else
        $(id).removeAttr('disabled');
    };

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
        monthNamesShort: ['${message(code: "january.short")}',
                          '${message(code: "february.short")}',
                          '${message(code: "march.short")}',
                          '${message(code: "april.short")}',
                          '${message(code: "may.short")}',
                          '${message(code: "june.short")}',
                          '${message(code: "july.short")}',
                          '${message(code: "august.short")}',
                          '${message(code: "september.short")}',
                          '${message(code: "october.short")}',
                          '${message(code: "november.short")}',
                          '${message(code: "december.short")}'],
        dayNamesMin: ['${message(code: "sunday.short")}',
                      '${message(code: "monday.short")}',
                      '${message(code: "tuesday.short")}',
                      '${message(code: "wednesday.short")}',
                      '${message(code: "thursday.short")}',
                      '${message(code: "friday.short")}',
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
        monthNamesShort: ['${message(code: "january.short")}',
                          '${message(code: "february.short")}',
                          '${message(code: "march.short")}',
                          '${message(code: "april.short")}',
                          '${message(code: "may.short")}',
                          '${message(code: "june.short")}',
                          '${message(code: "july.short")}',
                          '${message(code: "august.short")}',
                          '${message(code: "september.short")}',
                          '${message(code: "october.short")}',
                          '${message(code: "november.short")}',
                          '${message(code: "december.short")}'],
        dayNamesMin: ['${message(code: "sunday.short")}',
                      '${message(code: "monday.short")}',
                      '${message(code: "tuesday.short")}',
                      '${message(code: "wednesday.short")}',
                      '${message(code: "thursday.short")}',
                      '${message(code: "friday.short")}',
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
        dayNamesMin: ['${message(code: "sunday.short")}',
                      '${message(code: "monday.short")}',
                      '${message(code: "tuesday.short")}',
                      '${message(code: "wednesday.short")}',
                      '${message(code: "thursday.short")}',
                      '${message(code: "friday.short")}',
                      '${message(code: "saturday.short")}'],
        monthNames: ['${message(code: "january")}',
                     '${message(code: "february")}',
                     '${message(code: "march")}',
                     '${message(code: "april")}',
                     '${message(code: "may")}',
                     '${message(code: "june")}',
                     '${message(code: "july")}',
                     '${message(code: "august")}',
                     '${message(code: "september")}',
                     '${message(code: "october")}',
                     '${message(code: "november")}',
                     '${message(code: "december")}'],
        dateFormat: 'dd. mm. yy'
      });

      $('.datetimepicker2').datetimepicker({
        timeText: '${message(code: "time")}',
        hourText: '${message(code: "hour")}',
        minuteText: '${message(code: "minute")}',
        dayNamesMin: ['${message(code: "sunday.short")}',
                      '${message(code: "monday.short")}',
                      '${message(code: "tuesday.short")}',
                      '${message(code: "wednesday.short")}',
                      '${message(code: "thursday.short")}',
                      '${message(code: "friday.short")}',
                      '${message(code: "saturday.short")}'],
        monthNames: ['${message(code: "january")}',
                     '${message(code: "february")}',
                     '${message(code: "march")}',
                     '${message(code: "april")}',
                     '${message(code: "may")}',
                     '${message(code: "june")}',
                     '${message(code: "july")}',
                     '${message(code: "august")}',
                     '${message(code: "september")}',
                     '${message(code: "october")}',
                     '${message(code: "november")}',
                     '${message(code: "december")}'],
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

    function showBigSpinner() {
      $('#loading').css('visibility', 'visible');
    }

  </script>

  <ga:trackPageview />
  <g:layoutHead />

</head>
<body>

<div id="loading" style="position:absolute; left: 50%; text-align:center; top:50%; visibility: hidden;">
<img src="${resource(dir: 'images', file: 'big_spinner.gif')}" border=0></div>

<g:if test="${!entity}">
  <g:set var="entity" value="${currentEntity}"/>
</g:if>

%{--<div id="erp"><div class="title">ERP</div></div>--}%

<div id="private">

    <div id="hd">
      <g:render template="/templates/header"/>
    </div>

    <div id="subheader">
      <ul>
        <li><g:link class="activegray" controller="event" action="indexNew" onclick="showBigSpinner()"><g:message code="start"/></g:link></li>
        <li><g:link controller="educatorProfile" action="index" params="[name:entity.name]" onclick="showBigSpinner()"><g:message code="database"/></g:link></li>
        <li><g:link controller="logBook" action="entries" id="${entity.id}" onclick="showBigSpinner()"><g:message code="organisation"/></g:link></li>
        <li><g:link controller="templateProfile" action="index" onclick="showBigSpinner()"><g:message code="planning"/></g:link></li>
        <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
          <li style="border-right: none;"><g:link controller="setup" action="show" id="${entity.id}" params="[entity:entity.id]" onclick="showBigSpinner()"><g:message code="administration"/></g:link></li>
        </erp:accessCheck>
      </ul>
      <div class="clear"></div>
    </div>

    <div id="bd">
      <g:layoutBody/>
    </div>

    <div id="ft">
      <g:render template="/templates/footer"/>
    </div>

</div>

</body>
</html>