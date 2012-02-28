<!DOCTYPE html>

<html>
<head>
  <meta charset="utf-8" />
  <title>${grailsApplication.config.application.name} ${grailsApplication.config.customerName} - <g:layoutTitle/></title>
  <link rel="icon" href="${resource(dir: 'images', file: 'favicon.jpg')}" type="image/jpg"/>
  <r:require modules="other"/>

  <r:script disposition="defer">
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

  </r:script>

  <r:layoutResources/>

  <script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'jquery.jqEasyCharCounter.min.js')}"></script>
  <script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'jquery-ui-timepicker-addon.js')}"></script>
  <script type="text/javascript" src="${resource(dir: 'js/jquery', file: 'jquery.kolorpicker.js')}"></script>

  <g:layoutHead />
  <ckeditor:resources />
  <ga:trackPageview />
</head>

<body>
  <div id="loading" style="position: absolute; left: 50%; text-align: center; top: 50%; visibility: hidden; z-index: 1000;">
  <img src="${resource(dir: 'images', file: 'big_spinner.gif')}" border=0></div>

  <g:if test="${!entity}">
    <g:set var="entity" value="${currentEntity}"/>
  </g:if>

  <div id="private">

    <div id="hd">
      <g:render template="/templates/header"/>
    </div>

    <div id="subheader">
      <ul>
        <li><g:link controller="event" action="index" onclick="showBigSpinner()"><g:message code="start"/></g:link></li>
        <li><g:link controller="educatorProfile" action="index" onclick="showBigSpinner()"><g:message code="database"/></g:link></li>
        <li><g:link class="activegreen" controller="logBook" action="entries" onclick="showBigSpinner()"><g:message code="organisation"/></g:link></li>
        <li><g:link controller="templateProfile" action="index" onclick="showBigSpinner()"><g:message code="planning"/></g:link></li>
        <erp:accessCheck entity="${currentEntity}" types="['Betreiber']">
          <li style="border-right: none;"><g:link controller="setup" action="show" onclick="showBigSpinner()"><g:message code="administration"/></g:link></li>
        </erp:accessCheck>
      </ul>
      <div class="clear"></div>
    </div>

    <div class="yui3-g" id="grid">

      <div class="yui3-u" id="left">
        %{--<div class="boxHeader">
          <div class="second">
            <h1>${entity.profile.fullName} <g:if test="${entity.user}"><g:if test="${entity.user.enabled}"><img class="tooltip" data-tooltip="${message(code: 'isActive')}" src="${resource(dir: 'images/icons', file: 'icon_enabled.png')}" alt="aktiv" style="top: 1px; position: relative"/></g:if><g:else><img class="tooltip" data-tooltip="${message(code: 'isInactive')}" src="${resource(dir: 'images/icons', file: 'icon_disabled.png')}" alt="inaktiv"/></g:else></g:if></h1>
          </div>
        </div>

        <div class="profile-box" style="border-top-left-radius: 0; border-top-right-radius: 0">
          <div class="second">

            <g:if test="${entity.type.supertype.name == 'user' || entity.type.supertype.name == 'child' || entity.type.supertype.name == 'client' || entity.type.supertype.name == 'educator' || entity.type.supertype.name == 'parent' || entity.type.supertype.name == 'partner' || entity.type.supertype.name == 'pate' || entity.type.supertype.name == 'operator' || entity.type.supertype.name == 'facility' || entity.type.supertype.name == 'groupActivity' || entity.type.supertype.name == 'project'}">
              <g:render template="/templates/${entity.type.supertype.name +'Navigation'}" model="[entity: entity]"/>
            </g:if>
            <g:else>
              <g:render template="/templates/defaultNavigation" model="[entity: entity]"/>
            </g:else>

          </div>
        </div>--}%

        <div class="profile-box">
          <div class="second">

            <div class="header"><g:message code="organisation"/></div>

            %{--<div class="area"><g:message code="organisation"/></div>--}%
            <ul>
              <erp:accessCheck entity="${currentEntity}" types="['Betreiber','Pädagoge']">
                <li class="icon-operator"><g:link controller="logBook" action="entries"><g:message code="logBook"/></g:link></li>
              </erp:accessCheck>
            </ul>

          </div>
        </div>

        <div class="profile-box">
          <div class="second">
            <div class="header"><g:message code="privat.head.online"/></div>
            <ul id="onlineusers">
              <g:render template="/templates/onlineUsers"/>
            </ul>
          </div>
        </div>

        %{--<div id="livetickerbox"></div>--}%

      </div>

      <div class="yui3-u" id="main">
        <g:if test="${flash.message}">
          <div id="flash-msg">
            <img src="${resource(dir: 'images/icons', file: 'icon_tick.png')}" alt="success" style="top: 3px; position: relative"/> ${flash.message}
          </div>
        </g:if>
        <div style="padding: 0 15px;">
          <g:layoutBody/>
        </div>
      </div>

    </div>

    <div id="ft">
      <g:render template="/templates/footer"/>
    </div>

  </div>

  <r:layoutResources/>
</body>
</html>